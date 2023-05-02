#include <stdio.h>
#include <stdlib.h>
#define LENGTH 256

//静态整型变量 inc_v =1, 即使函数执行完毕也不会被销毁，而是会一直保留。作用是保证每次生成随机字符串时候都使用rand种子不同。
static int inc_v = 1;
//生成指定长度的随机字符串
void creat_str(char *s, int length)
{
    //srand设置随机数生成器的种子为inc_v，保证每次生成随机字符串时候，种子都不同。
    srand(inc_v);
    //生成 33到122之间的随机数，并将其转换成ASCII对应的字符。存储到指针s所指向的数组中。
    for(int i = 0; i < length; i++)
    {
        //33-122,'!'->'z'
        *(s + i) = rand() % 89 + 33;
        // 检查随机生成的字符是否有单引号或反斜杠。如果有，将其替换成字符1，因为会影响后面字符串的拼接
        if(*(s + i) == '\'' || *(s + i) == '\\')
            *(s + i) = '1';
    }
    //最后的位置加上字符串结束符\0
    s[length] = '\0';
    //将随机数种子值添加1，保证下一次生成随机字符串时使用的种子不同
    inc_v++;
}

int main()
{
    // 指向file类型的指针变量 fin_load, 用于指向文件流
    FILE *fin_load, *fin_run, *fout_set, *fout_test;
    if(!(fin_load = fopen("ycsb_load3.load", "r")))
    {
        //如果文件打开失败，则输出一行错误信息。
        printf("The source file *.load not exist.\n");
        //终止程序
        exit(-1);
    }

    if(!(fin_run = fopen("ycsb_run3.run", "r")))
    {
        printf("The source file *.run not exist.\n");
        exit(-1);
    }

    if(!(fout_set = fopen("ycsb_set3.txt", "w+")))
    {
        printf("The ycsb_set.txt create failed.\n");
        exit(-1);
    }

    if(!(fout_test = fopen("ycsb_test3.txt", "w+")))
    {
        printf("The ycsb_test.txt create failed.\n");
        exit(-1);
    }

    //read by line
    char tmp[10240];

    unsigned int insert_load = 0, insert_run = 0, update_run=0, read_run = 0;
    unsigned int op_all_load = 0, op_all_run = 0;

    while(fgets(tmp, 10240, fin_load) && (!feof(fin_load)))
    {
        char key[250] = {0};
        char value[LENGTH + 1] = {0};

        if(sscanf(tmp, "INSERT table %s [ field0=%[^\n]", key, value))
        {
            insert_load++;
            creat_str(value, LENGTH);
            fprintf(fout_set, "INSERT\t%s [%s]\n", key, value);
        }
        else if(sscanf(tmp, "\"operationcount\"=\"%u\"", &op_all_load))
        {
            fprintf(fout_set, "Operationcount=%u\n\n", op_all_load);
        }
    }
    // 输出load阶段的总数
    fprintf(fout_set, "\n\n LOAD_INSERT=%u", insert_load);

    //获取run阶段的指令
    while(fgets(tmp, 10240, fin_run) && (!feof(fin_run)))
    {
        char key[250] = {0};
        char value[LENGTH + 1] = {0};
        if(sscanf(tmp, "INSERT table %s [ field0=%[^\n]", key, value))   //fout insert
        {
            insert_run++;
            creat_str(value,LENGTH);
            fprintf(fout_test, "INSERT\t%s [%s]\n", key, value);
        }
        else if(sscanf(tmp, "READ table %s [", key))                      //fout read
        {
            read_run++;
            creat_str(value,LENGTH);
            fprintf(fout_test, "READ\t%s [%s]\n", key, value);
        }
        else if(sscanf(tmp, "UPDATE table %s [ field0=%[^\n]", key, value))    //fout update
        {
            update_run++;
            creat_str(value,LENGTH);
            fprintf(fout_test, "UPDATE\t%s [%s]\n", key, value);
        }
        else if(sscanf(tmp, "\"operationcount\"=\"%u\"", &op_all_run))    //fout count
        {
            fprintf(fout_test, "Operationcount=%u\n\n", op_all_run);
        }
        else
            ;
    }

    fprintf(fout_test, "\n\nRUN_INSERT=%u\n RUN_INSERT=%u\n RUN_READ=%u", insert_run, update_run,read_run);

    fclose(fin_load);
    fclose(fin_run);
    fclose(fout_set);
    fclose(fout_test);

    return 0;
}
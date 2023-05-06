#include <stdio.h>
#include <stdlib.h>
#define LENGTH 256

static int inc_v = 1;

void creat_str(char *s, int length)
{
    srand(inc_v);
    for(int i = 0; i < length; i++)
    {
        //33-122,'!'->'z'
        *(s + i) = rand() % 89 + 33;
        if(*(s + i) == '\'' || *(s + i) == '\\')
            *(s + i) = '1';
    }
    s[length] = '\0';
    inc_v++;
}

int main()
{

    FILE *fin_load, *fin_run, *fout_set, *fout_test;
    if(!(fin_load = fopen("ycsb_load1.load", "r")))
    {

        printf("The source file *.load not exist.\n");

        exit(-1);
    }

    if(!(fin_run = fopen("ycsb_run1.run", "r")))
    {
        printf("The source file *.run not exist.\n");
        exit(-1);
    }

    if(!(fout_set = fopen("ycsb_set1.txt", "w+")))
    {
        printf("The ycsb_set.txt create failed.\n");
        exit(-1);
    }

    if(!(fout_test = fopen("ycsb_test1.txt", "w+")))
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

    fprintf(fout_set, "\n\n LOAD_INSERT=%u", insert_load);

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
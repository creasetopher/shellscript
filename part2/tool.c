// Implement your cycle count tool here.
// referenced SO "Traverse FILE line by line using fscanf"
// https://stackoverflow.com/questions/20108334/traverse-file-line-by-line-using-fscanf/20108623
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


int main(int argc, char const *argv[]) {
  if (argv == NULL) {
    printf("You must pass in a filename as a command line argument!\n");
  }
  char filename[255] = "./";
  strcat(&filename, argv[1]);

  FILE *myFile = fopen(filename, "r");

  if (myFile != NULL) {
    char buffer[255];
    int instructions = 0;
    int cycles = 0;
    while(fscanf(myFile, "%[^\n]\n", buffer) != EOF)  {
      char temp[4] = "";
      if (strlen(buffer) > 2) {
        strncat(temp, buffer, 3);
        // strlwr(temp);

        if (strcmp(temp, "add") == 0
            || strcmp(temp, "sub") == 0
            || strcmp(temp, "mov") == 0
            || strcmp(temp, "pus") == 0
            || strcmp(temp, "jmp") == 0) {
          instructions++;
          cycles++;
        }

        else if (strcmp(temp, "div") == 0) {
          instructions++;
          cycles += 32;
        }


        else if (strcmp(temp, "mul") == 0
            || strcmp(temp, "imu") == 0) {
          instructions++;
          cycles += 3;
        }

        else if (strcmp(temp, "lea") == 0
            || strcmp(temp, "ret") == 0) {
          instructions++;
          cycles += 2;
        }

        else if (strcmp(temp, "pop") == 0) {
          instructions++;
          cycles += 3;
        }
      }
    }
    printf("Total Instructions: %d\n", instructions);
    printf("Total Cycles: %d\n", cycles);
  }
  else {
    printf("Unable to locate file...\n");
  }
  return 0;
}

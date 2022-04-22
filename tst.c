#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void) {
  char* args[4] = {"tabbed", "st", "-w", NULL};
  pid_t child_pid;
  int child_status;

  child_pid = fork();
  if(child_pid == 0) {
    execvp(args[0], args);
    exit(0);
  }
  else {
    wait(&child_status);
    return child_status;
  }
}
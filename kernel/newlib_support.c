#include <sys/types.h>
#include <sys/stat.h>
#include <stddef.h>

caddr_t sbrk(int incr) {
  return NULL;
}

int write(int file, char *ptr, int len) {
  return 0;
}

void _exit(int stat) {
}

int kill(pid_t pid, int sig) {
  return 0;
}

int getpid() {
  return 0;
}

int read(int file, char * ptr , int len) {
  return 0;
}

int lseek(int file, int ptr, int dir) {
  return 0;
}

int close(int file) {
  return 0;
}

int fstat(int file, struct stat *st) {
  return 0;
}

int isatty(int file) {
  return 0;
}

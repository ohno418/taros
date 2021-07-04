#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stddef.h>
#include <stdio.h>

caddr_t program_break, program_break_end;

caddr_t sbrk(int incr) {
  if (program_break == 0 || program_break + incr >= program_break_end) {
    // FIXME: lld link error here.
    // errno = ENOMEM;
    return (caddr_t)-1;
  }

  caddr_t prev_break = program_break;
  program_break += incr;
  return prev_break;
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

int sched_yield(void) {
  return 0;
}

FILE *stderr;

int __vfprintf_chk(FILE * fp, int flag, const char * format, va_list ap) {
  return 0;
}

void __assert_fail(const char * assertion, const char * file, unsigned int line, const char * function) {}
const unsigned short * * __ctype_b_loc (void) {
  return 0;
}

int dl_iterate_phdr(
          int (*callback) (struct dl_phdr_info *info,
                           size_t size, void *data),
          void *data) {
  return 0;
}

void __libc_fatal (const char *message) {}

int __sched_get_priority_max (int __algorithm) {
  return 0;
}

int __sched_get_priority_min (int __algorithm) {
  return 0;
}

int __sched_setscheduler (__pid_t __pid, int __policy, const struct sched_param *__param) {
  return 0;
}

int __sched_getparam (__pid_t __pid, struct sched_param *__param) {
  return 0;
}

int __sched_getscheduler (__pid_t __pid) {
  return 0;
}

#define tunable_id_t int
#define tunable_callback_t int
void __tunable_get_val (tunable_id_t a, void * b, tunable_callback_t c) {}
void _dl_x86_cpu_features() {}
void __libc_longjmp() {}

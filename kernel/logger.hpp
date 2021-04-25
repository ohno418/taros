#pragma once

enum LogLevel {
  kError = 3,
  kWarn  = 4,
  kInfo  = 6,
  kDebug = 7,
};

/** @brief Set the global level of log priority.
 * Only higher priority logs are outputted after this.
 */
void SetLogLevel(LogLevel level);

/** @brief Log with specified level.
 * If `level` is lower than the global level, this log is abandoned.
 */
int Log(LogLevel level, const char* format, ...);

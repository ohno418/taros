#pragma once

#include <cstddef>

const size_t kPageDirectoryCount = 64;

/** @brief Setup the page table that virtual address = physical address.
 */
void SetupIdentityPageTable();

void InitializePaging();

From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 00/12][v4] Backport several fixes from 64bits to 32bits hibernation
Date: Fri, 21 Sep 2018 14:24:46 +0800
Message-ID: <cover.1537448058.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently there are mainly three bugs in 32bits system when doing
hibernation:
1. The page copy code is not running in safe page, which might
   cause hang during resume.
2. There's no text mapping for the final jump address
   of the original kernel, which might cause the system jumping
   into illegal address and causes system hang during resume.
3. The restore kernel switches to its own kernel page table(swapper_pg_dir)
   rather than the original kernel page table after all the pages
   been copied back, which might cause invalid virtual-physical
   mapping issue during resume.

To solve these problems:

1. Copy the code core_restore_code to a safe page, to avoid the instruction
   code been overwritten when image kernel pages are being copied.
2. Set up temporary text mapping for the image kernel's jump address,
   so that after all the pages have been copied back, the system could
   jump to this address.
3. Switch to the original kernel page table during resume.

Furthermore, MD5 hash check for e820 map is also backported from 64bits
system.

In order to make this patch set more readable, these fixes are splitted
into several sub patches.

And use CONFIG_X86_64 to control the common code to be 'activated' for
32 bit system during each sub-patch for better maintaining.

Chen Yu (1):
  PM / hibernate: Check the success of generating md5 digest before
    hibernation

Zhimin Gu (11):
  x86, hibernate: Fix nosave_regions setup for hibernation
  x86-32/asm/power: Create stack frames in hibernate_asm_32.S
  x86, hibernate: Extract the common code of 64/32 bit system
  x86-32, hibernate: Enable CONFIG_ARCH_HIBERNATION_HEADER on 32bit
    system
  x86, hibernate: Rename temp_level4_pgt to temp_pgt
  x86-32, hibernate: Use temp_pgt as the temporary page table
  x86-32, hibernate: Use the page size macro instead of constant value
  x86-32, hibernate: Switch to original page table after resumed
  x86-32, hibernate: Switch to relocated restore code during resume on
    32bit system
  x86-32, hibernate: Set up temporary text mapping for 32bit system
  x86-32, hibernate: Adjust in_suspend after resumed on 32bit system

 arch/x86/Kconfig                  |   2 +-
 arch/x86/include/asm/suspend.h    |   8 +
 arch/x86/include/asm/suspend_32.h |   4 +
 arch/x86/kernel/setup.c           |   2 +-
 arch/x86/power/Makefile           |   2 +-
 arch/x86/power/hibernate.c        | 248 ++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_32.c     |  52 +++++--
 arch/x86/power/hibernate_64.c     | 224 +--------------------------
 arch/x86/power/hibernate_asm_32.S |  37 ++++-
 arch/x86/power/hibernate_asm_64.S |   2 +-
 10 files changed, 334 insertions(+), 247 deletions(-)
 create mode 100644 arch/x86/power/hibernate.c

-- 
2.17.1

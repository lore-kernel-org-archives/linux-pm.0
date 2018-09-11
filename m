From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/4][v2] Fixes hibernation bugs on x86-32 system
Date: Wed, 12 Sep 2018 01:19:55 +0800
Message-ID: <cover.1536685746.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Zhimin Gu <kookoo.gu@intel.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Currently there are mainly three bugs in x86-32 system when doing
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
   code be overwriten when image kernel pages are being copied.
2. Set up temporary text mapping for the image kernel's jump address, so that
   after all the pages have been copied back, the system could jump to this address.
3. Switch to the original kernel page table during resume.

Furthermore, MD5 hash check for e820 map is also backported from 64bits

Chen Yu (1):
  PM / hibernate: Check the success of generating md5 digest before
    hibernation

Zhimin Gu (3):
  x86, hibernate: Fix nosave_regions setup for hibernation
  x86, hibernate: Extract the common code of 64/32 bit system
  x86, hibernate: Backport several fixes from 64bits to 32bits
    hibernation

 arch/x86/Kconfig                  |   2 +-
 arch/x86/include/asm/suspend_32.h |   4 +
 arch/x86/kernel/setup.c           |   2 +-
 arch/x86/power/hibernate.c        | 263 ++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_32.c     |  60 ++++---
 arch/x86/power/hibernate_64.c     | 242 +--------------------------
 arch/x86/power/hibernate_asm_32.S |  49 +++++-
 arch/x86/power/hibernate_asm_64.S |   2 +-
 8 files changed, 350 insertions(+), 274 deletions(-)
 create mode 100644 arch/x86/power/hibernate.c

-- 
2.17.1

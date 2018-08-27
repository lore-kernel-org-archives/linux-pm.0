From: Gu Zhimin <kookoo.gu@intel.com>
Subject: [PATCH 0/3] Fixes hibernation bugs on x86-32 system
Date: Mon, 27 Aug 2018 17:41:18 +0800
Message-ID: <cover.1535361949.git.kookoo.gu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Yu Chen <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

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

Zhimin Gu (3):
  x86, hibernate: Fix nosave_regions setup for hibernation
  x86, hibernate: Extract the common code of 64/32 bit system
  x86, hibernate: Backport several fixes from 64bits to 32bits
    hibernation

 arch/x86/Kconfig                  |   2 +-
 arch/x86/include/asm/suspend_32.h |   4 +
 arch/x86/kernel/setup.c           |   2 +-
 arch/x86/power/hibernate.c        | 253 ++++++++++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_32.c     |  76 ++++++++----
 arch/x86/power/hibernate_64.c     | 241 +-----------------------------------
 arch/x86/power/hibernate_asm_32.S |  49 ++++++--
 arch/x86/power/hibernate_asm_64.S |   2 +-
 8 files changed, 353 insertions(+), 276 deletions(-)
 create mode 100644 arch/x86/power/hibernate.c

-- 
2.7.4

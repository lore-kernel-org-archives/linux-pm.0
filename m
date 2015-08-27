From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3] PM / hibernate: Fix hibernation panic caused by inconsistent e820 memory map
Date: Thu, 27 Aug 2015 15:05:33 +0800
Message-ID: <cover.1440640658.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, rjw@rjwysocki.net, pavel@ucw.cz, hpa@zytor.com
Cc: len.brown@intel.com, yinghai@kernel.org, joeyli.kernel@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patchset is mainly to fix a hibernation panic caused by
BIOS's inconsistent e820 memory map. It is unlikely that the BIOS
will be fixed one by one, as this panic is seen on multiple machines
in field already.

This patchset is composed of 3 sub patches:

patch 1 is to remove E820_RESERVED_KERN region from kernel that,
the resuming will not fail because of non-page-aligned regions brought
by E820_RESERVED_KERN. This patch is the base of patch 2 and patch 3.

patch 2 is the core patch that fixes the hibernation panic, by checking
each page frame's validation during resuming. This patch was once merged
but reverted due to regression described in patch 1.

patch 3 is to ensure that, system with larger memory size compared to the
one before hibernation, will get the permission to resume.
Please refer to the changelog in patch 3 for detail.

Chen Yu (1):
  PM / hibernate: Remove the restriction when checking memory size
    before/after hibernation

Lee, Chun-Yi (1):
  PM / hibernate: avoid unsafe pages in e820 reserved regions

Yinghai Lu (1):
  x86: Kill E820_RESERVED_KERN

 arch/x86/include/uapi/asm/e820.h |  8 --------
 arch/x86/kernel/e820.c           |  6 ++----
 arch/x86/kernel/setup.c          | 25 -------------------------
 arch/x86/kernel/tboot.c          |  3 +--
 arch/x86/mm/init_64.c            | 11 ++++-------
 kernel/power/snapshot.c          | 29 ++++++++++++++++++++++++++---
 6 files changed, 33 insertions(+), 49 deletions(-)

-- 
1.8.4.2

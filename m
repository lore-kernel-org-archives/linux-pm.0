From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.8-rc2
Date: Fri, 12 Aug 2016 23:25:10 +0200
Message-ID: <CAJZ5v0hi=vv1QxKZC=AFMBvKU_fiSEBX-ZbeOhkL75OjUUAViA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35014 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbcHLVZM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2016 17:25:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.8-rc2

with top-most commit 0aeeb3e73f5fd7faef3dce8cb590effd6ee51571

 Merge branches 'pm-sleep' and 'pm-cpufreq'

on top of commit 29b4817d4018df78086157ea3a55c1d9424a7cfc

 Linux 4.8-rc1

to receive power management fixes for v4.8-rc2.

Two hibernation fixes allowing it to work with the recently added
randomization of the kernel identity mapping base on x86-64 and
one cpufreq driver regression fix.

Specifics:

 - Fix the x86 identity mapping creation helpers to avoid the
   assumption that the base address of the mapping will always be
   aligned at the PGD level, as it may be aligned at the PUD level
   if address space randomization is enabled (Rafael Wysocki).

 - Fix the hibernation core to avoid executing tracing functions
   before restoring the processor state completely during resume
   (Thomas Garnier).

 - Fix a recently introduced regression in the powernv cpufreq
   driver that causes it to crash due to an out-of-bounds array
   access (Akshay Adiga).

Thanks!

---------------

Akshay Adiga (1):
      cpufreq: powernv: Fix crash in gpstate_timer_handler()

Rafael J. Wysocki (1):
      x86/power/64: Always create temporary identity mapping correctly

Thomas Garnier (1):
      PM / hibernate: Restore processor state before using per-CPU variables

---------------

 arch/x86/include/asm/init.h       |  4 ++--
 arch/x86/mm/ident_map.c           | 19 +++++++++++--------
 arch/x86/power/hibernate_64.c     |  2 +-
 drivers/cpufreq/powernv-cpufreq.c | 21 ++++++++++++++++++++-
 kernel/power/hibernate.c          |  4 ++--
 5 files changed, 36 insertions(+), 14 deletions(-)

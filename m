From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.7-rc7
Date: Fri, 8 Jul 2016 01:42:08 +0200
Message-ID: <CAJZ5v0jEEL-G-DS8_DJUddX8j9z0UWROB8z0+sWcuJizVLq9Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34194 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbcGGXmL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 19:42:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.7-rc7

to receive power management fixes for v4.7-rc7 with top-most commit
7fe39a21557b251e101671f2c3f79558a756afef

 Merge branches 'pm-cpuidle-fixes' and 'pm-sleep-fixes'

on top of commit a99cde438de0c4c0cecc1d1af1a55a75b10bfdef

 Linux 4.7-rc6

One fix for a recent cpuidle core change that, against all odds,
introduced a functional regression on Power systems and the fix
for the crash during resume from hibernation on x86-64 that has
been in the works for the last few weeks (it actually was ready
last week, but I wanted to allow the reporters to test if for some
more time).

Specifics:

 - Fix a recent performance regression on Power systems (powernv
   and pseries) introduced by a core cpuidle commit that decreased
   the precision of the last_residency conversion from nano- to
   microseconds, which should not matter in theory, but turned out
   to play not-so-well with the special "snooze" idle state on Power
   (Shreyas B Prabhu).

 - Fix a crash during resume from hibernation on x86-64 caused by
   possible corruption of the kernel text part of page tables in the
   last phase of image restoration exposed by a security-related
   change during the 4.3 development cycle (Rafael Wysocki).

Thanks!

---------------

Rafael J. Wysocki (1):
      x86/power/64: Fix kernel text mapping corruption during image restoration

Shreyas B. Prabhu (1):
      cpuidle: Fix last_residency division

---------------

 arch/x86/power/hibernate_64.c     | 97 ++++++++++++++++++++++++++++++++++-----
 arch/x86/power/hibernate_asm_64.S | 55 ++++++++++------------
 drivers/cpuidle/cpuidle.c         | 12 ++---
 3 files changed, 113 insertions(+), 51 deletions(-)

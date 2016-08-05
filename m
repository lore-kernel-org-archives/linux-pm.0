From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v4.8-rc1
Date: Fri, 5 Aug 2016 16:48:13 +0200
Message-ID: <CAJZ5v0hwWBP1WhVSs7pvYR5nn0K-+_oPzm_p8NZGysXNO-reww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34850 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759874AbcHEOsP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2016 10:48:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-extra-4.8-rc1

with top-most commit e2b3b80de5cda284c885721e873f9a6e90f68ef8

 Merge branches 'pm-sleep', 'pm-cpufreq', 'pm-core' and 'pm-opp'

on top of commit 601f887d6105ddd28dc569a1504595bdf8df8a5b

 Merge tag 'pm-urgent-4.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management material for v4.8-rc1.

A few more fixes and cleanups in the x86-64 low-level hibernation
code, PM core, cpufreq (Kconfig and intel_pstate), and the operating
points framework.

Specifics:

 - Prevent the low-level assembly hibernate code on x86-64 from
   referring to __PAGE_OFFSET directly as a symbol which doesn't work
   when the kernel identity mapping base is randomized, in which case
   __PAGE_OFFSET is a variable (Rafael Wysocki).

 - Avoid selecting CPU_FREQ_STAT by default as the statistics are not
   required for proper cpufreq operation (Borislav Petkov).

 - Add Skylake-X and Broadwell-X IDs to the intel_pstate's list of
   processors where out-of-band (OBB) control of P-states is possible
   and if that is in use, intel_pstate should not attempt to manage
   P-states (Srinivas Pandruvada).

 - Drop some unnecessary checks from the wakeup IRQ handling code in
   the PM core (Markus Elfring).

 - Reduce the number operating performance point (OPP) lookups in
   one of the OPP framework's helper functions (Jisheng Zhang).

Thanks!

---------------

Borislav Petkov (1):
      cpufreq: Do not default-yes CPU_FREQ_STAT

Jisheng Zhang (1):
      PM / OPP: optimize dev_pm_opp_set_rate() performance a bit

Markus Elfring (1):
      PM-wakeup: Delete unnecessary checks before three function calls

Rafael J. Wysocki (1):
      x86/power/64: Do not refer to __PAGE_OFFSET from assembly code

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Add more out-of-band IDs

---------------

 arch/x86/power/hibernate_64.c     | 18 +++++++++---------
 arch/x86/power/hibernate_asm_64.S |  2 --
 drivers/base/power/opp/core.c     | 31 +++++++++++++++++++------------
 drivers/base/power/wakeup.c       | 18 +++++++-----------
 drivers/cpufreq/Kconfig           |  1 -
 drivers/cpufreq/intel_pstate.c    |  2 ++
 6 files changed, 37 insertions(+), 35 deletions(-)

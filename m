From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.7-rc6
Date: Fri, 1 Jul 2016 23:14:53 +0200
Message-ID: <CAJZ5v0gUAsbZq3-OOksvMHREDAv7-2HwkVKNZHO-0P49_SYBXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33608 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbcGAVOz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 17:14:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.7-rc6

to receive power management fixes for v4.7-rc6 with top-most commit
742c87bf27d3b715820da6f8a81d6357adbf18f8

 cpufreq: Avoid false-positive WARN_ON()s in cpufreq_update_policy()

on top of commit 4c2e07c6a29e0129e975727b9f57eede813eea85

 Linux 4.7-rc5

Three cpufreq fixes, one in the core (stable-candidate) and two
in drivers (intel_pstate and cpufreq-dt).

Specifics:

 - Fix a recent intel_pstate regression that caused the number of
   wakeups to increase significantly on an idle system in some cases
   due to excessive synchronize_sched() invocations (Rafael Wysocki).

 - Fix unnecessary invocations of WARN_ON() in the cpufreq core
   after cpufreq has been suspended introduced during the 4.6 cycla
   (Rafael Wysocki).

 - Fix an error code path in the cpufreq-dt-platdev driver that
   forgets to drop a reference to a DT node (Masahiro Yamada).

Thanks!

---------------

Masahiro Yamada (1):
      cpufreq: dt: call of_node_put() before error out

Rafael J. Wysocki (2):
      intel_pstate: Do not clear utilization update hooks on policy changes
      cpufreq: Avoid false-positive WARN_ON()s in cpufreq_update_policy()

---------------

 drivers/cpufreq/cpufreq-dt-platdev.c | 7 ++++---
 drivers/cpufreq/cpufreq.c            | 4 ++++
 drivers/cpufreq/intel_pstate.c       | 5 +++--
 3 files changed, 11 insertions(+), 5 deletions(-)

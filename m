From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.7-rc3
Date: Fri, 10 Jun 2016 02:18:27 +0200
Message-ID: <CAJZ5v0jGY0V-sZgQpKTET3KWZrZYEasBrDNHc08KttQHJBLR0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33289 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcFJATN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 20:19:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.7-rc3

to receive power management fixes for v4.7-rc3 with top-most commit
3681196ae568f97d534537c1c1102f4707ca11f9

 Merge branches 'pm-cpufreq-fixes' and 'pm-cpuidle'

on top of commit af8c34ce6ae32addda3788d54a7e340cad22516b

 Linux 4.7-rc2

Stable-candidate fixes for the intel_pstate driver and the
cpuidle core.

Specifics:

 - Fix two intel_pstate initialization issues, one of which was
   introduced during the 4.4 cycle (Srinivas Pandruvada).

 - Fix kernel build with CONFIG_UBSAN set and CONFIG_CPU_IDLE
   unset (Catalin Marinas).

Thanks!

---------------

Catalin Marinas (1):
      cpuidle: Do not access cpuidle_devices when !CONFIG_CPU_IDLE

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Fix code ordering in intel_pstate_set_policy()
      cpufreq: intel_pstate: Fix ->set_policy() interface for no_turbo

---------------

 drivers/cpufreq/intel_pstate.c | 12 +++++++++---
 include/linux/cpuidle.h        |  3 +++
 kernel/sched/idle.c            |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

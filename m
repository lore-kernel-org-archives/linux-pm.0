From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v4.7-rc1
Date: Wed, 25 May 2016 22:49:21 +0200
Message-ID: <CAJZ5v0h93mB2fKdRmp3eSMq-QhcJzJaQNcoJvBcYp4N4BVQ5FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33654 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcEYUtX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2016 16:49:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.7-rc1-more

to receive more power management updates for v4.7-rc1 with top-most
commit 4c2628cd7580bc4f4a4994925cf366185ecc37a5

 Merge branches 'pm-cpufreq', 'pm-cpuidle' and 'pm-core'

on top of commit d57d39431924d1628ac9b93a2de7f806fc80680a

 Merge tag 'pm-4.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

These are two stable-candidate fixes (PM core, cpuidle) and a bunch
of cpufreq cleanups.

Specifics:

 - Stable-candidate cpuidle fix to make it check the right variable
   when deciding whether or not to enable interrupts on the local CPU
   so as to avoid enabling iterrupts too early in some cases if the
   system has both coupled and per-core idle states (Daniel Lezcano).

 - Stable-candidate PM core fix to make it handle failures at the
   "late suspend" stage of device suspend consistently for all
   devices regardless of whether or not async suspend/resume is
   enabled for them (Rafael Wysocki).

 - Cleanups in the cpufreq core, the schedutil governor and the
   intel_pstate driver (Rafael Wysocki, Pankaj Gupta, Viresh Kumar).

Thanks!

---------------

Daniel Lezcano (1):
      cpuidle: Fix cpuidle_state_is_coupled() argument in cpuidle_enter()

Pankaj Gupta (1):
      cpufreq: simplified goto out in cpufreq_register_driver()

Rafael J. Wysocki (4):
      intel_pstate: Simplify conditional in intel_pstate_set_policy()
      cpufreq: governor: CPUFREQ_GOV_POLICY_EXIT never fails
      cpufreq: governor: CPUFREQ_GOV_STOP never fails
      PM / sleep: Handle failures in device_suspend_late() consistently

Viresh Kumar (1):
      cpufreq: schedutil: Improve prints messages with pr_fmt

---------------

 drivers/base/power/main.c        |  5 ++-
 drivers/cpufreq/cpufreq.c        | 84 +++++++++++++---------------------------
 drivers/cpufreq/intel_pstate.c   | 11 +++---
 drivers/cpuidle/cpuidle.c        |  2 +-
 kernel/sched/cpufreq_schedutil.c |  4 +-
 5 files changed, 39 insertions(+), 67 deletions(-)

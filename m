From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.11-rc4
Date: Fri, 24 Mar 2017 02:30:15 +0100
Message-ID: <CAJZ5v0hrfZjWO6dFNnLtnPbEeeeF+4duPw_R1r2SqMTmjohkrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36456 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbdCXBaR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 21:30:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.11-rc4

with top-most commit 90ff2b729e181fba628b854eac2097e5ccc22e66

 Merge branch 'pm-cpuidle-fixes'

on top of commit 97da3854c526d3a6ee05c849c96e48d21527606c

 Linux 4.11-rc3

to receive power management fixes for v4.11-rc4.

One of these is an intel_pstate regression fix and it is not a small
change, but it mostly removes code that shouldn't be there.  That
code was acquired by mistake and has been a source of constant pain
since then, so the time has come to get rid of it finally.  We have
not seen problems with this change in the lab, so fingers crossed.

The rest is more usual: one more intel_pstate commit removing useless
code, a cpufreq core fix to make it restore policy limits on CPU
online (which prevents the limits from being reset over system
suspend/resume), a schedutil cpufreq governor initialization fix to
make it actually work as advertised on all systems and an extra
sanity check in the cpuidle core to prevent crashes from happening
if the arch code messes things up.

Specifics:

 - Make intel_pstate use one set of global P-state limits in the
   active mode regardless of the scaling_governor settings for
   individual CPUs instead of switching back and forth between two
   of them in a way that is hard to control (Rafael Wysocki).

 - Drop a useless function from intel_pstate to prevent it from
   modifying the maximum supported frequency value unexpectedly
   which may confuse the cpufreq core (Rafael Wysocki).

 - Fix the cpufreq core to restore policy limits on CPU online so
   that the limits are not reset over system suspend/resume, among
   other things (Viresh Kumar).

 - Fix the initialization of the schedutil cpufreq governor to
   make the IO-wait boosting mechanism in it actually work on
   systems with one CPU per cpufreq policy (Rafael Wysocki).

 - Add a sanity check to the cpuidle core to prevent crashes from
   happening if the architecture code initialization fails to set
   up things as expected (Vaidyanathan Srinivasan).

Thanks!

---------------

Rafael J. Wysocki (3):
      cpufreq: intel_pstate: One set of global limits in active mode
      cpufreq: schedutil: Fix per-CPU structure initialization in sugov_start()
      cpufreq: intel_pstate: Fix policy data management in passive mode

Vaidyanathan Srinivasan (1):
      cpuidle: Validate cpu_dev in cpuidle_add_sysfs()

Viresh Kumar (1):
      cpufreq: Restore policy min/max limits on CPU online

---------------

 drivers/cpufreq/cpufreq.c        |   3 +
 drivers/cpufreq/intel_pstate.c   | 167 ++++++++++++---------------------------
 drivers/cpuidle/sysfs.c          |  12 +++
 kernel/sched/cpufreq_schedutil.c |  20 ++---
 4 files changed, 72 insertions(+), 130 deletions(-)

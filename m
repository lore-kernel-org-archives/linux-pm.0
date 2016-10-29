From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.9-rc3
Date: Sat, 29 Oct 2016 02:57:37 +0200
Message-ID: <CAJZ5v0iBcPOX652dUe7+MNRXYOT5RYj6SRhOQUzu3UAFQdKBdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.9-rc3

with top-most commit 8b2ada27dc1045e8191673bf769a1136ce8a0127

 Merge branches 'pm-cpufreq-fixes' and 'pm-sleep-fixes'

on top of commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69

 Linux 4.9-rc2

to receive power management fixes for v4.9-rc3.

These fix two intel_pstate issues related to the way it works when
the scaling_governor sysfs attribute is set to "performance" and
fix up messages in the system suspend core code.

Specifics:

 - Fix a missing KERN_CONT in a system suspend message by converting
   the affected code to using pr_info() and pr_cont() instead of the
   "raw" printk() (Jon Hunter).

 - Make intel_pstate set the CPU P-state from its .set_policy()
   callback when the scaling_governor sysfs attribute is set to
   "performance" so that it interacts with NOHZ_FULL more
   predictably which was the case before 4.7 (Rafael Wysocki).

 - Make intel_pstate always request the maximum allowed P-state when
   the scaling_governor sysfs attribute is set to "performance" to
   prevent it from effectively ingoring that setting is some
   situations (Rafael Wysocki).

Thanks!

---------------

Jon Hunter (1):
      PM / suspend: Fix missing KERN_CONT for suspend message

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Set P-state upfront in performance mode
      cpufreq: intel_pstate: Always set max P-state in performance mode

---------------

 drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++++++------
 kernel/power/suspend.c         |  4 ++--
 2 files changed, 34 insertions(+), 8 deletions(-)

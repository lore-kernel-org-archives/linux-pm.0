From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for final v5.0
Date: Fri, 22 Feb 2019 10:42:40 +0100
Message-ID: <CAJZ5v0i-UVM7BwRgC2cDf93RguVaYxXViLQOACHGPETEM9a7jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.0

with top-most commit 5b317cbf2bcb85a1e96ce87717cb991ecab1dd4d

 Merge branch 'pm-cpufreq-fixes'

on top of commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438

 Linux 5.0-rc7

to receive power management fixes for final 5.0.

These fix a regression in the PM-runtime framework introduced
by the recent switch-over of it to using hrtimers and a
use-after-free introduced by one of the recent changes in the
scmi-cpufreq driver.

Specifics:

 - Use hrtimer_try_to_cancel() instead of hrtimer_cancel() in the
   PM-runtime framework to avoid a possible timer-related deadlock
   introduced recently (Vincent Guittot).

 - Reorder the scmi-cpufreq driver code to avoid accessing memory
   that has just been freed (Yangtao Li).

Thanks!


---------------

Vincent Guittot (1):
      PM-runtime: Fix deadlock when canceling hrtimer

Yangtao Li (1):
      cpufreq: scmi: Fix use-after-free in scmi_cpufreq_exit()

---------------

 drivers/base/power/runtime.c   | 2 +-
 drivers/cpufreq/scmi-cpufreq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

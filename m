From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v5.0-rc3
Date: Fri, 1 Feb 2019 11:39:56 +0100
Message-ID: <CAJZ5v0gSNtDedxn=zfxCN93srU3BidOH2Uuon8WK9CvM_01oqg@mail.gmail.com>
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
 pm-5.0-rc5

with top-most commit cbffab6825731f1baac7a950f6b7dd9239f55594

 Merge branch 'pm-cpuidle-fixes'

on top of commit f17b5f06cb92ef2250513a1e154c47b78df07d40

 Linux 5.0-rc4

to receive power management fixes for 5.0-rc5.

These fix a PM-runtime framework regression introduced by the
recent switch-over of device autosuspend to hrtimers and a
mistake in the "poll idle state" code introduced by a recent
change in it.

Specifics:

 - Since ktime_get() turns out to be problematic for device
   autosuspend in the PM-runtime framework, make it use
   ktime_get_mono_fast_ns() instead (Vincent Guittot).

 - Fix an initial value of a local variable in the "poll idle state"
   code that makes it behave not exactly as expected when all idle
   states except for the "polling" one are disabled (Doug Smythies).

Thanks!


---------------

Doug Smythies (1):
      cpuidle: poll_state: Fix default time limit

Vincent Guittot (1):
      PM-runtime: Fix deadlock with ktime_get()

---------------

 drivers/base/power/runtime.c | 10 +++++-----
 drivers/cpuidle/poll_state.c |  2 +-
 include/linux/pm_runtime.h   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

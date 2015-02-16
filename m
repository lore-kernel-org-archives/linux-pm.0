From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Updates related to suspend-to-idle for 3.20-rc1
Date: Mon, 16 Feb 2015 20:24:24 +0100
Message-ID: <CAJZ5v0i0VvGDmgBHBfWLR2cd03e14qZxAGpnJa8eXeayQ1H3Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 suspend-to-idle-3.20-rc1

to receive changes adding support for quiescing timers during suspend-to-idle
for v3.20-rc1 with top-most commit c7fb90dfbef49b03e6f3fd6a32338e59cbcf34ee

 ACPI / idle: Implement ->enter_freeze callback routine

on top of commit 18320f2a6871aaf2522f793fee4a67eccf5e131a

 Merge tag 'pm+acpi-3.20-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

This has been in the works for a few months and reached the point
when it is not useful to hold off pushing it any more.

Till now suspend-to-idle has not been able to save much more energy
than runtime PM because of timer interrupts that periodically bring
CPUs out of idle while they are waiting for a wakeup interrupt.  Of
course, the timer interrupts are not wakeup ones, so the handling of
them can be deferred until a real wakeup interrupt happens, but at
the same time we don't want to mass-expire timers at that point.

The solution is to suspend the entire timekeeping when the last CPU
is entering an idle state and resume it when the first CPU goes out
of idle.  That has to be done with care, though, so as to avoid
accessing suspended clocksources etc. end we need extra support
from idle drivers for that.

This series of commits adds support for quiescing timers during
suspend-to-idle and adds the requisite callbacks to intel_idle
and the ACPI cpuidle driver.  It contains a fix for an issue present
today which is very very difficult to trip over (that would involve
an NMI being traced during very late suspend or very early resume
when we're running with suspended timekeeping).

Thanks!


---------------

Rafael J. Wysocki (6):
      PM / sleep: Re-implement suspend-to-idle handling
      timekeeping: Pass readout base to update_fast_timekeeper()
      timekeeping: Make it safe to use the fast timekeeper while suspended
      PM / sleep: Make it possible to quiesce timers during suspend-to-idle
      intel_idle: Add ->enter_freeze callbacks
      ACPI / idle: Implement ->enter_freeze callback routine

---------------

 drivers/acpi/processor_idle.c |  48 +++++++++--
 drivers/cpuidle/cpuidle.c     |  94 ++++++++++++++++------
 drivers/idle/intel_idle.c     | 179 +++++++++++++++++++++++++++++-------------
 include/linux/cpuidle.h       |  13 ++-
 include/linux/suspend.h       |  16 ++++
 include/linux/tick.h          |   6 +-
 kernel/power/suspend.c        |  43 ++++++++--
 kernel/sched/idle.c           |  16 ++++
 kernel/time/tick-common.c     |  50 ++++++++++++
 kernel/time/timekeeping.c     |  48 ++++++++---
 kernel/time/timekeeping.h     |   2 +
 11 files changed, 407 insertions(+), 108 deletions(-)

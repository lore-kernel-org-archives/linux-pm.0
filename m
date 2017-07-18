From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH v2 0/4] PM / Suspend: Print wall time
Date: Tue, 18 Jul 2017 14:18:05 -0700
Message-ID: <20170718211813.122971-1-salyzyn@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@android.com>
List-Id: linux-pm@vger.kernel.org

Helpful for post-mortem analysis to synchronize CLOCK_MONOTONIC
kernel logs with CLOCK_REALTIME user space logs.  Post-mortem
analysis for Battery and Power diagnosis.  Improved reporting
of suspension times against the rtc wallclock, which is
persistent even at the lowest power management states.

analyze_suspend.py requires a configured kernel to debug, these
prints can remain in a field product with CONFIG_RTC_TIME_SHOW.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2:
- move implementation to kernel timekeeping from rtc_lib files
- use rtc_time64_to_tm() instead of rtc_time_to_tm()
- use inline in include/linux/rtc.h for !CONFIG_RTC_SHOW_TIME
- use late_initcall to ensure rtc_lib driver(s) are loaded

---
 include/linux/rtc.h         |    5 ++
 kernel/power/hibernate.c    |    4 +-
 kernel/power/suspend.c      |    3 +
 kernel/time/Kconfig         |   11 +++++
 kernel/time/Makefile        |    1 
 kernel/time/rtc_show_time.c |   82 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 105 insertions(+), 1 deletion(-)

From: Chen Yu <yu.c.chen@intel.com>
Subject: [RFC,v3] timekeeping: Limit the sleep time to avoid overflow
Date: Sat, 30 Jul 2016 23:27:45 +0800
Message-ID: <1469892465-15853-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16043 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753243AbcG3PUd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 30 Jul 2016 11:20:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>
Cc: Chen Yu <yu.c.chen@intel.com>, "Stable # 3 . 17+" <stable@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Xunlei Pang <xpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

It is reported the hibernation fails at 2nd attempt, which
hangs at hibernate() -> syscore_resume() -> i8237A_resume()
-> claim_dma_lock(), because the lock has already been taken.
However there is actually no other process would like to grab
this lock on that problematic platform.

Further investigation shows that, the problem is triggered by
setting /sys/power/pm_trace to 1 before the 1st hibernation.
Since once pm_trace is enabled, the rtc becomes unmeaningful
after suspend, and meanwhile some BIOSes would like to adjust
the 'invalid' tsc(e.g, smaller than 1970) to the release date
of that motherboard during POST stage, thus after resumed, a
significant long sleep time might be generated due to meaningless
tsc delta, thus in timekeeping_resume -> tk_debug_account_sleep_time,
if the bit31 happened to be set to 1, the fls returns 32 and then we
add 1 to sleep_time_bin[32], which caused a memory overwritten.
As depicted by System.map:

ffffffff81c9d080 b sleep_time_bin
ffffffff81c9d100 B dma_spin_lock

the dma_spin_lock.val is set to 1, which caused this problem.

In theory we can avoid the overflow by ignoring the idle injection
if pm_trace is enabled, but we might still miss other cases which
might also break the rtc, e.g, buggy clocksoure/rtc driver,
or even user space tool such as hwclock -- so there is no generic
method to dertermin whether we should trust the tsc.

A simpler way is to set the threshold for the sleep time, and
ignore those abnormal ones. This patch sets the upper limit of
sleep seconds to 0x7fffffff, since no one is likely to sleep
that long(68 years).

Cc: Stable <stable@vger.kernel.org> # 3.17+
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Xunlei Pang <xpang@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Reported-and-tested-by: Janek Kozicki <cosurgi@gmail.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/time/timekeeping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3b65746..17bc72c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1509,6 +1509,7 @@ void __init timekeeping_init(void)
 
 /* time in seconds when suspend began for persistent clock */
 static struct timespec64 timekeeping_suspend_time;
+#define MAX_SLEEP_TIME 0x7fffffff
 
 /**
  * __timekeeping_inject_sleeptime - Internal function to add sleep interval
@@ -1520,7 +1521,8 @@ static struct timespec64 timekeeping_suspend_time;
 static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 					   struct timespec64 *delta)
 {
-	if (!timespec64_valid_strict(delta)) {
+	if (!timespec64_valid_strict(delta) ||
+	     delta->tv_sec > MAX_SLEEP_TIME) {
 		printk_deferred(KERN_WARNING
 				"__timekeeping_inject_sleeptime: Invalid "
 				"sleep delta value!\n");
-- 
2.7.4


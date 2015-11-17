From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 14/27] tick: get next wakeup event for the CPU
Date: Tue, 17 Nov 2015 15:37:38 -0700
Message-ID: <1447799871-56374-15-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36701 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932545AbbKQWir (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:38:47 -0500
Received: by pacdm15 with SMTP id dm15so22081230pac.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:38:47 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

CPUidle governors use the sleep time of the CPU to determine the idle
state of the CPU. However, to determine a common sleep time between CPUs
that enter idle at different times, the tick_nohz_get_sleep_length() API
is not very helpful.

Add API to read the next event for the CPU. The value can be evaluated
at any time to determine the remaining sleep time of the CPU.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/tick.h     | 10 ++++++++++
 kernel/time/tick-sched.c |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index e312219..6db3e52 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -103,6 +103,7 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
+extern ktime_t tick_nohz_get_next_wakeup(void);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -116,6 +117,15 @@ static inline ktime_t tick_nohz_get_sleep_length(void)
 
 	return len;
 }
+
+static inline ktime_t tick_nohz_get_next_wakeup(void)
+{
+	ktime_t len = { .tv64 = NSEC_PER_SEC/HZ };
+
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(len, ktime_get());
+}
+
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7c7ec45..e130edd 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -870,6 +870,14 @@ ktime_t tick_nohz_get_sleep_length(void)
 	return ts->sleep_length;
 }
 
+ktime_t tick_nohz_get_next_wakeup(void)
+{
+	struct clock_event_device *dev =
+			__this_cpu_read(tick_cpu_device.evtdev);
+
+	return dev->next_event;
+}
+
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-- 
2.1.4


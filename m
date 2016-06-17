From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [RESEND PATCH v2 2/2] power/idle: enhance the precision of sleep_length
Date: Fri, 17 Jun 2016 17:13:36 +0800
Message-ID: <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33434 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbcFQJOD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 05:14:03 -0400
Received: by mail-pa0-f45.google.com with SMTP id b13so26932160pat.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2016 02:14:02 -0700 (PDT)
In-Reply-To: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, zhaoyang.huang@spreadtrum.com, tglx@linutronix.de

There should be a gap between tick_nohz_idle_enter and
tick_nohz_get_sleep_length when idle, which will cause the
sleep_length is not very precised. Change it in this patch.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 kernel/time/tick-sched.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 536ada8..ee3be3d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -975,6 +975,11 @@ void tick_nohz_irq_exit(void)
 ktime_t tick_nohz_get_sleep_length(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
+	ktime_t now;
+
+	now = ktime_get();
+	ts->sleep_length = ktime_sub(dev->next_event, now);
 
 	return ts->sleep_length;
 }
-- 
1.7.9.5


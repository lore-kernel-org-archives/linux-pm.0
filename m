From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: schedutil: Rectify comment in sugov_irq_work() function
Date: Thu, 24 Nov 2016 13:51:11 +0530
Message-ID: <94dc68617a6c8e42de4f225b1860d9d65d11b4aa.1479975620.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36444 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755116AbcKXIVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 03:21:51 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so16036634pgc.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Nov 2016 00:21:51 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>

This patch rectifies a comment present in sugov_irq_work() function to
follow proper grammar.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 42a220e78f00..71e1a980d40a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -315,15 +315,15 @@ static void sugov_irq_work(struct irq_work *irq_work)
 	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
 
 	/*
-	 * For Real Time and Deadline tasks, schedutil governor shoots the
-	 * frequency to maximum. And special care must be taken to ensure that
-	 * this kthread doesn't result in that.
+	 * For Real Time and Deadline tasks, the schedutil governor shoots the
+	 * frequency to maximum. Special care must be taken to ensure that this
+	 * kthread doesn't result in the same behavior.
 	 *
 	 * This is (mostly) guaranteed by the work_in_progress flag. The flag is
-	 * updated only at the end of the sugov_work() and before that schedutil
-	 * rejects all other frequency scaling requests.
+	 * updated only at the end of the sugov_work() function and before that
+	 * the schedutil governor rejects all other frequency scaling requests.
 	 *
-	 * Though there is a very rare case where the RT thread yields right
+	 * There is a very rare case though, where the RT thread yields right
 	 * after the work_in_progress flag is cleared. The effects of that are
 	 * neglected for now.
 	 */
-- 
2.7.1.410.g6faf27b


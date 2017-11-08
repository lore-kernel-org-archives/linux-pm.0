From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] schedutil: Reset cached freq if it is not in sync with next_freq
Date: Wed,  8 Nov 2017 20:23:55 +0530
Message-ID: <2897534536b2506cbdbd5f8ace6f1c2dcdad189d.1510152832.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:51212 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbdKHOyF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 09:54:05 -0500
Received: by mail-pg0-f66.google.com with SMTP id p9so2030023pgc.8
        for <linux-pm@vger.kernel.org>; Wed, 08 Nov 2017 06:54:05 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org

'cached_raw_freq' is used to get the next frequency quickly but should
always be in sync with sg_policy->next_freq. There is a case where it is
not and in such cases it should be reset to avoid switching to incorrect
frequencies.

Consider this case for example:
- policy->cur is 1.2 GHz (Max)
- New request comes for 780 MHz and we store that in cached_raw_freq.
- Based on 780 MHz, we calculate the effective frequency as 800 MHz.
- We then see the CPU wasn't idle recently and choose to keep the next
  freq as 1.2 GHz.
- Now we have cached_raw_freq is 780 MHz and sg_policy->next_freq is 1.2
  GHz.
- Now if the utilization doesn't change in then next request, then the
  next target frequency will still be 780 MHz and it will match with
  cached_raw_freq. But we will choose 1.2 GHz instead of 800 MHz here.

Change-Id: I71bd31a1b59d27c26c0b4885301e4ba6155c2c51
Cc: <stable@vger.kernel.org> # 4.12
Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ba0da243fdd8..2f52ec0f1539 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -282,8 +282,12 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 		 * Do not reduce the frequency if the CPU has not been idle
 		 * recently, as the reduction is likely to be premature then.
 		 */
-		if (busy && next_f < sg_policy->next_freq)
+		if (busy && next_f < sg_policy->next_freq) {
 			next_f = sg_policy->next_freq;
+
+			/* Reset cached freq as next_freq has changed */
+			sg_policy->cached_raw_freq = 0;
+		}
 	}
 	sugov_update_commit(sg_policy, time, next_f);
 }
-- 
2.15.0.rc1.236.g92ea95045093

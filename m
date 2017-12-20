From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH RESEND] cpufreq: schedutil: Use idle_calls counter of the
 remote CPU
Date: Wed, 20 Dec 2017 09:44:35 -0800
Message-ID: <ae8b2abd-d466-ff0e-a4d3-dc5c12e93cf4@google.com>
References: <20171219174712.13806-1-joelaf@google.com>
 <20171219184811.campbfjw3plynurs@hirez.programming.kicks-ass.net>
 <CAJWu+orWw6TFy165d1a=Fk4AfGNfSvcZ9SGj5KKD6V4YSqK50g@mail.gmail.com>
 <1680359.YAEeiLAcPD@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45825 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755620AbdLTRoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 12:44:39 -0500
Received: by mail-pl0-f68.google.com with SMTP id o2so9418804plk.12
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2017 09:44:39 -0800 (PST)
In-Reply-To: <1680359.YAEeiLAcPD@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Chris Redpath <Chris.Redpath@arm.com>, Steve Muckle <smuckle@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Ramussen <morten.rasmussen@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Saravana Kannan <skannan@quicinc.com>, Vikram Mulukutla <markivx@codeaurora.org>, Rohit Jain <rohit.k.jain@oracle.com>, Atish Patra <atish.patra@ora>

Hi Rafael,

On 12/20/2017 06:45 AM, Rafael J. Wysocki wrote:
> On Tuesday, December 19, 2017 8:32:09 PM CET Joel Fernandes wrote:
>> On Tue, Dec 19, 2017 at 10:48 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> On Tue, Dec 19, 2017 at 09:47:12AM -0800, Joel Fernandes wrote:
>>>> Since the recent remote cpufreq callback work, its possible that a cpufreq
>>>> update is triggered from a remote CPU. For single policies however, the current
>>>> code uses the local CPU when trying to determine if the remote sg_cpu entered
>>>> idle or is busy. This is incorrect. To remedy this, compare with the nohz tick
>>>> idle_calls counter of the remote CPU.
>>>>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>>>
>>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> Sweet!
> 
> OK, so any chance to get a Fixes: tag for the patch?

Sure. Please find an inline patch below with all acks and fixes tag. thanks!

---8<---
From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] cpufreq: schedutil: Use idle_calls counter of the remote CPU

Since the recent remote cpufreq callback work, its possible that a cpufreq
update is triggered from a remote CPU. For single policies however, the current
code uses the local CPU when trying to determine if the remote sg_cpu entered
idle or is busy. This is incorrect. To remedy this, compare with the nohz tick
idle_calls counter of the remote CPU.

Fixes: 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 include/linux/tick.h             |  1 +
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/time/tick-sched.c         | 13 +++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index f442d1a42025..7cc35921218e 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -119,6 +119,7 @@ extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
+extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2f52ec0f1539..d6717a3331a1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -244,7 +244,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
 #ifdef CONFIG_NO_HZ_COMMON
 static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
 {
-	unsigned long idle_calls = tick_nohz_get_idle_calls();
+	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
 	bool ret = idle_calls == sg_cpu->saved_idle_calls;
 
 	sg_cpu->saved_idle_calls = idle_calls;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 99578f06c8d4..77555faf6fbc 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -985,6 +985,19 @@ ktime_t tick_nohz_get_sleep_length(void)
 	return ts->sleep_length;
 }
 
+/**
+ * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
+ * for a particular CPU.
+ *
+ * Called from the schedutil frequency scaling governor in scheduler context.
+ */
+unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
+{
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
+
+	return ts->idle_calls;
+}
+
 /**
  * tick_nohz_get_idle_calls - return the current idle calls counter value
  *

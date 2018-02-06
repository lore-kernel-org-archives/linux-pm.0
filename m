From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Tue, 6 Feb 2018 19:14:28 +0100
Message-ID: <68afaf84-893e-6770-b9f1-619cd2b6dc9c@evidence.eu.com>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <f574036c-7572-9b97-79a0-794ff48e4d49@evidence.eu.com>
 <20180206154319.GF5739@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55309 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbeBFSOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Feb 2018 13:14:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id 143so5484572wma.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Feb 2018 10:14:30 -0800 (PST)
In-Reply-To: <20180206154319.GF5739@e110439-lin>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

Hi Patrick,

Il 06/02/2018 16:43, Patrick Bellasi ha scritto:
> Hi Claudio,
> 
> On 06-Feb 11:55, Claudio Scordino wrote:
>> Hi Peter,
>>
>> Il 20/12/2017 16:30, Peter Zijlstra ha scritto:
>>>
>>> So I ended up with the below (on top of Juri's cpufreq-dl patches).
>>>
>>> It compiles, but that's about all the testing it had.
>>>
>>> --- a/include/linux/sched/cpufreq.h
>>> +++ b/include/linux/sched/cpufreq.h
> 
> [..]
> 
>>> @@ -188,17 +187,23 @@ static void sugov_get_util(struct sugov_
>>>   static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>>>   {
>>> +	unsigned long util = sg_cpu->util_cfs + sg_cpu->util_dl;
>>> +	struct rq *rq = cpu_rq(sg_cpu->cpu);
>>> +
>>> +	if (rq->rt.rt_nr_running)
>>> +		util = sg_cpu->max;
>>> +
>>>   	/*
>>>   	 * Ideally we would like to set util_dl as min/guaranteed freq and
>>>   	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>>>   	 * ready for such an interface. So, we only do the latter for now.
>>>   	 */
>>> -	return min(sg_cpu->util_cfs + sg_cpu->util_dl, sg_cpu->max);
>>> +	return min(util, sg_cpu->max);
>>>   }
> 
> [...]
> 
>>
>> What is the status of this patch ? I couldn't find it on the
>> tip/queue repositories.
>>
>> BTW, I wonder if we actually want to remove also the information
>> about the scheduling class who triggered the frequency change.
> 
> Removing flags was the main goal of the patch, since they represents
> mainly duplicated information which scheduling classes already know.
> 
> This was making flags update error prone and difficult to keep
> aligned with existing scheduling classes info.
> 
>> This prevents us from adopting class-specific behaviors.
> 
> In Peter's proposal he replaces flags with checks like:
> 
>     if (rq->rt.rt_nr_running)
> 
>> For example, we might want to skip the rate limits when deadline
>> asks for an increase of frequency, as shown in the patch below.
>> In this case, we could just remove the flags from sugov_cpu, but
>> leave the defines and the argument for sugov_update_*()
> 
> At first glance, your proposal below makes to make sense.
> 
> However, I'm wondering if we cannot get it working using
> rq->dl's provided information instead of flags?

Yes, we can use the value of rq->dl to check if there has been an increase of the deadline utilization.
Even if schedutil might have been triggered by a different scheduling class, the effect should be almost the same.

Below a potential patch. I've kept all frequency update decisions in a single point (i.e. sugov_should_update_freq).
Not yet tested (waiting for further comments).

Thanks,

                Claudio




 From 49a6eec60574ae93297406d40155e6ce4113e442 Mon Sep 17 00:00:00 2001
From: Claudio Scordino <claudio@evidence.eu.com>
Date: Tue, 6 Feb 2018 18:42:23 +0100
Subject: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE

When the SCHED_DEADLINE scheduling class asks to increase the CPU
frequency, we should not wait the rate limit, otherwise we may miss some
deadline.

This patch moves all frequency update decisions to a single point:
sugov_should_update_freq(). In addition, it ignores the rate limit
whenever there is an increase of the CPU frequency given by an increase
of the deadline utilization.

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
---
  kernel/sched/cpufreq_schedutil.c | 27 +++++++++++++++++++--------
  1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index b0bd77d..e8504f5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -74,7 +74,11 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
  
  /************************ Governor internals ***********************/
  
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy,
+				     u64 time,
+				     struct sugov_cpu *sg_cpu_old,
+				     struct sugov_cpu *sg_cpu_new,
+				     unsigned int next_freq)
  {
  	s64 delta_ns;
  
@@ -111,6 +115,14 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
  		return true;
  	}
  
+	/*
+	 * Ignore rate limit when DL asked to increase the CPU frequency,
+	 * otherwise we may miss some deadline.
+	 */
+	if ((next_freq > sg_policy->next_freq) &&
+			(sg_cpu_new->util_dl > sg_cpu_old->util_dl))
+		return true;
+
  	delta_ns = time - sg_policy->last_freq_update_time;
  	return delta_ns >= sg_policy->freq_update_delay_ns;
  }
@@ -271,6 +283,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
  				unsigned int flags)
  {
  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_cpu sg_cpu_old = *sg_cpu;
  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
  	unsigned long util, max;
  	unsigned int next_f;
@@ -279,9 +292,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
  	sugov_set_iowait_boost(sg_cpu, time, flags);
  	sg_cpu->last_update = time;
  
-	if (!sugov_should_update_freq(sg_policy, time))
-		return;
-
  	busy = sugov_cpu_is_busy(sg_cpu);
  
  	sugov_get_util(sg_cpu);
@@ -300,7 +310,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
  		sg_policy->cached_raw_freq = 0;
  	}
  
-	sugov_update_commit(sg_policy, time, next_f);
+	if (sugov_should_update_freq(sg_policy, time, &sg_cpu_old, sg_cpu, next_f))
+		sugov_update_commit(sg_policy, time, next_f);
  }
  
  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
@@ -350,6 +361,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
  				unsigned int flags)
  {
  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_cpu sg_cpu_old = *sg_cpu;
  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
  	unsigned int next_f;
  
@@ -359,10 +371,9 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
  	sugov_set_iowait_boost(sg_cpu, time, flags);
  	sg_cpu->last_update = time;
  
-	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, time);
+	next_f = sugov_next_freq_shared(sg_cpu, time);
+	if (sugov_should_update_freq(sg_policy, time, &sg_cpu_old, sg_cpu, next_f))
  		sugov_update_commit(sg_policy, time, next_f);
-	}
  
  	raw_spin_unlock(&sg_policy->update_lock);
  }
-- 
2.7.4

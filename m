From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue
 to SCHED_FIFO task
Date: Fri, 11 Nov 2016 17:31:41 -0800
Message-ID: <582670FD.7080203@codeaurora.org>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org> <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 11/11/2016 02:16 PM, Rafael J. Wysocki wrote:
> On Fri, Nov 11, 2016 at 11:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> If slow path frequency changes are conducted in a SCHED_OTHER context
>> then they may be delayed for some amount of time, including
>> indefinitely, when real time or deadline activity is taking place.
>>
>> Move the slow path to a real time kernel thread. In the future the
>> thread should be made SCHED_DEADLINE. The RT priority is arbitrarily set
>> to 50 for now.
>>
>> Hackbench results on ARM Exynos, dual core A15 platform for 10
>> iterations:
>>
>> $ hackbench -s 100 -l 100 -g 10 -f 20
>>
>> Before                  After
>> ---------------------------------
>> 1.808                   1.603
>> 1.847                   1.251
>> 2.229                   1.590
>> 1.952                   1.600
>> 1.947                   1.257
>> 1.925                   1.627
>> 2.694                   1.620
>> 1.258                   1.621
>> 1.919                   1.632
>> 1.250                   1.240
>>
>> Average:
>>
>> 1.8829                  1.5041
>>
>> Based on initial work by Steve Muckle.
>>
>> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 62 ++++++++++++++++++++++++++++++++--------
>>   1 file changed, 50 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index ccb2ab89affb..045ce0a4e6d1 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -12,6 +12,7 @@
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>>   #include <linux/cpufreq.h>
>> +#include <linux/kthread.h>
>>   #include <linux/slab.h>
>>   #include <trace/events/power.h>
>>
>> @@ -35,8 +36,10 @@ struct sugov_policy {
>>
>>          /* The next fields are only needed if fast switch cannot be used. */
>>          struct irq_work irq_work;
>> -       struct work_struct work;
>> +       struct kthread_work work;
>>          struct mutex work_lock;
>> +       struct kthread_worker worker;
>> +       struct task_struct *thread;
>>          bool work_in_progress;
>>
>>          bool need_freq_update;
>> @@ -291,9 +294,10 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>>          raw_spin_unlock(&sg_policy->update_lock);
>>   }
>>
>> -static void sugov_work(struct work_struct *work)
>> +static void sugov_work(struct kthread_work *work)
>>   {
>> -       struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
>> +       struct sugov_policy *sg_policy =
>> +               container_of(work, struct sugov_policy, work);
>
> Why this change?
>
>>
>>          mutex_lock(&sg_policy->work_lock);
>>          __cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
>> @@ -308,7 +312,7 @@ static void sugov_irq_work(struct irq_work *irq_work)
>>          struct sugov_policy *sg_policy;
>>
>>          sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
>> -       schedule_work_on(smp_processor_id(), &sg_policy->work);
>> +       kthread_queue_work(&sg_policy->worker, &sg_policy->work);
>>   }
>>
>>   /************************** sysfs interface ************************/
>> @@ -362,9 +366,23 @@ static struct kobj_type sugov_tunables_ktype = {
>>
>>   static struct cpufreq_governor schedutil_gov;
>>
>> +static void sugov_policy_free(struct sugov_policy *sg_policy)
>> +{
>> +       if (!sg_policy->policy->fast_switch_enabled) {
>> +               kthread_flush_worker(&sg_policy->worker);
>> +               kthread_stop(sg_policy->thread);
>> +       }
>> +
>> +       mutex_destroy(&sg_policy->work_lock);
>> +       kfree(sg_policy);
>> +}
>> +
>>   static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
>>   {
>>          struct sugov_policy *sg_policy;
>> +       struct task_struct *thread;
>> +       struct sched_param param = { .sched_priority = 50 };
>
> I'd define a symbol for the 50.  It's just one extra line of code ...
>

Hold on a sec. I thought during LPC someone (Peter?) made a point that 
when RT thread run, we should bump the frequency to max? So, schedutil 
is going to trigger schedutil to bump up the frequency to max, right?

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

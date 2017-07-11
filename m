From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v2 2/2] sched: Make iowait_boost optional in schedutil
Date: Tue, 11 Jul 2017 12:02:04 -0700
Message-ID: <596520AC.2030104@codeaurora.org>
References: <20170519062344.27692-1-joelaf@google.com> <20170519062344.27692-3-joelaf@google.com> <20170519065021.GK17481@vireshk-i7> <CAJWu+oqWtvSBfabBfVZM5LfGtrjmkQEGw=4LfNwqJgUKSmEiYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756533AbdGKTCS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 15:02:18 -0400
In-Reply-To: <CAJWu+oqWtvSBfabBfVZM5LfGtrjmkQEGw=4LfNwqJgUKSmEiYA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On 05/19/2017 09:10 AM, Joel Fernandes wrote:
> Hi Viresh,
>
> On Thu, May 18, 2017 at 11:50 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 18-05-17, 23:23, Joel Fernandes wrote:
>>> We should apply the iowait boost only if cpufreq policy has iowait boost
>>> enabled. Also make it a schedutil configuration from sysfs so it can be turned
>>> on/off if needed (by default initialize it to the policy value).
>>>
>>> For systems that don't need/want it enabled, such as those on arm64 based
>>> mobile devices that are battery operated, it saves energy when the cpufreq
>>> driver policy doesn't have it enabled (details below):
>>>
>>> Here are some results for energy measurements collected running a YouTube video
>>> for 30 seconds:
>>> Before: 8.042533 mWh
>>> After: 7.948377 mWh
>>> Energy savings is ~1.2%
>>>
>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>>> ---
>>>   kernel/sched/cpufreq_schedutil.c | 32 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>> index 76877a62b5fa..0e392b58b9b3 100644
>>> --- a/kernel/sched/cpufreq_schedutil.c
>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>> @@ -24,6 +24,7 @@
>>>   struct sugov_tunables {
>>>        struct gov_attr_set attr_set;
>>>        unsigned int rate_limit_us;
>>> +     bool iowait_boost_enable;
>>
>> I suggested s/iowait_boost_enable/iowait_boost/ and you said okay for
>> that change.
>
> Yes, I somehow only picked up 'bool' from your comment.  I'll drop the
> '_enable' in the next version. Sorry and thanks.
>
>>>   };
>>>
>>>   struct sugov_policy {
>>> @@ -171,6 +172,11 @@ static void sugov_get_util(unsigned long *util, unsigned long *max)
>>>   static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>>>                                   unsigned int flags)
>>>   {
>>> +     struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>>> +
>>> +     if (!sg_policy->tunables->iowait_boost_enable)
>>> +             return;
>>> +
>>>        if (flags & SCHED_CPUFREQ_IOWAIT) {
>>>                sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
>>>        } else if (sg_cpu->iowait_boost) {
>>> @@ -386,10 +392,34 @@ static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *bu
>>>        return count;
>>>   }
>>>
>>> +static ssize_t iowait_boost_enable_show(struct gov_attr_set *attr_set,
>>> +                                     char *buf)
>>> +{
>>> +     struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
>>> +
>>> +     return sprintf(buf, "%u\n", tunables->iowait_boost_enable);
>>> +}
>>> +
>>> +static ssize_t iowait_boost_enable_store(struct gov_attr_set *attr_set,
>>> +                                      const char *buf, size_t count)
>>> +{
>>> +     struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
>>> +     bool enable;
>>> +
>>> +     if (kstrtobool(buf, &enable))
>>> +             return -EINVAL;
>>> +
>>> +     tunables->iowait_boost_enable = enable;
>>> +
>>> +     return count;
>>> +}
>>> +
>>>   static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
>>> +static struct governor_attr iowait_boost_enable = __ATTR_RW(iowait_boost_enable);
>>>
>>>   static struct attribute *sugov_attributes[] = {
>>>        &rate_limit_us.attr,
>>> +     &iowait_boost_enable.attr,
>>>        NULL
>>>   };
>>
>> Do we really need this right now? I mean, are you going to use it this
>> way? It may never get used eventually and may be better to leave the
>> sysfs option for now.
>
> I felt it is good to leave it to the system designer and have the
> policy set a 'default' value, so incase it isn't touched by the
> designer from userspace, then the policy default is fine, and if the
> designer chooses to change it then he has the option to. This is also
> how we currently set the rate limits for schedutil in android. I don't
> feel strongly about one way or the other and if the general consensus
> is to drop this part then I'm fine. I'm curious to know what others
> think as well though.
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>



-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

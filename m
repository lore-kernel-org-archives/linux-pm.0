From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [Eas-dev] [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq
 callbacks
Date: Wed, 26 Jul 2017 14:00:10 -0700
Message-ID: <597902DA.8060608@codeaurora.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org> <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org> <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdGZVAM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 17:00:12 -0400
In-Reply-To: <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, eas-dev@lists.linaro.org, smuckle.linux@gmail.com, Len Brown <lenb@kernel.org>

On 07/21/2017 06:03 AM, Peter Zijlstra wrote:
> On Thu, Jul 13, 2017 at 12:14:37PM +0530, Viresh Kumar wrote:
>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> index 47e24b5384b3..606b1a37a1af 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -275,6 +275,10 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
>>   	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
>>   	u64 delta_ns, lst;
>>
>> +	/* Don't allow remote callbacks */
>> +	if (smp_processor_id() != data->cpu)
>> +		return;
>> +
>
> The alternative is using some of that policy_dbs->policy->*cpus crud I
> suppose, because:

No, the alternative is to pass it on to the CPU freq driver and let it 
decide what it wants to do. That's the whole point if having a CPU freq 
driver -- so that the generic code doesn't need to care about HW 
specific details. Which is the point I was making in an earlier email to 
Viresh's patch -- we shouldn't be doing any CPU check for the call backs 
at the scheduler or ever governor level.

That would simplify this whole thing by deleting a bunch of code. And 
having much simpler checks in those drivers that actually have to deal 
with their HW specific details.


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

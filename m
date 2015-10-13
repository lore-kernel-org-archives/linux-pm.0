From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 1/5] cpufreq: Use cpumask_copy instead of cpumask_or to
 copy a mask
Date: Tue, 13 Oct 2015 12:22:43 -0700
Message-ID: <561D5A03.3010204@codeaurora.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org> <b8dc587ec7767b89b1d24f1348acd1a341e54a4a.1444583718.git.viresh.kumar@linaro.org> <561C0638.8060105@codeaurora.org> <20151013032301.GL5386@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151013032301.GL5386@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/12/2015 08:23 PM, Viresh Kumar wrote:
> On 12-10-15, 12:12, Saravana Kannan wrote:
>>>   	if (new_policy) {
>>>   		/* related_cpus should at least include policy->cpus. */
>>> -		cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
>>> +		cpumask_copy(policy->related_cpus, policy->cpus);
>>
>> Again, why? It actually seems wrong. A 4 core cluster could come up
>> with just 2 cores when the policy is added. But the related CPUs
>> would be 4 CPUs.
>
> Firstly, the patch hasn't changed anything at all. related_cpus was
> empty until this point, and orring or setting it with ->cpus will
> result in the same output.

I was under the impression that the CPUfreq drivers were expected to 
fill in related_cpus and the or-ing was a safety net. If that's not the 
case, then this change is fine.

> Secondly, this is what we always wanted. related_cpus should contain
> the mask of all possible CPUs for that cluster.

I think the confusion was that I thought the drivers are supposed to do 
this. If this doesn't mess up other CPUfreq drivers that I'm not 
familiar with, then I don't have concerns.

Can you still explain the why in the commit text though? If it's just 
that related_cpus is always empty and copying is more efficient than 
or-ing, then mention that?

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

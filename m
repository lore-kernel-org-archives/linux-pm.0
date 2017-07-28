From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [Eas-dev] [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq
 callbacks
Date: Fri, 28 Jul 2017 14:05:39 -0700
Message-ID: <597BA723.1060908@codeaurora.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org> <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org> <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net> <597902DA.8060608@codeaurora.org> <20170727033059.GD352@vireshk-i7> <597A452C.7000303@codeaurora.org> <20170728060054.GU352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbdG1VFl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 17:05:41 -0400
In-Reply-To: <20170728060054.GU352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: eas-dev@lists.linaro.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, smuckle.linux@gmail.com, Len Brown <lenb@kernel.org>

On 07/27/2017 11:00 PM, Viresh Kumar wrote:
> On 27-07-17, 12:55, Saravana Kannan wrote:
>> Yes. Simplifying isn't always about number of lines of code. It's also about
>> abstraction. Having generic scheduler code care about HW details doesn't
>> seem nice.
>
> I can argue that even the policy->cpus field is also hardware
> specific, isn't it ?

Yes.
> And we are using that in the schedutil governor
> anyway.
Yes

> What's wrong with having another field (in a generic way) in
> the same structure that tells us more about hardware ?

Nothing wrong. I'm not saying you shouldn't have the cpu field in the 
data or as a parameter to the hook. You'll definitely need that.

> And then schedutil isn't really scheduler, but a cpufreq governor.
> Just like ondemand/conservative, which are also called from the same
> scheduler path.

Exactly. I never debated anything about schedutil. I'm just saying don't 
have any CPU limitations or check on the scheduler side when sending 
notification. Scheduler shouldn't have to know/care of the driver can 
only set the freq on that CPU or across CPUs in a cluster or across the 
entire system.

>> It'll literally one simple check (cpu == smp_processor_id()) or (cpu "in"
>> policy->cpus).
>>
>> Also, this is only for drivers that currently support fast switching. How
>> many of those do you have?
>
> Why? Why shouldn't we do that for the other drivers? I think it should
> be done across everyone.

Because if I remember it right, the "don't send the notification if it's 
not the same CPU" limitation is only for the fast switching case?  I 
might be mistaken about this part though.

>>> The core already has most of the data required and I believe that we
>>> need to handle it in the governor's code as is handled in this series.
>>
>> Clearly, it doesn't. You are just making assumptions about HW.
>
> So assuming that any CPU from a policy can change freq on behalf of
> all the CPUs of the same policy is wrong? That is the basis of how the
> cpufreq core is designed.

1. I'm not saying that. I'm saying assuming CPUs can change the freq 
only on behalf of all the CPUs in the same policy is wrong. Again, the 
scheduler or governor shouldn't even be making any of that assumption. 
That's a CPUfreq driver problem.

2. No, that is not the basis of the entire cpufreq core design. None of 
the existing CPUfreq code has any assumptions that only CPUs in a policy 
can change their frequency. It doesn't break in any way in system where 
any CPU can change any other CPU's frequency -- all Qualcomm chips are 
like that. It's only the recent scheduler notifier changes that are 
adding this additional limitation and breaking stuff for systems where 
any CPU can change any other CPU's frequency.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

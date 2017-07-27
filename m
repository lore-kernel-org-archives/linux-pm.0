From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [Eas-dev] [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq
 callbacks
Date: Thu, 27 Jul 2017 12:55:24 -0700
Message-ID: <597A452C.7000303@codeaurora.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org> <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org> <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net> <597902DA.8060608@codeaurora.org> <20170727033059.GD352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdG0Tz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 15:55:26 -0400
In-Reply-To: <20170727033059.GD352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: eas-dev@lists.linaro.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, smuckle.linux@gmail.com, Len Brown <lenb@kernel.org>

On 07/26/2017 08:30 PM, Viresh Kumar wrote:
> On 26-07-17, 14:00, Saravana Kannan wrote:
>> No, the alternative is to pass it on to the CPU freq driver and let it
>> decide what it wants to do. That's the whole point if having a CPU freq
>> driver -- so that the generic code doesn't need to care about HW specific
>> details. Which is the point I was making in an earlier email to Viresh's
>> patch -- we shouldn't be doing any CPU check for the call backs at the
>> scheduler or ever governor level.
>>
>> That would simplify this whole thing by deleting a bunch of code. And having
>> much simpler checks in those drivers that actually have to deal with their
>> HW specific details.
>
> So what you are saying is that we go and update (almost) every cpufreq
> driver we have today and make their ->target() callbacks return early
> if they don't support switching frequency remotely ? Is that really
> simplifying anything?

Yes. Simplifying isn't always about number of lines of code. It's also 
about abstraction. Having generic scheduler code care about HW details 
doesn't seem nice.

It'll literally one simple check (cpu == smp_processor_id()) or (cpu 
"in" policy->cpus).

Also, this is only for drivers that currently support fast switching. 
How many of those do you have?

> The core already has most of the data required and I believe that we
> need to handle it in the governor's code as is handled in this series.

Clearly, it doesn't. You are just making assumptions about HW.

> To solve the problem that you have been reporting (update from any
> CPU), we need something like this which I earlier suggested and I
> will come back to it after this series is gone. Don't want to
> complicate things here unnecessarily.
>
> https://marc.info/?l=linux-kernel&m=148906012827786&w=2

I'm okay with handling it later. I'm just saying that if we are going to 
go back and debate the CPU check, then maybe it's better do it in one 
series.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

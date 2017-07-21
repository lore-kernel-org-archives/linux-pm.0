From: Vikram Mulukutla <markivx@codeaurora.org>
Subject: Re: cpuidle and cpufreq coupling?
Date: Thu, 20 Jul 2017 17:11:01 -0700
Message-ID: <6b28e6f3-d961-24c8-ad90-8cd6cd844236@codeaurora.org>
References: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
 <CAJZ5v0i2B0=cPB5VxXJUb36LW9hp_L7k-moj+Eg+vPvfPHFcSA@mail.gmail.com>
 <20170720071846.GK352@vireshk-i7>
 <CAJZ5v0hxK9iBR4RJBu9yutn7M=uTfsEwZZcwJie=17RuYtnuNA@mail.gmail.com>
 <20170720144530.da6bqpdvt2cvbjjs@hirez.programming.kicks-ass.net>
 <a237a845-c24e-c1dc-c910-e09a69d631b6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964809AbdGUALC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 20:11:02 -0400
In-Reply-To: <a237a845-c24e-c1dc-c910-e09a69d631b6@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Markus Mayer <code@mmayer.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 7/20/2017 3:56 PM, Florian Fainelli wrote:
> On 07/20/2017 07:45 AM, Peter Zijlstra wrote:

<snip>

>> 
>> Can your ARM part change OPP without scheduling? Because (for obvious
>> reasons) the idle thread is not supposed to block.
> 
> I think it should be able to do that, but I am not sure that if I went
> through the cpufreq API it would be that straight forward so I may have
> to re-implement some of the frequency scaling logic outside of cpufreq
> (or rather make the low-level parts some kind of library I guess).
> 

I think I can safely mention that some of our non-upstream idle drivers
in the past have invoked low level clock drivers to atomically switch
CPUs to low frequency OPPs, with no interaction whatsoever with cpufreq.
It was maintainable since both the idle and clock drivers were
qcom-specific. However this is no longer necessary in recent designs and
I really hope we never need to do this again...

We didn't have to do a voltage switch and just PLL or mux
work so this was doable. I'm guessing your atomic switching also allows
voltage reduction?

If your architecture allows another CPU to change the entering-idle 
CPU's
frequency, synchronization will be necessary as well - this is where it
can get a bit tricky.

Thanks,
Vikram

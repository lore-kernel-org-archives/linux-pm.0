From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: cpuidle and cpufreq coupling?
Date: Thu, 20 Jul 2017 17:30:38 -0700
Message-ID: <7d60dab4-f461-39d2-f1b6-12f053347bd9@gmail.com>
References: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
 <CAJZ5v0i2B0=cPB5VxXJUb36LW9hp_L7k-moj+Eg+vPvfPHFcSA@mail.gmail.com>
 <20170720071846.GK352@vireshk-i7>
 <CAJZ5v0hxK9iBR4RJBu9yutn7M=uTfsEwZZcwJie=17RuYtnuNA@mail.gmail.com>
 <20170720144530.da6bqpdvt2cvbjjs@hirez.programming.kicks-ass.net>
 <a237a845-c24e-c1dc-c910-e09a69d631b6@gmail.com>
 <6b28e6f3-d961-24c8-ad90-8cd6cd844236@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36501 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964809AbdGUAap (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 20:30:45 -0400
In-Reply-To: <6b28e6f3-d961-24c8-ad90-8cd6cd844236@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vikram Mulukutla <markivx@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Markus Mayer <code@mmayer.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 07/20/2017 05:11 PM, Vikram Mulukutla wrote:
> On 7/20/2017 3:56 PM, Florian Fainelli wrote:
>> On 07/20/2017 07:45 AM, Peter Zijlstra wrote:
> 
> <snip>
> 
>>>
>>> Can your ARM part change OPP without scheduling? Because (for obvious
>>> reasons) the idle thread is not supposed to block.
>>
>> I think it should be able to do that, but I am not sure that if I went
>> through the cpufreq API it would be that straight forward so I may have
>> to re-implement some of the frequency scaling logic outside of cpufreq
>> (or rather make the low-level parts some kind of library I guess).
>>
> 
> I think I can safely mention that some of our non-upstream idle drivers
> in the past have invoked low level clock drivers to atomically switch
> CPUs to low frequency OPPs, with no interaction whatsoever with cpufreq.
> It was maintainable since both the idle and clock drivers were
> qcom-specific. However this is no longer necessary in recent designs and
> I really hope we never need to do this again...

Yes same here, this is for a past generation product, current generation
has a smarter design that so far does not require that.

> 
> We didn't have to do a voltage switch and just PLL or mux
> work so this was doable. I'm guessing your atomic switching also allows
> voltage reduction?

Correct there is a voltage reduction occurring which is largely under
control of a separate MCU/firmware.

> 
> If your architecture allows another CPU to change the entering-idle CPU's
> frequency, synchronization will be necessary as well - this is where it
> can get a bit tricky.

That is a very good point, the frequency scaling is not per-CPU but for
the entire CPU complex (up to 4 cores) so that might indeed be a problem.

Thanks!
-- 
Florian

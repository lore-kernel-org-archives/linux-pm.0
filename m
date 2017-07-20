From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: cpuidle and cpufreq coupling?
Date: Thu, 20 Jul 2017 15:56:05 -0700
Message-ID: <a237a845-c24e-c1dc-c910-e09a69d631b6@gmail.com>
References: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
 <CAJZ5v0i2B0=cPB5VxXJUb36LW9hp_L7k-moj+Eg+vPvfPHFcSA@mail.gmail.com>
 <20170720071846.GK352@vireshk-i7>
 <CAJZ5v0hxK9iBR4RJBu9yutn7M=uTfsEwZZcwJie=17RuYtnuNA@mail.gmail.com>
 <20170720144530.da6bqpdvt2cvbjjs@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32954 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbdGTW4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 18:56:12 -0400
In-Reply-To: <20170720144530.da6bqpdvt2cvbjjs@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Markus Mayer <code@mmayer.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 07/20/2017 07:45 AM, Peter Zijlstra wrote:
> On Thu, Jul 20, 2017 at 11:52:41AM +0200, Rafael J. Wysocki wrote:
>> On Thu, Jul 20, 2017 at 9:18 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> On 20-07-17, 01:17, Rafael J. Wysocki wrote:
>>>> On Thu, Jul 20, 2017 at 12:54 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> We have a particular ARM CPU design that is drawing quite a lot of
>>>>> current upon exit from WFI, and it does so in a way even before the
>>>>> first instruction out of WFI is executed. That means we cannot influence
>>>>> directly the exit from WFI other than by changing the state in which it
>>>>> would be previously entered because of this "dead" time during which the
>>>>> internal logic needs to ramp up back where it left.
>>>>>
>>>>> A naive approach to solving this problem because we have CPU frequency
>>>>> scaling available would be to do the following:
>>>>>
>>>>> - just before entering WFI, switch to a low frequency OPP
>>>>> - enter WFI
>>>>> - upon exit from WFI, ramp up the frequency back to e.g: highest OPP
>>>>>
>>>>> Some of the parts that I am not exactly clear on would be:
>>>>>
>>>>> - would that qualify as a cpuidle governor of some kind that ties in
>>>>> which cpufreq?
>>>>> - would using cpufreq_driver_fast_switch() be an appropriate API to use
>>>>> from outside
> 
> Can your ARM part change OPP without scheduling? Because (for obvious
> reasons) the idle thread is not supposed to block.

I think it should be able to do that, but I am not sure that if I went
through the cpufreq API it would be that straight forward so I may have
to re-implement some of the frequency scaling logic outside of cpufreq
(or rather make the low-level parts some kind of library I guess).

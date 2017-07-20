From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: cpuidle and cpufreq coupling?
Date: Thu, 20 Jul 2017 16:01:35 -0700
Message-ID: <df0f7bc6-e8ee-1e51-dec5-9890e54f7ac7@gmail.com>
References: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
 <CAJZ5v0i2B0=cPB5VxXJUb36LW9hp_L7k-moj+Eg+vPvfPHFcSA@mail.gmail.com>
 <20170720071846.GK352@vireshk-i7>
 <49e8479c-bc47-16fe-0bf9-8a4aba333909@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38198 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936121AbdGTXBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 19:01:43 -0400
In-Reply-To: <49e8479c-bc47-16fe-0bf9-8a4aba333909@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Markus Mayer <code@mmayer.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 07/20/2017 02:23 AM, Sudeep Holla wrote:
> 
> 
> On 20/07/17 08:18, Viresh Kumar wrote:
>> On 20-07-17, 01:17, Rafael J. Wysocki wrote:
>>> On Thu, Jul 20, 2017 at 12:54 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> We have a particular ARM CPU design that is drawing quite a lot of
>>>> current upon exit from WFI, and it does so in a way even before the
>>>> first instruction out of WFI is executed. That means we cannot influence
>>>> directly the exit from WFI other than by changing the state in which it
>>>> would be previously entered because of this "dead" time during which the
>>>> internal logic needs to ramp up back where it left.
>>>>
>>>> A naive approach to solving this problem because we have CPU frequency
>>>> scaling available would be to do the following:
>>>>
>>>> - just before entering WFI, switch to a low frequency OPP
>>>> - enter WFI
>>>> - upon exit from WFI, ramp up the frequency back to e.g: highest OPP
>>>>
>>>> Some of the parts that I am not exactly clear on would be:
>>>>
>>>> - would that qualify as a cpuidle governor of some kind that ties in
>>>> which cpufreq?
>>>> - would using cpufreq_driver_fast_switch() be an appropriate API to use
>>>> from outside
>>>
>>> Generally, the idle driver is expected to manipulate OPPs as suitable
>>> for it at the low level.
>>
>> Does any idle driver do it today ?
> 
>> I am not sure, but I haven't heard anyone from ARM doing it. Though I
>> may have completely missed it :)
>>
> 
> It doesn't need to be in Linux. E.g. PSCI or any low lever driver can do
> that transparently.

Not everything is PSCI-based, this platform is ARM (32_bit) and now
several years old, still, the logic and spirit remains largely the same.

> 
>> So, that must call into cpufreq (somehow) and look for a low power
>> OPP?
>>
> 
> That's seems hacky and NAK if it's PSCI platform. It's cleaner do such
> hacks/workarounds in platform specific PSCI firmware.
> 
>> @Florian: It would be more tricky then we anticipate. We don't always
>> want to go to low OPP on idle, as we may get out of it very quickly
>> and changing OPP twice (before and after idle) in that scenario would
>> be a complete waste of time.
> 
> Exactly.
> 

I completely agree, this is a trade-off between creating a big but short
spike of energy that a poorly designed regulator/power distribution may
not handle versus creating a smaller amplitude, but longer in time
energy need.

The key point is that if your only lowest OPP is the lowest CPU
frequency, and the low-level logic to make that happen is there already
in the cpufreq driver, can we somehow both utilize it, and feed back its
latency into cpuidle, or should the cpufreq driver have hooks into
cpuidle (either way is probably fine, but the former scales better to
the number of diverse cpufreq drivers out there).

Thanks!
-- 
Florian

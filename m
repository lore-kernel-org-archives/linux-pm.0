From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: cpuidle and cpufreq coupling?
Date: Thu, 20 Jul 2017 10:23:27 +0100
Message-ID: <49e8479c-bc47-16fe-0bf9-8a4aba333909@arm.com>
References: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
 <CAJZ5v0i2B0=cPB5VxXJUb36LW9hp_L7k-moj+Eg+vPvfPHFcSA@mail.gmail.com>
 <20170720071846.GK352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720071846.GK352@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Markus Mayer <code@mmayer.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 20/07/17 08:18, Viresh Kumar wrote:
> On 20-07-17, 01:17, Rafael J. Wysocki wrote:
>> On Thu, Jul 20, 2017 at 12:54 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> Hi,
>>>
>>> We have a particular ARM CPU design that is drawing quite a lot of
>>> current upon exit from WFI, and it does so in a way even before the
>>> first instruction out of WFI is executed. That means we cannot influence
>>> directly the exit from WFI other than by changing the state in which it
>>> would be previously entered because of this "dead" time during which the
>>> internal logic needs to ramp up back where it left.
>>>
>>> A naive approach to solving this problem because we have CPU frequency
>>> scaling available would be to do the following:
>>>
>>> - just before entering WFI, switch to a low frequency OPP
>>> - enter WFI
>>> - upon exit from WFI, ramp up the frequency back to e.g: highest OPP
>>>
>>> Some of the parts that I am not exactly clear on would be:
>>>
>>> - would that qualify as a cpuidle governor of some kind that ties in
>>> which cpufreq?
>>> - would using cpufreq_driver_fast_switch() be an appropriate API to use
>>> from outside
>>
>> Generally, the idle driver is expected to manipulate OPPs as suitable
>> for it at the low level.
> 
> Does any idle driver do it today ?

> I am not sure, but I haven't heard anyone from ARM doing it. Though I
> may have completely missed it :)
> 

It doesn't need to be in Linux. E.g. PSCI or any low lever driver can do
that transparently.

> So, that must call into cpufreq (somehow) and look for a low power
> OPP?
> 

That's seems hacky and NAK if it's PSCI platform. It's cleaner do such
hacks/workarounds in platform specific PSCI firmware.

> @Florian: It would be more tricky then we anticipate. We don't always
> want to go to low OPP on idle, as we may get out of it very quickly
> and changing OPP twice (before and after idle) in that scenario would
> be a complete waste of time.

Exactly.

-- 
Regards,
Sudeep

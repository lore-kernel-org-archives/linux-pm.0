From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
Date: Wed, 7 Mar 2018 16:29:38 +0530
Message-ID: <CAP245DVwaY84+fZrbne1RLK9gKsfSTE2TELDAC0RkZGMzFkpWg@mail.gmail.com>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <6d5aeab8-aafe-fa3b-585e-953a34864e7d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6d5aeab8-aafe-fa3b-585e-953a34864e7d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>, DTML <devicetree@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 6, 2018 at 6:02 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 05/03/18 18:36, Amit Kucheria wrote:
>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>
>> There is currently no way for the governor to be selected for each thermal
>> zone in devicetree.
>
> How is that any different from cpufreq, cpuidle or devfreq subsystems ?

Cpufreq/cpuidle are designed to control a single parameter while
thermal framework is trying to mitigate heat from several disparate
sources that are throttled in different ways. Besides, cpufreq/cpuidle
have somewhat mature governors. Cpuidle has only one governor (for
tickless) - menu governor, cpufreq has ondemand in mainline, replaced
by interactive in android and hopefully soon both will be replaced by
schedutil.

Badly configured cpufreq/cpuidle/devfreq only leads to wasted power,
while badly configured thermal zone leads to the loss of operation
e.g. reboots, too hot to touch, etc.

>> This results in the default governor being used for all
>> thermal zones even though no such restriction exists in the core code.
>>
>
> What restrictions ?

I said "no such restriction exists". IOW, the core code does allow the
governor to be changed.

>> Add support for specifying the thermal governor to be used for a thermal
>> zone in the devicetree.
>
> Then what prevents us from doing the same for other subsystems with so
> called /inefficient default/ governors ?

Nothing? :-)

It depends on how closely we want the board DT to represent a
production-ready setup. If a platform maintainer wants to ship a
well-tested configuration in DT, is that really a problem?

If however, you are requiring them to ship magic runes for userspace
daemons (e.g. per-board thermald config) to tweak the various
governors in sysfs, it takes a bit more work to get to a
production-ready setup.

We should of course continue to improve our govenors to arrive at the
one true governor, but that'll take some time and might never even
happen in the case of thermal IMHO.

>> The devicetree config should specify the governor
>> name as a string that matches any available governors. If not specified, we
>> maintain the current behaviour of using the default governor.
>
> If one is specified, can the user change it from sysfs ? If
> yes, then why do we need this binding at all ? If no, we are basically
> restricting, then what would happen if the DT was shipped with wrong
> governor specified because the firmware author didn't know about any
> other governor ?

The governor can be changed from sysfs today. So it is all override-able.

I guess your main worry is an unmodifiable DT with this option being
shipped in firmware, right? That is a fair point, though that could be
worked around from sysfs.

> IMO, having this in DT is bad idea as it may cause more issues than
> gain. We already have sysfs support like other PM subsystems and
> userspace can deal with it.

As mentioned above, I think thermal is a bit special because bad
configuration may lead to loss of operation. But iff we're strictly
enforcing the rule about no policy in board DTs, then I concede.

Personally, I'd like mainline board DTs to have enough policy to
provide a stable system so I don't have to futz around with userspace
to set it all up correctly (in 3 different distros).

Regards,
Amit

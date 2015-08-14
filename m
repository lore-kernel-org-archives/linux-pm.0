From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Fri, 14 Aug 2015 10:52:01 +0100
Message-ID: <55CDBA41.2080703@arm.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org> <1438731339-58317-6-git-send-email-lina.iyer@linaro.org> <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com> <20150813150154.GB13356@red-moon> <20150813154503.GO52339@linaro.org> <55CCD35C.4000901@arm.com> <20150813192713.GA84868@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37709 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbbHNJwG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Aug 2015 05:52:06 -0400
In-Reply-To: <20150813192713.GA84868@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Krzysztof Koz??owski <k.kozlowski@samsung.com>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



On 13/08/15 20:27, Lina Iyer wrote:
> On Thu, Aug 13 2015 at 11:26 -0600, Sudeep Holla wrote:
>>

[...]

>>
>> Having gone through this series and the one using it[1], the only common
>> activity is just cluster pm notifiers. Other than that it's just
>> creating indirection for now. The scenario might change in future, but
>> for now it seems unnecessary.
>>
> Not sure, what seems unnecessary to you. Platforms do have to send
> cluster PM notifications, and they have to duplicate reference counting.
> Also PM domain framework allows hierarchy which is quite desirable to
> power down parts of the SoC that are powered on or have to clocked high,
> until the CPU is running.
>

Agreed, no argument on using genpd for CPU PM for all the goodies genpd
provides, but the way this patch was creating the genpd domains. It
needs to be part of your power controller.

> Cluster PM notifications are just one aspect of this that we currently
> handle in the first submission. The patchset as a whole provides a way
> to determine in Linux the last man down and the first man up and carry
> out activities. There are a bunch of things that are done to power save
> when the last man goes down - Turn off debuggers, switch off PLLs,
> reduce bus clocks, flush caches amongst a few that I know of. Some of it
> are platform specific and some of it arent. This patches provide the way
> for both of them to be done easily. The CPU runtime PM and PM domains as
> a framework, closely track what the hardware does.
>

Again no argument, I just favour common interface functions. Since each
power controller/platform will have specific sequence, it might be hard
to generalize that, but I may be wrong. OTH common interface functions
to handle those components might give some flexibility to the power
controllers.

> Mentioned in an other mail in this thread, is also an option to
> determine the cluster flush state and use it in conjunction with PSCI to
> do OS-Initiated cluster power down.
>

I haven't yet explored down that route yet, with platform co-ordination
we don't need much complexity in kernel :). OS co-ordination is a
different story as we need to consider the secure/non-secure world
dimensions there. We will have to consider the privileges/restrictions
Linux has.

>> Also if you look at the shmobile power controller driver, it covers all
>> the devices including CPUs unlike QCOM power controller which handles
>> only CPU. Yes we can skip CPU genpd creation there only for CPU, IMO
>> creating the power domains should be part of power controller driver.
>>
>> You can add helper functions for all the ARM specific code that can be
>> reused by multiple power controller drivers handling CPU/Cluster power
>> domain.
>>
> Sure, some architectures may desire that. I have them addressed in [2].
>

I haven't looked at that yet, but will do soon.

>>> An analogy to this would be the "arm,idle-state" that defines the DT
>>> node as something that also depicts a generic cpuidle C state.
>>>
>>
>> I tend to disagree. In idle-states, the nodes define that generic
>> properties and they can be parsed in a generic way. That's not the case
>> here. Each power controller binding differs.
>>
> Yes, may be we will have common elements like latency, residency of
> powering on/off a domain that a genpd governor can utilize in
> determining if its worth powering off the domain or not.
>

Make sense, but as Rob pointed how generic are those on various
platforms is something we need to check considering few platforms before
we build the generic infrastructure.

>> Yes the generic compatible might be useful to identify that this power
>> domain handles CPU/Cluster, but there will be more power controller
>> specific things compared to generic code.
>>
> Agreed, not debating that. Power controller is very SoC specific, but
> not debuggers, GIC, caches, buses etc. Many SoCs have almost similiar
> needs for many of these supplemental hardware to the CPUs and trend
> seems to be generalizing on many of these components.
>

Generalizing those components and using genpd is absolutely fine, just
the mechanics is what I am debating on.

Regards,
Sudeep

From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Fri, 14 Aug 2015 12:11:30 -0700
Message-ID: <7h1tf5it25.fsf@deeprootsystems.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
	<1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
	<CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
	<20150813150154.GB13356@red-moon> <20150813154503.GO52339@linaro.org>
	<20150813155245.GD13833@red-moon> <7hegj6le8c.fsf@deeprootsystems.com>
	<20150814154947.GC24806@red-moon>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33734 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbbHNTLd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 15:11:33 -0400
Received: by pabyb7 with SMTP id yb7so65202199pab.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 12:11:33 -0700 (PDT)
In-Reply-To: <20150814154947.GC24806@red-moon> (Lorenzo Pieralisi's message of
	"Fri, 14 Aug 2015 16:49:47 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robherring2@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Krzysztof Koz??owski <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Gross <agross@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Fri, Aug 14, 2015 at 04:51:15AM +0100, Kevin Hilman wrote:

[...]

>> However, you can think of CPU PM notifiers as the equivalent of runtime
>> PM hooks.  They're called when the "devices" are about to be powered off
>> (runtime suspended) or powered on (runtime resumed.)
>> 
>> However the CPU PM framework and notifiers are rather dumb compared to
>> runtime PM.  For example, runtime PM gives you usecounting, autosuspend,
>> control from userspace, statistics, etc. etc.  Also, IMO, CPU PM will 
>> not scale well for multiple clusters.
>> 
>> What if instead, we used runtime PM for the things that the CPU PM
>> notifiers manager (GIC, VFP, Coresight, etc.), and those drivers used
>> runtime PM callbacks to replace their CPU PM notifiers?  We'd then be in
>> a beautiful land where CPU "devices" (and the other connected logic) can
>> be modeled as devices using runtime PM just like every other device in
>> the system.
>
> I would agree with that (even though I do not see how we can make
> eg GIC, VFP and arch timers behave like devices from a runtime PM
> standpoint), 

Sure, that might be a stretch due the implementation details, but
conceptully it models the hardware well and I'd like to explore runtime
PM for all of these "devices", though it's not the highest priority.

> still I do not see why we need a virtual power domain for
> that, the CPU "devices" should be attached to the HW CPU power domain.
>
> More below for systems relying on FW interfaces to handle CPU power
> management.
>
>> Then take it up a level... what if we then could use genpd to model the
>> "cluster", made of of the CPUs and "connected" devices (GIC, VFP, etc.)
>> but also modeled the shared L2$ as a device which was using runtime PM.
>
> I have to understand what "modeled" means (do we create a struct device
> on purpose for that ? Same goes for GIC and VFP).

Not necessarily a struct device for the cluster, but for the CPUs (which
already have one) and and possibly GIC, VFP, timers. etc.  With that in
place, cluster would just be modleled by a genpd (which is what Lina's
series is doing.)

> But overall I get the gist of what you are saying, we just have to see
> how this can be implemented within the genPD framework.
>
> I suspect the "virtual" power domain you are introducing is there for
> systems where the power controller is hidden from the kernel (ie PSCI),
> where basically the CPU "devices" can't be attached to a power domain
> simply because that power domain is not managed in the kernel but
> by firmware.

The main idea behind a "virtual" power domain was to collect the common
parts of cluster management, possibly governors etc.  However, maybe
it's better just have a set of functions that the "real" hw power domain
drivers could use for the common parts.  That might get rid of the need
to describe this in DT, which I think is what Rob is suggesting also.

>> Now we're in a place where we can use all the benefits of runtime PM,
>> plus the governor features of genpd to start doing a real, multi-CPU,
>> multi-cluster CPUidle that's flexible enough to model the various
>> dependencies in an SoC independent way, but generic enough to be able to
>> use common governors for last-man standing, cache flushing, etc. etc.
>
> I do not disagree (even though I think that last man standing is pushing
> this concept a bit over the top), I am just concerned about the points
> raised above, most of them should be reasonably simple to solve.

Good, hopefully we can have a good discussion about this at Plumbers
next week as the issues above and proposed in Lina's series are the main
issues I want to raise in my part of the EAS/PM track[1].

See you there!

Kevin

[1] https://linuxplumbersconf.org/2015/ocw/events/LPC2015/tracks/501

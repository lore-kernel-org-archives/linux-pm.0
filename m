From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v9 5/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Fri, 5 Sep 2014 22:29:08 +0100
Message-ID: <20140905212908.GA28626@e102568-lin.cambridge.arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409938498-17984-6-git-send-email-lorenzo.pieralisi@arm.com>
 <7hlhpxygzv.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56953 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbaIEV3R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 17:29:17 -0400
In-Reply-To: <7hlhpxygzv.fsf@paris.lan>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@ker>

On Fri, Sep 05, 2014 at 09:00:52PM +0100, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > On most common ARM systems, the low-power states a CPU can be put into are
> > not discoverable in HW and require device tree bindings to describe
> > power down suspend operations and idle states parameters.
> >
> > In order to enable DT based idle states and configure idle drivers, this
> > patch implements the bulk infrastructure required to parse the device tree
> > idle states bindings and initialize the corresponding CPUidle driver states
> > data.
> >
> > The parsing API accepts a start index that defines the first idle state
> > that should be initialized by the parsing code in order to give new and
> > legacy driver flexibility over which states should be parsed using the
> > new DT mechanism.
> >
> > The idle states node(s) is obtained from the phandle list of the first cpu
> > in the driver cpumask;  the kernel checks that the idle state node phandle
> > is the same for all CPUs in the driver cpumask before declaring the idle state
> > as valid and start parsing its content.
> >
> > The idle state enter function pointer is initialized through DT match
> > structures passed in by the CPUidle driver, so that ARM legacy code can
> > cope with platform specific idle entry method based on compatible
> > string matching and the code used to initialize the enter function pointer
> > can be moved to the DT generic layer.
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> [...]
> 
> > +	idle_state->flags = CPUIDLE_FLAG_TIME_VALID;
> > +	if (of_property_read_bool(state_node, "local-timer-stop"))
> > +		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > +	/*
> > +	 * TODO:
> > +	 *	replace with kstrdup and pointer assignment when name
> > +	 *	and desc become string pointers
> > +	 */
> > +	strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN - 1);
> > +	strncpy(idle_state->desc, state_node->name, CPUIDLE_DESC_LEN - 1);
> 
> This is a very minor concern, and shouldn't hold back this series,
> but...
> 
> I was playing with this series in order to test out the qcom cpuidle
> driver from Lina, and noticed that the state name and descriptions were
> not terribly helpful:
> 
> /sys/devices/system/cpu/cpu0/cpuidle # cat state?/name
> cpu-idle-state-
> cpu-idle-state-
> /sys/devices/system/cpu/cpu0/cpuidle # cat state?/desc
> cpu-idle-state-0
> cpu-idle-state-1
> 
> Turns out these strings come from the node name itself, and truncated in
> the case of state->name, but this can be fixed in the DTS itself (c.f.
> reply to Lina's driver.)
> 
> However, seeing that the node name is used to populate both the
> state->name and ->, made me wonder if there should better way to set the
> state->desc field to a more useful string.  Tools like powertop actually
> use that field and it can be quite useful.

Well, the truncation problem will be solved when those strings will be
kdup'ed, so for the name I think there is not a problem, copying the
state node is fine waiting for those strings to become pointers.

For desc, there are four options:

(1) enumerating idle states (but that's worse than copying the name into
    desc since on ARM idle-state{1,2,3...} means nothing)
(2) copying the idle state node compatible string into desc
(3) Add an optional property to the DT bindings to describe the state
(4) Leave code as it is

(3) I am not extremely keen at this stage to re-patch the DT bindings,
it has been an awful lot of work to make everyone agree so I would avoid
any changes, I hope you understand (and I am not even sure DT maintainers
would accept that, so even less keen on changing the DT bindings at this
stage).

(2) I am not sure it will clarify the description much.

(1) I would rule it out. So either we accept that the name can be
extended in length (that's going to be the case since we will
dynamically allocate the string so there will be no truncation, to
a reasonable extent) so (4) is fine, or we merge this code and I
will take care of pushing for (3) in a separate patch and copy the resulting
description into desc (if that change does not get NACK'ed).

I would really want to see this code in the mailine asap since it is
groundwork for all future CPUidle generalisation, I hope that what I am
saying above is acceptable, please let me know what you think.

Lorenzo


From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Fri, 14 Aug 2015 16:49:47 +0100
Message-ID: <20150814154947.GC24806@red-moon>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
 <20150813150154.GB13356@red-moon>
 <20150813154503.GO52339@linaro.org>
 <20150813155245.GD13833@red-moon>
 <7hegj6le8c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39100 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755494AbbHNPtn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Aug 2015 11:49:43 -0400
Content-Disposition: inline
In-Reply-To: <7hegj6le8c.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robherring2@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Krzysztof Koz??owski <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Gross <agross@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Aug 14, 2015 at 04:51:15AM +0100, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > On Thu, Aug 13, 2015 at 04:45:03PM +0100, Lina Iyer wrote:
> >> On Thu, Aug 13 2015 at 09:01 -0600, Lorenzo Pieralisi wrote:
> >> >On Thu, Aug 06, 2015 at 04:14:51AM +0100, Rob Herring wrote:
> >> >> On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> >> >> > Define and add Generic PM domains (genpd) for ARM CPU clusters. Many new
> >> >> > SoCs group CPUs as clusters. Clusters share common resources like GIC,
> >> >> > power rail, caches, VFP, Coresight etc. When all CPUs in the cluster are
> >> >> > idle, these shared resources may also be put in their idle state.
> >> >> >
> >> >> > The idle time between the last CPU entering idle and a CPU resuming
> >> >> > execution is an opportunity for these shared resources to be powered
> >> >> > down. Generic PM domain provides a framework for defining such power
> >> >> > domains and attach devices to the domain. When the devices in the domain
> >> >> > are idle at runtime, the domain would also be suspended and resumed
> >> >> > before the first of the devices resume execution.
> >> >> >
> >> >> > We define a generic PM domain for each cluster and attach CPU devices in
> >> >> > the cluster to that PM domain. The DT definitions for the SoC describe
> >> >> > this relationship. Genpd callbacks for power_on and power_off can then
> >> >> > be used to power up/down the shared resources for the domain.
> >> >>
> >> >> [...]
> >> >>
> >> >> > +ARM CPU Power domains
> >> >> > +
> >> >> > +The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
> >> >> > +CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
> >> >> > +caches, VFP and power controller and other peripheral hardware. Generally,
> >> >> > +when the CPUs in the cluster are idle/suspended, the shared resources may also
> >> >> > +be suspended and resumed before any of the CPUs resume execution.
> >> >> > +
> >> >> > +CPUs are the defined as the PM domain consumers and there is a PM domain
> >> >> > +provider for the CPUs. Bindings for generic PM domains (genpd) is described in
> >> >> > +[1].
> >> >> > +
> >> >> > +The ARM CPU PM domain follows the same binding convention as any generic PM
> >> >> > +domain. Additional binding properties are -
> >> >> > +
> >> >> > +- compatible:
> >> >> > +       Usage: required
> >> >> > +       Value type: <string>
> >> >> > +       Definition: Must also have
> >> >> > +                       "arm,pd"
> >> >> > +               inorder to initialize the genpd provider as ARM CPU PM domain.
> >> >>
> >> >> A compatible string should represent a particular h/w block. If it is
> >> >> generic, it should represent some sort of standard programming
> >> >> interface (e.g, AHCI, EHCI, etc.). This doesn't seem to be either and
> >> >> is rather just a mapping of what "driver" you want to use.
> >> >>
> >> >> I would expect that identifying a cpu's or cluster's power domain
> >> >> would be done by a phandle between the cpu/cluster node and power
> >> >> domain node. But I've not really looked at the power domain bindings
> >> >> so who knows.
> >> >
> >> >I would expect the same, meaning that a cpu node, like any other device
> >> >node would have a phandle pointing at the respective HW power domain.
> >> >
> >> CPUs have phandles to their domains. That is how the relationship
> >> between the domain provider (power-controller) and the consumer (CPU) is
> >> established.
> >> 
> >> >I do not really understand why we want a "generic" CPU power domain, what
> >> >purpose does it serve ? Creating a collection of cpu devices that we
> >> >can call "cluster" ?
> >> >
> >> Nope, not for calling a cluster, a cluster :)
> >> 
> >> This compatible is used to define a generic behavior of the CPU domain
> >> controller (in addition to the platform specific behavior of the domain
> >> power controller). The kernel activities for such power controller are
> >> generally the same which otherwise would be repeated across platforms.
> >
> > What activities ? CPU PM notifiers ?
> 
> For today, yes.
> 
> However, you can think of CPU PM notifiers as the equivalent of runtime
> PM hooks.  They're called when the "devices" are about to be powered off
> (runtime suspended) or powered on (runtime resumed.)
> 
> However the CPU PM framework and notifiers are rather dumb compared to
> runtime PM.  For example, runtime PM gives you usecounting, autosuspend,
> control from userspace, statistics, etc. etc.  Also, IMO, CPU PM will 
> not scale well for multiple clusters.
> 
> What if instead, we used runtime PM for the things that the CPU PM
> notifiers manager (GIC, VFP, Coresight, etc.), and those drivers used
> runtime PM callbacks to replace their CPU PM notifiers?  We'd then be in
> a beautiful land where CPU "devices" (and the other connected logic) can
> be modeled as devices using runtime PM just like every other device in
> the system.

I would agree with that (even though I do not see how we can make
eg GIC, VFP and arch timers behave like devices from a runtime PM
standpoint), still I do not see why we need a virtual power domain for
that, the CPU "devices" should be attached to the HW CPU power domain.

More below for systems relying on FW interfaces to handle CPU power
management.

> Then take it up a level... what if we then could use genpd to model the
> "cluster", made of of the CPUs and "connected" devices (GIC, VFP, etc.)
> but also modeled the shared L2$ as a device which was using runtime PM.

I have to understand what "modeled" means (do we create a struct device
on purpose for that ? Same goes for GIC and VFP).

But overall I get the gist of what you are saying, we just have to see
how this can be implemented within the genPD framework.

I suspect the "virtual" power domain you are introducing is there for
systems where the power controller is hidden from the kernel (ie PSCI),
where basically the CPU "devices" can't be attached to a power domain
simply because that power domain is not managed in the kernel but
by firmware.

> Now we're in a place where we can use all the benefits of runtime PM,
> plus the governor features of genpd to start doing a real, multi-CPU,
> multi-cluster CPUidle that's flexible enough to model the various
> dependencies in an SoC independent way, but generic enough to be able to
> use common governors for last-man standing, cache flushing, etc. etc.

I do not disagree (even though I think that last man standing is pushing
this concept a bit over the top), I am just concerned about the points
raised above, most of them should be reasonably simple to solve.

Thanks,
Lorenzo

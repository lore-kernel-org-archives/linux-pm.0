From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Extending OPP bindings
Date: Fri, 31 Jan 2014 12:46:20 +0000
Message-ID: <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
References: <52EA570A.8040501@arm.com>
 <52EAF1CA.3040702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55563 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbaAaMqZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2014 07:46:25 -0500
In-Reply-To: <52EAF1CA.3040702@ti.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Shawn Guo <shawn.guo@linaro.org>, "mturquette@linaro.org" <mturquette@linaro.org>, Mark Brown <mark.brown@linaro.org>, Eduardo Valentin <eduardo.valentin@ti.com>

Hi Nishanth,

On Fri, Jan 31, 2014 at 12:43:54AM +0000, Nishanth Menon wrote:
> Hi Sudeep,
> 
> On 01/30/2014 07:43 AM, Sudeep Holla wrote:
> 
> > 
> > I am looking into a couple shortcomings in the current OPP bindings and
> > how to address them. Feel free to add to the list if you think of any more
> > issues that needs to be addressed or if and how any problem mentioned below
> > can be handled with the existing bindings.
> > 
> > 1. indexing: currently there are no indices in the operating-points.
> indexing is based on frequency which is why the accessors use
> frequency to pull out the OPP data.
> 
> indexing is a horrible idea - on platforms where OPP may be disabled
> or enabled for various reasons(see arch/arm/mach-imx/mach-imx6q.c,
> arch/arm/mach-omap2/board-omap3beagle.c etc) - the indexing you see in
> dts is just a myth that may not exist once the nodes are loaded and
> operated upon depending on SoC variations (example efuse describing
> which OPPs can be used and which not).

I do not understand why. As long as a mapping from DT to data structures
in the kernel is done at boot, I can see how by indexing device nodes
can refer to specific OPPs. If they are disabled, amen, as long as we
can point at specific operating points that should be ok.

Indexing does not mean that the index in the DT is the same as the one
allocated by the OS. Indexing is there to point at specific OPPs from
different DT nodes, a good example are clock bindings and that's exactly
how they work.

Can you provide me with an example where the indexing would go wrong
please ?

Certainly relying on implicit ordering is not great either, actually I
would say that it is broken.

> That said, the original OPP[1][2] series discussion started by trying
> to kill indexing precisely for the same reason.. once you have it - it
> becomes just crazy to deal with.

I could not find any "index killing" :) discussion in there, but I will
keep reading.

> > 	It's assumed that the list is either in ascending or descending
> > 	order of frequency but not explicit in the binding document.
> > 	There are arch/arm/boot/dts/* files with opps in both styles.
> it should not matter -> opp library should do an insertion sort and
> organize it in ascending order once all the data is inserted. (line
> 449ish in opp.c)

That's OS details and they must not be mandated by the bindings.
We cannot rely on word of mouth for things to work, I do not like
implicit rules, so the bindings should speficy the ordering or better
a way to reference OPPs.

> if you see issues with the insertion sort not functioning, it is a bug
> and should be easy to track down and fix.

Problem is not the insertion sort, problem is that DT bindings do not
define a way to refer to a specific OPP, unless we do that implicitly
and again, I rest my case, that is broken.

> > 	Few other bindings like thermal defines bindings like
> > 	cooling-{min,max}-state assuming some order which is broken IMO.
> Now that you bring it up, I missed it :(.. yeah, I might have
> preferred it to be min frequency and max_frequency - I agree it is
> probably broken. I'd let Eduardo comment more about it.
> 
> > 
> > 	One such use-case that came up recently[0] is the c-state latencies
> > 	which could be different for each OPP. It would be good if the
> > 	latencies are specified with the indices to OPP table to avoid
> > 	inconsistency between the bindings.
> 
> You can define C states based on frequencies as well - which really
> makes sense - since that sounds really like our constraint (say
> valid-at-frequency "xyz"

I do not think that's generic enough, I do not like the idea of looking
up frequencies (eg a C-state target_residency does not depend on the
frequency only - ie voltage and other factors play a role, it really
depends on an operating point- looking it up by frequency is misleading IMO).

> > 	It's mainly to avoid issues due to inconsistency and duplication
> > 	on data(frequency) in multiple bindings requiring it.
> > 
> > 	Once we have indices to each on the OPP entries, then other binding
> > 	using it can refer to OPP with phandle and OPP index/specifier pairs
> > 	very similar to clock provider and consumer.
> 
> Having used indexing in OMAP platforms, indexing is a problem waiting
> to happen unfortunately :(

Please be specific, I do not see why it is a problem.

[...]

> > 3. latencies(*): currently the latency that the CPU/memory access is unavailable
> > 	during an OPP transition is generic i.e. same from any OPP to any
> > 	other OPP. Does it make sense to have this per-OPP entry ?
> 
> Why modify OPP when you are describing something else? you are
> describing "latency at a frequency" - just because an OPP definition
> as it stands right now is {frequency, voltage} tuple, makes it a very
> attractive target to keep extending it -> believe me, we have done
> that in the past ->arch/arm/mach-omap2/opp4xxx_data.c efuse register
> describing AVS per frequency is tempting..
> 
> why not have memory-latency-per-opp = <frequency latency>?
> 
> that allows OPP definitions to change in the future, but the
> definition remain constant.
> 
> That said -> consider the following usecase: AM335x, OMAP3,4... (i
> will use omap4 as an example)
> MPU@300MHz and bus (on which LPDDR2 memory is) at 100MHz
> AND
> MPU@300MHz and bus (on which LPDDR2 memory is) at 200MHz
> 
> are both valid with different memory access latencies. tying it down
> to OPP for MPU is just plain wrong - as it ignores other factors.

I think it is time we were defining OPPs for the system as a whole, the
issue has been brought up for C-state dependencies as well.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/228042.html

We can easily define a global node that encompasses OPPs for various
devices, and then map the OPPs for devices to a global OPP table.

(totally made-up DT bindings, just to get the message across)

opps {
	operating-points = <......>;
	operating-point-cells = <2>;

	cpu-opps {
	/* where index maps to a global OPP above where the CPU OPP is valid */
		operating-points = <...... index>;
	
	};
	memory-opp {
	/*
	   where index maps to a global OPP above where the memory OPP is
	   valid
	*/
		operating-points = <...... index>;
	};
};

> > 4. power(*): A measure of maximum power dissipation in an OPP state.
> > 	This might be useful measure for power aware scheduling ?
> Umm.. this is a hard nut to crack -> I had considered that previously
> as well -> In reality the leakage characteristics of the SoC
> distribution varies dramatically depending on which end of the
> distribution you look for a specific process node. in my company, we
> typically use cold, hot,nominal devices, this is some form or other
> (example - Samsung calls it "SoC's ASV group" [4]) - and every SoC
> company comes up with some strategy or other to control it optimally
> -> TI uses ABB[5], AVS[6] - etc... - not an unique problem -> so what
> will "power" mean? we cannot create dts per SoC part.

Yes, that's a hard nut to crack. Probably we can define a reference value,
to be debated.

> > (*) these are already part of P-state in ACPI(refer struct acpi_processor_px
> > in include/acpi/processor.h)
> 
> Hmm.. what do we do with legacy processors that dont support ACPI or
> what ever our latest ARM term is for the equivalent?
> 
> > 
> > Apart from these I have seen on-going discussion for Samsung Exynos CPUFreq[2]
> > which might have some feedback for OPP bindings.
> > 
> > It would be good to consolidate the shortcomings found so far, that could
> > help in extending the current OPP bindings.
> 
> I hope this discussion helps. open to more views as well.

It helps a lot, thank you, please keep it going.

Thanks,
Lorenzo


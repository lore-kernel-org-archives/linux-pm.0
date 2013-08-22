From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of
 another node for OPP
Date: Thu, 22 Aug 2013 16:50:00 +0100
Message-ID: <20130822155000.GF23152@e106331-lin.cambridge.arm.com>
References: <51F93AFB.1030104@ti.com>
 <20130801135422.GA8095@e106331-lin.cambridge.arm.com>
 <51FA8BE2.9000309@ti.com>
 <20130802131541.GN2884@e106331-lin.cambridge.arm.com>
 <20130806134534.GB6603@kahuna>
 <20130807161722.GJ28558@e106331-lin.cambridge.arm.com>
 <52133E26.1000801@arm.com>
 <521543AC.4020709@wwwdotorg.org>
 <20130822115957.GC9799@e106331-lin.cambridge.arm.com>
 <52162EFA.2070108@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43446 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753522Ab3HVPuG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2013 11:50:06 -0400
Content-Disposition: inline
In-Reply-To: <52162EFA.2070108@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Nishanth Menon <nm@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, Aug 22, 2013 at 04:32:10PM +0100, Sudeep KarkadaNagesha wrote:
> On 22/08/13 12:59, Mark Rutland wrote:
> > On Wed, Aug 21, 2013 at 11:48:12PM +0100, Stephen Warren wrote:
> >> On 08/20/2013 04:00 AM, Sudeep KarkadaNagesha wrote:
> >> ...
> >>> Until we get more feedback and agreement on new proposal can we have
> >>> this simple amendment in this patch to the existing binding ? Since the
> >>> new proposal[1] is backward compatible(this patch adding support for
> >>> option#5 to existing option#1), we will have to add support for other
> >>> binding options in [1] later.
> >>>
> >>> This is needed to support shared OPPs with simple/single OPP profile
> >>> and also to fix the broken and unused binding
> >>> @Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
> >>>
> >>> Regards,
> >>> Sudeep
> >>>
> >>> [1] http://www.spinics.net/lists/cpufreq/msg06563.html
> >>
> >> Presumably the desire for cpu1's node to say "go look at cpu0's node for
> >> OPP" is because they share OPPs. Don't they share OPPs because they are
> >> parts of the same device - that device being the CPU complex. As such,
> >> why not define the OPPs in /cpus rather than in each of /cpus/cpuN?
> > 
> > I'd very much like for it to be possible to factor out common properties
> > into the /cpus node, but it should follow the ePAPR recommendation fo
> > being treated as a fallback if not present in a particular /cpus/cpu@N
> > node -- that way we can handle clusters with differing OPPs. The
> > property might just be a phandle to a table node, but it should be
> > possible to make it common.
> > 
> Yes we can have this fallback mechanism, but only from cpu devices(OPP
> library handles non-cpu devices too).

Ok.

> 
> Referring the table node, I have a generic question on DT nodes.
> Does each DT node have to represent a unique device ? If so having a
> property common to one/more devices in a separate node doesn't sound
> correct.

I believe the answer is almost always yes. There are devices with
subnodes that represent some logical portion of the device, but I
couldn't think of any free-standing nodes that aren't a device or unique
firmware interface.

> 
> >>
> >> Of course, that doesn't help if there are separate CPU and GPU nodes
> >> that just happen to have the same set of OPPs and you want to share them
> >> to save DT space. Is that at all likely?
> > 
> > I suspect that the OPPs for CPUs and GPUs are likely to be quite
> > distict, and they are logically separate regardless. I'm not averse to
> > sharing of tables if we can handle them in a standard fashion.
> > 
> IMO sharing OPPs just for saving DT space might lead to confusions(no
> strong opinion though).

Agreed.

> 
> >>
> >> I'd suggest/bike-shed that operating-points-device is not the correct
> >> property name; it somehow implies that the other device actively defines
> >> the OPPs for this device, rather than just happening to have the same
> >> OPPs. Perhaps "operating-points-identical-to"?
> >>
> > 
> > I'd rather not have properties that point elsewhere and say "treat me
> > the same as this node". I'd rather we have common properties as
> > described above.
> > 
> Agreed, but for platforms with multiple CPU clusters, since we have only
> one /cpus node, we ned to have table node which is arguable if node has
> represent a device(as mentioned above)

I agree that this seems wasteful of space, but I really don't think that
pointing at another device you want the OPPs of is the best way of
describing the linkage, and I suspect we'll get all sorts of stupid bugs
resulting from that style of binding.

Consider the following (properties trimmed for brevity): 

cpus {
	cpu0: cpu@0 {
		operating-points-identical-to = <&cpu1>;
	};
	cpu1: cpu@1 {
		operating-points = <0 100>,
				   <23 47>,
				   <62 970>;
	}
};

If we boot a UP kernel on the above, I assume we won't read the info for
cpu1, and thus we won't get operating points info for cpu0. Worse, what
if cpu1 has status="disabled"? Does that make its OPP table invalid?
What if the bootloader drops cpu1?

I really don't like indirecting linkage to a property through an
arbitrary node, simply because it happened to have the same property. It
creates an artificial depdendency that will lead to problems.

Thanks,
Mark.

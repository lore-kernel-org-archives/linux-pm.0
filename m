From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of
 another node for OPP
Date: Fri, 23 Aug 2013 13:26:18 +0100
Message-ID: <20130823122618.GD25856@e106331-lin.cambridge.arm.com>
References: <51FA8BE2.9000309@ti.com>
 <20130802131541.GN2884@e106331-lin.cambridge.arm.com>
 <20130806134534.GB6603@kahuna>
 <20130807161722.GJ28558@e106331-lin.cambridge.arm.com>
 <52133E26.1000801@arm.com>
 <521543AC.4020709@wwwdotorg.org>
 <20130822115957.GC9799@e106331-lin.cambridge.arm.com>
 <52162EFA.2070108@arm.com>
 <20130822155000.GF23152@e106331-lin.cambridge.arm.com>
 <52163C1A.4040707@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52163C1A.4040707@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Nishanth Menon <nm@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 22, 2013 at 05:28:10PM +0100, Sudeep KarkadaNagesha wrote:
> On 22/08/13 16:50, Mark Rutland wrote:
> > On Thu, Aug 22, 2013 at 04:32:10PM +0100, Sudeep KarkadaNagesha wrote:
> >> On 22/08/13 12:59, Mark Rutland wrote:
> >>> On Wed, Aug 21, 2013 at 11:48:12PM +0100, Stephen Warren wrote:
> [...]
> >>>>
> >>>> I'd suggest/bike-shed that operating-points-device is not the correct
> >>>> property name; it somehow implies that the other device actively defines
> >>>> the OPPs for this device, rather than just happening to have the same
> >>>> OPPs. Perhaps "operating-points-identical-to"?
> >>>>
> >>>
> >>> I'd rather not have properties that point elsewhere and say "treat me
> >>> the same as this node". I'd rather we have common properties as
> >>> described above.
> >>>
> >> Agreed, but for platforms with multiple CPU clusters, since we have only
> >> one /cpus node, we ned to have table node which is arguable if node has
> >> represent a device(as mentioned above)
> > 
> > I agree that this seems wasteful of space, but I really don't think that
> > pointing at another device you want the OPPs of is the best way of
> > describing the linkage, and I suspect we'll get all sorts of stupid bugs
> > resulting from that style of binding.
> > 
> > Consider the following (properties trimmed for brevity): 
> > 
> > cpus {
> > 	cpu0: cpu@0 {
> > 		operating-points-identical-to = <&cpu1>;
> > 	};
> > 	cpu1: cpu@1 {
> > 		operating-points = <0 100>,
> > 				   <23 47>,
> > 				   <62 970>;
> > 	}
> > };
> > 
> > If we boot a UP kernel on the above, I assume we won't read the info for
> > cpu1, and thus we won't get operating points info for cpu0. Worse, what
> > if cpu1 has status="disabled"? Does that make its OPP table invalid?
> > What if the bootloader drops cpu1?
> > 
> Another question :), does status property dictate the validity of the
> other properties in the node(not specific to above example, in general)?

That depends on what the binding in question describes for a disabled
status. In general, if a node is disabled I would imagine that
attempting to derive any knowledge from it is not a good idea.

> 
> But I agree that this indirect linkage is broken as boot-loaders can
> drop the cpu node holding OPP.
> 
> IMO fallback method would be reasonable(and much cleaner compared to a
> separate node) if it can even accommodate multiple cpu clusters.

Well, it may be that for separate clusters we just have to describe the
information per-cpu...

> 
> > I really don't like indirecting linkage to a property through an
> > arbitrary node, simply because it happened to have the same property. It
> > creates an artificial depdendency that will lead to problems.
> > 
> I totally agree on this.

Cool.

Thanks,
Mark.

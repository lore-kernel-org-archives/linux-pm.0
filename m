From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: extend DT binding to specify phandle of
 another node for OPP
Date: Fri, 18 Oct 2013 09:40:41 +0100
Message-ID: <20131018084041.GC398@e102568-lin.cambridge.arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1380634382-15609-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <5252DAD3.6040903@gmail.com>
 <525400B4.8060203@arm.com>
 <CAL_JsqKPprCKorvfgCH3usvX6hw5moypQYvKTdAznFVoTV-pyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKPprCKorvfgCH3usvX6hw5moypQYvKTdAznFVoTV-pyg@mail.gmail.com>
Content-Disposition: inline
Sender: cpufreq-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 17, 2013 at 02:22:44PM +0100, Rob Herring wrote:

[...]

> >>> +    cpu3: cpu@101 {
> >>> +            compatible = "arm,cortex-a7";
> >>> +            reg = <101>;
> >>> +            operating-points-phandle = <&cluster1_opp>;
> >>> +    };
> >>> +
> >>> +    opps-table {
> >>> +            cluster0_opp: cluster0_opp {
> >>
> >> Why not use the cpu topology? Then the operating point can apply to
> >> cores based on the position in the topology. You don't even need a
> >> phandle in that case. You can look for OPPs in either a cpu node or in
> >> the topology.
> >>
> > Agreed but few thoughts behind this binding:
> >
> > 1. OPPs are not just cpu specific:
> >    How do we share OPPs for 2 devices in the same clock domain ?
> >    Also moving the OPP into cpu-topo makes parsing specific to cpu.
> >    Currently the OPP library fetches the of_node from the device struct
> >    which is applicable to any devices.
> 
> But an OPP for a cpu is cpu specific, so put it there. For devices, we
> may need something different. Perhaps it should be part of the clock
> binding in some way.
> 
> > 2. Should cpu topology(i.e. cpu-map) just contain the topology info ? and
> >    phandles to these nodes should be used to setup any affinity ?
> 
> Can't the OPP just be in the topology nodes at the appropriate level.
> Then the kernel can look for the OPPs in either place. Perhaps Lorenzo
> has thoughts on this.

The reason we introduced the topology nodes (ie cpu-map) was to provide
a topology description of the system with leaf nodes linked to cpu
nodes; nodes in the topology do not map to HW entities.
Put it differently, IMHO we should attach no HW meaning to nodes in the
cpu-map so we should not add eg OPPs under cluster nodes because those
nodes do not represent HW entities, I would like to keep cpu-map a pure
DT representation of the topology, no more, but debate is open.

Lorenzo


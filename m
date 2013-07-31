From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of
 another node for OPP
Date: Wed, 31 Jul 2013 16:29:25 +0100
Message-ID: <20130731152925.GP29859@e106331-lin.cambridge.arm.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51F80750.8030701@wwwdotorg.org>
 <51F826A0.2000109@ti.com>
 <51F8F17B.1020304@arm.com>
 <51F9234A.6010501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51F9234A.6010501@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 31, 2013 at 03:46:34PM +0100, Nishanth Menon wrote:
> On 07/31/2013 06:14 AM, Sudeep KarkadaNagesha wrote:
> > On 30/07/13 21:48, Nishanth Menon wrote:
> >> On 07/30/2013 01:34 PM, Stephen Warren wrote:
> >>> On 07/30/2013 12:00 PM, Sudeep KarkadaNagesha wrote:
> >>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> >>>>
> >>>> If more than one similar devices share the same OPPs, currently we
> >>>> need to replicate the OPP entries in all the nodes.
> >>>>
> >>>> Few drivers like cpufreq depend on physical cpu0 node to specify the
> >>>> OPPs and only that node is referred irrespective of the logical cpu
> >>>> accessing it. Alternatively to support cpuhotplug path, few drivers
> >>>> parse all the cpu nodes for OPPs. Instead we can specify the phandle
> >>>> of the node with which the current node shares the operating points.
> >>>>
> >>>> This patch adds support to specify the phandle in the operating points
> >>>> of any device node, where the node specified by the phandle holds the
> >>>> actual OPPs.
> >>>
> >>>> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> >>>
> >>>> +Optional properties:
> >>>> +- operating-points-phandle: phandle to the device node with which this
> >>>
> >>> That's a funny name. Bikeshedding a bit, how about shared-operating-points?
> >>>
> >>> I haven't thought at all about whether this change conceptually makes sense.
> >>>
> >>
> >> They may not really be shared- we could have phandle list even. one
> >> might have optional OPP sets for a chip family that one may  - I was
> >> about to suggest something similar to pinctrl
> >>
> > I am not sure if I follow you here, if each chip family has its unique
> > set of OPPs, why do we need to represent all of them together ?
> > IIUC you are thinking about having these in include dts file, used by
> > multiple chip/board dts.
> >
> >> operating-points-names = "default", "performance", "cheapboard-config" ;)
> >> operating-points-0 = <&...>
> >> operating-points-1 = <&...>
> >> operating-points-2 = <&...>
> >>
> > This looks more like a PM policy.
> 
> Let me try to explain since SoCs such as OMAP/AM family dont make life 
> trivial :)..
> 
> An legacy example[1][2]
> 
> SoC DM explains that the chip is capable of X opps:
> opp1, 2 - for all devices
> opp1,2, 3 - if efuse bit X@y is set
> opp1,2,3,4 - if efuse bit X@y is set AND Board design meets SoC vendors 
> requirements (including additional features A, B is enabled).
> 
> So, the same chip family has a hardware feature - not just as a pm 
> policy of selecting among a set of OPPs which opp to work on, but the 
> actual set of OPPs are actually options in themselves that is selected 
> based on board's SoC selection.

This sounds like we're describing a set of features not applicable to
the device, then removing them, rather than only describing those
features applicable to the device. If you have to probe to figure out
which values in the dt are applicable, I'm not sure I see the benefit of
describing said values in dt.

Thanks,
Mark.

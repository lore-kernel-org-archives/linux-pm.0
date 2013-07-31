From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of
 another node for OPP
Date: Wed, 31 Jul 2013 14:13:53 -0500
Message-ID: <20130731191353.GA6123@kahuna>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51F80750.8030701@wwwdotorg.org>
 <51F826A0.2000109@ti.com>
 <51F8F17B.1020304@arm.com>
 <51F9234A.6010501@ti.com>
 <51F92D3B.3070103@arm.com>
 <51F93303.7010609@ti.com>
 <51F93DFC.7070904@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35243 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab3GaTOA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Jul 2013 15:14:00 -0400
Content-Disposition: inline
In-Reply-To: <51F93DFC.7070904@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 17:40-20130731, Sudeep KarkadaNagesha wrote:
> On 31/07/13 16:53, Nishanth Menon wrote:
> > On 07/31/2013 10:28 AM, Sudeep KarkadaNagesha wrote:
> >> On 31/07/13 15:46, Nishanth Menon wrote:
> >>> On 07/31/2013 06:14 AM, Sudeep KarkadaNagesha wrote:
> >>>> On 30/07/13 21:48, Nishanth Menon wrote:
> >> [...]
> >>>>> This should setup stage for many of the work we have been trying to
> >>>>> figure out on AM/OMAP and few other processors which has to depend on
> >>>>> few sets of OPPs which may not be supported on various platforms.
> >>>>>
> >>>> I still don't get the point why you would publish some OPP in the DT
> >>>> when the hardware which it describes doesn't support it.
> >>>>
> >>>> This may be already discussed when DT support was added to OPP library,
> >>>> IMO if for some reason the firmware/boot entity disables some of the
> >>>> OPPs, then it can append OPPs in DT with the state(enabled/disabled).
> >>>> But this needs extension of current binding.
> >>>
> >>> you could also have reduced OPP set which needs to be invoked, appending
> >>> wont really work if cpufreq table is built as part of probe - it kind of
> >>> creates all kind of races which I would really like to avoid.
> >>>
> >> IIUC opp_set_availability(opp_enable/opp_disable) is designed for such
> >> use-case ? Currently there are no users of this API but I see it fits
> >> your use case.
> >>
> >> Even with multiple OPP sets listed in DT as you described, you need to
> >> read those fuses and chose the right set of OPPs. Instead you can use
> >> opp_en(/dis)able methods to do that ?
> >>
> > yes when the efuse data is present, but look at the other case I had 
> > also pointed at:
> > 
> > Lets take an example: SoC X has OPPs 1,2,3,4
> > 
> > Same SoC is used on Board A and B.
> > Board A meets with all SoC vendor requirements for routing, IR drop 
> > limits etc
> > Board B *does not* meet with all SoC vendor requirements for routing, IR 
> > drop limits etc
> > 
> > we no longer have board files, board will have to have a mechanism to 
> > "state it is not optimal configuration".
> > 
> But we still have DTS per board(I assume each board will at-least
> different in IRQ/GPIO assignments or even different pin-mux configuration)

yes, of course.

> 
> > A real life example is BeagleBoard Xm and another product board(which I 
> > cannot mention) -both use OMAP3630 1GHz part. 1GHz requirements are met 
> > on BeagleBoard Xm, but on the product board it is not. Chip used is 
> > exactly the same, we dont have "dts property" to mention "yes, this 
> > board meets SoC data manual and associated documentation requirement" - 
> > instead what we do have is what is the chip capable of doing.
> > 
> If SoC gives configuration w.r.t OPPs, then its board property like
> pin-mux. Why is it not possible to have 1GHz only in BeagleBoard Xm and
> not in product board X ?
Unless we have two "phandles", we wont be able to do the same. Then
you'd want to standardize how we do that which is why I made the
proposal.

> 
> > opp_enable/disable wont work here unless there is board specific 
> > "properties" we introduce. However, board file could choose "low 
> > performance" option of OPPs.
> > 
> Again board file choice of selecting OPPs is policy and DT must describe
> all the features board supports.

Umm... I would probably call it "capability" based on selection of SoC
type, board design etc. as against "policy" of making a decision -
example, this device is too hot, so lets reduce the number of OPPs that
cpufreq chooses to operate on.

> 
> > the opp_enable/disable wont scale there. Further, opp_add is done 
> > enmasse by cpufreq-cpu0 and and cpufreq table is built off it, there is 
> > no option of SoC specific modification to the table (opportunity to do 
> > opp_enable/disable) there - not something that cannot be fixed, and 
> > eventually will be, but not there right now.
> > 
> Freescale iMX6 seems to be using it, not use if its SoC level or board
> level.(imx6q_opp_check_1p2ghz in arch/arm/mach-imx/mach-imx6q.c)

Yep, this is similar to the "efuse case" I had stated, and  given no
other option, that is the only way I will probably have to go
w.r.t OMAP, but given OMAP, iMX have similar challenges, I am hoping we
can have a definition that is generic enough for various SoCs to use.
(similar to beagle_opp_init in arch/arm/mach-omap2/board-omap3beagle.c -
which is pre-dts days usage)

> 
> 
> I just had a look @arch/arm/boot/dts/omap36xx.dtsi and
> omap3-beagle-xm.dts. This is my opinion(if you can't handle this
> dynamically):
> 
> Now you have omap36xx SoC on 2 products X and BeagleBoard Xm.
> omap36xx can support up to 1GHz but depends on actual products.
> So its better not to publish OPPs in omap36xx.dtsi but leave to product
> X and BeagleBoard Xm to describe what that hardware supports.
That is the pain I was trying to explain, having configuration options
defined in SoC dtsi providing all valid options available is more
sensible. It also solves the issue of multiple devices/clocks using
same definitions

Speaking as an SoC vendor, allowing board files define their own opp
tables is basically an invitation for disaster from a production risk
perspective, as, there are too many board variants out there and not all
developers are, umm... "OPP-aware" and end up with a maintenance burden
for rest of us (e.g. board X, board Y defining 1GHz differently) etc.

-- 
Regards,
Nishanth Menon

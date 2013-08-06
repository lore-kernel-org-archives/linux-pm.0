From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of
 another node for OPP
Date: Tue, 6 Aug 2013 08:45:34 -0500
Message-ID: <20130806134534.GB6603@kahuna>
References: <51F826A0.2000109@ti.com>
 <51F8F17B.1020304@arm.com>
 <51F9234A.6010501@ti.com>
 <20130731152925.GP29859@e106331-lin.cambridge.arm.com>
 <51F9341E.60102@ti.com>
 <20130731161103.GS29859@e106331-lin.cambridge.arm.com>
 <51F93AFB.1030104@ti.com>
 <20130801135422.GA8095@e106331-lin.cambridge.arm.com>
 <51FA8BE2.9000309@ti.com>
 <20130802131541.GN2884@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45533 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab3HFNpn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 6 Aug 2013 09:45:43 -0400
Content-Disposition: inline
In-Reply-To: <20130802131541.GN2884@e106331-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 14:15-20130802, Mark Rutland wrote:
> On Thu, Aug 01, 2013 at 05:25:06PM +0100, Nishanth Menon wrote:
> > On 08/01/2013 08:54 AM, Mark Rutland wrote:
> > > On Wed, Jul 31, 2013 at 05:27:39PM +0100, Nishanth Menon wrote:
> > >> On 07/31/2013 11:11 AM, Mark Rutland wrote:
> > >>> On Wed, Jul 31, 2013 at 04:58:22PM +0100, Nishanth Menon wrote:
> > >>>> On 07/31/2013 10:29 AM, Mark Rutland wrote:
> > >>>>> On Wed, Jul 31, 2013 at 03:46:34PM +0100, Nishanth Menon wrote:
> > >>>>>> On 07/31/2013 06:14 AM, Sudeep KarkadaNagesha wrote:
> > >>>>>>> On 30/07/13 21:48, Nishanth Menon wrote:
> > >>>>>>>> On 07/30/2013 01:34 PM, Stephen Warren wrote:
> > >>>>>>>>> On 07/30/2013 12:00 PM, Sudeep KarkadaNagesha wrote:
[...]
> > 
> > >
> > > * Performance profiles, in which you have a set of OPP tables for
> > >    "performance, "low-power", and whatever else. This arbitrary split
> > >    seems like a configuration decision rather than a hardware description
> > >    unless there is some hard limit that cannot be detected (e.g. the
> > >    processor can function at some arbitrary high speed, but becomes hot
> > >    enough to melt something, and there's no temperature sensor to handle
> > >    this case dynamically).
> > 
> > precisely -> I think I point this out in this thread:
> > http://marc.info/?l=devicetree&m=137535932402560&w=2
> 
> The one thing I don't like is the arbitrary grouping into profiles, as
> the division is entirely a configuration decision. The operating points
> themselves are a hardware capability, and it may make sense to describe
> the feasible points for a device in the dt, but I don't want to have
> different profiles exported because it straddles the line of the dt
> telling us how to use the hardware rather than what the hardware is, and
> will come back to bite us later if we want to handle cpu frequency
> decisions differently.

I can understand why it seems to wrongly indicate *how* to use the
hardware, rather than *what the hardware is* - Lets try it this way:
- if Bit X is set in efuse, one cannot use high performance mode
- If PDN (Power Distribution Network) guidelines are not met, one cannot
use high performance mode.

These constrain *hardware capability* you can do on that SoC+Board
combination - that is exactly what we have been struggling to describe
here. These are not *how to use hardware* profiles, but *hardware
capability* profiles whose selection is upto to the System in
discussion - example - SoC x will decide on bit based decision and
forbid Board file overrides while an SoC y family might choose another
path.. Framework and dts should not dictate policy and we dont try to
do that here.

How to use the hardware within the *capability costraints* is upto
drivers, there is no attempt to define that in my proposal.

> I also have a suspicion that this will end up having a subset of sane
> values, and Linux won't necessarily be able to do any interpolation of
> values without additional platform knowledge.

These may be SoC dependent. An fixed regulator might be acceptable on
SoC x, but not on y (as leakage angle might make it infeasible).

[...]
> > I did make a proposal here: 
> > http://marc.info/?l=devicetree&m=137530056230441&w=2
> > 
> > Do you see it making sense, If yes, I can help flesh out the idea with code.
> 
> I can see one of the example mechanisms working for describing OPPs
> being usable, but I'm still concerned about the division into profiles.
Above.

Does this make sense? I understand and share the concern about potential
misuse, but I am all open ears of how we'd like to ensure data is
completely separated out from kernel source.

-- 
Regards,
Nishanth Menon

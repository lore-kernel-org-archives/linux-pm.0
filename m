From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of
 another node for OPP
Date: Tue, 6 Aug 2013 08:29:57 -0500
Message-ID: <20130806132956.GA6603@kahuna>
References: <51F826A0.2000109@ti.com>
 <51F8F17B.1020304@arm.com>
 <51F9234A.6010501@ti.com>
 <20130731152925.GP29859@e106331-lin.cambridge.arm.com>
 <51F9341E.60102@ti.com>
 <20130731161103.GS29859@e106331-lin.cambridge.arm.com>
 <51F93AFB.1030104@ti.com>
 <20130801135422.GA8095@e106331-lin.cambridge.arm.com>
 <51FA917D.4060408@wwwdotorg.org>
 <51FBB788.7040209@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51FBB788.7040209@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <Mark.Rutland@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 14:43-20130802, Sudeep KarkadaNagesha wrote:
> On 01/08/13 17:49, Stephen Warren wrote:
> > On 08/01/2013 07:54 AM, Mark Rutland wrote:
> > ...
> >> We seem to be going over two cases, which both feel wrong to me:
> >>
> >> * One SoC used in multiple boards, where on some boards an OPP cannot be
> >>   used because some requirement is not met. In this case, the board's
> >>   dts (by including the SoC's dtsi) describes something that's not
> >>   necessarily usable, and we seem to have no way to describe in the OPP
> >>   table that the OPP is not usable for that board.
> > 
> > There are probably a lot of examples of this already. For example, for
> > pinctrl, people often want the SoC .dtsi file to include "pin
> > configuration nodes" (see
> > Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt) for many
> > common pinmux configurations in the SoC .dtsi file, so that board files
> > can simply refer to the already-existing nodes rather than having to
> > write everything from scratch. Obviously, not all common configurations
> > are used by every board.
> > 
> > ...
> Agreed, but I am not convinced with the comparison(pinmux and OPPs).
> The main concern I have is that if some developer wants to experiment
> with various configurations provided by SoC(e.g. I have seen some SoC
> where the pinmux have multiple functions and you can chose one of them)
> But that's not true with OPPs, if someone experiments with wrong OPP
> profile, then it might damage the board permanently.

Even today, nothing prevents folks from "adding custom OPPs" at their
own personal risk here - We have seen folks do this as part of board
files - Now, for that matter, there is nothing that prevents folks
linking the wrong LDO or setting wrong LDO voltage and damaging the
board either.

I mean, at the level where we "describe" the hardware and it's
operation, you cannot be idiot or experimenter-proof - If these were
to be considered paramount and prevent us from choosing the right
concept that is needed for as many SoCs as possible, it'd be a shame.

-- 
Regards,
Nishanth Menon

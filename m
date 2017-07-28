From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: LTC3651 and other GPIO chargers
Date: Fri, 28 Jul 2017 03:04:40 +0200
Message-ID: <20170728010440.4vw23w5xafyhanp6@lenoch>
References: <20170626162105.rgewvl2z2ftbxqyn@lenoch>
 <5b439c7f-4401-5333-a45f-2d2e243902c8@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:60870 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdG1BEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 21:04:43 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993961AbdG1BElnha4O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jul 2017 03:04:41 +0200
Content-Disposition: inline
In-Reply-To: <5b439c7f-4401-5333-a45f-2d2e243902c8@topic.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>

Hello Mike,

On Tue, Jun 27, 2017 at 07:39:21AM +0200, Mike Looijmans wrote:
> On 26-06-17 18:21, Ladislav Michl wrote:
> > Hi there!
> > 
> > A driver for LTC3651 was recently added to -next
> > https://patchwork.kernel.org/patch/9717049/
> > which brings a question whenever we want to add separate driver
> > (or vendor specific bindings) for ever growing list of similar
> > chargers. For example those using the same status output lines
> > are: BQ24232HA, LTC4007, LTM8061, RT9502, LT3651, LT3650, TP4056,
> > MAX1737...
> > Others for example BQ24032A and LM3658 (which I have to support)
> > are using different status encoding, ie. LM3658:
> > 
> > stat1	stat2		Condition
> >    0	  0	Power-Down, charging is suspended or interrupted
> >    1	  0	Pre-qualification mode, CC and CV charging
> >    0	  1	Charge is completed
> >    1	  1	Bad battery (Safety timer expired), or LDO mode
> > 
> > What about extending gpio-charger instead?
> > - allow gpio list fdt subnode
> >    - consider each gpio line to represent bit in a word
> > - provide per property subnodes
> >    - each subnode holds a mask and mapping to property values
> > This way we should be able to cover most chargers providing status
> > using gpios. Comments welcome and appreciated - those will turn into
> > implementation.
> 
> It's an interesting idea, and while writing the ltc3651 driver, I was
> thinking along those lines already. However, there are only two gpio charger
> drivers now, so I didn't see the need yet.
> 
> The table is an interesting approach. Something else to consider: Some gpio
> chargers allow control as well, e.g. pulling the "charging" ping low
> externally forces the charging to stop.

Just one more question before submitting "one driver for all" patch...
In LTC3651 you made acpr_gpio mandatory while chrg_gpio and fault_gpio
are optional. I quite do not get it as those later two gpios make
driver LTC3651 specific, while without them it is just another gpio-charger
driver. Also I have a board here, where acpr_gpio is not routed at all
and ADC is used to measure Vin, which makes this driver imposible to use.

Any specific reason you implemented it this way? As once 4.13 is out,
devicetree binding will be set in stone and I'm out of luck...

(based on that I exteded gpio-charger to take into account optional
gpios as well)

> Something that might help is to create a "GPIO charger" sub-menu in Kconfig,
> to make hunting for these drivers a bit easier.

Thank you,
	ladis

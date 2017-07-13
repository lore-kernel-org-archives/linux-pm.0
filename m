From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: LTC3651 and other GPIO chargers
Date: Thu, 13 Jul 2017 09:25:09 +0200
Message-ID: <20170713072509.zlokpbnezgfb3p5z@lenoch>
References: <20170626162105.rgewvl2z2ftbxqyn@lenoch>
 <20170703135238.6rbjh26l6yd7v7xy@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:42534 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdGMHZQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 03:25:16 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23991073AbdGMHZLcaGN6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jul 2017 09:25:11 +0200
Content-Disposition: inline
In-Reply-To: <20170703135238.6rbjh26l6yd7v7xy@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: linux-pm@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, Rob Herring <robh@kernel.org>

On Mon, Jul 03, 2017 at 03:52:38PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Jun 26, 2017 at 06:21:06PM +0200, Ladislav Michl wrote:
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
> >   0	  0	Power-Down, charging is suspended or interrupted
> >   1	  0	Pre-qualification mode, CC and CV charging
> >   0	  1	Charge is completed
> >   1	  1	Bad battery (Safety timer expired), or LDO mode
> > 
> > What about extending gpio-charger instead?
> > - allow gpio list fdt subnode
> >   - consider each gpio line to represent bit in a word
> > - provide per property subnodes
> >   - each subnode holds a mask and mapping to property values
> > This way we should be able to cover most chargers providing status
> > using gpios. Comments welcome and appreciated - those will turn into
> > implementation.
> > 
> > Thank you,
> > 	ladis
> 
> I think you mean something like this?

Not exatly, but you are pretty close.

> charger {
>     compatible = "vendor,chip", "gpio-charger;
> 
>     status-gpios = <status-gpio1>, <status-gpio2>;
> 
>     status-mapping-0 {
>         mask = <00>;
>         type = "exploded";
>     };
> 
>     status-mapping-1 {
>         mask = <01>;
>         type = "frozen";
>     };
> 
>     ...
> };
> 
> In that case: NAK. I like the general idea, but the DT binding looks
> like a mess. Instead of providing the mapping in DT, it should be
> provided by the driver and selected based on the compatible value.

I won't pretend I'm not disapointed, but you are propably right.
Mapping in DT would bind DT with Linux specific implementation details.

Now testing patched gpio-charger. Patch will be send once I'm happy
with implementation.

Thank you,
	ladis

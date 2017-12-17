From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v3 04/11] thermal: armada: Rationalize register accesses
Date: Mon, 18 Dec 2017 00:02:35 +0200
Message-ID: <20171217220235.4uwy4nw77gf3kvfp@tarshish>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-5-miquel.raynal@free-electrons.com>
 <20171216221838.v6gtaoqy2xhozapp@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:58074 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbdLQWCk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Dec 2017 17:02:40 -0500
Content-Disposition: inline
In-Reply-To: <20171216221838.v6gtaoqy2xhozapp@tarshish>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Will Deacon <will.deacon@arm.com>, David Sniatkiwicz <davidsn@marvell.com>, Eduardo Valentin <edubezval@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Miquèl,

On Sun, Dec 17, 2017 at 12:18:38AM +0200, Baruch Siach wrote:
> On Thu, Dec 14, 2017 at 11:30:04AM +0100, Miquel Raynal wrote:
> > Bindings were incomplete for a long time by only exposing one of the two
> > available control registers. To ease the migration to the full bindings
> > (already in use for the Armada 375 SoC), rename the pointers for
> > clarification. This way, it will only be needed to add another pointer
> > to access the other control register when the time comes.
> > 
> > This avoids dangerous situations where the offset 0 of the control
> > area can be either one register or the other depending on the bindings
> > used. After this change, device trees of other SoCs could be migrated to
> > the "full" bindings if they may benefit from features from the
> > unaccessible register, without any change in the driver.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > ---
> 
> [...]
> 
> > +	/*
> > +	 * Legacy DT bindings only described "control1" register (also referred
> > +	 * as "control MSB" on old documentation). New bindings cover
> > +	 * "control0/control LSB" and "control1/control MSB" registers within
> > +	 * the same resource, which is then of size 8 instead of 4.
> > +	 */
> > +	if ((res->end - res->start) == LEGACY_CONTROL_MEM_LEN) {
> > +		/* ->control0 unavailable in this configuration */
> > +		priv->control1 = control + LEGACY_CONTROL1_OFFSET;
> > +	} else {
> > +		priv->control0 = control + CONTROL0_OFFSET;
> > +		priv->control1 = control + CONTROL1_OFFSET;
> > +	}
> 
> I think we need to add a check here that the control registers area size 
> matches the expected value given the compatible string. In case of mismatch 
> probe should fail.

One more thing. You should probably use resource_size() instead of open coding 
it. resource_size() does "res->end - res->start + 1". Are you sure your code 
is correct?

> >  	priv->data = (struct armada_thermal_data *)match->data;
> >  	priv->data->init_sensor(pdev, priv);

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

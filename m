From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v6 06/11] thermal: armada: Add support for Armada AP806
Date: Fri, 22 Dec 2017 13:03:50 +0200
Message-ID: <20171222110350.zq2hlrctbzbkbrm7@tarshish>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
 <20171222093226.23456-7-miquel.raynal@free-electrons.com>
 <20171222101426.yujvg2xbca3ghpyc@tarshish>
 <20171222114948.32c36369@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:58582 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdLVLDy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 06:03:54 -0500
Content-Disposition: inline
In-Reply-To: <20171222114948.32c36369@xps13>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel RAYNAL <miquel.raynal@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>

Hi Miquèl,

On Fri, Dec 22, 2017 at 11:49:48AM +0100, Miquel RAYNAL wrote:
> On Fri, 22 Dec 2017 12:14:26 +0200
> Baruch Siach <baruch@tkos.co.il> wrote:
> > On Fri, Dec 22, 2017 at 10:32:21AM +0100, Miquel Raynal wrote:
> > > From: Baruch Siach <baruch@tkos.co.il>
> > > 
> > > The AP806 component is integrated in the Armada 8K and 7K lines of
> > > processors.
> > > 
> > > The thermal sensor sample field on the status register is a signed
> > > value. Extend armada_get_temp() and the driver structure to handle
> > > signed values.
> > > 
> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > [<miquel.raynal@free-electrons.com>: Changes when applying over the
> > > previous patches, including the register names changes, also
> > > switched the coefficients values to s64 instead of unsigned long to
> > > deal with negative values and used do_div instead of the
> > > traditionnal '/'] Signed-off-by: Miquel Raynal
> > > <miquel.raynal@free-electrons.com> Reviewed-by: Gregory CLEMENT
> > > <gregory.clement@free-electrons.com> Tested-by: Gregory CLEMENT
> > > <gregory.clement@free-electrons.com> ---  
> > 
> > [..]
> > 
> > >  static int armada_get_temp(struct thermal_zone_device *thermal,
> > > -			  int *temp)
> > > +			   int *temperature)
> > >  {
> > >  	struct armada_thermal_priv *priv = thermal->devdata;
> > > -	unsigned long reg;
> > > -	unsigned long m, b, div;
> > > +	u32 reg, div;
> > > +	s64 sample, b, m;
> > > +	u64 tmp;
> > >  
> > >  	/* Valid check */
> > >  	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
> > > @@ -178,6 +197,11 @@ static int armada_get_temp(struct
> > > thermal_zone_device *thermal, 
> > >  	reg = readl_relaxed(priv->status);
> > >  	reg = (reg >> priv->data->temp_shift) &
> > > priv->data->temp_mask;
> > > +	if (priv->data->signed_sample)
> > > +		/* The most significant bit is the sign bit */
> > > +		sample = sign_extend32(reg,
> > > fls(priv->data->temp_mask) - 1);
> > > +	else
> > > +		sample = reg;
> > >  
> > >  	/* Get formula coeficients */
> > >  	b = priv->data->coef_b;
> > > @@ -185,9 +209,13 @@ static int armada_get_temp(struct
> > > thermal_zone_device *thermal, div = priv->data->coef_div;
> > >  
> > >  	if (priv->data->inverted)
> > > -		*temp = ((m * reg) - b) / div;
> > > +		tmp = (m * sample) - b;
> > >  	else
> > > -		*temp = (b - (m * reg)) / div;
> > > +		tmp = b - (m * sample);
> > > +
> > > +	do_div(tmp, div);
> > > +	*temperature = (int)tmp;  
> > 
> > Nitpick: why not (untested)
> > 
> > #include <linux/math64.h>
> > 
> >   if (priv->data->inverted)
> >     *temp = div_s64((m * sample) - b, div);
> >   else
> >     *temp = div_s64(b - (m * sample), div);
> 
> Indeed I could also use div_s64, but the result must be unsigned anyway.

*temp is signed, as far as I can see. Temperature can go below zero, at least 
in the Celsius scale.

> But this does all the operations on the same line, maybe this is more
> readable, I will update it and send (hopefully) the last version :)

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

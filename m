From: Miquel RAYNAL <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH v6 06/11] thermal: armada: Add support for Armada AP806
Date: Fri, 22 Dec 2017 11:49:48 +0100
Message-ID: <20171222114948.32c36369@xps13>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
        <20171222093226.23456-7-miquel.raynal@free-electrons.com>
        <20171222101426.yujvg2xbca3ghpyc@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47225 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756720AbdLVKuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 05:50:01 -0500
In-Reply-To: <20171222101426.yujvg2xbca3ghpyc@tarshish>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>

Hi Baruch,

On Fri, 22 Dec 2017 12:14:26 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Miquèl,
> 
> On Fri, Dec 22, 2017 at 10:32:21AM +0100, Miquel Raynal wrote:
> > From: Baruch Siach <baruch@tkos.co.il>
> > 
> > The AP806 component is integrated in the Armada 8K and 7K lines of
> > processors.
> > 
> > The thermal sensor sample field on the status register is a signed
> > value. Extend armada_get_temp() and the driver structure to handle
> > signed values.
> > 
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > [<miquel.raynal@free-electrons.com>: Changes when applying over the
> > previous patches, including the register names changes, also
> > switched the coefficients values to s64 instead of unsigned long to
> > deal with negative values and used do_div instead of the
> > traditionnal '/'] Signed-off-by: Miquel Raynal
> > <miquel.raynal@free-electrons.com> Reviewed-by: Gregory CLEMENT
> > <gregory.clement@free-electrons.com> Tested-by: Gregory CLEMENT
> > <gregory.clement@free-electrons.com> ---  
> 
> [..]
> 
> >  static int armada_get_temp(struct thermal_zone_device *thermal,
> > -			  int *temp)
> > +			   int *temperature)
> >  {
> >  	struct armada_thermal_priv *priv = thermal->devdata;
> > -	unsigned long reg;
> > -	unsigned long m, b, div;
> > +	u32 reg, div;
> > +	s64 sample, b, m;
> > +	u64 tmp;
> >  
> >  	/* Valid check */
> >  	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
> > @@ -178,6 +197,11 @@ static int armada_get_temp(struct
> > thermal_zone_device *thermal, 
> >  	reg = readl_relaxed(priv->status);
> >  	reg = (reg >> priv->data->temp_shift) &
> > priv->data->temp_mask;
> > +	if (priv->data->signed_sample)
> > +		/* The most significant bit is the sign bit */
> > +		sample = sign_extend32(reg,
> > fls(priv->data->temp_mask) - 1);
> > +	else
> > +		sample = reg;
> >  
> >  	/* Get formula coeficients */
> >  	b = priv->data->coef_b;
> > @@ -185,9 +209,13 @@ static int armada_get_temp(struct
> > thermal_zone_device *thermal, div = priv->data->coef_div;
> >  
> >  	if (priv->data->inverted)
> > -		*temp = ((m * reg) - b) / div;
> > +		tmp = (m * sample) - b;
> >  	else
> > -		*temp = (b - (m * reg)) / div;
> > +		tmp = b - (m * sample);
> > +
> > +	do_div(tmp, div);
> > +	*temperature = (int)tmp;  
> 
> Nitpick: why not (untested)
> 
> #include <linux/math64.h>
> 
>   if (priv->data->inverted)
>     *temp = div_s64((m * sample) - b, div);
>   else
>     *temp = div_s64(b - (m * sample), div);

Indeed I could also use div_s64, but the result must be unsigned anyway.

But this does all the operations on the same line, maybe this is more
readable, I will update it and send (hopefully) the last version :)

Cheers,
Miquèl

> 
> baruch
> 
> > +
> >  	return 0;
> >  }  
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v6 06/11] thermal: armada: Add support for Armada AP806
Date: Fri, 22 Dec 2017 12:14:26 +0200
Message-ID: <20171222101426.yujvg2xbca3ghpyc@tarshish>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
 <20171222093226.23456-7-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171222093226.23456-7-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Miquèl,

On Fri, Dec 22, 2017 at 10:32:21AM +0100, Miquel Raynal wrote:
> From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> 
> The AP806 component is integrated in the Armada 8K and 7K lines of
> processors.
> 
> The thermal sensor sample field on the status register is a signed
> value. Extend armada_get_temp() and the driver structure to handle
> signed values.
> 
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> [<miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>: Changes when applying over the
> previous patches, including the register names changes, also switched
> the coefficients values to s64 instead of unsigned long to deal with
> negative values and used do_div instead of the traditionnal '/']
> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---

[..]

>  static int armada_get_temp(struct thermal_zone_device *thermal,
> -			  int *temp)
> +			   int *temperature)
>  {
>  	struct armada_thermal_priv *priv = thermal->devdata;
> -	unsigned long reg;
> -	unsigned long m, b, div;
> +	u32 reg, div;
> +	s64 sample, b, m;
> +	u64 tmp;
>  
>  	/* Valid check */
>  	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
> @@ -178,6 +197,11 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  
>  	reg = readl_relaxed(priv->status);
>  	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
> +	if (priv->data->signed_sample)
> +		/* The most significant bit is the sign bit */
> +		sample = sign_extend32(reg, fls(priv->data->temp_mask) - 1);
> +	else
> +		sample = reg;
>  
>  	/* Get formula coeficients */
>  	b = priv->data->coef_b;
> @@ -185,9 +209,13 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  	div = priv->data->coef_div;
>  
>  	if (priv->data->inverted)
> -		*temp = ((m * reg) - b) / div;
> +		tmp = (m * sample) - b;
>  	else
> -		*temp = (b - (m * reg)) / div;
> +		tmp = b - (m * sample);
> +
> +	do_div(tmp, div);
> +	*temperature = (int)tmp;

Nitpick: why not (untested)

#include <linux/math64.h>

  if (priv->data->inverted)
    *temp = div_s64((m * sample) - b, div);
  else
    *temp = div_s64(b - (m * sample), div);

baruch

> +
>  	return 0;
>  }

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.52.368.4656, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

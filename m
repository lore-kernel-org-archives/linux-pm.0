From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 01/11] dt-bindings: thermal: Describe Armada AP806
 and CP110
Date: Fri, 22 Dec 2017 10:43:16 +0100
Message-ID: <20171222104316.201484c0@xps13>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
        <20171222093226.23456-2-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171222093226.23456-2-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,


On Fri, 22 Dec 2017 10:32:16 +0100
Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> 
> Add compatible strings for AP806 and CP110 that are part of the Armada
> 8k/7k line of SoCs.
> 
> Add a note on the differences in the size of the control area in
> different bindings. This is an existing difference between the Armada
> 375 binding and the other boards already supported. The new AP806 and
> CP110 bindings are similar to the existing Armada 375 in this regard.
> 
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> [<miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>: reword, additional details]
> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

I forgot to add your:

    Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

in this series, sorry about that.

Kind regards,
Miquèl


> ---
>  .../devicetree/bindings/thermal/armada-thermal.txt | 37
> +++++++++++++++------- 1 file changed, 25 insertions(+), 12
> deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> b/Documentation/devicetree/bindings/thermal/armada-thermal.txt index
> 24aacf8948c5..e0d013a2e66d 100644 ---
> a/Documentation/devicetree/bindings/thermal/armada-thermal.txt +++
> b/Documentation/devicetree/bindings/thermal/armada-thermal.txt @@
> -2,22 +2,35 @@ Required properties:
>  
> -- compatible:	Should be set to one of the following:
> -		marvell,armada370-thermal
> -		marvell,armada375-thermal
> -		marvell,armada380-thermal
> -		marvell,armadaxp-thermal
> +- compatible: Should be set to one of the following:
> +    * marvell,armada370-thermal
> +    * marvell,armada375-thermal
> +    * marvell,armada380-thermal
> +    * marvell,armadaxp-thermal
> +    * marvell,armada-ap806-thermal
> +    * marvell,armada-cp110-thermal
>  
> -- reg:		Device's register space.
> -		Two entries are expected, see the examples below.
> -		The first one is required for the sensor register;
> -		the second one is required for the control register
> -		to be used for sensor initialization (a.k.a.
> calibration). +- reg: Device's register space.
> +  Two entries are expected, see the examples below. The first one
> points
> +  to the status register (4B). The second one points to the control
> +  registers (8B).
> +  Note: The compatibles marvell,armada370-thermal,
> +  marvell,armada380-thermal, and marvell,armadaxp-thermal must point
> to
> +  "control MSB/control 1", with size of 4 (deprecated binding), or
> point
> +  to "control LSB/control 0" with size of 8 (current binding). All
> other
> +  compatibles must point to "control LSB/control 0" with size of 8.
>  
> -Example:
> +Examples:
>  
> +	/* Legacy bindings */
>  	thermal@d0018300 {
>  		compatible = "marvell,armada370-thermal";
> -                reg = <0xd0018300 0x4
> +		reg = <0xd0018300 0x4
>  		       0xd0018304 0x4>;
>  	};
> +
> +	ap_thermal: thermal@6f8084 {
> +		compatible = "marvell,armada-ap806-thermal";
> +		reg = <0x6f808C 0x4>,
> +		      <0x6f8084 0x8>;
> +	};



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

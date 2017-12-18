From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 09/12] thermal: armada: Change sensors trim default value
Date: Mon, 18 Dec 2017 17:08:42 +0100
Message-ID: <87lgi0hvcl.fsf@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
        <20171218143643.7714-10-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218143643.7714-10-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Miquel
        Raynal's message of "Mon, 18 Dec 2017 15:36:40 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Miquel,
 
 On lun., déc. 18 2017, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Errata #132698 highlights an error in the default value of Tc trim.
> Set this parameter to b'011.
>
> Suggested-by: David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Gregory

> ---
>  drivers/thermal/armada_thermal.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index cef5c65c8f32..2eadd662591d 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -46,6 +46,10 @@
>  #define CONTROL0_OFFSET			0x0
>  #define CONTROL1_OFFSET			0x4
>  
> +/* Errata fields */
> +#define CONTROL0_TSEN_TC_TRIM_MASK	0x7
> +#define CONTROL0_TSEN_TC_TRIM_VAL	0x3
> +
>  /* TSEN refers to the temperature sensors within the AP */
>  #define CONTROL0_TSEN_START		BIT(0)
>  #define CONTROL0_TSEN_RESET		BIT(1)
> @@ -161,6 +165,15 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
>  	writel(reg, priv->control1);
>  	msleep(10);
> +
> +	/* Set Tsen Tc Trim to correct default value (errata #132698) */
> +	if (priv->control0) {
> +		reg = readl_relaxed(priv->control0);
> +		reg &= ~CONTROL0_TSEN_TC_TRIM_MASK;
> +		reg |= CONTROL0_TSEN_TC_TRIM_VAL;
> +		writel(reg, priv->control0);
> +		msleep(10);
> +	}
>  }
>  
>  static void armada_ap806_init_sensor(struct platform_device *pdev,
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

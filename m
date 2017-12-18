From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 05/12] thermal: armada: Use real status register name
Date: Mon, 18 Dec 2017 16:58:30 +0100
Message-ID: <873748jae1.fsf@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
        <20171218143643.7714-6-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218143643.7714-6-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Miquel
        Raynal's message of "Mon, 18 Dec 2017 15:36:36 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Miquel,
 
 On lun., déc. 18 2017, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Three 32-bit registers are used to drive the thermal IP: control0,
> control1 and status. The two control registers share the same name both
> in the documentation and in the code, while the latter is referred as
> "sensor" in the code. Rename this pointer to be called "status" in order
> to be aligned with the documentation.
>
> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Gregory

> ---
>  drivers/thermal/armada_thermal.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index f422563e617c..198485fa77f2 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -51,7 +51,7 @@ struct armada_thermal_data;
>  
>  /* Marvell EBU Thermal Sensor Dev Structure */
>  struct armada_thermal_priv {
> -	void __iomem *sensor;
> +	void __iomem *status;
>  	void __iomem *control0;
>  	void __iomem *control1;
>  	struct armada_thermal_data *data;
> @@ -98,9 +98,9 @@ static void armadaxp_init_sensor(struct platform_device *pdev,
>  	writel(reg, priv->control1);
>  
>  	/* Enable the sensor */
> -	reg = readl_relaxed(priv->sensor);
> +	reg = readl_relaxed(priv->status);
>  	reg &= ~PMU_TM_DISABLE_MASK;
> -	writel(reg, priv->sensor);
> +	writel(reg, priv->status);
>  }
>  
>  static void armada370_init_sensor(struct platform_device *pdev,
> @@ -156,7 +156,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  
>  static bool armada_is_valid(struct armada_thermal_priv *priv)
>  {
> -	u32 reg = readl_relaxed(priv->sensor);
> +	u32 reg = readl_relaxed(priv->status);
>  
>  	return reg & priv->data->is_valid_bit;
>  }
> @@ -175,7 +175,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  		return -EIO;
>  	}
>  
> -	reg = readl_relaxed(priv->sensor);
> +	reg = readl_relaxed(priv->status);
>  	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
>  
>  	/* Get formula coeficients */
> @@ -277,9 +277,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(priv->sensor))
> -		return PTR_ERR(priv->sensor);
> +	priv->status = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->status))
> +		return PTR_ERR(priv->status);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	control = devm_ioremap_resource(&pdev->dev, res);
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

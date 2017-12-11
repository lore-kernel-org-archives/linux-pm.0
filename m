From: Miquel RAYNAL <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH v2 3/4] thermal: armada: add support for CP110
Date: Mon, 11 Dec 2017 16:09:32 +0100
Message-ID: <20171211160932.692ba8be@xps13>
References: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
        <d48c916a2502f9c75e9ea4ba41300e2ffbb254d8.1512299484.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38334 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbdLKPJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 10:09:44 -0500
In-Reply-To: <d48c916a2502f9c75e9ea4ba41300e2ffbb254d8.1512299484.git.baruch@tkos.co.il>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Baruch,

On Sun,  3 Dec 2017 13:11:23 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> The CP110 component is integrated in the Armada 8k and 7k lines of
> processors.
> 
> This patch also adds an option of offset to the MSB of the control
> register. The existing DT binding for Armada 38x refers to a single
> 32 bit control register. It turns out that this is actually only the
> MSB of the control area. Changing the binding to fix that would break
> existing DT files, so the Armada 38x binding is left as is.
> 
> The new CP110 binding increases the size of the control area to 64
> bits, thus moving the MSB to offset 4.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: No change
> ---
>  drivers/thermal/armada_thermal.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c
> b/drivers/thermal/armada_thermal.c index 0eb82097571f..59b75f63945d
> 100644 --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -73,6 +73,7 @@ struct armada_thermal_data {
>  	unsigned int temp_shift;
>  	unsigned int temp_mask;
>  	unsigned int is_valid_shift;
> +	unsigned int control_msb_offset;
>  };
>  
>  static void armadaxp_init_sensor(struct platform_device *pdev,
> @@ -142,12 +143,14 @@ static void armada375_init_sensor(struct
> platform_device *pdev, static void armada380_init_sensor(struct
> platform_device *pdev, struct armada_thermal_priv *priv)
>  {
> -	unsigned long reg = readl_relaxed(priv->control);
> +	void __iomem *control_msb =
> +		priv->control + priv->data->control_msb_offset;
> +	unsigned long reg = readl_relaxed(control_msb);
>  
>  	/* Reset hardware once */
>  	if (!(reg & A380_HW_RESET)) {
>  		reg |= A380_HW_RESET;
> -		writel(reg, priv->control);
> +		writel(reg, control_msb);
>  		mdelay(10);
>  	}
>  }
> @@ -266,6 +269,19 @@ static const struct armada_thermal_data
> armada_ap806_data = { .signed_sample = true,
>  };
>  
> +static const struct armada_thermal_data armada_cp110_data = {
> +	.is_valid = armada_is_valid,
> +	.init_sensor = armada380_init_sensor,

I see the initialization for CP110 thermal IP is close to
Armada-380's, but, as you point it in the commit log it is still
different.

I don't know what is the best way to handle this but until now each
new compatible had his own ->init_sensor function, shouldn't we do
the same here as changes are requested? This would naturally avoid the
situation with Armada-380 bindings.

Thanks,
Miquèl

From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
Date: Sat, 8 Nov 2014 22:16:46 -0500
Message-ID: <20141109031646.GO3698@titan.lakedaemon.net>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29249 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbaKIDRA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 8 Nov 2014 22:17:00 -0500
Content-Disposition: inline
In-Reply-To: <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
> The Armada 375 Z1 SoC revision is no longer supported. This commit
> removes the quirk needed for the thermal sensor.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
>  drivers/thermal/armada_thermal.c                     | 20 --------------------
>  2 files changed, 28 deletions(-)

As Thomas and Ezequiel rightfully mentioned, the compatible string below
has never been in a dts file.  Our arch code detected the Z1, and
changed the compatible on the fly.  As a result, there shouldn't be any
dtbs in the wild with this compatible string.  If there are, it will be
held by the few developers (Marvell, partners) that know what they are
doing.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> index 4cf0249..4698e0e 100644
> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> @@ -5,17 +5,9 @@ Required properties:
>  - compatible:	Should be set to one of the following:
>  		marvell,armada370-thermal
>  		marvell,armada375-thermal
> -		marvell,armada375-z1-thermal
>  		marvell,armada380-thermal
>  		marvell,armadaxp-thermal
>  
> -		Note: As the name suggests, "marvell,armada375-z1-thermal"
> -		applies for the SoC Z1 stepping only. On such stepping
> -		some quirks need to be done and the register offset differs
> -		from the one in the A0 stepping.
> -		The operating system may auto-detect the SoC stepping and
> -		update the compatible and register offsets at runtime.
> -
>  - reg:		Device's register space.
>  		Two entries are expected, see the examples below.
>  		The first one is required for the sensor register;
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 9d1420a..9c8e783 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -35,10 +35,6 @@
>  #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
>  #define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
>  
> -#define A375_Z1_CAL_RESET_LSB		0x8011e214
> -#define A375_Z1_CAL_RESET_MSB		0x30a88019
> -#define A375_Z1_WORKAROUND_BIT		BIT(9)
> -
>  #define A375_UNIT_CONTROL_SHIFT		27
>  #define A375_UNIT_CONTROL_MASK		0x7
>  #define A375_READOUT_INVERT		BIT(15)
> @@ -124,24 +120,12 @@ static void armada375_init_sensor(struct platform_device *pdev,
>  				  struct armada_thermal_priv *priv)
>  {
>  	unsigned long reg;
> -	bool quirk_needed =
> -		!!of_device_is_compatible(pdev->dev.of_node,
> -					  "marvell,armada375-z1-thermal");
> -
> -	if (quirk_needed) {
> -		/* Ensure these registers have the default (reset) values */
> -		writel(A375_Z1_CAL_RESET_LSB, priv->control);
> -		writel(A375_Z1_CAL_RESET_MSB, priv->control + 0x4);
> -	}
>  
>  	reg = readl(priv->control + 4);
>  	reg &= ~(A375_UNIT_CONTROL_MASK << A375_UNIT_CONTROL_SHIFT);
>  	reg &= ~A375_READOUT_INVERT;
>  	reg &= ~A375_HW_RESETn;
>  
> -	if (quirk_needed)
> -		reg |= A375_Z1_WORKAROUND_BIT;
> -
>  	writel(reg, priv->control + 4);
>  	mdelay(20);
>  
> @@ -260,10 +244,6 @@ static const struct of_device_id armada_thermal_id_table[] = {
>  		.data       = &armada375_data,
>  	},
>  	{
> -		.compatible = "marvell,armada375-z1-thermal",
> -		.data       = &armada375_data,
> -	},
> -	{
>  		.compatible = "marvell,armada380-thermal",
>  		.data       = &armada380_data,
>  	},
> -- 
> 2.1.0
> 

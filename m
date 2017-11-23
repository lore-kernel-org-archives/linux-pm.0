From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/3] thermal: armada: add support for AP806
Date: Thu, 23 Nov 2017 15:24:17 +0000
Message-ID: <20171123152416.GR31757@n2100.armlinux.org.uk>
References: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
 <320800cce532d6ae1927b36f82b007f04c740a15.1511361725.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52066 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbdKWPYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Nov 2017 10:24:38 -0500
Content-Disposition: inline
In-Reply-To: <320800cce532d6ae1927b36f82b007f04c740a15.1511361725.git.baruch@tkos.co.il>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Miquel Raynal <miquel.raynal@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Wed, Nov 22, 2017 at 04:42:04PM +0200, Baruch Siach wrote:
> The AP806 component is integrated in the Armada 8k and 7k lines of processors.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/thermal/armada_thermal.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index ae75328945f7..1f7f81628040 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -41,6 +41,10 @@
>  #define A375_HW_RESETn			BIT(8)
>  #define A380_HW_RESET			BIT(8)
>  
> +#define AP806_START			BIT(0)
> +#define AP806_RESET			BIT(1)
> +#define AP806_ENABLE			BIT(2)
> +
>  struct armada_thermal_data;
>  
>  /* Marvell EBU Thermal Sensor Dev Structure */
> @@ -147,6 +151,18 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  	}
>  }
>  
> +static void armada_ap806_init_sensor(struct platform_device *pdev,
> +				     struct armada_thermal_priv *priv)
> +{
> +	u32 reg = readl_relaxed(priv->control);
> +
> +	reg &= ~AP806_RESET;
> +	reg |= AP806_START;
> +	reg |= AP806_ENABLE;
> +	writel(reg, priv->control);
> +	mdelay(10);

Do you really need to make the CPU busy-wait for 10ms here?  This
looks like it's called from a schedulable context, so won't msleep()
do?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

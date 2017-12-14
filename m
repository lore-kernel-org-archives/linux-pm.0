From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v3 09/11] thermal: armada: Wait sensors validity before exiting the init callback
Date: Thu, 14 Dec 2017 12:23:11 +0100
Message-ID: <87ind9o8o0.fsf@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
        <20171214103011.24713-10-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59404 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdLNLXX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Dec 2017 06:23:23 -0500
In-Reply-To: <20171214103011.24713-10-miquel.raynal@free-electrons.com>
        (Miquel Raynal's message of "Thu, 14 Dec 2017 11:30:09 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, linux-arm-kernel@lists.infradead.org

Hi Miquel,
 
 On jeu., déc. 14 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> The thermal core will check for sensors validity right after the
> initialization callback has returned. As the initialization routine make
> a reset, the sensors are not ready immediately and the core spawns an
> error in the dmesg. Avoid this annoying situation by polling on the
> validity bit before exiting from these routines. This also avoid the use
> of blind sleeps.

You only modified the armada 380 and ap806 init function. Does it means
that this feature is not supported on the other variant?

Gregory

>
> Suggested-by: David Sniatkiwicz <davidsn@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  drivers/thermal/armada_thermal.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index be141ca53e83..1c4122f7377c 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -23,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
>  #include <linux/thermal.h>
> +#include <linux/iopoll.h>
>  
>  /* Thermal Manager Control and Status Register */
>  #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
> @@ -59,6 +60,9 @@
>  #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
>  #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
>  
> +#define STATUS_POLL_PERIOD_US		1000
> +#define STATUS_POLL_TIMEOUT_US		100000
> +
>  struct armada_thermal_data;
>  
>  /* Marvell EBU Thermal Sensor Dev Structure */
> @@ -154,6 +158,16 @@ static void armada375_init_sensor(struct platform_device *pdev,
>  	msleep(50);
>  }
>  
> +static void armada_wait_sensor_validity(struct armada_thermal_priv *priv)
> +{
> +	u32 reg;
> +
> +	readl_relaxed_poll_timeout(priv->status, reg,
> +				   reg & priv->data->is_valid_bit,
> +				   STATUS_POLL_PERIOD_US,
> +				   STATUS_POLL_TIMEOUT_US);
> +}
> +
>  static void armada380_init_sensor(struct platform_device *pdev,
>  				  struct armada_thermal_priv *priv)
>  {
> @@ -163,7 +177,6 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  	reg |= CONTROL1_EXT_TSEN_HW_RESETn;
>  	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
>  	writel(reg, priv->control1);
> -	msleep(10);
>  
>  	/* Set Tsen Tc Trim to correct default value (errata #132698) */
>  	if (priv->control0) {
> @@ -171,8 +184,10 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  		reg &= ~CONTROL0_TSEN_TC_TRIM_MASK;
>  		reg |= CONTROL0_TSEN_TC_TRIM_VAL;
>  		writel(reg, priv->control0);
> -		msleep(10);
>  	}
> +
> +	/* Wait the sensors to be valid or the core will warn the user */
> +	armada_wait_sensor_validity(priv);
>  }
>  
>  static void armada_ap806_init_sensor(struct platform_device *pdev,
> @@ -190,7 +205,9 @@ static void armada_ap806_init_sensor(struct platform_device *pdev,
>  	reg &= ~CONTROL0_TSEN_RESET;
>  	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
>  	writel(reg, priv->control0);
> -	msleep(10);
> +
> +	/* Wait the sensors to be valid or the core will warn the user */
> +	armada_wait_sensor_validity(priv);
>  }
>  
>  static bool armada_is_valid(struct armada_thermal_priv *priv)
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v3 02/11] thermal: armada: Use msleep for long delays
Date: Thu, 14 Dec 2017 11:51:35 +0100
Message-ID: <87bmj1pop4.fsf@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
        <20171214103011.24713-3-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58118 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdLNKvr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Dec 2017 05:51:47 -0500
In-Reply-To: <20171214103011.24713-3-miquel.raynal@free-electrons.com> (Miquel
        Raynal's message of "Thu, 14 Dec 2017 11:30:02 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, linux-arm-kernel@lists.infradead.org

Hi Miquel,
 
 On jeu., déc. 14 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> From: Baruch Siach <baruch@tkos.co.il>
>
> Use msleep for long (> 10ms) delays, instead of the busy waiting mdelay.
> All delays are called from the probe routine, where scheduling is
> allowed.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory
> ---
>  drivers/thermal/armada_thermal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 706d74798cbe..6c4af2622d4f 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -113,7 +113,7 @@ static void armada370_init_sensor(struct platform_device *pdev,
>  	reg &= ~PMU_TDC0_START_CAL_MASK;
>  	writel(reg, priv->control);
>  
> -	mdelay(10);
> +	msleep(10);
>  }
>  
>  static void armada375_init_sensor(struct platform_device *pdev,
> @@ -127,11 +127,11 @@ static void armada375_init_sensor(struct platform_device *pdev,
>  	reg &= ~A375_HW_RESETn;
>  
>  	writel(reg, priv->control + 4);
> -	mdelay(20);
> +	msleep(20);
>  
>  	reg |= A375_HW_RESETn;
>  	writel(reg, priv->control + 4);
> -	mdelay(50);
> +	msleep(50);
>  }
>  
>  static void armada380_init_sensor(struct platform_device *pdev,
> @@ -143,7 +143,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  	if (!(reg & A380_HW_RESET)) {
>  		reg |= A380_HW_RESET;
>  		writel(reg, priv->control);
> -		mdelay(10);
> +		msleep(10);
>  	}
>  }
>  
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

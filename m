From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v7 02/11] thermal: armada: Use msleep for long delays
Date: Mon, 1 Jan 2018 12:55:39 -0800
Message-ID: <20180101205537.GA29474@localhost.localdomain>
References: <20171222161413.20816-1-miquel.raynal@free-electrons.com>
 <20171222161413.20816-3-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46783 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeAAUzm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jan 2018 15:55:42 -0500
Content-Disposition: inline
In-Reply-To: <20171222161413.20816-3-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

On Fri, Dec 22, 2017 at 05:14:04PM +0100, Miquel Raynal wrote:
> From: Baruch Siach <baruch@tkos.co.il>
> 
> Use msleep for long (> 10ms) delays, instead of the busy waiting mdelay.
> All delays are called from the probe routine, where scheduling is
> allowed.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I am queueing this patch, however, ...

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

I want to double check with you that msleep(10) is documented to reach
up to 20ms, see:


WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
#43: FILE: drivers/thermal/armada_thermal.c:116:
+	msleep(10);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
#66: FILE: drivers/thermal/armada_thermal.c:146:
+		msleep(10);

Just want to check that you are aware of this and that it won't cause
troubles in the code flows changed in this patch. Driver is still in one piece, correct?

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

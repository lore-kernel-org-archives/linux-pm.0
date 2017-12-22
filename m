From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v6 11/11] thermal: armada: Give meaningful names to the thermal zones
Date: Fri, 22 Dec 2017 16:36:04 +0100
Message-ID: <873742epwb.fsf@free-electrons.com>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
        <20171222093226.23456-12-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54979 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbdLVPgQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 10:36:16 -0500
In-Reply-To: <20171222093226.23456-12-miquel.raynal@free-electrons.com>
        (Miquel Raynal's message of "Fri, 22 Dec 2017 10:32:26 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

Hi Miquel,
 
 On ven., déc. 22 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> After registration to the thermal core, sysfs will make one entry
> per instance of the driver in /sys/class/thermal_zoneX and
> /sys/class/hwmon/hwmonX, X being the index of the instance, all of them
> having the type/name "armada_thermal".
>
> Until now there was only one thermal zone per SoC but SoCs like Armada
> A7K and Armada A8K have respectively two and three thermal zones (one
> per AP and one per CP) and this number is subject to grow in the future.
>
> Use dev_name() instead of the "armada_thermal" string to get a
> meaningful name and be able to identify the thermal zones from
> userspace.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

And here I also tested that when all the series was applied there was no
regression on an Armada XP based board: PlatHome OpenBlocks AX3-4, and
on an Armada 388 one: SolidRun Clearfog A1. hera again for both of them
it was OK:

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Gregory

> ---
>  drivers/thermal/armada_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index ea958e651312..454137f78eb3 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -406,8 +406,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  
>  	priv->data->init_sensor(pdev, priv);
>  
> -	thermal = thermal_zone_device_register("armada_thermal", 0, 0,
> -					       priv, &ops, NULL, 0, 0);
> +	thermal = thermal_zone_device_register(dev_name(&pdev->dev), 0, 0, priv,
> +					       &ops, NULL, 0, 0);
>  	if (IS_ERR(thermal)) {
>  		dev_err(&pdev->dev,
>  			"Failed to register thermal zone device\n");
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

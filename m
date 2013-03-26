From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] thermal: kirkwood: Fix thermal sensor formula
Date: Tue, 26 Mar 2013 22:24:33 +0800
Message-ID: <1364307873.2821.23.camel@rzhang1-mobl4>
References: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
	 <1363954983-30822-2-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19342 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934459Ab3CZOYm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 10:24:42 -0400
In-Reply-To: <1363954983-30822-2-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>

On Fri, 2013-03-22 at 09:23 -0300, Ezequiel Garcia wrote:
> The currently formula has been taken from the 88AP510 SoC datasheet,
> which is not exactly correct. The correct value for the temperature
> in Celcius of the sensor present in this SoC is:
> 
>   Celsius = (322-reg)/1.3625
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/kirkwood_thermal.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index 65cb4f0..84b331f 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -49,13 +49,13 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
>  	}
>  
>  	/*
> -	 * Calculate temperature. See Section 8.10.1 of the 88AP510,
> -	 * datasheet, which has the same sensor.
> -	 * Documentation/arm/Marvell/README
> +	 * Calculate temperature. According to Marvell internal
> +	 * documentation the formula for this is:
> +	 * Celsius = (322-reg)/1.3625
>  	 */
>  	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
>  		KIRKWOOD_THERMAL_TEMP_MASK;
> -	*temp = ((2281638UL - (7298*reg)) / 10);
> +	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
>  
>  	return 0;
>  }



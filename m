From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 7/9 v2] thermal: bcm2835: constify
 thermal_zone_of_device_ops structures
Date: Tue, 8 Aug 2017 21:58:07 +0200 (CEST)
Message-ID: <1239025469.165778.1502222287761@email.1und1.de>
References: <1502204943-20075-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502204943-20075-8-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:59360 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdHHT67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2017 15:58:59 -0400
In-Reply-To: <1502204943-20075-8-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, bhumirks@gmail.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eduardo Valentin <edubezval@gmail.com>


> Julia Lawall <Julia.Lawall@lip6.fr> hat am 8. August 2017 um 17:09 geschrieben:
> 
> 
> The thermal_zone_of_device_ops structure is only passed as the fourth
> argument to thermal_zone_of_sensor_register, which is declared as const.
> Thus the thermal_zone_of_device_ops structure itself can be const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Still

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

> 
> ---
> 
> v2: This patch was present in the original series
> 
>  drivers/thermal/broadcom/bcm2835_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index e6863c8..a4d6a0e 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -145,7 +145,7 @@ static void bcm2835_thermal_debugfs(struct platform_device *pdev)
>  	debugfs_create_regset32("regset", 0444, data->debugfsdir, regset);
>  }
>  
> -static struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
> +static const struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
>  	.get_temp = bcm2835_thermal_get_temp,
>  };
>  
>

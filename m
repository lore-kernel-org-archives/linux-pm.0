From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/6] thermal: armada: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 22:32:34 +0800
Message-ID: <1367850754.2079.50.camel@rzhang1-mobl4>
References: <003e01ce4a11$e1134900$a339db00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37926 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab3EFOcj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 May 2013 10:32:39 -0400
In-Reply-To: <003e01ce4a11$e1134900$a339db00$@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, 'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>

On Mon, 2013-05-06 at 13:26 +0900, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

it seems that we already have a patchset for this issue.
please check https://patchwork.kernel.org/patch/2516651/

thanks,
rui
> ---
>  drivers/thermal/armada_thermal.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 5b4d75f..0d02d4e 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -210,7 +210,6 @@ static int armada_thermal_exit(struct platform_device *pdev)
>  		platform_get_drvdata(pdev);
>  
>  	thermal_zone_device_unregister(armada_thermal);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
>  }



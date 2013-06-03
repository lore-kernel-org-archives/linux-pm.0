From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Add pm_sleep_ops_ptr() macro
Date: Mon, 03 Jun 2013 13:11:07 +0200
Message-ID: <1867006.c6mxKpbPvX@vostro.rjw.lan>
References: <002801ce6022$a2928930$e7b79b90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57285 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab3FCLCI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Jun 2013 07:02:08 -0400
In-Reply-To: <002801ce6022$a2928930$e7b79b90$@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Lars-Peter Clausen' <lars@metafoo.de>, 'Michael Hennerich' <michael.hennerich@analog.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, June 03, 2013 03:21:51 PM Jingoo Han wrote:
> Add pm_sleep_ops_ptr() macro that allows the .pm entry in the driver structures
> to be assigned without having an #define xxx NULL for the case that PM_SLEEP is
> not enabled.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>

Do you want me to replace the previous patch with this?

Rafael


> ---
>  drivers/video/bfin-lq035q1-fb.c |   20 +++++++++++---------
>  include/linux/pm.h              |    6 ++++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
> index 29d8c04..4474e64 100644
> --- a/drivers/video/bfin-lq035q1-fb.c
> +++ b/drivers/video/bfin-lq035q1-fb.c
> @@ -170,16 +170,19 @@ static int lq035q1_spidev_remove(struct spi_device *spi)
>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
>  }
>  
> -#ifdef CONFIG_PM
> -static int lq035q1_spidev_suspend(struct spi_device *spi, pm_message_t state)
> +#ifdef CONFIG_PM_SLEEP
> +static int lq035q1_spidev_suspend(struct device *dev)
>  {
> +	struct spi_device *spi = to_spi_device(dev);
> +
>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
>  }
>  
> -static int lq035q1_spidev_resume(struct spi_device *spi)
> +static int lq035q1_spidev_resume(struct device *dev)
>  {
> -	int ret;
> +	struct spi_device *spi = to_spi_device(dev);
>  	struct spi_control *ctl = spi_get_drvdata(spi);
> +	int ret;
>  
>  	ret = lq035q1_control(spi, LQ035_DRIVER_OUTPUT_CTL, ctl->mode);
>  	if (ret)
> @@ -187,11 +190,11 @@ static int lq035q1_spidev_resume(struct spi_device *spi)
>  
>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_ON);
>  }
> -#else
> -# define lq035q1_spidev_suspend NULL
> -# define lq035q1_spidev_resume  NULL
>  #endif
>  
> +static SIMPLE_DEV_PM_OPS(lq035q1_spidev_pm_ops, lq035q1_spidev_suspend,
> +			lq035q1_spidev_resume);
> +
>  /* Power down all displays on reboot, poweroff or halt */
>  static void lq035q1_spidev_shutdown(struct spi_device *spi)
>  {
> @@ -708,8 +711,7 @@ static int bfin_lq035q1_probe(struct platform_device *pdev)
>  	info->spidrv.probe    = lq035q1_spidev_probe;
>  	info->spidrv.remove   = lq035q1_spidev_remove;
>  	info->spidrv.shutdown = lq035q1_spidev_shutdown;
> -	info->spidrv.suspend  = lq035q1_spidev_suspend;
> -	info->spidrv.resume   = lq035q1_spidev_resume;
> +	info->spidrv.driver.pm = pm_sleep_ops_ptr(&lq035q1_spidev_pm_ops);
>  
>  	ret = spi_register_driver(&info->spidrv);
>  	if (ret < 0) {
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index bd50d15..999d652 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -61,6 +61,12 @@ extern const char power_group_name[];		/* = "power" */
>  #define pm_ops_ptr(_ptr)	NULL
>  #endif
>  
> +#ifdef CONFIG_PM_SLEEP
> +#define pm_sleep_ops_ptr(_ptr)	(_ptr)
> +#else
> +#define pm_sleep_ops_ptr(_ptr)	NULL
> +#endif
> +
>  typedef struct pm_message {
>  	int event;
>  } pm_message_t;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

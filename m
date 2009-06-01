From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][RFC] Driver Core: Rework platform
	suspend/resume, print warning
Date: Mon, 1 Jun 2009 20:44:27 +0200
Message-ID: <200906012044.27631.rjw@sisk.pl>
References: <20090601102044.10780.12920.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090601102044.10780.12920.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>, gregkh@suse.de
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 01 June 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch reworks the platform driver code for legacy
> suspend and resume to avoid installing callbacks in
> struct device_driver. A warning is also added telling
> users to update the platform driver to use dev_pm_ops.
> 
> The functions platform_legacy_suspend()/resume() directly
> call suspend and resume callbacks in struct platform_driver
> instead of wrapping things in platform_drv_suspend()/resume().
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Greg, is this patch fine with you?

Rafael


> ---
> 
>  Compiles fine, but not runtime tested.
> 
>  drivers/base/platform.c |   36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
> 
> --- 0009/drivers/base/platform.c
> +++ work/drivers/base/platform.c	2009-06-01 18:12:34.000000000 +0900
> @@ -470,22 +470,6 @@ static void platform_drv_shutdown(struct
>  	drv->shutdown(dev);
>  }
>  
> -static int platform_drv_suspend(struct device *_dev, pm_message_t state)
> -{
> -	struct platform_driver *drv = to_platform_driver(_dev->driver);
> -	struct platform_device *dev = to_platform_device(_dev);
> -
> -	return drv->suspend(dev, state);
> -}
> -
> -static int platform_drv_resume(struct device *_dev)
> -{
> -	struct platform_driver *drv = to_platform_driver(_dev->driver);
> -	struct platform_device *dev = to_platform_device(_dev);
> -
> -	return drv->resume(dev);
> -}
> -
>  /**
>   * platform_driver_register
>   * @drv: platform driver structure
> @@ -499,10 +483,10 @@ int platform_driver_register(struct plat
>  		drv->driver.remove = platform_drv_remove;
>  	if (drv->shutdown)
>  		drv->driver.shutdown = platform_drv_shutdown;
> -	if (drv->suspend)
> -		drv->driver.suspend = platform_drv_suspend;
> -	if (drv->resume)
> -		drv->driver.resume = platform_drv_resume;
> +	if (drv->suspend || drv->resume)
> +		pr_warning("Platform driver '%s' needs updating - please use "
> +			"dev_pm_ops\n", drv->driver.name);
> +
>  	return driver_register(&drv->driver);
>  }
>  EXPORT_SYMBOL_GPL(platform_driver_register);
> @@ -634,20 +618,24 @@ static int platform_match(struct device 
>  
>  static int platform_legacy_suspend(struct device *dev, pm_message_t mesg)
>  {
> +	struct platform_driver *pdrv = to_platform_driver(dev->driver);
> +	struct platform_device *pdev = to_platform_device(dev);
>  	int ret = 0;
>  
> -	if (dev->driver && dev->driver->suspend)
> -		ret = dev->driver->suspend(dev, mesg);
> +	if (dev->driver && pdrv->suspend)
> +		ret = pdrv->suspend(pdev, mesg);
>  
>  	return ret;
>  }
>  
>  static int platform_legacy_resume(struct device *dev)
>  {
> +	struct platform_driver *pdrv = to_platform_driver(dev->driver);
> +	struct platform_device *pdev = to_platform_device(dev);
>  	int ret = 0;
>  
> -	if (dev->driver && dev->driver->resume)
> -		ret = dev->driver->resume(dev);
> +	if (dev->driver && pdrv->resume)
> +		ret = pdrv->resume(pdev);
>  
>  	return ret;
>  }

From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] extcon: usb-gpio: switch to use pm wakeirq apis
Date: Thu, 7 Apr 2016 11:23:25 +0300
Message-ID: <570618FD.8030602@ti.com>
References: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: nm@ti.com, linux-pm@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 06/04/16 20:32, Grygorii Strashko wrote:
> Switch to use PM wakeirq APIs which automates wakeup IRQs
> enabling/disabling and so allows to make code simpler.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
> Unfortunately this simple patch depends on:
> "[RFC PATCH] PM / wakeirq: fix wakeirq setting after wakup re-configuration from sysfs"
> https://lkml.org/lkml/2016/4/6/296
> 
>  drivers/extcon/extcon-usb-gpio.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
> index 2b2fecf..bc61d11 100644
> --- a/drivers/extcon/extcon-usb-gpio.c
> +++ b/drivers/extcon/extcon-usb-gpio.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  
> @@ -141,7 +142,8 @@ static int usb_extcon_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, info);
> -	device_init_wakeup(dev, 1);
> +	device_init_wakeup(dev, true);
> +	dev_pm_set_wake_irq(dev, info->id_irq);
>  
>  	/* Perform initial detection */
>  	usb_extcon_detect_cable(&info->wq_detcable.work);
> @@ -155,6 +157,9 @@ static int usb_extcon_remove(struct platform_device *pdev)
>  
>  	cancel_delayed_work_sync(&info->wq_detcable);
>  
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);
> +
>  	return 0;
>  }
>  
> @@ -164,12 +169,6 @@ static int usb_extcon_suspend(struct device *dev)
>  	struct usb_extcon_info *info = dev_get_drvdata(dev);
>  	int ret = 0;
>  
> -	if (device_may_wakeup(dev)) {
> -		ret = enable_irq_wake(info->id_irq);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	/*
>  	 * We don't want to process any IRQs after this point
>  	 * as GPIOs used behind I2C subsystem might not be
> @@ -185,12 +184,6 @@ static int usb_extcon_resume(struct device *dev)
>  	struct usb_extcon_info *info = dev_get_drvdata(dev);
>  	int ret = 0;
>  
> -	if (device_may_wakeup(dev)) {
> -		ret = disable_irq_wake(info->id_irq);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	enable_irq(info->id_irq);
>  
>  	return ret;
> 

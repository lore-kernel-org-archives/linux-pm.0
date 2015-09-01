From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] drivers/power/wakeirq: Call device_init_wakeup from dev_pm_set_wake_irq
Date: Wed, 02 Sep 2015 01:58:34 +0200
Message-ID: <2671167.vEAaCPQzyJ@vostro.rjw.lan>
References: <1441119218-31490-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441119218-31490-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: zhaoyang.huang@linaro.org, sudeep.holla@arm.com, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 01, 2015 04:53:37 PM Daniel Lezcano wrote:
> The function dev_pm_set_wake_irq is typically called after device_init_wakeup.
> 
> Instead of summing a couple of call, let's call device_init_wakeup directly
> from dev_pm_set_wake_irq / dev_pm_clear_wake_irq.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

If there are any existing callers of dev_pm_attach_wake_irq(), you need to
update them too I think.  Also, what if someone wants to use
device_set_wakeup_capable() rather than device_init_wakeup()?


> ---
>  drivers/base/power/wakeirq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index eb6e674..287a021 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -60,8 +60,7 @@ static int dev_pm_attach_wake_irq(struct device *dev, int irq,
>   *
>   * Attach a device IO interrupt as a wake IRQ. The wake IRQ gets
>   * automatically configured for wake-up from suspend  based
> - * on the device specific sysfs wakeup entry. Typically called
> - * during driver probe after calling device_init_wakeup().
> + * on the device specific sysfs wakeup entry.
>   */
>  int dev_pm_set_wake_irq(struct device *dev, int irq)
>  {
> @@ -75,9 +74,13 @@ int dev_pm_set_wake_irq(struct device *dev, int irq)
>  	wirq->dev = dev;
>  	wirq->irq = irq;
>  
> +	device_init_wakeup(dev, true);
> +
>  	err = dev_pm_attach_wake_irq(dev, irq, wirq);
> -	if (err)
> +	if (!err) {
>  		kfree(wirq);
> +		device_init_wakeup(dev, false);
> +	}
>  
>  	return err;
>  }
> @@ -102,6 +105,7 @@ void dev_pm_clear_wake_irq(struct device *dev)
>  	if (!wirq)
>  		return;
>  
> +	device_init_wakeup(dev, false);
>  	spin_lock_irqsave(&dev->power.lock, flags);
>  	device_wakeup_detach_irq(dev);
>  	dev->power.wakeirq = NULL;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

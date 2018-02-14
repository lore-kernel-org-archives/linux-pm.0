From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
Date: Wed, 14 Feb 2018 11:52:56 +0100
Message-ID: <2003557.9eaylDJto6@aspire.rjw.lan>
References: <20180209161456.18951-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180209161456.18951-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Friday, February 9, 2018 5:14:56 PM CET Tony Lindgren wrote:
> This makes it easy to grep :wakeup /proc/interrupts.
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/base/power/power.h   |  1 +
>  drivers/base/power/wakeirq.c | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -31,6 +31,7 @@ struct wake_irq {
>  	struct device *dev;
>  	unsigned int status;
>  	int irq;
> +	char *name;
>  };
>  
>  extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -112,6 +112,7 @@ void dev_pm_clear_wake_irq(struct device *dev)
>  		free_irq(wirq->irq, wirq);
>  		wirq->status &= ~WAKE_IRQ_DEDICATED_MASK;
>  	}
> +	kfree(wirq->name);
>  	kfree(wirq);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
> @@ -175,7 +176,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
>  int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  {
>  	struct wake_irq *wirq;
> -	int err;
> +	int err, namelen;
> +	const char *postfix = ":wakeup";
>  
>  	if (irq < 0)
>  		return -EINVAL;
> @@ -184,6 +186,14 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  	if (!wirq)
>  		return -ENOMEM;
>  
> +	namelen = strlen(dev_name(dev)) + strlen(postfix) + 1;
> +	wirq->name = kzalloc(namelen, GFP_KERNEL);
> +	if (!wirq->name) {
> +		err = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	snprintf(wirq->name, namelen, "%s%s", dev_name(dev), postfix);
>  	wirq->dev = dev;
>  	wirq->irq = irq;
>  	irq_set_status_flags(irq, IRQ_NOAUTOEN);
> @@ -196,9 +206,9 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  	 * so we use a threaded irq.
>  	 */
>  	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
> -				   IRQF_ONESHOT, dev_name(dev), wirq);
> +				   IRQF_ONESHOT, wirq->name, wirq);
>  	if (err)
> -		goto err_free;
> +		goto err_free_name;
>  
>  	err = dev_pm_attach_wake_irq(dev, irq, wirq);
>  	if (err)
> @@ -210,6 +220,8 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  
>  err_free_irq:
>  	free_irq(irq, wirq);
> +err_free_name:
> +	kfree(wirq->name);
>  err_free:
>  	kfree(wirq);
>  
> 

I'll queue this up for 4.17 if there are no objections.

Thanks,
Rafael

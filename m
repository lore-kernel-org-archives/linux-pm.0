From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] opp: handle allocation of device_opp in a separate routine
Date: Wed, 10 Dec 2014 23:01:59 +0100
Message-ID: <3480697.K2MkBymPAS@vostro.rjw.lan>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org> <b759d2563caee1189b543d7a3acb222d316d81a1.1418184737.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52441 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932721AbaLJVkY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 16:40:24 -0500
In-Reply-To: <b759d2563caee1189b543d7a3acb222d316d81a1.1418184737.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Wednesday, December 10, 2014 09:45:34 AM Viresh Kumar wrote:
> Get the 'device_opp' allocation code into a separate routine to keep only the
> necessary part in dev_pm_opp_add_dynamic().
> 
> Also do s/sizeof(struct device_opp)/sizeof(*dev_opp) and remove the print
> message on kzalloc() failure as checkpatch warns for that.

I've lost patches [1-2/5] somehow, but never mind.  I can get them from Patchwork.

In this one I'm wondering about the printk removal mentioned above.  Did
checkpatch complain about the printk?


> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 525ffb202d77..1150b9d2e012 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -386,6 +386,27 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
>  
> +static struct device_opp *add_device_opp(struct device *dev)
> +{
> +	struct device_opp *dev_opp;
> +
> +	/*
> +	 * Allocate a new device OPP table. In the infrequent case where a new
> +	 * device is needed to be added, we pay this penalty.
> +	 */
> +	dev_opp = kzalloc(sizeof(*dev_opp), GFP_KERNEL);
> +	if (!dev_opp)
> +		return NULL;
> +
> +	dev_opp->dev = dev;
> +	srcu_init_notifier_head(&dev_opp->srcu_head);
> +	INIT_LIST_HEAD(&dev_opp->opp_list);
> +
> +	/* Secure the device list modification */
> +	list_add_rcu(&dev_opp->node, &dev_opp_list);
> +	return dev_opp;
> +}
> +
>  static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
>  				  unsigned long u_volt, bool dynamic)
>  {
> @@ -412,27 +433,13 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
>  	/* Check for existing list for 'dev' */
>  	dev_opp = find_device_opp(dev);
>  	if (IS_ERR(dev_opp)) {
> -		/*
> -		 * Allocate a new device OPP table. In the infrequent case
> -		 * where a new device is needed to be added, we pay this
> -		 * penalty.
> -		 */
> -		dev_opp = kzalloc(sizeof(struct device_opp), GFP_KERNEL);
> +		dev_opp = add_device_opp(dev);
>  		if (!dev_opp) {
>  			mutex_unlock(&dev_opp_list_lock);
>  			kfree(new_opp);
> -			dev_warn(dev,
> -				"%s: Unable to create device OPP structure\n",
> -				__func__);
>  			return -ENOMEM;
>  		}
>  
> -		dev_opp->dev = dev;
> -		srcu_init_notifier_head(&dev_opp->srcu_head);
> -		INIT_LIST_HEAD(&dev_opp->opp_list);
> -
> -		/* Secure the device list modification */
> -		list_add_rcu(&dev_opp->node, &dev_opp_list);
>  		head = &dev_opp->opp_list;
>  		goto list_add;
>  	}
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

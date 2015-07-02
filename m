From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 03/10] OPP: Allocate dev_opp from _add_device_opp()
Date: Wed, 01 Jul 2015 18:02:40 -0700
Message-ID: <55948DB0.8060500@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org> <83bd3b9837b30bab62f41aed3dd2cdf52cc21688.1434369079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49408 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbbGBBCn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 21:02:43 -0400
In-Reply-To: <83bd3b9837b30bab62f41aed3dd2cdf52cc21688.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 06/15/2015 04:57 AM, Viresh Kumar wrote:
> There is no need to complicate _opp_add_dynamic() with allocation of
> dev_opp as well. Allocate it from _add_device_opp() instead.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 7895fdd64192..4b646f36f252 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -408,11 +408,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
>  
>  /**
> - * _add_device_opp() - Allocate a new device OPP table
> + * _add_device_opp() - Returns device OPP table

Find device OPP table, or allocate a new one?

>   * @dev:	device for which we do this operation
>   *
> - * New device node which uses OPPs - used when multiple devices with OPP tables
> - * are maintained.
> + * It tries to find an existing table first, if it couldn't find one, it
> + * allocates a new OPP table and returns that.
>   *
>   * Return: valid device_opp pointer if success, else NULL.
>   */
> @@ -420,6 +420,11 @@ static struct device_opp *_add_device_opp(struct device *dev)
>  {
>  	struct device_opp *dev_opp;
>  
> +	/* Check for existing list for 'dev' first */
> +	dev_opp = _find_device_opp(dev);
> +	if (!IS_ERR(dev_opp))
> +		return dev_opp;
> +
>  	/*
>  	 * Allocate a new device OPP table. In the infrequent case where a new
>  	 * device is needed to be added, we pay this penalty.
> @@ -575,8 +580,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
>  static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  			    long u_volt, bool dynamic)
>  {
> -	struct device_opp *dev_opp = NULL;
> -	struct dev_pm_opp *opp, *new_opp;
> +	struct device_opp *dev_opp;
> +	struct dev_pm_opp *opp = NULL, *new_opp;

Hm...

>  	struct list_head *head;
>  	int ret;
>  
> @@ -592,19 +597,11 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  	new_opp->rate = freq;
>  	new_opp->u_volt = u_volt;
>  	new_opp->available = true;
> -	new_opp->dynamic = dynamic;
>  
> -	/* Check for existing list for 'dev' */
> -	dev_opp = _find_device_opp(dev);
> -	if (IS_ERR(dev_opp)) {
> -		dev_opp = _add_device_opp(dev);
> -		if (!dev_opp) {
> -			ret = -ENOMEM;
> -			goto free_opp;
> -		}
> -
> -		head = &dev_opp->opp_list;
> -		goto list_add;
> +	dev_opp = _add_device_opp(dev);
> +	if (!dev_opp) {
> +		ret = -ENOMEM;
> +		goto free_opp;
>  	}
>  
>  	/*
> @@ -620,17 +617,17 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  	}
>  
>  	/* Duplicate OPPs ? */
> -	if (new_opp->rate == opp->rate) {
> +	if (opp && new_opp->rate == opp->rate) {

Isn't opp always non-NULL at this point? Maybe this if statement should
be moved into the list_for_each_entry_rcu() loop.

>  		ret = opp->available && new_opp->u_volt == opp->u_volt ?
>  			0 : -EEXIST;
>  
>  		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
>  			 __func__, opp->rate, opp->u_volt, opp->available,
>  			 new_opp->rate, new_opp->u_volt, new_opp->available);
> -		goto free_opp;
> +		goto remove_dev_opp;
>  	}
>  
> -list_add:
> +	new_opp->dynamic = dynamic;
>  	new_opp->dev_opp = dev_opp;
>  	list_add_rcu(&new_opp->node, head);
>  	mutex_unlock(&dev_opp_list_lock);
> @@ -642,6 +639,8 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADD, new_opp);
>  	return 0;
>  
> +remove_dev_opp:
> +	_remove_device_opp(dev_opp);

Doesn't this just return early because dev_opp has something in it?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project


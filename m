From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Wed, 25 Nov 2015 12:51:47 -0800
Message-ID: <20151125205147.GE11298@codeaurora.org>
References: <cover.1447904566.git.viresh.kumar@linaro.org>
 <4341a83dc6591364cd9deb3dfa8343961b8605d6.1447904566.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59443 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbbKYUvu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2015 15:51:50 -0500
Content-Disposition: inline
In-Reply-To: <4341a83dc6591364cd9deb3dfa8343961b8605d6.1447904566.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On 11/19, Viresh Kumar wrote:
> OPP bindings allow a platform to enable OPPs based on the version of the
> hardware they are used for.
> 
> Add support to the OPP-core to parse these bindings, by introducing
> dev_pm_opp_{set|put}_supported_hw() APIs.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/core.c | 142 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/base/power/opp/opp.h  |   5 ++
>  include/linux/pm_opp.h        |  13 ++++
>  3 files changed, 160 insertions(+)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 6aa172be6e8e..5449bae74a44 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -559,6 +559,9 @@ static void _remove_device_opp(struct device_opp *dev_opp)
>  	if (!list_empty(&dev_opp->opp_list))
>  		return;
>  
> +	if (dev_opp->supported_hw)
> +		return;
> +
>  	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
>  				    node);
>  
> @@ -834,6 +837,139 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
>  }
>  
>  /**
> + * dev_pm_opp_set_supported_hw() - Set supported platforms
> + * @dev: Device for which supported-hw has to be set.
> + * @versions: Array of hierarchy of versions to match.
> + * @count: Number of elements in the array.
> + *
> + * This is required only for the V2 bindings, and it enables a platform to
> + * specify the hierarchy of versions it supports. OPP layer will then enable
> + * OPPs, which are available for those versions, based on its 'opp-supported-hw'
> + * property.
> + *
> + * Locking: The internal device_opp and opp structures are RCU protected.
> + * Hence this function internally uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + */
> +int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
> +				unsigned int count)
> +{
> +	struct device_opp *dev_opp;
> +	int ret = 0;
> +
> +	/* Hold our list modification lock here */
> +	mutex_lock(&dev_opp_list_lock);
> +
> +	dev_opp = _add_device_opp(dev);

So this function will publish an opp to the list...

> +	if (!dev_opp) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	/* Do we already have a version hierarchy associated with dev_opp? */
> +	if (dev_opp->supported_hw) {
> +		dev_err(dev, "%s: Already have supported hardware list\n",
> +			__func__);
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	dev_opp->supported_hw = kmemdup(versions, count * sizeof(*versions),
> +					GFP_KERNEL);

And then we're going to modify said opp here under the mutex
lock.


> +	if (!dev_opp->supported_hw) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	dev_opp->supported_hw_count = count;

So we've properly handled the concurrent writer case (which is
probably not even real), but we have improperly handled the case
where a reader is running in parallel to the writer. We should
only list_add_rcu the pointer once we're done modifying the
pointer we created. Otherwise a reader can come along and see the
half initialized structure, which is not good.

I'm worried that the RCU locking is messed up in other places in
this file now too. Hopefully not, but it's going to require an
audit.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: hl <hl@rock-chips.com>
Subject: Re: [PATCH v2 1/2] PM/devfreq: add suspend frequency support
Date: Thu, 3 Nov 2016 14:36:28 +0800
Message-ID: <581ADAEC.5020701@rock-chips.com>
References: <1478153770-8433-1-git-send-email-hl@rock-chips.com>
 <1478153770-8433-2-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:52535 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbcKCGgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2016 02:36:48 -0400
In-Reply-To: <1478153770-8433-2-git-send-email-hl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: cw00.choi@samsung.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi All,
     Miss something in this patch, just ignored it, sorry about that.

On 2016年11月03日 14:16, Lin Huang wrote:
> Add suspend frequency support and if needed set it to
> the frequency obtained from the suspend opp (can be defined
> using opp-v2 bindings and is optional).
>
> Change-Id: Iaa0d3848d63d9ce03f65ea76f263e4685a4c295e
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - use update_devfreq() instead devfreq_update_status()
>
>   drivers/devfreq/devfreq.c | 17 ++++++++++++++++-
>   include/linux/devfreq.h   |  9 +++++++++
>   2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3ea76..0a76282 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -364,7 +364,10 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
>   		return;
>   	}
>   
> -	devfreq_update_status(devfreq, devfreq->previous_freq);
> +	if (devfreq->suspend_freq)
> +		update_devfreq(devfreq, devfreq->suspend_freq);
> +	else
> +		devfreq_update_status(devfreq, devfreq->previous_freq);
>   	devfreq->stop_polling = true;
>   	mutex_unlock(&devfreq->lock);
>   	cancel_delayed_work_sync(&devfreq->work);
> @@ -1251,6 +1254,18 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>   }
>   EXPORT_SYMBOL(devfreq_recommended_opp);
>   
> +void devfreq_opp_get_suspend_opp(struct device *dev, struct devfreq *devfreq)
> +{
> +	struct dev_pm_opp *suspend_opp;
> +
> +	rcu_read_lock();
> +	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
> +	if (suspend_opp)
> +		devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(devfreq_opp_get_suspend_opp);
> +
>   /**
>    * devfreq_register_opp_notifier() - Helper function to get devfreq notified
>    *				   for any changes in the OPP availability
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2de4e2e..c785ad9 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -88,6 +88,7 @@ struct devfreq_dev_status {
>    */
>   struct devfreq_dev_profile {
>   	unsigned long initial_freq;
> +	unsigned long suspend_freq;
>   	unsigned int polling_ms;
>   
>   	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
> @@ -172,6 +173,7 @@ struct devfreq {
>   	struct delayed_work work;
>   
>   	unsigned long previous_freq;
> +	unsigned long suspend_freq;
>   	struct devfreq_dev_status last_status;
>   
>   	void *data; /* private data for governors */
> @@ -214,6 +216,8 @@ extern void devm_devfreq_remove_device(struct device *dev,
>   /* Helper functions for devfreq user device driver with OPP. */
>   extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>   					   unsigned long *freq, u32 flags);
> +extern void devfreq_opp_get_suspend_opp(struct device *dev,
> +					struct devfreq *devfreq);
>   extern int devfreq_register_opp_notifier(struct device *dev,
>   					 struct devfreq *devfreq);
>   extern int devfreq_unregister_opp_notifier(struct device *dev,
> @@ -348,6 +352,11 @@ static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>   	return ERR_PTR(-EINVAL);
>   }
>   
> +static inline void devfreq_opp_get_suspend_opp(struct device *dev,
> +					       struct devfreq *devfreq)
> +{
> +}
> +
>   static inline int devfreq_register_opp_notifier(struct device *dev,
>   					 struct devfreq *devfreq)
>   {

-- 
Lin Huang



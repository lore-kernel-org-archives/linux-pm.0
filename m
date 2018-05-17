From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH] PM / devfreq: Add policy notifier
Date: Thu, 17 May 2018 11:01:34 +0900
Message-ID: <5AFCE27E.20803@samsung.com>
References: <CGME20180515212545epcas1p2bdfd9c90f2ce6b74ac0fdd8cd9f9f63b@epcas1p2.samsung.com>
        <20180515212447.180595-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180515212447.180595-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Could you give some use-case of DEVFREQ_POLICY_NOTIFIER
or send use-case patch with this patch?

I already knew the CPUFREQ_POLICY_NOTIFIER.
But, until now, there are no any requirements of DEVFREQ_POLICY_NOTIFIER.
If there are no any use-case, it is not necessary codes.

On 2018년 05월 16일 06:24, Matthias Kaehlcke wrote:
> Policy notifiers are called before a frequency change and may adjust the
> frequency, similar to CPUFREQ_ADJUST. The purpose of policy notifiers is
> to support non-thermal throttling of devfreq devices.
> 
> As of now notifiers may only select a lower frequency, but not increase it.
> The reason for this limitation is that devfreq currently doesn't have an
> actual policy for frequencies and OPPs > freq might be disabled by a
> devfreq cooling device (see drivers/thermal/devfreq_cooling.c).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Marked as RFC since I'm aware that this isn't quite a 'policy' notifier,
> but I also didn't want to make it too specific. Maybe devfreq devices should
> have a policy similar to cpufreq?
> 
> Should devfreq core be in charge of disabling/enabling OPPs instead of
> the thermal cooling device? Typically we don't want to use higher OPPs
> than those whitelisted by thermal, so in practice the current situation
> shouldn't be much of an issue.
> 
>  drivers/devfreq/devfreq.c | 20 ++++++++++++++++----
>  include/linux/devfreq.h   |  6 ++++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..a7294c056f65 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -273,6 +273,9 @@ int update_devfreq(struct devfreq *devfreq)
>  	if (err)
>  		return err;
>  
> +	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
> +			DEVFREQ_ADJUST, &freq);

It is not proper to used 'freq' as the passed data.
In current step,'freq' is not adjusted and is not final decided frequency.

> +
>  	/*
>  	 * Adjust the frequency with user freq, QoS and available freq.
>  	 *
> @@ -640,6 +643,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->last_stat_updated = jiffies;
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
> +	srcu_init_notifier_head(&devfreq->policy_notifier_list);
>  
>  	mutex_unlock(&devfreq->lock);
>  
> @@ -1414,7 +1418,7 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
>   * devfreq_register_notifier() - Register a driver with devfreq
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to register.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  int devfreq_register_notifier(struct devfreq *devfreq,
>  				struct notifier_block *nb,
> @@ -1430,6 +1434,10 @@ int devfreq_register_notifier(struct devfreq *devfreq,
>  		ret = srcu_notifier_chain_register(
>  				&devfreq->transition_notifier_list, nb);
>  		break;
> +	case DEVFREQ_POLICY_NOTIFIER:
> +		ret = srcu_notifier_chain_register(
> +				&devfreq->policy_notifier_list, nb);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1442,7 +1450,7 @@ EXPORT_SYMBOL(devfreq_register_notifier);
>   * devfreq_unregister_notifier() - Unregister a driver with devfreq
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  int devfreq_unregister_notifier(struct devfreq *devfreq,
>  				struct notifier_block *nb,
> @@ -1458,6 +1466,10 @@ int devfreq_unregister_notifier(struct devfreq *devfreq,
>  		ret = srcu_notifier_chain_unregister(
>  				&devfreq->transition_notifier_list, nb);
>  		break;
> +	case DEVFREQ_POLICY_NOTIFIER:
> +		ret = srcu_notifier_chain_unregister(
> +				&devfreq->policy_notifier_list, nb);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1485,7 +1497,7 @@ static void devm_devfreq_notifier_release(struct device *dev, void *res)
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  int devm_devfreq_register_notifier(struct device *dev,
>  				struct devfreq *devfreq,
> @@ -1521,7 +1533,7 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  void devm_devfreq_unregister_notifier(struct device *dev,
>  				struct devfreq *devfreq,
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 3aae5b3af87c..8edc538d78f7 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -33,6 +33,10 @@
>  #define	DEVFREQ_PRECHANGE		(0)
>  #define DEVFREQ_POSTCHANGE		(1)
>  
> +#define DEVFREQ_POLICY_NOTIFIER		1
> +
> +#define	DEVFREQ_ADJUST			0
> +
>  struct devfreq;
>  struct devfreq_governor;
>  
> @@ -136,6 +140,7 @@ struct devfreq_dev_profile {
>   * @time_in_state:	Statistics of devfreq states
>   * @last_stat_updated:	The last time stat updated
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> + * @policy_notifier_list: list head of DEVFREQ_POLICY_NOTIFIER notifier
>   *
>   * This structure stores the devfreq information for a give device.
>   *
> @@ -174,6 +179,7 @@ struct devfreq {
>  	unsigned long last_stat_updated;
>  
>  	struct srcu_notifier_head transition_notifier_list;
> +	struct srcu_notifier_head policy_notifier_list;
>  };
>  
>  struct devfreq_freqs {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

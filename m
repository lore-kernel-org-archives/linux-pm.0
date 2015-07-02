From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Wed, 01 Jul 2015 18:13:27 -0700
Message-ID: <55949037.80305@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org> <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49681 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbGBBNa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 21:13:30 -0400
In-Reply-To: <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 06/15/2015 04:57 AM, Viresh Kumar wrote:
> ---
>  drivers/base/power/opp.c | 238 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 213 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 2ac48ff9c1ef..3198c3e77224 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -49,12 +49,17 @@
>   *		are protected by the dev_opp_list_lock for integrity.
>   *		IMPORTANT: the opp nodes should be maintained in increasing
>   *		order.
> - * @dynamic:	not-created from static DT entries.
>   * @available:	true/false - marks if this OPP as available or not
> + * @dynamic:	not-created from static DT entries.

Why move dynamic?

> + * @turbo:	true if turbo (boost) OPP
>   * @rate:	Frequency in hertz
> - * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
> + * @u_volt:	Target voltage in microvolts corresponding to this OPP
> + * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
> + * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
> + * @u_amp:	Maximum current drawn by the device in microamperes
>   * @dev_opp:	points back to the device_opp struct this opp belongs to
>   * @rcu_head:	RCU callback head used for deferred freeing
> + * @np:		OPP's device node.
>   *
>   * This structure stores the OPP information for a given device.
>   */
> @@ -63,11 +68,22 @@ struct dev_pm_opp {
>  
>  	bool available;
>  	bool dynamic;
> +	bool turbo;
>  	unsigned long rate;
> +
> +	/*
> +	 * Order in which u_volt{_min|_max} are present in this structure
> +	 * shouldn't be changed.
> +	 */
>  	unsigned long u_volt;
> +	unsigned long u_volt_min;
> +	unsigned long u_volt_max;
> +	unsigned long u_amp;
>  
>  	struct device_opp *dev_opp;
>  	struct rcu_head rcu_head;
> +
> +	struct device_node *np;
>  };
>  
>  /**
> @@ -501,6 +517,7 @@ static void _opp_remove(struct device_opp *dev_opp,
>  	 */
>  	if (notify)
>  		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
> +
>  	list_del_rcu(&opp->node);
>  	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
>  

Please remove this hunk of noise.

> @@ -675,6 +692,100 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  }
>  
>  /**
> + * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> + * @dev:	device for which we do this operation
> + * @np:		device node
> + *
> + * This function adds an opp definition to the opp list and returns status. The
> + * opp can be controlled using dev_pm_opp_enable/disable functions and may be
> + * removed by dev_pm_opp_remove.
> + *
> + * Locking: The internal device_opp and opp structures are RCU protected.
> + * Hence this function internally uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + *
> + * Return:
> + * 0		On success OR
> + *		Duplicate OPPs (both freq and volt are same) and opp->available
> + * -EEXIST	Freq are same and volt are different OR
> + *		Duplicate OPPs (both freq and volt are same) and !opp->available
> + * -ENOMEM	Memory allocation failure
> + * -EINVAL	Failed parsing the OPP node
> + */
> +static int _opp_add_static_v2(struct device *dev, struct device_node *np)
> +{
> +	struct device_opp *dev_opp;
> +	struct dev_pm_opp *new_opp;
> +	int ret;
> +
> +	/* Hold our list modification lock here */
> +	mutex_lock(&dev_opp_list_lock);
> +
> +	new_opp = _allocate_opp(dev, &dev_opp);
> +	if (!new_opp) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	ret = of_property_read_u32(np, "opp-hz", (u32 *)&new_opp->rate);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: opp-hz not found\n", __func__);
> +		goto free_opp;
> +	}
> +
> +	if (of_get_property(np, "turbo-mode", NULL))
> +		new_opp->turbo = true;

new_opp->turbo = of_property_read_bool(np, "turbo-mode");

> +
> +	new_opp->np = np;
> +	new_opp->dynamic = false;
> +	new_opp->available = true;
> +
> +	/*
> +	 * TODO: Support multiple regulators
> +	 *
> +	 * read opp-microvolt array
> +	 */
> +	ret = of_property_count_u32_elems(np, "opp-microvolt");
> +	if (ret == 1 || ret == 3) {
> +		/* There can be one or three elements here */
> +		ret = of_property_read_u32_array(np, "opp-microvolt",
> +						 (u32 *)&new_opp->u_volt, ret);

It seems fragile to rely on the struct packing here. Maybe the same
comment in the struct should be copied here, and possibly some better
way of doing this so the code can't be subtly broken?

> +		if (ret) {
> +			dev_err(dev, "%s: error parsing opp-microvolt: %d\n",
> +				__func__, ret);
> +			goto free_opp;
> +		}
> +	}
> +
> +	of_property_read_u32(np, "opp-microamp", (u32 *)&new_opp->u_amp);
> +
> +	ret = _opp_add(new_opp, dev_opp);
> +	if (ret)
> +		goto free_opp;
> +
> +	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu\n",
> +		 __func__, new_opp->turbo, new_opp->rate, new_opp->u_volt,
> +		 new_opp->u_volt_min, new_opp->u_volt_max);
> +
> +	mutex_unlock(&dev_opp_list_lock);

We can pr_debug after the unlock?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project


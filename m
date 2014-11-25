From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] opp: Introduce APIs to remove OPPs
Date: Tue, 25 Nov 2014 08:24:35 -0800
Message-ID: <20141125162434.GC5050@linux.vnet.ibm.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
 <f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:48175 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbaKYQYl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 11:24:41 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 25 Nov 2014 09:24:41 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 43C1619D803D
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 09:13:18 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPGObIW46203060
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 09:24:37 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id sAPGTWb5003017
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 09:29:33 -0700
Content-Disposition: inline
In-Reply-To: <f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, stefan.wahren@i2se.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com

On Tue, Nov 25, 2014 at 04:04:19PM +0530, Viresh Kumar wrote:
> OPPs are created statically (from DT) or dynamically. Currently we don't free
> OPPs that are created statically, when the module unloads. And so if the module
> is inserted back again, we get warning for duplicate OPPs as the same were
> already present.
> 
> Also, there might be a need to remove dynamic OPPs in future and so API for that
> is also added.
> 
> This patch adds helper APIs to remove/free existing static and dynamic OPPs.
> 
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> ---
> @Paul/Rafael: Do we need to use call_srcu() instead of kfree_rcu() in
> opp_set_availability()? I left it as it looked a bit different.
> srcu_notifier_call_chain() is getting called after deleting the node.

If the data is alway accessed under an SRCU read-side critical section,
then you do need call_srcu() when freeing it -- as you pointed out,
-with- the srcu_struct included.  ;-)

If the data is accessed under both SRCU and RCU, then things get a bit
more involved.

>  drivers/base/power/opp.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h   |  12 +++++-
>  2 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index b249b01..7ae4db5 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -79,6 +79,7 @@ struct dev_pm_opp {
>   *		however addition is possible and is secured by dev_opp_list_lock
>   * @dev:	device pointer
>   * @srcu_head:	notifier head to notify the OPP availability changes.
> + * @rcu_head:	RCU callback head used for deferred freeing
>   * @opp_list:	list of opps
>   *
>   * This is an internal data structure maintaining the link to opps attached to
> @@ -90,6 +91,7 @@ struct device_opp {
> 
>  	struct device *dev;
>  	struct srcu_notifier_head srcu_head;
> +	struct rcu_head rcu_head;
>  	struct list_head opp_list;
>  };
> 
> @@ -498,6 +500,76 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_add);
> 
> +static void kfree_opp_rcu(struct rcu_head *head)
> +{
> +	struct dev_pm_opp *opp = container_of(head, struct dev_pm_opp, rcu_head);
> +
> +	kfree(opp);
> +}
> +
> +static void kfree_device_rcu(struct rcu_head *head)
> +{
> +	struct device_opp *device_opp = container_of(head, struct device_opp, rcu_head);
> +
> +	kfree(device_opp);
> +}
> +
> +void __dev_pm_opp_remove(struct device_opp *dev_opp, struct dev_pm_opp *opp)
> +{
> +	/*
> +	 * Notify the changes in the availability of the operable
> +	 * frequency/voltage list.
> +	 */
> +	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
> +	list_del_rcu(&opp->node);
> +	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, kfree_opp_rcu);

I am guessing that opp->node is being removed from the list traversed
by srcu_notifier_call_chain()...  (Looks that way below.)

> +
> +	if (list_empty(&dev_opp->opp_list)) {

Does the above want to be "if (!list_empty(&dev_opp->opp_list)) {"?

							Thanx, Paul

> +		list_del_rcu(&dev_opp->node);
> +		call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
> +			  kfree_device_rcu);
> +	}
> +}
> +
> +/**
> + * dev_pm_opp_remove()  - Remove an OPP from OPP list
> + * @dev:	device for which we do this operation
> + * @freq:	OPP to remove with matching 'freq'
> + *
> + * This function removes an opp from the opp list.
> + */
> +void dev_pm_opp_remove(struct device *dev, unsigned long freq)
> +{
> +	struct dev_pm_opp *opp;
> +	struct device_opp *dev_opp;
> +	bool found = false;
> +
> +	/* Hold our list modification lock here */
> +	mutex_lock(&dev_opp_list_lock);
> +
> +	dev_opp = find_device_opp(dev);
> +	if (IS_ERR(dev_opp))
> +		goto unlock;
> +
> +	list_for_each_entry(opp, &dev_opp->opp_list, node) {
> +		if (opp->rate == freq) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
> +			 __func__, freq);
> +		goto unlock;
> +	}
> +
> +	__dev_pm_opp_remove(dev_opp, opp);
> +unlock:
> +	mutex_unlock(&dev_opp_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
> +
>  /**
>   * opp_set_availability() - helper to set the availability of an opp
>   * @dev:		device for which we do this operation
> @@ -687,4 +759,34 @@ int of_init_opp_table(struct device *dev)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_init_opp_table);
> +
> +/**
> + * of_free_opp_table() - Free OPP table entries created from static DT entries
> + * @dev:	device pointer used to lookup device OPPs.
> + *
> + * Free OPPs created using static entries present in DT.
> + */
> +void of_free_opp_table(struct device *dev)
> +{
> +	struct device_opp *dev_opp = find_device_opp(dev);
> +	struct dev_pm_opp *opp, *tmp;
> +
> +	/* Check for existing list for 'dev' */
> +	dev_opp = find_device_opp(dev);
> +	if (WARN(IS_ERR(dev_opp), "%s: dev_opp: %ld\n", dev_name(dev),
> +		 PTR_ERR(dev_opp)))
> +		return;
> +
> +	/* Hold our list modification lock here */
> +	mutex_lock(&dev_opp_list_lock);
> +
> +	/* Free static OPPs */
> +	list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
> +		if (!opp->dynamic)
> +			__dev_pm_opp_remove(dev_opp, opp);
> +	}
> +
> +	mutex_unlock(&dev_opp_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(of_free_opp_table);
>  #endif
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0330217..cec2d45 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -21,7 +21,7 @@ struct dev_pm_opp;
>  struct device;
> 
>  enum dev_pm_opp_event {
> -	OPP_EVENT_ADD, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
> +	OPP_EVENT_ADD, OPP_EVENT_REMOVE, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
>  };
> 
>  #if defined(CONFIG_PM_OPP)
> @@ -44,6 +44,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
> 
>  int dev_pm_opp_add(struct device *dev, unsigned long freq,
>  		   unsigned long u_volt);
> +void dev_pm_opp_remove(struct device *dev, unsigned long freq);
> 
>  int dev_pm_opp_enable(struct device *dev, unsigned long freq);
> 
> @@ -90,6 +91,10 @@ static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
>  	return -EINVAL;
>  }
> 
> +static inline void dev_pm_opp_remove(struct device *dev, unsigned long freq)
> +{
> +}
> +
>  static inline int dev_pm_opp_enable(struct device *dev, unsigned long freq)
>  {
>  	return 0;
> @@ -109,11 +114,16 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
> 
>  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
>  int of_init_opp_table(struct device *dev);
> +void of_free_opp_table(struct device *dev);
>  #else
>  static inline int of_init_opp_table(struct device *dev)
>  {
>  	return -EINVAL;
>  }
> +
> +static inline void of_free_opp_table(struct device *dev)
> +{
> +}
>  #endif
> 
>  #endif		/* __LINUX_OPP_H__ */
> -- 
> 2.0.3.693.g996b0fd
> 


From: Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Re: [PATCH] PM / QoS: Fix device resume latency PM QoS
Date: Mon, 23 Oct 2017 22:54:09 -0700
Message-ID: <20171024055409.GA5805@intel.com>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan>
Reply-To: ramesh.thomas@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2245486.jYtPfSLF5g@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 2017-10-20 at 13:27:34 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
>  
>  static ssize_t pm_qos_resume_latency_store(struct device *dev,
> @@ -228,11 +235,19 @@ static ssize_t pm_qos_resume_latency_sto
>  	s32 value;
>  	int ret;
>  
> -	if (kstrtos32(buf, 0, &value))
> -		return -EINVAL;
> +	if (!kstrtos32(buf, 0, &value)) {
> +		/*
> +		 * Prevent users from writing negative or "no constraint" values
> +		 * directly.
> +		 */
> +		if (value < 0 || value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
> +			return -EINVAL;
>  
> -	if (value < 0)
> -		return -EINVAL;
> +		if (value == 0)
> +			value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +	} else if (!strcmp(buf, "n/a") || !strcmp(buf, "n/a\n")) {

Can the 2 checks for "n/a" be combined by checking first 3 characters?

> +		value = 0;
> +	}

Should there be a check for kstrtos32 failure and return -EINVAL?

>  
>  	ret = dev_pm_qos_update_request(dev->power.qos->resume_latency_req,
>  					value);


> Index: linux-pm/drivers/base/power/domain_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/domain_governor.c
> +++ linux-pm/drivers/base/power/domain_governor.c
> @@ -14,23 +14,20 @@
>  static int dev_update_qos_constraint(struct device *dev, void *data)
>  {
>  	s64 *constraint_ns_p = data;
> -	s32 constraint_ns = -1;
> +	s64 constraint_ns = -1;
>  
>  	if (dev->power.subsys_data && dev->power.subsys_data->domain_data)
>  		constraint_ns = dev_gpd_data(dev)->td.effective_constraint_ns;
>  
> -	if (constraint_ns < 0) {
> +	if (constraint_ns < 0)
>  		constraint_ns = dev_pm_qos_read_value(dev);
> -		constraint_ns *= NSEC_PER_USEC;
> -	}
> -	if (constraint_ns == 0)
> +
> +	if (constraint_ns == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>  		return 0;
>  
> -	/*
> -	 * constraint_ns cannot be negative here, because the device has been
> -	 * suspended.
> -	 */
> -	if (constraint_ns < *constraint_ns_p || *constraint_ns_p == 0)
> +	constraint_ns *= NSEC_PER_USEC;
> +
> +	if (constraint_ns < *constraint_ns_p || *constraint_ns_p < 0)
>  		*constraint_ns_p = constraint_ns;
>  
>  	return 0;
> @@ -63,10 +60,14 @@ static bool default_suspend_ok(struct de
>  
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
>  
> -	if (constraint_ns < 0)
> +	if (constraint_ns == 0)
>  		return false;
>  
> -	constraint_ns *= NSEC_PER_USEC;
> +	if (constraint_ns == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
> +		constraint_ns = -1;
> +	else
> +		constraint_ns *= NSEC_PER_USEC;
> +
>  	/*
>  	 * We can walk the children without any additional locking, because
>  	 * they all have been suspended at this point and their
> @@ -76,14 +77,19 @@ static bool default_suspend_ok(struct de
>  		device_for_each_child(dev, &constraint_ns,
>  				      dev_update_qos_constraint);
>  
> -	if (constraint_ns > 0) {
> -		constraint_ns -= td->suspend_latency_ns +
> -				td->resume_latency_ns;
> -		if (constraint_ns == 0)
> -			return false;
> +	if (constraint_ns < 0) {
> +		/* The children have no constraints. */
> +		td->effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +		td->cached_suspend_ok = true;
> +	} else {
> +		constraint_ns -= td->suspend_latency_ns + td->resume_latency_ns;
> +		if (constraint_ns > 0) {
> +			td->effective_constraint_ns = constraint_ns;
> +			td->cached_suspend_ok = true;
> +		} else {
> +			td->effective_constraint_ns = 0;

Previously effective_constraint_ns was left as -1 if constraint_ns becomes 0
Not sure if this change is intentional. I think at dev_update_qos_constraint,
this can cause to skip call to dev_pm_qos_read_value. 

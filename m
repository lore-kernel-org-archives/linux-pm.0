From: Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Re: [PATCH v2] PM / QoS: Fix device resume latency PM QoS
Date: Wed, 25 Oct 2017 00:16:25 -0700
Message-ID: <20171025071625.GA13327@intel.com>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan>
 <2465945.6cfLQGiipl@aspire.rjw.lan>
 <CAJZ5v0imdah_V1ErJsAUgh=vmsS3wtRsoRtgLQwxonGLzQrT-A@mail.gmail.com>
 <1948004.bU45lK7TsE@aspire.rjw.lan>
Reply-To: ramesh.thomas@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1948004.bU45lK7TsE@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 2017-10-24 at 13:35:05 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

[cut]

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

If the resume latency constraint was increased after this,
default_power_down_ok may not consider the new value. default_suspend_ok needs
to get called first if the new value is to be read.

This is because dev_pm_qos_read_value will get called only if
effective_constraint_ns has a negative value. default_suspend_ok initializes
effective_constraint_ns with -1 before doing the calculations.
default_power_down_ok does not initialize it to -1 and uses
the existing value.

A comment in default_power_down_ok implies it is not necessary to call
default_suspend_ok before calling default_power_down_ok. In that case,
default_power_down_ok should be able to get the new latency constraint value.


> +		}
>  	}
> -	td->effective_constraint_ns = constraint_ns;
> -	td->cached_suspend_ok = constraint_ns >= 0;
>  
>  	/*
>  	 * The children have been suspended already, so we don't need to take
> @@ -145,13 +151,14 @@ static bool __default_power_down_ok(stru
>  		td = &to_gpd_data(pdd)->td;
>  		constraint_ns = td->effective_constraint_ns;
>  		/* default_suspend_ok() need not be called before us. */
> -		if (constraint_ns < 0) {
> +		if (constraint_ns < 0)
>  			constraint_ns = dev_pm_qos_read_value(pdd->dev);
> -			constraint_ns *= NSEC_PER_USEC;
> -		}
> -		if (constraint_ns == 0)
> +
> +		if (constraint_ns == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>  			continue;
>  
> +		constraint_ns *= NSEC_PER_USEC;
> +
>  		/*
>  		 * constraint_ns cannot be negative here, because the device has
>  		 * been suspended.

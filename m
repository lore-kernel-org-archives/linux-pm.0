From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH] PM / QoS: Fix device resume latency PM QoS
Date: Fri, 20 Oct 2017 15:04:32 -0700
Message-ID: <9768e3ed-4bf8-7f10-34e4-d4ac91b43847@intel.com>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:19124 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752671AbdJTWEe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Oct 2017 18:04:34 -0400
In-Reply-To: <2245486.jYtPfSLF5g@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alex Shi <alex.shi@linaro.org>, Ramesh Thomas <ramesh.thomas@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Rafael,

Thank you very much!

With this patch I am now able to dynamically modify the latency requirements via the kernel API.

Below I provide the details of what I tested.

On a four core system I wanted to dynamically constrain two cores from entering deeper C-states.
# grep . /sys/devices/system/cpu/cpuidle/current_*
/sys/devices/system/cpu/cpuidle/current_driver:acpi_idle
/sys/devices/system/cpu/cpuidle/current_governor_ro:menu

Stage1:
On boot I now see (from the cpu online code):
       swapper/0-1     [000] ....     0.346148: dev_pm_qos_add_request: device=cpu0 type=DEV_PM_QOS_RESUME_LATENCY new_value=2147483647
       swapper/0-1     [000] ....     0.346247: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2147483647
       swapper/0-1     [000] ....     0.346519: dev_pm_qos_add_request: device=cpu1 type=DEV_PM_QOS_RESUME_LATENCY new_value=2147483647
       swapper/0-1     [000] ....     0.346593: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2147483647
       swapper/0-1     [000] ....     0.346794: dev_pm_qos_add_request: device=cpu2 type=DEV_PM_QOS_RESUME_LATENCY new_value=2147483647
       swapper/0-1     [000] ....     0.346867: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2147483647
       swapper/0-1     [000] ....     0.347080: dev_pm_qos_add_request: device=cpu3 type=DEV_PM_QOS_RESUME_LATENCY new_value=2147483647
       swapper/0-1     [000] ....     0.347153: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2147483647

At this time turbostat shows me that all four of the cores are in C6 more than 99% of the time.

Stage2:
Starting my code I request a 2us constraint on the resume latency of core #2 and #3 and this goes smoothly:
           runit-700   [002] ....   933.722548: dev_pm_qos_add_request: device=cpu2 type=DEV_PM_QOS_RESUME_LATENCY new_value=2
           runit-700   [002] ....   933.722956: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2
           runit-700   [002] ....   933.723161: dev_pm_qos_add_request: device=cpu3 type=DEV_PM_QOS_RESUME_LATENCY new_value=2
           runit-700   [002] ....   933.723407: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2

Running turbostat in parallel I can immediately observe that the cores are indeed not entering deeper C-states (they stay in C1). I also tried it by requesting a 0us constraint where turbostat showed that only C1 is entered minimally (0.09%).

Stage3:
Removing the constraint went just as smoothly, previous "no constraint" was restored and turbostat shows we are spending most time in C6 again.
           rmdir-757   [002] ....  1050.146021: dev_pm_qos_remove_request: device=cpu3 type=DEV_PM_QOS_RESUME_LATENCY new_value=-1
           rmdir-757   [002] ....  1050.146383: pm_qos_update_target: action=REMOVE_REQ prev_value=2 curr_value=2147483647
           rmdir-757   [002] ....  1050.146512: dev_pm_qos_remove_request: device=cpu2 type=DEV_PM_QOS_RESUME_LATENCY new_value=-1
           rmdir-757   [002] ....  1050.146812: pm_qos_update_target: action=REMOVE_REQ prev_value=2 curr_value=2147483647

Through all three stages every core kept reporting a resume_latency requirement of zero. Though not blocking anything from my side it is still of concern to me that there is no way to query the effective constraint from user space. 
# grep . /sys/devices/system/cpu/cpu?/power/pm_qos_resume_latency_us
/sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us:0
/sys/devices/system/cpu/cpu1/power/pm_qos_resume_latency_us:0
/sys/devices/system/cpu/cpu2/power/pm_qos_resume_latency_us:0
/sys/devices/system/cpu/cpu3/power/pm_qos_resume_latency_us:0

I am keeping this patch in my local repo to continue developing against it. 

Thank you very much.

Tested-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

On 10/20/2017 4:27 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The special value of 0 for device resume latency PM QoS means
> "no restriction", but there are two problems with that.
> 
> First, device resume latency PM QoS requests with 0 as the
> value are always put in front of requests with positive
> values in the priority lists used internally by the PM QoS
> framework, causing 0 to be chosen as an effective constraint
> value.  However, that 0 is then interpreted as "no restriction"
> effectively overriding the other requests with specific
> restrictions which is incorrect.
> 
> Second, the users of device resume latency PM QoS have no
> way to specify that *any* resume latency at all should be
> avoided, which is an artificial limitation in general.
> 
> To address these issues, modify device resume latency PM QoS to
> use S32_MAX as the "no constraint" value and 0 as the "no
> latency at all" one and rework its users (the cpuidle menu
> governor, the genpd QoS governor and the runtime PM framework)
> to follow these changes.
> 
> Also add a special "n/a" value to the corresponding user space I/F
> to allow user space to indicate that it cannot accept any resume
> latencies at all for the given device.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197323
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-power |    4 +
>  drivers/base/cpu.c                            |    3 -
>  drivers/base/power/domain_governor.c          |   53 ++++++++++++++------------
>  drivers/base/power/qos.c                      |    2 
>  drivers/base/power/runtime.c                  |    2 
>  drivers/base/power/sysfs.c                    |   25 +++++++++---
>  drivers/cpuidle/governors/menu.c              |    4 -
>  include/linux/pm_qos.h                        |    5 +-
>  8 files changed, 62 insertions(+), 36 deletions(-)
> 
> Index: linux-pm/drivers/base/power/sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/sysfs.c
> +++ linux-pm/drivers/base/power/sysfs.c
> @@ -218,7 +218,14 @@ static ssize_t pm_qos_resume_latency_sho
>  					  struct device_attribute *attr,
>  					  char *buf)
>  {
> -	return sprintf(buf, "%d\n", dev_pm_qos_requested_resume_latency(dev));
> +	s32 value = dev_pm_qos_requested_resume_latency(dev);
> +
> +	if (value == 0)
> +		return sprintf(buf, "n/a\n");
> +	else if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
> +		value = 0;
> +
> +	return sprintf(buf, "%d\n", value);
>  }
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
> +		value = 0;
> +	}
>  
>  	ret = dev_pm_qos_update_request(dev->power.qos->resume_latency_req,
>  					value);
> Index: linux-pm/include/linux/pm_qos.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_qos.h
> +++ linux-pm/include/linux/pm_qos.h
> @@ -27,16 +27,17 @@ enum pm_qos_flags_status {
>  	PM_QOS_FLAGS_ALL,
>  };
>  
> -#define PM_QOS_DEFAULT_VALUE -1
> +#define PM_QOS_DEFAULT_VALUE	(-1)
> +#define PM_QOS_LATENCY_ANY	S32_MAX
>  
>  #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
>  #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
>  #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
>  #define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE	0
>  #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	0
> +#define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
>  #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
> -#define PM_QOS_LATENCY_ANY			((s32)(~(__u32)0 >> 1))
>  
>  #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
>  
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -298,8 +298,8 @@ static int menu_select(struct cpuidle_dr
>  		data->needs_update = 0;
>  	}
>  
> -	/* resume_latency is 0 means no restriction */
> -	if (resume_latency && resume_latency < latency_req)
> +	if (resume_latency < latency_req &&
> +	    resume_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>  		latency_req = resume_latency;
>  
>  	/* Special case when user has set very strict latency requirement */
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
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -253,7 +253,7 @@ static int rpm_check_suspend_allowed(str
>  	    || (dev->power.request_pending
>  			&& dev->power.request == RPM_REQ_RESUME))
>  		retval = -EAGAIN;
> -	else if (__dev_pm_qos_read_value(dev) < 0)
> +	else if (__dev_pm_qos_read_value(dev) == 0)
>  		retval = -EPERM;
>  	else if (dev->power.runtime_status == RPM_SUSPENDED)
>  		retval = 1;
> Index: linux-pm/drivers/base/cpu.c
> ===================================================================
> --- linux-pm.orig/drivers/base/cpu.c
> +++ linux-pm/drivers/base/cpu.c
> @@ -377,7 +377,8 @@ int register_cpu(struct cpu *cpu, int nu
>  
>  	per_cpu(cpu_sys_devices, num) = &cpu->dev;
>  	register_cpu_under_node(num, cpu_to_node(num));
> -	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
> +	dev_pm_qos_expose_latency_limit(&cpu->dev,
> +					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
>  
>  	return 0;
>  }
> Index: linux-pm/drivers/base/power/qos.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/qos.c
> +++ linux-pm/drivers/base/power/qos.c
> @@ -189,7 +189,7 @@ static int dev_pm_qos_constraints_alloca
>  	plist_head_init(&c->list);
>  	c->target_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
>  	c->default_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
> -	c->no_constraint_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
> +	c->no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  	c->type = PM_QOS_MIN;
>  	c->notifiers = n;
>  
> Index: linux-pm/Documentation/ABI/testing/sysfs-devices-power
> ===================================================================
> --- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-power
> +++ linux-pm/Documentation/ABI/testing/sysfs-devices-power
> @@ -211,7 +211,9 @@ Description:
>  		device, after it has been suspended at run time, from a resume
>  		request to the moment the device will be ready to process I/O,
>  		in microseconds.  If it is equal to 0, however, this means that
> -		the PM QoS resume latency may be arbitrary.
> +		the PM QoS resume latency may be arbitrary and the special value
> +		"n/a" means that user space cannot accept any resume latency at
> +		all for the given device.
>  
>  		Not all drivers support this attribute.  If it isn't supported,
>  		it is not present.
> 

From: Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Re: cpuidle: Add "cpuidle.use_deepest" to bypass governor and allow
 HW to go deep
Date: Thu, 9 Nov 2017 13:47:41 -0800
Message-ID: <20171109214739.GA23508@intel.com>
References: <1d81edef71c936099f8bb9d16162f8e70fbe401c.1510212816.git.len.brown@intel.com>
Reply-To: ramesh.thomas@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1d81edef71c936099f8bb9d16162f8e70fbe401c.1510212816.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: thomas.ilsche@tu-dresden.de, dsmythies@telus.net, linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 2017-11-09 at 02:38:51 -0500, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 

[cut]

> +/**
> + * cpuidle_find_deepest_state_qos - Find the deepest available idle state.
> + * @drv: cpuidle driver for the given CPU.
> + * @dev: cpuidle device for the given CPU.
> + * Honors PM_QOS
> + */
> +int cpuidle_find_deepest_state_qos(struct cpuidle_driver *drv,
> +			       struct cpuidle_device *dev)
> +{
> +	return find_deepest_state(drv, dev,
> +			pm_qos_request(PM_QOS_CPU_DMA_LATENCY), 0, false);

I think here the per-cpu PM QoS latency requirement should also be considered.  
User would have kept the system wide PM QoS at default high and set a low       
latency tolerance for a CPU.                                                    
                                                                                
Like it is done in the menu cpuidle governor -                                  
                                                                                
int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);                       
struct device *device = get_cpu_device(dev->cpu);                               
int resume_latency = dev_pm_qos_raw_read_value(device);                         
                                                                                
Then take the lower of the 2.                                                   
        if (resume_latency && resume_latency < latency_req)                     
                                latency_req = resume_latency;                   

> +}
> +
>  #ifdef CONFIG_SUSPEND
>  static void enter_s2idle_proper(struct cpuidle_driver *drv,
>  				struct cpuidle_device *dev, int index)
> @@ -681,4 +699,5 @@ static int __init cpuidle_init(void)
>  }
>  
>  module_param(off, int, 0444);
> +module_param(use_deepest, bool, 0644);
>  core_initcall(cpuidle_init);
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 8f7788d23b57..e3c2c9d1898f 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -198,19 +198,26 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>  #ifdef CONFIG_CPU_IDLE
>  extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  				      struct cpuidle_device *dev);
> +extern int cpuidle_find_deepest_state_qos(struct cpuidle_driver *drv,
> +				      struct cpuidle_device *dev);
>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>  				struct cpuidle_device *dev);
>  extern void cpuidle_use_deepest_state(bool enable);
> +extern bool cpuidle_using_deepest_state(void);
>  #else
>  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  					     struct cpuidle_device *dev)
>  {return -ENODEV; }
> +static inline int cpuidle_find_deepest_state_qos(struct cpuidle_driver *drv,
> +					     struct cpuidle_device *dev)
> +{return -ENODEV; }
>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>  				       struct cpuidle_device *dev)
>  {return -ENODEV; }
>  static inline void cpuidle_use_deepest_state(bool enable)
>  {
>  }
> +static inline bool cpuidle_using_deepest_state(void) {return false; }
>  #endif
>  
>  /* kernel/sched/idle.c */
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 257f4f0b4532..6c7348ae28ec 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -167,17 +167,33 @@ static void cpuidle_idle_call(void)
>  	 * until a proper wakeup interrupt happens.
>  	 */
>  
> -	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
> -		if (idle_should_enter_s2idle()) {
> -			entered_state = cpuidle_enter_s2idle(drv, dev);
> -			if (entered_state > 0) {
> -				local_irq_enable();
> -				goto exit_idle;
> -			}
> +	if (idle_should_enter_s2idle()) {
> +		entered_state = cpuidle_enter_s2idle(drv, dev);
> +		if (entered_state > 0) {
> +			local_irq_enable();
> +			goto exit_idle;
>  		}

Looks like there is a change in behavior here. Earlier if entered_state is <= 0 
then it finds the deepest state and enters it. Now it will go through the       
checks below and may even end up calling the governor, which it should not
based on the comment about s2idle above this if block.
                                                                                
> +	}
>  
> +	/*
> +	 * cpuidle_dev->user_deepest_state is per-device, and thus per-CPU.
> +	 * it is used to force power-savings, and thus does not obey PM_QOS.
> +	 */
> +
> +	if (dev->use_deepest_state) {
>  		next_state = cpuidle_find_deepest_state(drv, dev);
>  		call_cpuidle(drv, dev, next_state);
> +	}
> +
> +	/*
> +	 * cpuidle_using_deepest_state() is system-wide, applying to all CPUs.
> +	 * When activated, Linux gives the hardware permission to go as deep
> +	 * as PM_QOS allows.
> +	 */
> +
> +	else if (cpuidle_using_deepest_state()) {
> +		next_state = cpuidle_find_deepest_state_qos(drv, dev);
> +		call_cpuidle(drv, dev, next_state);
>  	} else {
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient idle state.


Regards,
Ramesh

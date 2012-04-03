From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH][V3] cpuidle : use percpu cpuidle in the core
	code
Date: Tue, 03 Apr 2012 11:19:56 +0530
Message-ID: <4F7A8F84.5040700@linux.vnet.ibm.com>
References: <1333394401-20701-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1333394401-20701-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, patches@linaro.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 04/03/2012 12:50 AM, Daniel Lezcano wrote:

> The usual cpuidle initialization routines register the driver and
> then register a cpuidle device per cpu.
> 
> By default, most drivers initialize the device state count with the
> driver state count.
> 
> We can then add a new function 'cpuidle_register' where we register
> the driver and the devices. These devices can be defined in a global
> static variable in cpuidle.c. We will be able to factor out and
> remove a lot of duplicate lines of code.
> 
> As we still have some drivers, with different initialization routines,
> we keep 'cpuidle_register_driver' and 'cpuidle_register_device' as low
> level initialization routines to do some specific operations on the
> cpuidle devices.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Looks good to me now.
Acked-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>


Regards,
Srivatsa S. Bhat

> ---
>  drivers/cpuidle/cpuidle.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpuidle.h   |    3 +++
>  2 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 87411ce..4d1f79b 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -23,6 +23,7 @@
>  #include "cpuidle.h"
> 
>  DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> +DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
> 
>  DEFINE_MUTEX(cpuidle_lock);
>  LIST_HEAD(cpuidle_detected_devices);
> @@ -419,6 +420,47 @@ int cpuidle_register_device(struct cpuidle_device *dev)
> 
>  EXPORT_SYMBOL_GPL(cpuidle_register_device);
> 
> +/*
> + * cpuidle_register : register cpuidle driver and devices
> + * Note this function must be called after smp_init.
> + * @drv : the cpuidle driver
> + * Returns 0 on success, < 0 otherwise
> + */
> +int cpuidle_register(struct cpuidle_driver *drv)
> +{
> +	int ret, cpu, i;
> +	struct cpuidle_device *dev;
> +
> +	ret = cpuidle_register_driver(drv);
> +	if (ret)
> +		return ret;
> +
> +	for_each_online_cpu(cpu) {
> +		dev = &per_cpu(cpuidle_device, cpu);
> +		dev->cpu = cpu;
> +
> +		ret = cpuidle_register_device(dev);
> +		if (ret)
> +			goto out_unregister;
> +	}
> +
> +out:
> +	return ret;
> +
> +out_unregister:
> +	for_each_online_cpu(i) {
> +		if (i == cpu)
> +			break;
> +		dev = &per_cpu(cpuidle_device, i);
> +		cpuidle_unregister_device(dev);
> +	}
> +
> +	cpuidle_unregister_driver(drv);
> +
> +	goto out;
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_register);
> +
>  /**
>   * cpuidle_unregister_device - unregisters a CPU's idle PM feature
>   * @dev: the cpu
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 6c26a3d..3475294 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -135,6 +135,7 @@ struct cpuidle_driver {
>  #ifdef CONFIG_CPU_IDLE
>  extern void disable_cpuidle(void);
>  extern int cpuidle_idle_call(void);
> +extern int cpuidle_register(struct cpuidle_driver *drv);
>  extern int cpuidle_register_driver(struct cpuidle_driver *drv);
>  struct cpuidle_driver *cpuidle_get_driver(void);
>  extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
> @@ -154,6 +155,8 @@ extern int cpuidle_play_dead(void);
>  #else
>  static inline void disable_cpuidle(void) { }
>  static inline int cpuidle_idle_call(void) { return -ENODEV; }
> +static inline int cpuidle_register(struct cpuidle_driver *drv)
> +{return -ENODEV; }
>  static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
>  {return -ENODEV; }
>  static inline struct cpuidle_driver *cpuidle_get_driver(void) {return NULL; }

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] ARM: cpuidle: Document the code
Date: Tue, 24 Mar 2015 18:51:44 +0000
Message-ID: <20150324185144.GB27311@red-moon>
References: <20150323225828.GC15435@e102568-lin.cambridge.arm.com>
 <1427190842-30675-1-git-send-email-daniel.lezcano@linaro.org>
 <1427190842-30675-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49241 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313AbbCXSvh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 Mar 2015 14:51:37 -0400
Content-Disposition: inline
In-Reply-To: <1427190842-30675-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On Tue, Mar 24, 2015 at 09:54:02AM +0000, Daniel Lezcano wrote:
> Add kernel-doc format documentation in the code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/kernel/cpuidle.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index 2b0dae3..9219613 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -21,6 +21,17 @@ static const struct of_cpuidle_method __cpuidle_method_of_table_sentinel
>  
>  static struct cpuidle_ops cpuidle_ops[NR_CPUS];
>  
> +/*

You miss a star here to comply with kernel-doc (comment valid throughout
the patch for all functions).

> + * arm_cpuidle_simple_enter() - a wrapper to cpu_do_idle()
> + * @dev: not used
> + * @drv: not used
> + * @index: not used
> + *
> + * A trivial wrapper to allow the cpu_do_idle function to be assigned as a
> + * cpuidle callback by matching the function signature.
> + *
> + * Returns the index passed as parameter
> + */
>  int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>  		struct cpuidle_driver *drv, int index)
>  {
> @@ -29,6 +40,16 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>  	return index;
>  }
>  
> +/*
> + * arm_cpuidle_suspend() - function to enter low power idle states
> + * @index: an integer used as an identifier for the low level PM callbacks
> + *
> + * This function calls the underlying arch specific low level PM code as
> + * registered at the init time.
> + *
> + * Returns -EOPNOTSUPP if no suspend callback is defined, the result of the
> + * callback otherwise.
> + */
>  int arm_cpuidle_suspend(int index)
>  {
>  	int ret = -EOPNOTSUPP;
> @@ -40,6 +61,15 @@ int arm_cpuidle_suspend(int index)
>  	return ret;
>  }
>  
> +/*
> + * arm_cpuidle_get_ops() - find a registered cpuidle_ops by name
> + * @method: the method name
> + *
> + * Search in the __cpuidle_method_of_table array the cpuidle ops matching the
> + * method name.
> + *
> + * Returns a struct cpuidle_ops pointer, NULL if not found.
> + */
>  static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
>  {
>  	struct of_cpuidle_method *m = __cpuidle_method_of_table;
> @@ -51,6 +81,19 @@ static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
>  	return NULL;
>  }
>  
> +/*
> + * arm_cpuidle_read_ops() - Initialize the cpuidle ops with the device tree
> + * @dn: a struct device node corresponding to a cpu node

It is a pointer, not a struct.

> + * @cpu: the cpu identifier
> + *
> + * Get the method name defined in the 'enabled-method' property, retrieve the
> + * associated cpuidle_ops and do a struct copy. This copy is needed because all
> + * cpuidle_ops are tagged __initdata and will be unloaded after the init
> + * process.
> + *
> + * Return 0 on sucess, -ENOENT if no enabled-method is defined, -EOPNOTSUPP if
> + * no cpuidle_ops is registered for the enabled-method.
> + */
>  static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
>  {
>  	const char *enable_method;
> @@ -75,6 +118,21 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
>  	return 0;
>  }
>  
> +/*
> + * arm_cpuidle_init() - Initialize cpuidle_ops for a specific cpu
> + * @cpu: the cpu to be initialized
> + *
> + * Initialize the cpuidle ops with the device for the cpu and then call
> + * the cpu's idle initialization callback. This may fail if the underlying HW
> + * is not operational.
> + *
> + * Returns:
> + *  0 on success,
> + *  -ENODEV if it fails to find the cpu node in the device tree,
> + *  -EOPNOTSUPP if it does not find a registered cpuidle_ops for this cpu,
> + *  -ENOENT if it fails to find a enabled-method property,

Ultra-nit: "an enabled-method"

> + *  -ENXIO if the HW reports a failure or a misconfiguration

-ENOMEM is missing.

Apart from these ultraminor changes (and thanks for putting it
together):

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> + */
>  int __init arm_cpuidle_init(int cpu)
>  {
>  	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
> -- 
> 1.9.1
> 
> 

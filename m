From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH][V2] cpuidle : use percpu cpuidle in the core
	code
Date: Mon, 02 Apr 2012 18:51:48 +0530
Message-ID: <4F79A7EC.5000003@linux.vnet.ibm.com>
References: <1333370928-1930-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1333370928-1930-1-git-send-email-daniel.lezcano@linaro.org>
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
Cc: linux-pm@lists.linux-foundation.org, patches@linaro.org, linaro-dev@lists.linaro.org, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

On 04/02/2012 06:18 PM, Daniel Lezcano wrote:

> The usual cpuidle initialization routines are to register the
> driver, then register a cpuidle device per cpu.
> 
> With the device's state count default initialization with the
> driver's state count, the code initialization remains mostly the
> same in the different drivers.
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
> +		dev = &per_cpu(cpuidle_device, cpu);


					       ^^^
That must have been "i" instead of "cpu"...

> +		cpuidle_unregister_device(dev);
> +	}
> +
> +	cpuidle_unregister_driver(drv);
> +
> +	goto out;
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_register);
> +



Regards,
Srivatsa S. Bhat

From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 05/18] cpuidle: make a single register function for all
Date: Wed, 10 Apr 2013 18:55:09 +0200
Message-ID: <20130410165509.GK13524@lunn.ch>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:46497 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934979Ab3DJQ6a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Apr 2013 12:58:30 -0400
Content-Disposition: inline
In-Reply-To: <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

> +/**
> + * cpuidle_register: registers the driver and the cpu devices with the
> + * coupled_cpus passed as parameter. This function is used for all common
> + * initialization pattern there are in the arch specific drivers. The
> + * devices is globally defined in this file.
> + *
> + * @drv         : a valid pointer to a struct cpuidle_driver
> + * @coupled_cpus: a cpumask for the coupled states
> + *
> + * Returns 0 on success, < 0 otherwise
> + */
> +int cpuidle_register(struct cpuidle_driver *drv,
> +		     const struct cpumask *const coupled_cpus)
> +{
> +	int ret, cpu;
> +	struct cpuidle_device *device;
> +
> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		printk(KERN_ERR "failed to register cpuidle driver\n");

pr_err()

> +		return ret;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		device = &per_cpu(cpuidle_dev, cpu);
> +		device->cpu = cpu;
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +		device->coupled_cpus = *coupled_cpus;
> +#endif
> +		ret = cpuidle_register_device(device);
> +		if (!ret)
> +			continue;
> +
> +		printk(KERN_ERR "Failed to register cpuidle "
> +		       "device for cpu%d\n", cpu);

pr_err() and don't split the message over two lines, it makes it
harder for somebody to find with

grep -r "Failed to register cpuidle device for cpu" *

> +		cpuidle_unregister(drv);
> +		break;
> +	}
> +
> +	return 0;

You should return an error code, so that the caller can also return an
error code. If you look at cpuidle-kirkwood and cpuidle-calxeda, and
maybe others, if the registration fails, the probe function returns an
error code, as it should. With your change, its always going to return
0, even if it fails.

   Andrew



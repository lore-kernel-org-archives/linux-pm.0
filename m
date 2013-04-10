From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 05/18] cpuidle: make a single register function for all
Date: Wed, 10 Apr 2013 19:04:57 +0200
Message-ID: <20130410170457.GL13524@lunn.ch>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:46536 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935641Ab3DJRHC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Apr 2013 13:07:02 -0400
Content-Disposition: inline
In-Reply-To: <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

> +int cpuidle_register(struct cpuidle_driver *drv,
> +		     const struct cpumask *const coupled_cpus)
> +{
> +	int ret, cpu;
> +	struct cpuidle_device *device;
> +
> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		printk(KERN_ERR "failed to register cpuidle driver\n");
> +		return ret;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		device = &per_cpu(cpuidle_dev, cpu);
> +		device->cpu = cpu;
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +		device->coupled_cpus = *coupled_cpus;
> +#endif

At least the kirkwood and the calxeda driver set 

   device->state_count

which you don't appear to do. cpuidle_add_state_sysfs() and
cpuidle_remove_state_sysfs() use this. Is it now being set somewhere
else?

Thanks
	Andrew

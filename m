From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 05/18] cpuidle: make a single register function for all
Date: Wed, 10 Apr 2013 09:59:45 -0500
Message-ID: <51657E61.9010701@gmail.com>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org> <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:40260 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934984Ab3DJO7s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 10:59:48 -0400
Received: by mail-qc0-f178.google.com with SMTP id d10so232483qca.37
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 07:59:48 -0700 (PDT)
In-Reply-To: <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

On 04/10/2013 09:22 AM, Daniel Lezcano wrote:
> The usual scheme to initialize a cpuidle driver on a SMP is:
> 
> 	cpuidle_register_driver(drv);
> 	for_each_possible_cpu(cpu) {
> 		device = &per_cpu(cpuidle_dev, cpu);
> 		cpuidle_register_device(device);
> 	}
> 
> This code is duplicated in each cpuidle driver.
> 
> On UP systems, it is done this way:
> 
> 	cpuidle_register_driver(drv);
> 	device = &per_cpu(cpuidle_dev, cpu);
> 	cpuidle_register_device(device);
> 
> On UP, the macro 'for_each_cpu' does one iteration:
> 
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> 
> Hence, the initialization loop is the same for UP than SMP.
> 
> Beside, we saw different bugs / mis-initialization / return code unchecked in
> the different drivers, the code is duplicated including bugs. After fixing all
> these ones, it appears the initialization pattern is the same for everyone.
> 
> Let's add a wrapper function doing this initialization with a cpumask parameter
> for the coupled idle states and use it for all the drivers.
> 
> That will save a lot of LOC, consolidate the code, and the modifications in the
> future could be done in a single place. Another benefit is the consolidation of
> the cpuidle_device variable which is now in the cpuidle framework and no longer
> spread accross the different arch specific drivers.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Perhaps my ack was too quick...

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

This needs a NULL check. CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is most
likely going to be enabled with multi-platform kernels and this will crash.

Also, I think typically struct copies have a note that it is copy.

Rob


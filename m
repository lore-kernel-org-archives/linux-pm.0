From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 05/18] cpuidle: make a single register function for all
Date: Wed, 10 Apr 2013 20:23:59 +0200
Message-ID: <20130410182359.GN13524@lunn.ch>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
 <20130410170457.GL13524@lunn.ch>
 <5165A937.70705@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:47118 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934446Ab3DJSYa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Apr 2013 14:24:30 -0400
Content-Disposition: inline
In-Reply-To: <5165A937.70705@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Wed, Apr 10, 2013 at 08:02:31PM +0200, Daniel Lezcano wrote:
> On 04/10/2013 07:04 PM, Andrew Lunn wrote:
> >> +int cpuidle_register(struct cpuidle_driver *drv,
> >> +		     const struct cpumask *const coupled_cpus)
> >> +{
> >> +	int ret, cpu;
> >> +	struct cpuidle_device *device;
> >> +
> >> +	ret = cpuidle_register_driver(drv);
> >> +	if (ret) {
> >> +		printk(KERN_ERR "failed to register cpuidle driver\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	for_each_possible_cpu(cpu) {
> >> +		device = &per_cpu(cpuidle_dev, cpu);
> >> +		device->cpu = cpu;
> >> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> >> +		device->coupled_cpus = *coupled_cpus;
> >> +#endif
> > 
> > At least the kirkwood and the calxeda driver set 
> > 
> >    device->state_count
> > 
> > which you don't appear to do. cpuidle_add_state_sysfs() and
> > cpuidle_remove_state_sysfs() use this. Is it now being set somewhere
> > else?
> 
> Yes, in cpuidle_enable_device called from cpuidle_register_device:

O.K. It would be nice to add a comment in the change log message about
this.

Ah, also, it would be good to update Documentation/cpuidle/drivers.txt
with these new functions and update the text.

     Thanks
	Andrew


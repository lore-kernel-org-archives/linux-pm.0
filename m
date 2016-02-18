From: Javi Merino <javi.merino@arm.com>
Subject: Re: Regard of thermal power allocator's coefficients
Date: Thu, 18 Feb 2016 15:19:26 +0000
Message-ID: <20160218151926.GA4511@e104805>
References: <20160214110041.GB26920@leoy-linaro>
 <20160214171217.GA5924@localhost.localdomain>
 <20160215044751.GA5660@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40131 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426400AbcBRPT3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Feb 2016 10:19:29 -0500
Content-Disposition: inline
In-Reply-To: <20160215044751.GA5660@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Punit Agrawal <Punit.Agrawal@arm.com>

Hi Leo,

On Mon, Feb 15, 2016 at 12:47:51PM +0800, Leo Yan wrote:
> Hi Eduardo,
> 
> Thanks for replying.
> 
> On Sun, Feb 14, 2016 at 09:12:19AM -0800, Eduardo Valentin wrote:
> > On Sun, Feb 14, 2016 at 07:00:41PM +0800, Leo Yan wrote:
> 
> [...]
> 
> > > So want to firstly to confirm if should we pass coefficients by using
> > > device tree? Is someone working on related work for this?
> > 
> > We pass the sustainable power, but not the coefficients. IIRC, the IPA
> > coefficients were considered (SW) implementation details. Sustainable power,
> > on the other hand, still describes hardware capabilities.
> > 
> > So, I don't think they will go via DT.
> 
> I'd like clarify one thing: "coefficients" are used to calculate
> static leakage and dynamic power but not PID's term constants. They
> are quite dependent on silicon's process; this is similiar with
> sustainable power. So do you think we should take these "coefficients"
> as software paramters?

For the dynamic power coefficient there is a binding in the cpu node
of DT, see Documentation/devicetree/bindings/arm/cpus.txt [0].  If you
use the cpufreq-dt driver, it will be registered automatically for
you.

[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/cpus.txt#n249

For static, sadly we don't have anything currently and as far as I'm
aware nobody is working on it.  The main problem with static power is
that there is no single formula that applies for different SoCs.
That's why we left it as a function pointer.

HTH,
Javi

> The code is written in drivers/thermal/hisi_thermal.c like below:
> 
> ---8<---
> 
> struct cluster_power_coefficients cluster_data = {
> 	.dyn_coeff      = 266,
> 	.static_cpu     = 14,
> 	.static_cluster = 5,
> };
> 
> /* voltage in uV and temperature in mC */
> static int get_static_power(cpumask_t *cpumask, int interval,
> 		unsigned long u_volt, u32 *power)
> {
> 	int nr_cpus = cpumask_weight(cpumask);
> 
> 	*power  = nr_cpus * cluster_data.static_cpu;
> 	*power += 2 * cluster_data.static_cluster;
> 
> 	return 0;
> }
> 
> static int hisi_thermal_register_cooling_device(struct platform_device *pdev,
> 						struct hisi_thermal_data *data)
> {
> 	struct device_node *np;
> 
> 	np = of_find_node_by_name(NULL, "cluster0");
> 	if (!np) {
> 		dev_err(&pdev->dev, "Cluster0 node not founds\n");
> 		return -ENODEV;
> 	}
> 
> 	data->cdevs = of_cpufreq_power_cooling_register(np,
> 			cpu_present_mask, cluster_data.dyn_coeff,
> 			get_static_power);
> 	if (IS_ERR(data->cdevs)) {
> 		dev_err(&pdev->dev,
> 			"Error registering cooling device: %ld\n",
> 			PTR_ERR(data->cdevs));
> 		return PTR_ERR(data->cdevs);
> 	}
> 
> 	return 0;
> }
> 
> Thanks,
> Leo Yan
> 

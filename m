From: Leo Yan <leo.yan@linaro.org>
Subject: Re: Regard of thermal power allocator's coefficients
Date: Mon, 15 Feb 2016 12:47:51 +0800
Message-ID: <20160215044751.GA5660@leoy-linaro>
References: <20160214110041.GB26920@leoy-linaro>
 <20160214171217.GA5924@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160214171217.GA5924@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

Thanks for replying.

On Sun, Feb 14, 2016 at 09:12:19AM -0800, Eduardo Valentin wrote:
> On Sun, Feb 14, 2016 at 07:00:41PM +0800, Leo Yan wrote:

[...]

> > So want to firstly to confirm if should we pass coefficients by using
> > device tree? Is someone working on related work for this?
> 
> We pass the sustainable power, but not the coefficients. IIRC, the IPA
> coefficients were considered (SW) implementation details. Sustainable power,
> on the other hand, still describes hardware capabilities.
> 
> So, I don't think they will go via DT.

I'd like clarify one thing: "coefficients" are used to calculate
static leakage and dynamic power but not PID's term constants. They
are quite dependent on silicon's process; this is similiar with
sustainable power. So do you think we should take these "coefficients"
as software paramters?

The code is written in drivers/thermal/hisi_thermal.c like below:

---8<---

struct cluster_power_coefficients cluster_data = {
	.dyn_coeff      = 266,
	.static_cpu     = 14,
	.static_cluster = 5,
};

/* voltage in uV and temperature in mC */
static int get_static_power(cpumask_t *cpumask, int interval,
		unsigned long u_volt, u32 *power)
{
	int nr_cpus = cpumask_weight(cpumask);

	*power  = nr_cpus * cluster_data.static_cpu;
	*power += 2 * cluster_data.static_cluster;

	return 0;
}

static int hisi_thermal_register_cooling_device(struct platform_device *pdev,
						struct hisi_thermal_data *data)
{
	struct device_node *np;

	np = of_find_node_by_name(NULL, "cluster0");
	if (!np) {
		dev_err(&pdev->dev, "Cluster0 node not founds\n");
		return -ENODEV;
	}

	data->cdevs = of_cpufreq_power_cooling_register(np,
			cpu_present_mask, cluster_data.dyn_coeff,
			get_static_power);
	if (IS_ERR(data->cdevs)) {
		dev_err(&pdev->dev,
			"Error registering cooling device: %ld\n",
			PTR_ERR(data->cdevs));
		return PTR_ERR(data->cdevs);
	}

	return 0;
}

Thanks,
Leo Yan

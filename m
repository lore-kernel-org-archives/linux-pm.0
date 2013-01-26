From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq, highbank: add support for highbank cpufreq
Date: Sat, 26 Jan 2013 22:39:53 +0800
Message-ID: <20130126143950.GA7079@S2101-09.ap.freescale.net>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1359143205-20279-1-git-send-email-mark.langsdorf@calxeda.com>
 <1359143205-20279-5-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359143205-20279-5-git-send-email-mark.langsdorf@calxeda.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Mark,

On Fri, Jan 25, 2013 at 01:46:45PM -0600, Mark Langsdorf wrote:
> +static int hb_cpufreq_driver_init(void)
> +{
> +	struct device *cpu_dev;
> +	struct clk *cpu_clk;
> +	struct device_node *np;
> +	int ret;
> +
> +	for_each_child_of_node(of_find_node_by_path("/cpus"), np)
> +		if (of_get_property(np, "operating-points", NULL))
> +			break;
> +
> +	if (!np) {
> +		pr_err("failed to find highbank cpufreq node\n");
> +		return -ENOENT;
> +	}
> +
...
> +out_put_node:
> +	of_node_put(np);
> +	return ret;
> +}
> +module_init(hb_cpufreq_driver_init);

As we are moving to multiplatform build, this init function will run
on all other platforms built together with highbank.  We should
probably eliminate that effect.  cpufreq-cpu0 driver is facing the
same problem, and I just sent a patch "cpufreq: instantiate cpufreq-cpu0
as a platform_driver" to address that.

Shawn


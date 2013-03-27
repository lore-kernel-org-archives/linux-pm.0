From: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 3/3] cpufreq: Add cpufreq driver for Freescale e500mc
 SOCs
Date: Wed, 27 Mar 2013 14:32:36 -0500
Message-ID: <20130327143236.7cb4613b78ad18d79bfbcc57@freescale.com>
References: <1364265391-26077-1-git-send-email-Yuantian.Tang@freescale.com>
	<1364265391-26077-3-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1364265391-26077-3-git-send-email-Yuantian.Tang@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: rjw@sisk.pl, linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 26 Mar 2013 10:36:31 +0800
<Yuantian.Tang@freescale.com> wrote:

> +static int __init ppc_corenet_cpufreq_init(void)
> +{
> +	int ret = 0;
> +	struct device_node  *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_matching_node(NULL, node_matches);
> +	if (!np)
> +		return -ENODEV;
> +
> +	match = of_match_node(node_matches, np);
> +	freq_data.cpus_per_cluster = (long)match->data;
> +	mutex_init(&freq_data.cpufreq_lock);
> +	of_node_put(np);
> +
> +	ret = cpufreq_register_driver(&ppc_corenet_cpufreq_driver);
> +	if (ret)
> +		return ret;
> +
> +	pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");
> +
> +	return ret;
> +}
> +
> +static void __exit ppc_corenet_cpufreq_exit(void)
> +{
> +	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
> +}
> +
> +module_init(ppc_corenet_cpufreq_init);
> +module_exit(ppc_corenet_cpufreq_exit);

this needs to be a module_platform_driver.

Kim


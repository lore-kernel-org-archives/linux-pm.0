From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/2] powercap/rapl: reduce ipi calls
Date: Fri, 19 Feb 2016 22:50:54 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602192246070.2477@nanos>
References: <1455914253-18138-1-git-send-email-jacob.jun.pan@linux.intel.com> <1455914253-18138-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455914253-18138-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-pm@vger.kernel.org

On Fri, 19 Feb 2016, Jacob Pan wrote:
> @@ -1380,6 +1375,7 @@ static int rapl_detect_topology(void)
>  	int i;
>  	int phy_package_id;
>  	struct rapl_package *new_package, *rp;
> +	int lead_cpu;
>  
>  	for_each_online_cpu(i) {
>  		phy_package_id = topology_physical_package_id(i);
> @@ -1392,7 +1388,11 @@ static int rapl_detect_topology(void)
>  			/* add the new package to the list */
>  			new_package->id = phy_package_id;
>  			new_package->nr_cpus = 1;
> -
> +			/* find the first active cpu of the package */
> +			lead_cpu = cpumask_any_and(topology_core_cpumask(i),
> +						cpumask_of(i));

Yuck. Why any_and? The result is i, simply because i is online otherwise you
would not be there. 

> +			if (lead_cpu < nr_cpu_ids)
> +				new_package->lead_cpu = lead_cpu;

So the above is identical to 

			new_package->lead_cpu = lead_cpu;

Hmm?

> @@ -1500,6 +1503,15 @@ static int rapl_cpu_callback(struct notifier_block *nfb,
>  			break;
>  		if (--rp->nr_cpus == 0)
>  			rapl_remove_package(rp);
> +		else if (cpu == rp->lead_cpu) {
> +			/* choose another active cpu in the package */
> +			lead_cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);

This part is correct.

Thanks,

	tglx

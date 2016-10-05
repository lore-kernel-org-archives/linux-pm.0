From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Wed, 5 Oct 2016 16:35:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610051624590.8953@nanos>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1475322326-160112-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1475322326-160112-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

On Sat, 1 Oct 2016, Srinivas Pandruvada wrote:
> +static int sched_itmt_update_handler(struct ctl_table *table, int write,
> +			      void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret;
> +	unsigned int old_sysctl;
> +
> +	mutex_lock(&itmt_update_mutex);
> +
> +	if (!sched_itmt_capable) {
> +		mutex_unlock(&itmt_update_mutex);
> +		return 0;

This should return a proper error code.

>  void sched_set_itmt_support(bool itmt_supported)
>  {
>  	mutex_lock(&itmt_update_mutex);
>  
> -	if (itmt_supported != sched_itmt_capable)
> -		sched_itmt_capable = itmt_supported;
> +	if (itmt_supported == sched_itmt_capable) {
> +		mutex_unlock(&itmt_update_mutex);
> +		return;
> +	}
> +	sched_itmt_capable = itmt_supported;
> +
> +	if (itmt_supported) {
> +		itmt_sysctl_header =
> +			register_sysctl_table(itmt_root_table);
> +		if (!itmt_sysctl_header) {
> +			mutex_unlock(&itmt_update_mutex);
> +			return;

So you now have a state of capable which cannot be enabled. Whats the
point?

> +		}
> +		/*
> +		 * ITMT capability automatically enables ITMT
> +		 * scheduling for small systems (single node).
> +		 */
> +		if (topology_num_packages() == 1)
> +			sysctl_sched_itmt_enabled = 1;
> +	} else {
> +		if (itmt_sysctl_header)
> +			unregister_sysctl_table(itmt_sysctl_header);
> +	}
> +
> +	if (sysctl_sched_itmt_enabled) {
> +		/* disable sched_itmt if we are no longer ITMT capable */
> +		if (!itmt_supported)


How do you get here if itmt is not supported? 

> +			sysctl_sched_itmt_enabled = 0;
> +		x86_topology_update = true;
> +		rebuild_sched_domains();
> +	}
>  
>  	mutex_unlock(&itmt_update_mutex);

Thanks,

	tglx

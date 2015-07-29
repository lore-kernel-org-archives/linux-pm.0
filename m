From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update 2x][PATCH 7/7] cpufreq: Separate CPU device registration
 from CPU online
Date: Wed, 29 Jul 2015 11:02:48 +0530
Message-ID: <20150729053248.GC21493@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <1739669.kedIsxdRK2@vostro.rjw.lan>
 <1702607.RH80fBCN6J@vostro.rjw.lan>
 <3091538.g8dYBumqSx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3091538.g8dYBumqSx@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 29-07-15, 03:03, Rafael J. Wysocki wrote:
> +static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> +{
> +	unsigned cpu = dev->id;
> +	int ret;
> +
> +	dev_dbg(dev, "%s: adding CPU%u\n", __func__, cpu);
> +
> +	if (cpu_online(cpu)) {
> +		ret = cpufreq_online(cpu);

I will do return right here ...

> +	} else {

... and this else will not be required anymore.

> +		/*
> +		 * A hotplug notifier will follow and we will handle it as CPU
> +		 * online then.  For now, just create the sysfs link, unless
> +		 * there is no policy or the link is already present.
> +		 */
> +		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> +
> +		ret = policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
> +			? add_cpu_dev_symlink(policy, cpu) : 0;
> +	}
> +
> +	return ret;
> +}

Looks good otherwise.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

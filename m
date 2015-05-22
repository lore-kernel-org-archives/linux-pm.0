From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 09/14] cpufreq: add/remove sysfs links via cpufreq_add_remove_dev_symlink()
Date: Sat, 23 May 2015 01:28:20 +0200
Message-ID: <3403066.ABqM7b3uGI@vostro.rjw.lan>
References: <cover.1431924457.git.viresh.kumar@linaro.org> <93a3bfbe26dfa1c298e21da369e6ed37fca1da34.1431924457.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58211 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757797AbbEVXC5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 19:02:57 -0400
In-Reply-To: <93a3bfbe26dfa1c298e21da369e6ed37fca1da34.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Monday, May 18, 2015 10:43:32 AM Viresh Kumar wrote:
> Later patches would require us to add/remove all sysfs links together.
> Create another routine cpufreq_add_remove_dev_symlink() to do that.
> 
> This is a preparatory step for the next patch and is done separately for
> easier reviews.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7fc3d9294f8..b5e883f497dd 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -957,25 +957,42 @@ void cpufreq_sysfs_remove_file(const struct attribute *attr)
>  }
>  EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
>  
> -/* symlink affected CPUs */
> -static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
> +static inline int add_remove_cpu_dev_symlink(struct cpufreq_policy *policy,

Let the compiler decide whether or not to inline.

> +					     int cpu, bool add)

I wouldn't do that this way.  The last bool arg seems kind of fragile and
easy to get wrong.

What about defining add_cpu_dev_symlink() and remove_cpu_dev_symlink() as
separate routines?

Like:

static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
{
	struct device *cpu_dev = get_cpu_device(cpu);

	if (WARN_ON(!cpu_dev))
		return 0;

	pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
	return sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
}

(The last statement line is likely longer than 80 chars, but that's fine.)

And analogously for the other one (which may be void BTW).


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

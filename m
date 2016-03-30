From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: acpi: policy->driver_data can't be NULL in ->exit()
Date: Wed, 30 Mar 2016 13:15:00 +0200
Message-ID: <CAJZ5v0hqrUyi2ggsDyOq9y0Q9BzktYdSG6DZQMfMF9HsqRLf0g@mail.gmail.com>
References: <f4f0e029b46cdd09dd7d3f0035e8588f5de94e21.1459311858.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:32827 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcC3LPC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 07:15:02 -0400
In-Reply-To: <f4f0e029b46cdd09dd7d3f0035e8588f5de94e21.1459311858.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Mar 30, 2016 at 6:24 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Its always set by ->init() and so it will always be there in ->exit().
> There is no need to have a special check for just that.

I'm not sure what happens if there are two (or more) CPUs in the policy, though.

That case is almost certainly handled incorrectly here (or rather not
handled at all), but it may just happen to sort of work, because the
first exiting CPU will clear driver_data and the second one will
notice that it is NULL now.  Of course, that still is racy with
respect to governors etc, but I'd rather fix the driver properly.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index eb2196f9d7fa..e20cbb1317cc 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -847,13 +847,11 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>
>         pr_debug("acpi_cpufreq_cpu_exit\n");
>
> -       if (data) {
> -               policy->driver_data = NULL;
> -               acpi_processor_unregister_performance(data->acpi_perf_cpu);
> -               free_cpumask_var(data->freqdomain_cpus);
> -               kfree(policy->freq_table);
> -               kfree(data);
> -       }
> +       policy->driver_data = NULL;
> +       acpi_processor_unregister_performance(data->acpi_perf_cpu);
> +       free_cpumask_var(data->freqdomain_cpus);
> +       kfree(policy->freq_table);
> +       kfree(data);
>
>         return 0;
>  }
> --
> 2.7.1.410.g6faf27b
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

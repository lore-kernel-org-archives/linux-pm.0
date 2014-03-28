From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] cpufreq: use kzalloc() to allocate memory for
 cpufreq_frequency_table
Date: Fri, 28 Mar 2014 06:29:16 -0700
Message-ID: <1396013356.31134.27.camel@joe-AO722>
References: <b5bc276cdd34b039de2aa640ec0bb5dff195f832.1395996386.git.viresh.kumar@linaro.org>
	 <f6aa622dc5acfd3ab9b1360973c0d15b3972c6b6.1396001532.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:34075 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752076AbaC1N3W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Mar 2014 09:29:22 -0400
In-Reply-To: <f6aa622dc5acfd3ab9b1360973c0d15b3972c6b6.1396001532.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com

On Fri, 2014-03-28 at 15:44 +0530, Viresh Kumar wrote:
> Few drivers are using kmalloc() to allocate memory for frequency tables and once
> we have an additional field '.flags' in 'struct cpufreq_frequency_table', these
> might become unstable. Better get these fixed by replacing kmalloc() by
> kzalloc() instead.

There seems to be some sort of bug fix in the
patch at the very end too?

Perhaps a better fix would be to use kcalloc for
all the allocs with a multiply.

> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
[]
> @@ -754,7 +754,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
[]
> -	data->freq_table = kmalloc(sizeof(*data->freq_table) *
> +	data->freq_table = kzalloc(sizeof(*data->freq_table) *
>  		    (perf->state_count+1), GFP_KERNEL);

> diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
[]
> @@ -254,7 +254,7 @@ acpi_cpufreq_cpu_init (
[]
> -	data->freq_table = kmalloc(sizeof(*data->freq_table) *
> +	data->freq_table = kzalloc(sizeof(*data->freq_table) *
>  	                           (data->acpi_data.state_count + 1),
>  	                           GFP_KERNEL);

> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
[]
> @@ -475,7 +475,7 @@ static int longhaul_get_ranges(void)
[]
> -	longhaul_table = kmalloc((numscales + 1) * sizeof(*longhaul_table),

> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
[]
> @@ -623,7 +623,7 @@ static int fill_powernow_table(struct powernow_k8_data *data,
[]
> -	powernow_table = kmalloc((sizeof(*powernow_table)
> +	powernow_table = kzalloc((sizeof(*powernow_table)
>  		* (data->numps + 1)), GFP_KERNEL);

> diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
[]
> @@ -586,7 +586,7 @@ static int s3c_cpufreq_build_freq(void)
[]
> -	ftab = kmalloc(sizeof(*ftab) * size, GFP_KERNEL);
> +	ftab = kzalloc(sizeof(*ftab) * size, GFP_KERNEL);

> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
[]
> @@ -195,18 +195,15 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
[]
> -	freq_tbl = kmalloc(sizeof(*freq_tbl) * (cnt + 1), GFP_KERNEL);
> +	freq_tbl = kzalloc(sizeof(*freq_tbl) * (cnt + 1), GFP_KERNEL);
>  	if (!freq_tbl) {
>  		ret = -ENOMEM;
>  		goto out_put_node;
>  	}
>  
> -	for (i = 0; i < cnt; i++) {
> -		freq_tbl[i].driver_data = i;
> +	for (i = 0; i < cnt; i++)
>  		freq_tbl[i].frequency = be32_to_cpup(val++);
> -	}
>  
> -	freq_tbl[i].driver_data = i;
>  	freq_tbl[i].frequency = CPUFREQ_TABLE_END;

Is this some bug fix?



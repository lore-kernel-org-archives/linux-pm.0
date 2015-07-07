From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] acpi-cpufreq: replace per_cpu with driver_data of
 policy
Date: Tue, 7 Jul 2015 10:11:26 -0700
Message-ID: <20150707171126.GB12491@dtor-ws>
References: <559BC96E.8020804@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38264 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbbGGRLb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 13:11:31 -0400
Content-Disposition: inline
In-Reply-To: <559BC96E.8020804@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

Hi Pan,

On Tue, Jul 07, 2015 at 08:43:26PM +0800, Pan Xinhui wrote:
> @@ -364,19 +363,24 @@ static u32 get_cur_val(const struct cpumask *mask)
>  
>  static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  {
> -	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, cpu);
> +	struct acpi_cpufreq_data *data;
> +	struct cpufreq_policy *policy;
>  	unsigned int freq;
>  	unsigned int cached_freq;
>  
>  	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
>  
> -	if (unlikely(data == NULL ||
> -		     data->acpi_data == NULL || data->freq_table == NULL)) {
> +	policy = cpufreq_cpu_get(cpu);
> +	if (unlikely(!policy))
> +		return 0;
> +
> +	data = policy->driver_data;
> +	cpufreq_cpu_put(policy);

If we put policy here can we guarantee that memory pointed to by data
stays valid? Shoudln't we issue cpufreq_cpu_put(policy) after we done
assessing the pointer?

> +	if (unlikely(!data || !data->acpi_data || !data->freq_table))
>  		return 0;
> -	}
>  
>  	cached_freq = data->freq_table[data->acpi_data->state].frequency;
> -	freq = extract_freq(get_cur_val(cpumask_of(cpu)), data);
> +	freq = extract_freq(get_cur_val(cpumask_of(cpu), data), data);
>  	if (freq != cached_freq) {
>  		/*
>  		 * The dreaded BIOS frequency change behind our back.

Thanks.

-- 
Dmitry

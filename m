From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH] acpi-cpufreq: get the cur_freq from acpi_processor_performance states
Date: Sat, 27 Sep 2014 01:21:39 +0200
Message-ID: <2075276.PKjjuvNeys@vostro.rjw.lan>
References: <53F589C3.4050504@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61869 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751542AbaIZXBs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 19:01:48 -0400
In-Reply-To: <53F589C3.4050504@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wang Weidong <wangweidong1@huawei.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org >> \"linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>

On Thursday, August 21, 2014 01:55:15 PM Wang Weidong wrote:
> As the initialized freq_tables maybe different from the p-states
> values, so the array index is different as well.
> 
> p-states value: [2400 2400 2000 ...], while the freq_tables:
> [2400 2000 ... CPUFREQ_TABLE_END]. After setted the freqs 2000,
> the perf->state is 3 while the freqs_table's index should be 2.
> So when call the get_cur_freq_on_cpu, the freqs value we get
> is 2400.
> 
> So, fix the problem with the correct tables.

What you're saying is basically that freq_table and perf->states
diverge at one point.  Shouldn't we re-generate freq_table in that
case instead of fixing up get_cur_freq_on_cpu() only in a quite
indirect way? 

> Signed-off-by: Wang Weidong <wangweidong1@huawei.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index b0c18ed..ac93885 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -365,6 +365,7 @@ static u32 get_cur_val(const struct cpumask *mask)
>  static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  {
>  	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, cpu);
> +	struct acpi_processor_performance *perf;
>  	unsigned int freq;
>  	unsigned int cached_freq;
>  
> @@ -375,7 +376,8 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  		return 0;
>  	}
>  
> -	cached_freq = data->freq_table[data->acpi_data->state].frequency;
> +	perf = data->acpi_data;
> +	cached_freq = perf->states[perf->state].core_frequency * 1000;
>  	freq = extract_freq(get_cur_val(cpumask_of(cpu)), data);
>  	if (freq != cached_freq) {
>  		/*
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: don't print value of .driver_data from core
Date: Thu, 27 Mar 2014 15:49:29 +0530
Message-ID: <5333FB31.7080602@linux.vnet.ibm.com>
References: <2490cd0aaeaaeb88131c8089d491c485f08da5da.1395914766.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2490cd0aaeaaeb88131c8089d491c485f08da5da.1395914766.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On 03/27/2014 03:37 PM, Viresh Kumar wrote:
> CPUFreq core doesn't control value of .driver_data and this field is completely
> driver specific. This can contain any value and not only indexes. For most of
> the drivers, which aren't using this field, its value is zero. So, printing this
> from core doesn't make any sense. Don't print it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  drivers/cpufreq/freq_table.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 8e54f97..f002272 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -36,8 +36,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>  		    && table[i].driver_data == CPUFREQ_BOOST_FREQ)
>  			continue;
> 
> -		pr_debug("table entry %u: %u kHz, %u driver_data\n",
> -					i, freq, table[i].driver_data);
> +		pr_debug("table entry %u: %u kHz\n", i, freq);
>  		if (freq < min_freq)
>  			min_freq = freq;
>  		if (freq > max_freq)
> @@ -175,8 +174,8 @@ int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>  	} else
>  		*index = optimal.driver_data;
> 
> -	pr_debug("target is %u (%u kHz, %u)\n", *index, table[*index].frequency,
> -		table[*index].driver_data);
> +	pr_debug("target index is %u, freq is:%u kHz\n", *index,
> +		 table[*index].frequency);
> 
>  	return 0;
>  }
> 


From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: don't print value of .driver_data from core
Date: Thu, 27 Mar 2014 16:18:42 +0530
Message-ID: <20140327104842.GB27777@in.ibm.com>
References: <2490cd0aaeaaeb88131c8089d491c485f08da5da.1395914766.git.viresh.kumar@linaro.org>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2490cd0aaeaaeb88131c8089d491c485f08da5da.1395914766.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org


On Thu, Mar 27, 2014 at 03:37:22PM +0530, Viresh Kumar wrote:
> CPUFreq core doesn't control value of .driver_data and this field is completely
> driver specific. This can contain any value and not only indexes. For most of
> the drivers, which aren't using this field, its value is zero. So, printing this
> from core doesn't make any sense. Don't print it.

So after this patch, driver_data is only going to be used by drivers
which want an "unsigned int" value to be saved along with the
frequency in the frequency_table and for those who want to overload
its interpretation to indicate BOOST.

>From the core's stand point, it is useful only for determining whether
a frequency is BOOST frequency or not. 

So, wouldn't it be logical to allow drivers maintain their own driver
data since the core is anyway not interested in it, and change this
.driver_data to "flags" or some such which can indicate boost ?

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
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
> -- 
> 1.7.12.rc2.18.g61b472e
> 


From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] cpufreq: set value of CPUFREQ_BOOST_FREQ to 0xABABABAB
Date: Mon, 24 Mar 2014 09:21:12 +0100
Message-ID: <20140324092112.74f930d3@amdc2363>
References: <78187ea173460c871eef31432ec2a80ec657fe30.1395643393.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <78187ea173460c871eef31432ec2a80ec657fe30.1395643393.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> Ideally, .driver_data field of struct cpufreq_frequency_table must
> not be used by core at all. But during a recent change if its value
> is same as CPUFREQ_BOOST_FREQ macro, then it is treated specially by
> core.
> 
> The value of this macro was set to ~2 earlier, i.e. 0xFFFFFFFD. In
> case some driver is using this field for its own data and sets this
> field to -3, then with two's complement that value will also become
> 0xFFFFFFFD.
> 
> To fix this issue, lets change value of this flag to a very uncommon
> value which shouldn't be used by any driver unless they want to use
> BOOST feature.
> 
> Along with this update comments to make this more clear.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Gautham/Vaidy: I hope this fixes the problem we discussed for your
> patchset.
> 

I think that a name of the patchset, for which the current setting
causes problem would be welcome here.

Otherwise, I can only ask why it is not possible to add 
#define SPECIAL_SETTING ~3 ?


>  include/linux/cpufreq.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c48e595..9f25d9d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -455,12 +455,18 @@ extern struct cpufreq_governor
> cpufreq_gov_conservative;
>   *                     FREQUENCY TABLE HELPERS
> *
> *********************************************************************/ 
> +/* Special Values of .frequency field */
>  #define CPUFREQ_ENTRY_INVALID ~0
>  #define CPUFREQ_TABLE_END     ~1
> -#define CPUFREQ_BOOST_FREQ    ~2
> +/* Special Values of .driver_data field */
> +#define CPUFREQ_BOOST_FREQ    0xABABABAB
>  
>  struct cpufreq_frequency_table {
> -	unsigned int	driver_data; /* driver specific data,
> not used by core */
> +	/*
> +	 * driver specific data, not used by core unless it is set to
> +	 * CPUFREQ_BOOST_FREQ.
> +	 */
> +	unsigned int	driver_data;
>  	unsigned int	frequency; /* kHz - doesn't need to be
> in ascending
>  				    * order */
>  };



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

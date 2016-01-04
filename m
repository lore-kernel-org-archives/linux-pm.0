From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ondemand: Set MIN_FREQUENCY_UP_THRESHOLD to 1
Date: Mon, 4 Jan 2016 11:26:51 +0530
Message-ID: <20160104055651.GB27177@ubuntu>
References: <9645d54c1bc65ce69ecfd5e92259ead7699afc82.1451880670.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9645d54c1bc65ce69ecfd5e92259ead7699afc82.1451880670.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, sworddragon2@aol.com
List-Id: linux-pm@vger.kernel.org

On 04-01-16, 12:14, Chen Yu wrote:
> Currently the minimal up_threshold is 11, and user may want to
> use a smaller minimal up_threshold for performance tuning,
> so MIN_FREQUENCY_UP_THRESHOLD could be set to 1 because:
> 
> 1. Current systems wouldn't be affected as they have already
>    a value >= 11.
> 2. New systems with a default kernel would keep still the default
>    value that is >= 11.
> 
> Users now have the advantage that they can make their own decisions
> and customize the 'trip point' to switch to the max frequency.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=65501
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 03ac6ce..2a093b5 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -24,7 +24,7 @@
>  #define MAX_SAMPLING_DOWN_FACTOR		(100000)
>  #define MICRO_FREQUENCY_UP_THRESHOLD		(95)
>  #define MICRO_FREQUENCY_MIN_SAMPLE_RATE		(10000)
> -#define MIN_FREQUENCY_UP_THRESHOLD		(11)
> +#define MIN_FREQUENCY_UP_THRESHOLD		(1)
>  #define MAX_FREQUENCY_UP_THRESHOLD		(100)
>  
>  static DEFINE_PER_CPU(struct od_cpu_dbs_info_s, od_cpu_dbs_info);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] CPUFREQ: Loongson2: constify platform_device_id
Date: Wed, 16 Aug 2017 08:55:59 +0530
Message-ID: <20170816032559.GB4233@vireshk-i7>
References: <38726390c030dc256d7dd169a416bc4a9814cbf7.1502617113.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <38726390c030dc256d7dd169a416bc4a9814cbf7.1502617113.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13-08-17, 15:10, Arvind Yadav wrote:
> platform_device_id are not supposed to change at runtime. All functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index 9ac27b2..da34469 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -114,7 +114,7 @@ static struct cpufreq_driver loongson2_cpufreq_driver = {
>  	.attr = cpufreq_generic_attr,
>  };
>  
> -static struct platform_device_id platform_device_ids[] = {
> +static const struct platform_device_id platform_device_ids[] = {
>  	{
>  		.name = "loongson2_cpufreq",
>  	},

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

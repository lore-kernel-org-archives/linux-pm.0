From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: cpu_cooling: Use kmalloc_array() in
 __cpufreq_cooling_register()
Date: Tue, 11 Apr 2017 11:40:27 +0530
Message-ID: <20170411061027.GB3670@vireshk-i7>
References: <d45b0bbb-0893-906d-edfc-44b712e55b14@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d45b0bbb-0893-906d-edfc-44b712e55b14@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10-04-17, 17:12, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 10 Apr 2017 17:00:13 +0200
> 
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/thermal/cpu_cooling.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 69d0f430b2d1..273d9d5dbe0f 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -823,8 +823,9 @@ __cpufreq_cooling_register(struct device_node *np,
>  	cpufreq_for_each_valid_entry(pos, table)
>  		cpufreq_dev->max_level++;
>  
> -	cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
> -					  cpufreq_dev->max_level, GFP_KERNEL);
> +	cpufreq_dev->freq_table = kmalloc_array(cpufreq_dev->max_level,
> +						sizeof(*cpufreq_dev->freq_table),
> +						GFP_KERNEL);
>  	if (!cpufreq_dev->freq_table) {
>  		cool_dev = ERR_PTR(-ENOMEM);
>  		goto free_time_in_idle_timestamp;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next] cpufreq: scpi: fix error return code in
 scpi_cpufreq_init()
Date: Tue, 23 Jan 2018 08:45:54 +0530
Message-ID: <20180123031554.GD13020@vireshk-i7>
References: <1516673342-170261-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516673342-170261-1-git-send-email-weiyongjun1@huawei.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-01-18, 02:09, Wei Yongjun wrote:
> Fix to return a negative error code from the clk_get() error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 247fcbf..7095fc0 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -145,6 +145,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  	if (IS_ERR(priv->clk)) {
>  		dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d\n",
>  			__func__, cpu_dev->id);
> +		ret = PTR_ERR(priv->clk);
>  		goto out_free_cpufreq_table;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: qcom-kryo: make some variables static
Date: Mon, 4 Feb 2019 12:01:00 +0530
Message-ID: <20190204063100.v3ebrh52hm5kxxtw@vireshk-i7>
References: <20190204061310.1211-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204061310.1211-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: ilia.lin@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-02-19, 01:13, Yangtao Li wrote:
> The variables are local to the source and do not
> need to be in global scope, so make them static.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 2a3675c24032..1c8583cc06a2 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -42,7 +42,7 @@ enum _msm8996_version {
>  	NUM_OF_MSM8996_VERSIONS,
>  };
>  
> -struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
> +static struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
>  
>  static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
>  {

Applied. Thanks.

-- 
viresh

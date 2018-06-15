From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: kryo: Add module remove and exit
Date: Fri, 15 Jun 2018 08:15:24 +0530
Message-ID: <20180615024524.5ecazjeufuiqmast@vireshk-i7>
References: <20180607205827.1588-1-ilia.lin@gmail.com>
 <20180614204212.2028-1-ilia.lin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180614204212.2028-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ilia.lin@gmail.com
Cc: Ilia Lin <ilialin@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14-06-18, 22:42, ilia.lin@gmail.com wrote:
> From: Ilia Lin <ilia.lin@gmail.com>
> 
> Add device remove and module exit code to make the driver
> functioning as a loadable module.
> 
> Fixes: ac28927659be (cpufreq: kryo: allow building as a loadable module)
> Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 5e9511223ce9..01bddacf5c3b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -42,6 +42,8 @@ enum _msm8996_version {
>  	NUM_OF_MSM8996_VERSIONS,
>  };
>  
> +struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
> +
>  static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>  {
>  	size_t len;
> @@ -74,7 +76,6 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
>  	struct opp_table *opp_tables[NR_CPUS] = {0};
> -	struct platform_device *cpufreq_dt_pdev;
>  	enum _msm8996_version msm8996_version;
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
> @@ -129,6 +130,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  		BUG();
>  		break;
>  	}
> +	kfree(speedbin);

Again, stuff like this can't go in this patch itself. It is a separate
bug fix and you should send it with a matching fixes tag separately.

>  
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
> @@ -164,8 +166,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
> +{
> +	platform_device_unregister(cpufreq_dt_pdev);
> +	return 0;
> +}
> +
>  static struct platform_driver qcom_cpufreq_kryo_driver = {
>  	.probe = qcom_cpufreq_kryo_probe,
> +	.remove = qcom_cpufreq_kryo_remove,
>  	.driver = {
>  		.name = "qcom-cpufreq-kryo",
>  	},
> @@ -200,8 +209,9 @@ static int __init qcom_cpufreq_kryo_init(void)
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> -	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
> -		"qcom-cpufreq-kryo", -1, NULL, 0));
> +	kryo_cpufreq_pdev = platform_device_register_simple(
> +		"qcom-cpufreq-kryo", -1, NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
>  	if (0 == ret)
>  		return 0;
>  
> @@ -210,5 +220,12 @@ static int __init qcom_cpufreq_kryo_init(void)
>  }
>  module_init(qcom_cpufreq_kryo_init);
>  
> +static void __init qcom_cpufreq_kryo_exit(void)
> +{
> +	platform_device_unregister(kryo_cpufreq_pdev);
> +	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
> +}
> +module_exit(qcom_cpufreq_kryo_exit);
> +
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.11.0

-- 
viresh

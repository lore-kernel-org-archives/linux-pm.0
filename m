From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 3/9] cpufreq: qcom: create a driver struct
Date: Tue, 9 Apr 2019 11:12:32 +0530
Message-ID: <20190409054232.76ies442zgfhh7vf@vireshk-i7>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-4-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-4-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-04-19, 07:09, Niklas Cassel wrote:
> create a driver struct to make it easier to free up all common
> resources, and only call dev_pm_opp_set_supported_hw() if the
> implementation has dynamically allocated versions.
> 
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 69 ++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 652a1de2a5d4..366c65a7132a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -43,6 +43,11 @@ enum _msm8996_version {
>  	NUM_OF_MSM8996_VERSIONS,
>  };
>  
> +struct qcom_cpufreq_drv {

I would suggest renaming it a bit, around the purpose of this thing. Maybe like
struct supported_hw {} ? Or something else that you would like.

> +	struct opp_table **opp_tables;
> +	u32 *versions;

Maybe this can be just "u32 versions" instead and you won't need a separate
kzalloc.

> +};
> +
>  static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
>  
>  static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> @@ -76,12 +81,16 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  
>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct nvmem_cell *speedbin_nvmem,
> -					  u32 *versions)
> +					  struct qcom_cpufreq_drv *drv)
>  {
>  	size_t len;
>  	u8 *speedbin;
>  	enum _msm8996_version msm8996_version;
>  
> +	drv->versions = kzalloc(sizeof(*drv->versions), GFP_KERNEL);
> +	if (!drv->versions)
> +		return -ENOMEM;
> +
>  	msm8996_version = qcom_cpufreq_get_msm_id();
>  	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
>  		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> @@ -94,10 +103,10 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  
>  	switch (msm8996_version) {
>  	case MSM8996_V3:
> -		*versions = 1 << (unsigned int)(*speedbin);
> +		*drv->versions = 1 << (unsigned int)(*speedbin);
>  		break;
>  	case MSM8996_SG:
> -		*versions = 1 << ((unsigned int)(*speedbin) + 4);
> +		*drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
>  		break;

I see that versions will surely have a non-zero value here ? In that case you
can use it ... (see later)

>  	default:
>  		BUG();
> @@ -110,15 +119,14 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  
>  static int qcom_cpufreq_probe(struct platform_device *pdev)
>  {
> -	struct opp_table **opp_tables;
> +	struct qcom_cpufreq_drv *drv;
>  	int (*get_version)(struct device *cpu_dev,
>  			   struct nvmem_cell *speedbin_nvmem,
> -			   u32 *versions);
> +			   struct qcom_cpufreq_drv *drv);
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
>  	unsigned cpu;
> -	u32 versions;
>  	const struct of_device_id *match;
>  	int ret;
>  
> @@ -141,23 +149,31 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> +	drv = kzalloc(sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
>  	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
>  	of_node_put(np);
>  	if (IS_ERR(speedbin_nvmem)) {
>  		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
>  			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
>  				PTR_ERR(speedbin_nvmem));
> -		return PTR_ERR(speedbin_nvmem);
> +		ret = PTR_ERR(speedbin_nvmem);
> +		goto free_drv;
>  	}
>  
> -	ret = get_version(cpu_dev, speedbin_nvmem, &versions);
> +	ret = get_version(cpu_dev, speedbin_nvmem, drv);
>  	nvmem_cell_put(speedbin_nvmem);
>  	if (ret)
> -		return ret;
> +		goto free_drv;
>  
> -	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
> -	if (!opp_tables)
> -		return -ENOMEM;
> +	drv->opp_tables = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tables),
> +				  GFP_KERNEL);
> +	if (!drv->opp_tables) {
> +		ret = -ENOMEM;
> +		goto free_drv;
> +	}
>  
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
> @@ -166,10 +182,12 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  			goto free_opp;
>  		}
>  
> -		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> -							      &versions, 1);
> -		if (IS_ERR(opp_tables[cpu])) {
> -			ret = PTR_ERR(opp_tables[cpu]);
> +		if (drv->versions)

... here like "if (*drv->versions)" instead and get rid of kzalloc ?

> +			drv->opp_tables[cpu] =
> +				dev_pm_opp_set_supported_hw(cpu_dev,
> +							    drv->versions, 1);
> +		if (IS_ERR(drv->opp_tables[cpu])) {

This should be part of the above if() block as we shouldn't check it if
*versions == 0.

> +			ret = PTR_ERR(drv->opp_tables[cpu]);
>  			dev_err(cpu_dev, "Failed to set supported hardware\n");
>  			goto free_opp;
>  		}
> @@ -178,7 +196,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
>  							  NULL, 0);
>  	if (!IS_ERR(cpufreq_dt_pdev)) {
> -		platform_set_drvdata(pdev, opp_tables);
> +		platform_set_drvdata(pdev, drv);
>  		return 0;
>  	}
>  
> @@ -187,26 +205,31 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  
>  free_opp:
>  	for_each_possible_cpu(cpu) {
> -		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> +		if (IS_ERR_OR_NULL(drv->opp_tables[cpu]))
>  			break;
> -		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> +		dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
>  	}
> -	kfree(opp_tables);
> +	kfree(drv->opp_tables);
> +free_drv:
> +	kfree(drv->versions);
> +	kfree(drv);
>  
>  	return ret;
>  }
>  
>  static int qcom_cpufreq_remove(struct platform_device *pdev)
>  {
> -	struct opp_table **opp_tables = platform_get_drvdata(pdev);
> +	struct qcom_cpufreq_drv *drv = platform_get_drvdata(pdev);
>  	unsigned int cpu;
>  
>  	platform_device_unregister(cpufreq_dt_pdev);
>  
>  	for_each_possible_cpu(cpu)
> -		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> +		dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
>  
> -	kfree(opp_tables);
> +	kfree(drv->opp_tables);
> +	kfree(drv->versions);
> +	kfree(drv);
>  
>  	return 0;
>  }
> -- 
> 2.20.1

-- 
viresh

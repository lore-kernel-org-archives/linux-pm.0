From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Thu, 6 Dec 2018 09:52:42 +0530
Message-ID: <20181206042242.pzhkkfs4ew36nsnq@vireshk-i7>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
 <20181205061600.7zglbpkgbktn27am@vireshk-i7>
 <154402920660.88331.5729780274488650479@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154402920660.88331.5729780274488650479@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Taniya Das <tdas@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On 05-12-18, 09:00, Stephen Boyd wrote:
> Here's a patch to squash in to fix those tiny problems. I left it as
> devm_ioremap_resource() because that has all the nice features of
> resource requesting inside and it didn't seem too bad to devm_iounmap()
> on the exit path.
> 
> ---------8<--------------
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index bcf9bb37298a..1e865e216839 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/slab.h>
>  
>  #define LUT_MAX_ENTRIES			40U
>  #define LUT_SRC				GENMASK(31, 30)
> @@ -77,8 +78,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>  	unsigned int max_cores = cpumask_weight(policy->cpus);
>  	struct cpufreq_frequency_table	*table;
>  
> -	table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> -				sizeof(*table), GFP_KERNEL);
> +	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>  	if (!table)
>  		return -ENOMEM;
>  
> @@ -144,7 +144,7 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>  
>  		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>  						 "#freq-domain-cells", 0,
> -						  &args);
> +						 &args);
>  		of_node_put(cpu_np);
>  		if (ret < 0)
>  			continue;
> @@ -170,7 +170,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>  			"#freq-domain-cells", 0, &args);
>  	of_node_put(cpu_np);
> -
>  	if (ret)
>  		return ret;
>  
> @@ -184,13 +183,15 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	/* HW should be in enabled state to proceed */
>  	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
>  		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto error;
>  	}
>  
>  	qcom_get_related_cpus(index, policy->cpus);
>  	if (!cpumask_weight(policy->cpus)) {
>  		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> -		return -ENOENT;
> +		ret = -ENOENT;
> +		goto error;
>  	}
>  
>  	policy->driver_data = base + REG_PERF_STATE;
> @@ -198,11 +199,25 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
>  	if (ret) {
>  		dev_err(dev, "Domain-%d failed to read LUT\n", index);
> -		return ret;
> +		goto error;
>  	}
>  
>  	policy->fast_switch_possible = true;
>  
> +	return 0;
> +
> +error:
> +	devm_iounmap(dev, base);
> +	return ret;
> +}
> +
> +static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	void __iomem *base = policy->driver_data - REG_PERF_STATE;
> +
> +	kfree(policy->freq_table);
> +	devm_iounmap(&global_pdev->dev, base);
> +
>  	return 0;
>  }
>  
> @@ -219,6 +234,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>  	.target_index	= qcom_cpufreq_hw_target_index,
>  	.get		= qcom_cpufreq_hw_get,
>  	.init		= qcom_cpufreq_hw_cpu_init,
> +	.exit		= qcom_cpufreq_hw_cpu_exit,
>  	.fast_switch    = qcom_cpufreq_hw_fast_switch,
>  	.name		= "qcom-cpufreq-hw",
>  	.attr		= qcom_cpufreq_hw_attr,
> @@ -248,12 +264,11 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
>  	if (ret) {
>  		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> -		return ret;
> +	} else {
> +		dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
>  	}
>  
> -	dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)

LGTM

-- 
viresh

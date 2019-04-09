From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 4/9] cpufreq: qcom: support qcs404 on nvmem driver
Date: Tue, 9 Apr 2019 11:18:03 +0530
Message-ID: <20190409054803.m24qucluqtxmd4vq@vireshk-i7>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-5-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-5-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-04-19, 07:09, Niklas Cassel wrote:
> From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> 

Always have something here, even for the simplest of the patches.

> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 366c65a7132a..7fdc38218390 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
> @@ -79,6 +80,13 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  	return version;
>  }
>  
> +static int qcom_cpufreq_qcs404_name_version(struct device *cpu_dev,
> +					    struct nvmem_cell *speedbin_nvmem,
> +					    struct qcom_cpufreq_drv *drv)
> +{
> +	return 0;
> +}
> +

Why provide empty stubs? Rather check for get_version() in probe and call only
if it is supported.

>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct nvmem_cell *speedbin_nvmem,
>  					  struct qcom_cpufreq_drv *drv)
> @@ -191,6 +199,14 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  			dev_err(cpu_dev, "Failed to set supported hardware\n");
>  			goto free_opp;
>  		}
> +
> +		ret = dev_pm_domain_attach(cpu_dev, false);

Why is it required specially for this platform and not earlier ?

And I was hoping for the attach-by-name thing to be present here instead because
of multiple domain thing.

> +		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				goto free_opp;
> +			dev_err(cpu_dev, "Could not attach to pm_domain: %d\n",
> +				ret);

And it is okay if we couldn't attach the domain ?

> +		}
>  	}
>  
>  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> @@ -247,6 +263,8 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>  	  .data = qcom_cpufreq_kryo_name_version },
>  	{ .compatible = "qcom,msm8996",
>  	  .data = qcom_cpufreq_kryo_name_version },
> +	{ .compatible = "qcom,qcs404",
> +	  .data = qcom_cpufreq_qcs404_name_version },
>  	{},
>  };
>  
> -- 
> 2.20.1

-- 
viresh

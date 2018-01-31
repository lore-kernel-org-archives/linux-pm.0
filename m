From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Wed, 31 Jan 2018 12:23:43 +0000
Message-ID: <9942b74d-7437-21cc-cbd7-38f2844c5d1d@arm.com>
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
	<1516362223-22946-3-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1516362223-22946-3-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 19/01/18 11:43, Vivek Gautam wrote:
> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> The smmu needs to be functional only when the respective
> master's using it are active. The device_link feature
> helps to track such functional dependencies, so that the
> iommu gets powered when the master device enables itself
> using pm_runtime. So by adapting the smmu driver for
> runtime pm, above said dependency can be addressed.
> 
> This patch adds the pm runtime/sleep callbacks to the
> driver and also the functions to parse the smmu clocks
> from DT and enable them in resume/suspend.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> [vivek: Clock rework to request bulk of clocks]
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 78d4c6b8f1ba..21acffe91a1c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -48,6 +48,7 @@
>   #include <linux/of_iommu.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   
> @@ -205,6 +206,9 @@ struct arm_smmu_device {
>   	u32				num_global_irqs;
>   	u32				num_context_irqs;
>   	unsigned int			*irqs;
> +	struct clk_bulk_data		*clocks;
> +	int				num_clks;
> +	const char * const		*clk_names;

This seems unnecessary, as we use it a grand total of of once, during 
initialisation when we have the source data directly to hand. Just pass 
data->clks into arm_smmu_init_clks() as an additional argument.

Otherwise, I think this looks reasonable; it's about as unobtrusive as 
it's going to get.

Robin.

>   	u32				cavium_id_base; /* Specific to Cavium */
>   
> @@ -1685,6 +1689,25 @@ static int arm_smmu_id_size_to_bits(int size)
>   	}
>   }
>   
> +static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
> +{
> +	int i;
> +	int num = smmu->num_clks;
> +
> +	if (num < 1)
> +		return 0;
> +
> +	smmu->clocks = devm_kcalloc(smmu->dev, num,
> +				    sizeof(*smmu->clocks), GFP_KERNEL);
> +	if (!smmu->clocks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num; i++)
> +		smmu->clocks[i].id = smmu->clk_names[i];
> +
> +	return devm_clk_bulk_get(smmu->dev, num, smmu->clocks);
> +}
> +
>   static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   {
>   	unsigned long size;
> @@ -1897,10 +1920,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   struct arm_smmu_match_data {
>   	enum arm_smmu_arch_version version;
>   	enum arm_smmu_implementation model;
> +	const char * const *clks;
> +	int num_clks;
>   };
>   
>   #define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>   
>   ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> @@ -2001,6 +2026,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   	data = of_device_get_match_data(dev);
>   	smmu->version = data->version;
>   	smmu->model = data->model;
> +	smmu->clk_names = data->clks;
> +	smmu->num_clks = data->num_clks;
>   
>   	parse_driver_options(smmu);
>   
> @@ -2099,6 +2126,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		smmu->irqs[i] = irq;
>   	}
>   
> +	err = arm_smmu_init_clocks(smmu);
> +	if (err)
> +		return err;
> +
>   	err = arm_smmu_device_cfg_probe(smmu);
>   	if (err)
>   		return err;
> @@ -2197,7 +2228,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>   	return 0;
>   }
>   
> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	return clk_bulk_prepare_enable(smmu->num_clks, smmu->clocks);
> +}
> +
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(smmu->num_clks, smmu->clocks);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
> +	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> +			   arm_smmu_runtime_resume, NULL)
> +};
>   
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
> 

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v14 4/4] iommu/arm-smmu: Add support for qcom,smmu-v2
	variant
Date: Wed, 22 Aug 2018 16:27:04 +0100
Message-ID: <44c79159-bf14-cdf0-70ab-421b1dc3c83e@arm.com>
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
	<20180727070224.23966-5-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180727070224.23966-5-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 27/07/18 08:02, Vivek Gautam wrote:
> qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
> clock and power requirements. This smmu core is used with
> multiple masters on msm8996, viz. mdss, video, etc.
> Add bindings for the same.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> 
> Change since v13:
>   - No change.
> 
>   .../devicetree/bindings/iommu/arm,smmu.txt         | 42 ++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c                           | 13 +++++++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce12af5..7c71a6ed465a 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,10 +17,19 @@ conditions.
>                           "arm,mmu-401"
>                           "arm,mmu-500"
>                           "cavium,smmu-v2"
> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
>   
>                     depending on the particular implementation and/or the
>                     version of the architecture implemented.
>   
> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
> +                  string that should be present along with the "qcom,smmu-v2"
> +                  to facilitate SoC specific clocks/power connections and to
> +                  address specific bug fixes.

As demonstrated in the GPU thread, this proves a bit too vague for a 
useful binding. Provided Qcom folks can reach a consensus on what a 
given SoC is actually called, I'd rather just unambiguously list 
whatever sets of fully-defined strings we need.

Robin.

> +                  An example string would be -
> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
> +
>   - reg           : Base address and size of the SMMU.
>   
>   - #global-interrupts : The number of global interrupts exposed by the
> @@ -71,6 +80,22 @@ conditions.
>                     or using stream matching with #iommu-cells = <2>, and
>                     may be ignored if present in such cases.
>   
> +- clock-names:    List of the names of clocks input to the device. The
> +                  required list depends on particular implementation and
> +                  is as follows:
> +                  - for "qcom,smmu-v2":
> +                    - "bus": clock required for downstream bus access and
> +                             for the smmu ptw,
> +                    - "iface": clock required to access smmu's registers
> +                               through the TCU's programming interface.
> +                  - unspecified for other implementations.
> +
> +- clocks:         Specifiers for all clocks listed in the clock-names property,
> +                  as per generic clock bindings.
> +
> +- power-domains:  Specifiers for power domains required to be powered on for
> +                  the SMMU to operate, as per generic power domain bindings.
> +
>   ** Deprecated properties:
>   
>   - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> @@ -137,3 +162,20 @@ conditions.
>                   iommu-map = <0 &smmu3 0 0x400>;
>                   ...
>           };
> +
> +	/* Qcom's arm,smmu-v2 implementation */
> +	smmu4: iommu {
> +		compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> +		reg = <0xd00000 0x10000>;
> +
> +		#global-interrupts = <1>;
> +		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
> +		#iommu-cells = <1>;
> +		power-domains = <&mmcc MDSS_GDSC>;
> +
> +		clocks = <&mmcc SMMU_MDP_AXI_CLK>,
> +			 <&mmcc SMMU_MDP_AHB_CLK>;
> +		clock-names = "bus", "iface";
> +	};
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index e558abf1ecfc..2b4edba188a5 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -119,6 +119,7 @@ enum arm_smmu_implementation {
>   	GENERIC_SMMU,
>   	ARM_MMU500,
>   	CAVIUM_SMMUV2,
> +	QCOM_SMMUV2,
>   };
>   
>   struct arm_smmu_s2cr {
> @@ -1971,6 +1972,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>   
> +static const char * const qcom_smmuv2_clks[] = {
> +	"bus", "iface",
> +};
> +
> +static const struct arm_smmu_match_data qcom_smmuv2 = {
> +	.version = ARM_SMMU_V2,
> +	.model = QCOM_SMMUV2,
> +	.clks = qcom_smmuv2_clks,
> +	.num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> +};
> +
>   static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
>   	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
> @@ -1978,6 +1990,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
>   	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
>   	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
> +	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> 

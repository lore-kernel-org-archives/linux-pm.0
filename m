From: Rob Herring <robh@kernel.org>
Subject: Re: [Patch v15 4/5] dt-bindings: arm-smmu: Add bindings for
 qcom,smmu-v2
Date: Tue, 28 Aug 2018 15:34:18 -0500
Message-ID: <20180828203418.GA18366@bogus>
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-5-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827105551.16346-5-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org, alex.williamson@redhat.com, mark.rutland@arm.com, rjw@rjwysocki.net, robdclark@gmail.com, andy.gross@linaro.org, linux-pm@vger.kernel.org, sboyd@kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org, sricharan@codeaurora.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 27, 2018 at 04:25:50PM +0530, Vivek Gautam wrote:
> Add bindings doc for Qcom's smmu-v2 implementation.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> Changes since v14:
>  - This is a new patch added in v15 after noticing the new
>    checkpatch warning for separate dt-bindings doc.
>  - This patch also addresses comments given by Rob and Robin to add
>    a list of valid values of '<soc>' in "qcom,<soc>-smmu-v2"
>    compatible string.
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce12af5..52198a539606 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,10 +17,24 @@ conditions.
>                          "arm,mmu-401"
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"

The v2 in the compatible string is kind of redundant unless the SoC has 
other SMMU types.

>  
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
>  
> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
> +                  string that should be present along with the "qcom,smmu-v2"
> +                  to facilitate SoC specific clocks/power connections and to
> +                  address specific bug fixes.
> +                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
> +                  following:
> +                  msm8996 - for msm8996 Qcom SoC.
> +                  sdm845 - for sdm845 Qcom Soc.

Rather than all this prose, it would be simpler to just add 2 lines with 
the full compatibles rather than <soc>. The <soc> thing is not going to 
work when/if we move bindings to json-schema also.

> +
> +                  An example string would be -
> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
> +
>  - reg           : Base address and size of the SMMU.
>  
>  - #global-interrupts : The number of global interrupts exposed by the
> @@ -71,6 +85,22 @@ conditions.
>                    or using stream matching with #iommu-cells = <2>, and
>                    may be ignored if present in such cases.
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
>  ** Deprecated properties:
>  
>  - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> @@ -137,3 +167,20 @@ conditions.
>                  iommu-map = <0 &smmu3 0 0x400>;
>                  ...
>          };
> +
> +	/* Qcom's arm,smmu-v2 implementation */
> +	smmu4: iommu {

Needs a unit-address.

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
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

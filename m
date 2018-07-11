From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v6 6/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
Date: Wed, 11 Jul 2018 09:42:09 -0700
Message-ID: <20180711164209.GF545@tuxbook-pro>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 09 Jul 04:43 PDT 2018, Amit Kucheria wrote:

> We want to create common code for v2 of the TSENS IP block that is used in
> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> most of the common functionality start with a common get_temp() function.
> 
> It is also necessary to split out the memory regions for the TM and SROT
> register banks because their offsets are not constant across SoC families.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 06195e8..8f963b1 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -1,10 +1,16 @@
>  * QCOM SoC Temperature Sensor (TSENS)
>  
>  Required properties:
> -- compatible :
> - - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> - - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> - - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> +- compatible:
> +  Must be one of the following:
> +    - "qcom,msm8916-tsens" (MSM8916)
> +    - "qcom,msm8974-tsens" (MSM8974)
> +    - "qcom,msm8996-tsens" (MSM8996)
> +    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
> +    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
> +  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC with
> +  version 2 of the TSENS IP. MSM8996 is the only exception beacause the generic
> +  property did not exist when support was added.
>  
>  - reg: Address range of the thermal registers
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> @@ -12,7 +18,7 @@ Required properties:
>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
>  nvmem cells
>  
> -Example:
> +Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):
>  tsens: thermal-sensor@900000 {
>  		compatible = "qcom,msm8916-tsens";
>  		reg = <0x4a8000 0x2000>;
> @@ -20,3 +26,12 @@ tsens: thermal-sensor@900000 {
>  		nvmem-cell-names = "caldata", "calsel";
>  		#thermal-sensor-cells = <1>;
>  	};
> +
> +Example 2 (for any platform containing v2 of the TSENS IP):
> +tsens0: tsens@c222000 {
> +		compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +		reg = <0xc263000 0x1ff>, /* TM */
> +			<0xc222000 0x1ff>; /* SROT */
> +		#qcom,sensors = <13>;
> +		#thermal-sensor-cells = <1>;
> +	};
> -- 
> 2.7.4
> 

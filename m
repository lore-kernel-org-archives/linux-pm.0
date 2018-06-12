From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 2/5] dt: qcom: 8996: thermal: Move to DT initialisation
Date: Tue, 12 Jun 2018 12:35:07 -0700
Message-ID: <20180612193507.GO14924@minitux>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <683ceb9a7d283bcad47fc6e8e4fcfbd7e76c1018.1528799892.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <683ceb9a7d283bcad47fc6e8e4fcfbd7e76c1018.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue 12 Jun 03:54 PDT 2018, Amit Kucheria wrote:

> We also split up the regmap address space into two, one for the TM
> registers, the other for the SROT registers. This was required to deal with
> different address offsets for the TM and SROT registers across different
> SoC families.
> 
> Since tsens-common.c/init_common() currently only registers one address space, the order is important (TM before SROT).This is OK since the code doesn't really use the SROT functionality yet.

Please line wrap this.

> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>  drivers/thermal/qcom/tsens-8996.c     |  1 -
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 410ae78..b4aab18 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -451,7 +451,17 @@
>  
>  		tsens0: thermal-sensor@4a8000 {
>  			compatible = "qcom,msm8996-tsens";
> -			reg = <0x4a8000 0x2000>;
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@4ac000 {
> +			compatible = "qcom,msm8996-tsens";
> +			reg = <0x4ad000 0x1000>, /* TM */
> +			      <0x4ac000 0x1000>; /* SROT */
> +			#qcom,sensors = <8>;
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
> index e1f7781..6e59078 100644
> --- a/drivers/thermal/qcom/tsens-8996.c
> +++ b/drivers/thermal/qcom/tsens-8996.c
> @@ -79,6 +79,5 @@ static const struct tsens_ops ops_8996 = {
>  };
>  
>  const struct tsens_data data_8996 = {
> -	.num_sensors	= 13,

This will cause the current 8996 dts to fail probing the tsens. I think
you should just leave this as is, because specifying qcom,sensors in dts
will overwrite this number regardless.

It also would make this change dts specific, which is convenient as it
breaks the interdependency between the different subsystems.

>  	.ops		= &ops_8996,

Regards,
Bjorn

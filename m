From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 01/11] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
Date: Mon, 3 Sep 2018 13:02:55 -0700
Message-ID: <20180903200255.GL3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <882739b10bd0a3b655baef9b7ee1958680aa0b04.1535462942.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <882739b10bd0a3b655baef9b7ee1958680aa0b04.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> We've earlier added support to split the register address space into TM
> and SROT regions.
> 
> Split up the regmap address space into two for the remaining platforms
> that have a similar register layout and make corresponding changes to
> the get_temp_common() function used by these platforms.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT).  This is OK since the
> code doesn't really use the SROT functionality yet.
> 

Having a single patch touching both code and dts will cause merge issues
as this patch travel upstream. Even more arm-soc expects arm and arm64
dts changes to come in different pull requests.

Please split it so that the three pieces can be picked up by respective
maintainer.

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 5 +++--
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++--
>  drivers/thermal/qcom/tsens-common.c   | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index d9019a49b292..56dbbf788d15 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -427,9 +427,10 @@
>  			};
>  		};
>  
> -		tsens: thermal-sensor@fc4a8000 {
> +		tsens: thermal-sensor@fc4a9000 {
>  			compatible = "qcom,msm8974-tsens";
> -			reg = <0xfc4a8000 0x2000>;
> +			reg = <0xfc4a9000 0x1000>, /* TM */
> +			      <0xfc4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
>  			nvmem-cell-names = "calib", "calib_backup";
>  			#thermal-sensor-cells = <1>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 7b32b8990d62..6a277fce3333 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -761,9 +761,10 @@
>  			};
>  		};
>  
> -		tsens: thermal-sensor@4a8000 {
> +		tsens: thermal-sensor@4a9000 {
>  			compatible = "qcom,msm8916-tsens";
> -			reg = <0x4a8000 0x2000>;
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
>  			nvmem-cell-names = "calib", "calib_sel";
>  			#thermal-sensor-cells = <1>;
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 6207d8d92351..478739543bbc 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -21,7 +21,7 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> -#define S0_ST_ADDR		0x1030
> +#define STATUS_OFFSET		0x30
>  #define SN_ADDR_OFFSET		0x4
>  #define SN_ST_TEMP_MASK		0x3ff
>  #define CAL_DEGC_PT1		30
> @@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  	unsigned int status_reg;
>  	int last_temp = 0, ret;
>  
> -	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> +	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;

Wasn't this change part of the previous set that introduced the
tm_offset? If not how did we handle the fact that tmdev->map is already
indented 0x1000 bytes?

Both changes looks good, but I'm worries about the order of things.

Regards,
Bjorn

>  	ret = regmap_read(tmdev->map, status_reg, &code);
> +
>  	if (ret)
>  		return ret;
>  	last_temp = code & SN_ST_TEMP_MASK;
> -- 
> 2.17.1
> 

From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] dt-bindings: document qcom tsens thermal
Date: Thu, 29 Jan 2015 18:29:18 -0400
Message-ID: <20150129222916.GB29837@developer.amazonguestwifi.org>
References: <1422331687-19535-1-git-send-email-nrajan@codeaurora.org>
 <54C73B16.2030506@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33713 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbbA2W3X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 17:29:23 -0500
Content-Disposition: inline
In-Reply-To: <54C73B16.2030506@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Narendran Rajan <nrajan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Tue, Jan 27, 2015 at 07:15:34AM +0000, Srinivas Kandagatla wrote:
> Hi Narendran,
> 
> What a coincidence.. I was just in the middle of forward porting the 
> same driver from 3.4 kernel :-) You look fast... :-)
> 
> On 27/01/15 04:08, Narendran Rajan wrote:
> > Add binding documentation for the QCOM tsens device tree node
> > ---
> >   .../devicetree/bindings/thermal/qcom-thermal.txt   | 58 ++++++++++++++++++++++
> >   1 file changed, 58 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/qcom-thermal.txt
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-thermal.txt b/Documentation/devicetree/bindings/thermal/qcom-thermal.txt
> > new file mode 100644
> > index 0000000..d2e99d6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-thermal.txt
> > @@ -0,0 +1,58 @@
> > +* QCOM SoC Temperature Sensor (TSENS)
> > +
> > +Required properties:
> > +- compatible : "qcom,ipq806x-tsens"
> 
> I think this should be something like qcom,msm8960-tsens as that is the 
> first part where this tsens appeared.
> 
> > +- interrupts : The interrupt number to the cpu. The interrupt specifier format
> > +	       depends on the interrupt controller.
> > +- qcom,imem : Must contain phandle to imem syscon node
> Doing this way would work but not great, We should try to do this in an 
> abstracted way so that all the drivers who are in need of qfprom would 
> not add the same code all the time. I did send some WIP patches on msm 
> mailing list.
> 
> > +- qcom,tsens-base : Must contain phandle to clock controller node
> This is not correct, you dont need this property.
> 
> AFAIK for APQ8064 Tsens should be a child of gcc as some of the 
> registers are in already mapped by gcc. You should probably use this 
> patch + do a
> 	base = dev_get_regmap(dev->parent, NULL);
> 
> ------------------>cut<-----------------------------
>  From 87b71df272048fb3aaa89b77524e4b6426e5ddc5 Mon Sep 17 00:00:00 2001
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date: Thu, 22 Jan 2015 14:03:53 +0000
> Subject: [PATCH] clk: qcom: gcc-msm8960: add child devices support.
> 
> This patch adds support to add child devices to gcc as some of the
> registers mapped by gcc are used by things like thermal sensors.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Srinivas,

Can you please send this as proper separated patch?

> ---
>   drivers/clk/qcom/gcc-msm8960.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
> index 0b61e8a..8307db3 100644
> --- a/drivers/clk/qcom/gcc-msm8960.c
> +++ b/drivers/clk/qcom/gcc-msm8960.c
> @@ -15,6 +15,7 @@
>   #include <linux/bitops.h>
>   #include <linux/err.h>
>   #include <linux/platform_device.h>
> +#include <linux/of_platform.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> @@ -3666,7 +3667,8 @@ static int gcc_msm8960_probe(struct 
> platform_device *pdev)
>   		hfpll_l2.d = &hfpll_l2_8064_data;
>   	}
> 
> -	return qcom_cc_probe(pdev, match->data);
> +	qcom_cc_probe(pdev, match->data);
> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
>   }
> 
>   static int gcc_msm8960_remove(struct platform_device *pdev)
> -- 
> 2.2.1
> 
> ------------------>cut<-----------------------------
> 
> > +- qcom,calib-offsets : Must contain offsets to primary and secondary
> > +			calibration data within imem
> > +- qcom,tsens-slopes : Must contain slope value for each of the sensors controlled
> > +			by this device
> > +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> > +
> > +Exiample:
> > +tsens: tsens-msm8960 {
> > +		compatible = "qcom,ipq806x-tsens";
> 
> > +		interrupts = <0 178 1>;
> > +		qcom,imem = <&imem>;
> > +		qcom,tsens-base = <&gcc>;
> > +		qcom,calib-offsets = <0x400 0x410>;
> > +		qcom,tsens-slopes = <1176 1176 1154 1176 1111
> > +				1132 1132 1199 1132 1199
> > +				1132>;
> > +		#thermal-sensor-cells = <1>;
> > +	};
> > +
> > +Example: referring to thermal sensors:
> > +thermal-zones {
> > +	cpu_thermal: cpu_thermal {
> > +		polling-delay-passive = <1000>; /* milliseconds */
> > +		polling-delay = <5000>; /* milliseconds */
> > +
> > +		/* sensor	ID */
> > +		thermal-sensors = <&tsens	1>;
> > +
> > +		trips {
> > +			cpu_alert0: cpu_alert {
> > +				temperature = <80000>; /* millicelsius */
> > +				hysteresis = <2000>; /* millicelsius */
> > +				type = "passive";
> > +			};
> > +			cpu_crit: cpu_crit {
> > +				temperature = <120000>; /* millicelsius */
> > +				hysteresis = <2000>; /* millicelsius */
> > +				type = "critical";
> > +			};
> > +		};
> > +
> > +		cooling-maps {
> > +			map0 {
> > +				trip = <&cpu_alert0>;
> > +				cooling-device =
> > +					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +			};
> > +		};
> > +	};
> > +};
> >
> 
> ---srini

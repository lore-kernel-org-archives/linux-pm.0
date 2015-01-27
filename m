From: "Narendran Rajan" <nrajan@codeaurora.com>
Subject: RE: [PATCH] dt-bindings: document qcom tsens thermal
Date: Tue, 27 Jan 2015 11:44:41 -0800
Message-ID: <002301d03a69$b1f169f0$15d43dd0$@codeaurora.com>
References: <1422331687-19535-1-git-send-email-nrajan@codeaurora.org> <54C73B16.2030506@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:54845 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbbA0Ton (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 14:44:43 -0500
In-Reply-To: <54C73B16.2030506@linaro.org>
Content-Language: en-us
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Srinivas Kandagatla' <srinivas.kandagatla@linaro.org>, 'Narendran Rajan' <nrajan@codeaurora.org>, 'Zhang Rui' <rui.zhang@intel.com>, 'Eduardo Valentin' <edubezval@gmail.com>
Cc: 'Linux ARM MSM' <linux-arm-msm@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>

Hi Srini,

Thanks for the comments

> -----Original Message-----
> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
> owner@vger.kernel.org] On Behalf Of Srinivas Kandagatla
> Sent: Monday, January 26, 2015 11:16 PM
> To: Narendran Rajan; Zhang Rui; Eduardo Valentin
> Cc: Linux ARM MSM; Linux PM
> Subject: Re: [PATCH] dt-bindings: document qcom tsens thermal
> 
> Hi Narendran,
> 
> What a coincidence.. I was just in the middle of forward porting the same
> driver from 3.4 kernel :-) You look fast... :-)
> 
> On 27/01/15 04:08, Narendran Rajan wrote:
> > Add binding documentation for the QCOM tsens device tree node
> > ---
> >   .../devicetree/bindings/thermal/qcom-thermal.txt   | 58
> ++++++++++++++++++++++
> >   1 file changed, 58 insertions(+)
> >   create mode 100644
> > Documentation/devicetree/bindings/thermal/qcom-thermal.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/thermal/qcom-thermal.txt
> > b/Documentation/devicetree/bindings/thermal/qcom-thermal.txt
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
first
> part where this tsens appeared.
> 
Will address in next version.

> > +- interrupts : The interrupt number to the cpu. The interrupt specifier
> format
> > +	       depends on the interrupt controller.
> > +- qcom,imem : Must contain phandle to imem syscon node
> Doing this way would work but not great, We should try to do this in an
> abstracted way so that all the drivers who are in need of qfprom would not
> add the same code all the time. I did send some WIP patches on msm mailing
> list.
> 
> > +- qcom,tsens-base : Must contain phandle to clock controller node
> This is not correct, you dont need this property.
> 
> AFAIK for APQ8064 Tsens should be a child of gcc as some of the registers
are
> in already mapped by gcc. You should probably use this patch + do a
> 	base = dev_get_regmap(dev->parent, NULL);
> 

I started with a child node version as you suggested, but later modified to
be top 
level device node.   IMHO tsens register map sandwiched between gcc
registers 
looked odd and didn't want to expose this in the device tree hierarchy,
hence the 
roundabout way to get the gcc phandle.

Let me please know your thoughts. I am open to either ways.

> ------------------>cut<-----------------------------
>  From 87b71df272048fb3aaa89b77524e4b6426e5ddc5 Mon Sep 17 00:00:00
> 2001
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date: Thu, 22 Jan 2015 14:03:53 +0000
> Subject: [PATCH] clk: qcom: gcc-msm8960: add child devices support.
> 
> This patch adds support to add child devices to gcc as some of the
registers
> mapped by gcc are used by things like thermal sensors.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/clk/qcom/gcc-msm8960.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-
> msm8960.c index 0b61e8a..8307db3 100644
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
> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL,
> +&pdev->dev);
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
> > +- qcom,tsens-slopes : Must contain slope value for each of the sensors
> controlled
> > +			by this device
> > +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a
description.
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
> > +					<&cpu0 THERMAL_NO_LIMIT
> THERMAL_NO_LIMIT>;
> > +			};
> > +		};
> > +	};
> > +};
> >
> 
> ---srini
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

--Naren


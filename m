From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] dt-bindings: Document the hi6220 thermal sensor
 bindings
Date: Thu, 19 Mar 2015 14:08:29 +0000
Message-ID: <20150319140829.GA25967@leverpostej>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1426751849-10604-4-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426751849-10604-4-git-send-email-kong.kongxinwei@hisilicon.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kongxinwei <kong.kongxinwei@hisilicon.com>
Cc: "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 19, 2015 at 07:57:29AM +0000, kongxinwei wrote:
> This adds documentation of device tree bindings for the
> thermal sensor controller of hi6220 SoC.

Please place the patches adding binding docs _before_ any patcheds
introducing code or dts files using them.

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
> ---
>  .../bindings/thermal/hisilicon-thermal.txt         | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> new file mode 100644
> index 0000000..b75c48e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> @@ -0,0 +1,51 @@
> +* Hisilicon Thermal
> +
> +This driver is for hi6220 SoC which contain 4 thermal sensor.
> +
> +	1. sensor 0: local sensor;
> +	2. sensor 1: remote sensor for ACPU cluster 1;
> +	3. sensor 2: remote sensor for ACPU cluster 2;
> +	4. sensor 3: remote sensor for GPU.
> +
> +Every sensor use one child node to represent it, so thermal sensor include
> +parent node and four child node. The parent node describe common feature and
> +child node describe private feature for thermal sensor;
> +
> +** Required properties :
> +
> +- compatible : "hisilicon,tsensor";
> +- reg : address range of the thermal sensor registers;

Is there jsut the one block?

> +- interrupt : Standard way to define interrupt numbr;

Describe what the interrupt logically is from the PoV of this device. We
all know what an interrupt is in abstract.

> +- clock-names : Should be "thermal_clk".

What is the clock input actually called on the data sheet?

Is this the only clock input?

No regulators or other inputs we need to describe?

> +		  See: Documentation/devicetree/bindings/resource-names.txt;

Drop this, it's irrelevant.

> +- clocks : Phandle of the clock used by the thermal sensor.

Define this in terms of clock-names.

> +	     See: Documentation/devicetree/bindings/clock/clock-bindingm.txt

Drop this. This is pointless, exepcially given the typo.

> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description;

Define what the permitted values are. This is useless as-is.

> +
> +** Required properties for child nodes :
> +
> +- hisilicon,tsensor-id : the index of thermal senor;

As with #thermal-sensor-cells, this description is incomplete.

> +- hisilicon,tsensor-thres-temp : the interrupt threshold temperature of
> +				thermal senor;
> +- hisilicon,tsensor-reset-temp : the reset temperature of the hardware SoC;

NAK. These do not belong on the sensor.

> +- hisilicon,tsensor-bind-irq : systerm interrupt binding thermal sensor;

NAK. I've tried a few times, but I still can't figure out what this is
intended to mean. I don't see what this could possibly mean that would
be reasonable to describe.

Mark.

> +
> +Example :
> +
> +	tsensor: tsensor@0,f7030700 {
> +		compatible = "hisilicon,tsensor";
> +		reg = <0x0 0xf7030700 0x0 0x1000>;
> +		interrupts = <0 7 0x4>;
> +		clocks = <&clock_sys HI6220_TSENSOR_CLK>;
> +		clock-names = "thermal_clk";
> +		#thermal-sensor-cells = <1>;
> +
> +		local_sensor {
> +			hisilicon,tsensor-id = <0>;
> +			hisilicon,tsensor-lag-value = <10>;
> +			hisilicon,tsensor-thres-temp = <35000>;
> +			hisilicon,tsensor-reset-temp = <100000>;
> +			hisilicon,tsensor-bind-irq;
> +		}
> +		.......
> +	}
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

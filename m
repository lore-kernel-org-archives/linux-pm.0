From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 3/3] dts: hi6220: enable thermal sensor for hisilicon
 SoC
Date: Wed, 20 May 2015 11:02:21 +0800
Message-ID: <555BF93D.4050104@hisilicon.com>
References: <1431933109-22764-1-git-send-email-kong.kongxinwei@hisilicon.com> <1431933109-22764-4-git-send-email-kong.kongxinwei@hisilicon.com> <20150520045100.GB4295@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:46721 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbbETDBZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 23:01:25 -0400
In-Reply-To: <20150520045100.GB4295@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhuang@intel.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org, dan.zhao@hisilicon.com, devicetree@vger.kernel.org, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, mark.rutland@arm.com, linuxarm@huawei.com, zhenwei.wang@hisilicon.com, leo.yan@linaro.org, mporter@konsulko.com, zhangfei.gao@linaro.org, liguozhu@hisilicon.com



On 2015/5/20 12:51, Eduardo Valentin wrote:
> On Mon, May 18, 2015 at 03:11:49PM +0800, Xinwei Kong wrote:
>> From: kongxinwei <kong.kongxinwei@hisilicon.com>
>>
>> Dts includes two part: the first part is related with thermal sensor;
>> the second part is related with thermal zones, in this part it will
>> define the thermal zones and which sensor device should be bound to.
>> it also need specify the polling interval for every thermal zone.
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 127 ++++++++++++++++++++++++++++++
>>  1 file changed, 127 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> new file mode 100644
>> index 0000000..82f213d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> @@ -0,0 +1,127 @@
>> +
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +/ {
>> +
>> +	tsensor: tsensor@0,f7030700 {
>> +		compatible = "hisilicon,tsensor";
>> +		reg = <0x0 0xf7030700 0x0 0x1000>;
>> +		interrupts = <0 7 0x4>;
>> +		clocks = <&clock_sys HI6220_TSENSOR_CLK>;
>> +		clock-names = "thermal_clk";
>> +		#thermal-sensor-cells = <1>;

 		}

oh, my god. I miss it. add "}".
>> +
>> +	thermal-zones {
> 
> The thermal-zones node is typically in the root node, not inside the
> sensor node.
> 
>> +		local: local {
>> +			/* milliseconds */
>> +			polling-delay-passive = <1000>;
>> +			/* milliseconds */
>> +			polling-delay = <5000>;
>> +
>> +			/* sensor	ID */
>> +			thermal-sensors = <&tsensor  0>;
>> +
>> +			trips {
>> +				local_alert: local_alert {
>> +					/* millicelsius */
>> +					temperature = <70000>;
>> +					/* millicelsius */
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +				local_crit: local_crit {
>> +					temperature = <90000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				/* There are currently no cooling maps
>> +				because there are no cooling devices */
> 
> Not even cpufreq? in your driver you mention about cpufreq cooling.
> 
> Do you have cpufreq-dt driver  properly setup in your board?
> 
>> +			};
>> +		};
>> +
>> +		cluster1: cluster1 {
>> +			polling-delay-passive = <1000>;
>> +			polling-delay = <5000>;
>> +
>> +			/* sensor	ID */
>> +			thermal-sensors = <&tsensor  1>;
>> +
>> +			trips {
>> +				cluster1_alert: cluster1_alert {
>> +					temperature = <70000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +				cluster1_crit: cluster1_crit {
>> +					temperature = <90000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				/* There are currently no cooling maps
>> +				because there are no cooling devices */
>> +			};
>> +		};
>> +
>> +		cluster0: cluster0 {
>> +			polling-delay-passive = <1000>;
>> +			polling-delay = <5000>;
>> +
>> +			/* sensor	ID */
>> +			thermal-sensors = <&tsensor  2>;
>> +
>> +			trips {
>> +				cluster0_alert: cluster0_alert {
>> +					temperature = <70000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +				cluster0_crit: cluster0_crit {
>> +					temperature = <90000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cluster0_alert>;
>> +					cooling-device =
>> +					    <&cpu0 THERMAL_NO_LIMIT
>> +						THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		gpu: gpu {
>> +			polling-delay-passive = <1000>;
>> +			polling-delay = <5000>;
>> +
>> +			/* sensor	ID */
>> +			thermal-sensors = <&tsensor  3>;
>> +
>> +			trips {
>> +				gpu_alert: gpu_alert {
>> +					temperature = <70000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +				gpu_crit: gpu_crit {
>> +					temperature = <90000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				/* There are currently no cooling maps
>> +				because there are no cooling devices */
>> +			};
>> +		};
>> +	};
>> +}
> 
> Are you sure this DT file works? I think it misses a closing \}.

I will re-varify  this driver and enable or use this tsensor based
mainline kernel  4.1-rc1.
> 
>> -- 
>> 1.9.1
>>
>>


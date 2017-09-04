From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: register Hi3660's thermal sensor
Date: Mon, 4 Sep 2017 16:11:12 +0800
Message-ID: <c7b85592-1bca-6a31-c652-011ac6f86a2a@hisilicon.com>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
 <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1503994666-13954-4-git-send-email-kevin.wangtao@hisilicon.com>
 <4e819928-9544-e7a1-b8ff-09ebee07f32b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4e819928-9544-e7a1-b8ff-09ebee07f32b@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com
List-Id: linux-pm@vger.kernel.org



在 2017/9/1 5:13, Daniel Lezcano 写道:
> On 29/08/2017 10:17, Tao Wang wrote:
>> From: Tao Wang <kevin.wangtao@linaro.org>
>>
>> Bind thermal sensor driver for Hi3660.
> 
> The description is a bit light :)
All right
> 
> 
>> Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
>>   arch/arm64/boot/dts/hisilicon/hi3660.dtsi    | 14 +++++++++++++
>>   include/dt-bindings/thermal/hi3660-thermal.h | 31 ++++++++++++++++++++++++++++
>>   2 files changed, 45 insertions(+)
>>   create mode 100644 include/dt-bindings/thermal/hi3660-thermal.h
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index c6a1961..1ee6084 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -6,6 +6,7 @@
>>   
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/clock/hi3660-clock.h>
>> +#include <dt-bindings/thermal/hi3660-thermal.h>
>>   
>>   / {
>>   	compatible = "hisilicon,hi3660";
>> @@ -848,5 +849,18 @@
>>   				     &sdio_cfg_func>;
>>   			status = "disabled";
>>   		};
>> +
>> +		tsensor: tsensor@fff30000 {
>> +			compatible = "hisilicon,hi3660-tsensor";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			reg = <0x0 0xfff3001c 0x0 0x4>,
>> +				<0x0 0xfff3005c 0x0 0x4>,
>> +				<0x0 0xfff3009c 0x0 0x4>;
>> +			hisi,tsensors = <HISI_MAX_TSENSORS>;
>> +			hisi,coef = <165000 (-40000)>;
>> +			hisi,adc-range = <0x74 0x39A>;
>> +			#thermal-sensor-cells = <1>;
>> +		};
>>   	};
>>   };
>> diff --git a/include/dt-bindings/thermal/hi3660-thermal.h b/include/dt-bindings/thermal/hi3660-thermal.h
>> new file mode 100644
>> index 0000000..d9d9b6a
>> --- /dev/null
>> +++ b/include/dt-bindings/thermal/hi3660-thermal.h
>> @@ -0,0 +1,31 @@
>> +/*
>> + *  Copyright (c) 2017 Hisilicon Limited.
>> + *  Copyright (c) 2017 Linaro Limited.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; version 2 of the License.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __DTS_HI3660_THERMAL_H
>> +#define __DTS_HI3660_THERMAL_H
>> +
>> +/* sensor id */
>> +#define LITTLE_CPU_TEMP		0
>> +#define BIG_CPU_TEMP		1
>> +#define GPU_TEMP		2
> 
> Is it possible to stick to the sensor description?
OK
> 
> eg.
> 
> #define HI3660_A53_TEMP	0
> #define HI3660_A72_TEMP 1
> #define HI3660_GPU_TEMP 2
> 
>> +#define MAX_TEMP		3
>> +#define AVG_TEMP		4
> 
> It does not make sense to define AVG and MAX, they describe how is
> computed the temperature. It makes more sense to define the group eg.
> SOC_TEMP and add an attribute to the virtual sensor telling how you want
> the temperature to be computed. That will make the code in the driver
> much more simple, clear and clean.
You inspired me, actually the thermal zone just want the SoC temp, my driver only need to offer one virtual sensor, we don't need the sensor id any more
> 
>> +#define HISI_MAX_TSENSORS		3> +#define THERMAL_NO_LIMIT		(~0)
> 
> Already defined in dt-bindings/thermal.h
> 
>> +#endif
> 
> 
> 

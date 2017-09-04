From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: Document the hi3660 thermal sensor
 bindings
Date: Mon, 4 Sep 2017 14:39:04 +0800
Message-ID: <38fdf052-97be-1b54-5e7d-9dd0bc11e9b4@hisilicon.com>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
 <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1503994666-13954-2-git-send-email-kevin.wangtao@hisilicon.com>
 <d56428a6-ef27-4424-3ce5-4610fef3ac15@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:5515 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdIDGjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Sep 2017 02:39:33 -0400
In-Reply-To: <d56428a6-ef27-4424-3ce5-4610fef3ac15@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com



在 2017/9/1 2:24, Daniel Lezcano 写道:
> On 29/08/2017 10:17, Tao Wang wrote:
>> From: Tao Wang <kevin.wangtao@linaro.org>
>>
>> This adds documentation of device tree bindings for the
>> thermal sensor controller of hi3660 SoC.
>>
>> Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
>> ---
>>   .../devicetree/bindings/thermal/hisi-tsensor.txt   | 37 ++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>> new file mode 100644
>> index 0000000..4643dbe
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>> @@ -0,0 +1,37 @@
>> +* Temperature Sensor on hisilicon SoC
>> +
>> +Hisilicon SoC supplies temperature sensor feature, each CPU cluster and G3D
>> +area contains a temperture sensor. The temperture sensor produces an output
>> +value which has a linear relationship with the temperture of the area.
>> +
> 
> s/temperture/temperature/
THX
> 
>> +for Hi3660,
>> +sensor0 monitors the temperture of A53;
>> +sensor1 monitors the temperture of A72;
>> +sensor2 monitors the temperture of GPU;
>> +sensor3 is a virtual sensor, which produces the maximum value of all sensors;
>> +sensor4 is a virtual sensor, which produces the average value of all sensors.
> 
> I don't think we need to escribe the virtual sensors in the DT bindings.
I just want to let user know the sensor id of virtual sensor, I also define it in header file, so the header file is enough?
> 
>> +** Required properties :
>> +- compatible: "hisilicon,thermal-tsensor".
>> +- reg: physical reg address of thermal sensor and length of memory mapped
>> +  region.
>> +- hisi,tsensors: number of hardware tsensors
>> +- hisi,coef:	An array of integers (one signed cell) containing
>> +		coefficients to turn adc value to temperture.
>> +- hisi,adc-range: adc value range, minimum value is followed by maximum value.
>> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
>> +
>> +Example :
>> +Hi3660:
>> +tsensor: tsensor@fff30000 {
>> +	compatible = "hisilicon,hi3660-tsensor";
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	reg = <0x0 0xfff3001c 0x0 0x4>,
>> +		<0x0 0xfff3005c 0x0 0x4>,
>> +		<0x0 0xfff3009c 0x0 0x4>;
>> +	hisi,tsensors = <HISI_MAX_TSENSORS>;
>> +	hisi,coef = <165000 (-40000)>;
>> +	hisi,adc-range = <0x74 0x39A>;
> 
> Do we really need max sensors, coef and adc range to be specified in the DT?
> 
> Can't we assume the hi3660-tsensor has 3 sensors, and hard-code the
> coef, adc, in the driver itself?
My purpose is to make the driver be compitable with our future platform.
> 
> Can't this binding be merged with the hisilicon-thermal.txt?
> 
> Thanks.
> 
>    -- Daniel
> 
> 

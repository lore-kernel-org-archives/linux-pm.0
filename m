From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: Document the hi3660 thermal sensor
 bindings
Date: Mon, 21 Aug 2017 10:17:48 +0800
Message-ID: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
References: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1502353935-92924-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1502353935-92924-2-git-send-email-kevin.wangtao@hisilicon.com>
 <20170817141517.izhteflvfwtoovqv@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:4084 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753467AbdHUCSR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2017 22:18:17 -0400
In-Reply-To: <20170817141517.izhteflvfwtoovqv@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, xuwei5@hisilicon.com, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sunzhaosheng@hisilicon.com



ÔÚ 2017/8/17 23:10, Rob Herring Ð´µÀ:
> On Thu, Aug 10, 2017 at 04:32:13PM +0800, Tao Wang wrote:
>> From: Tao Wang <kevin.wangtao@linaro.org>
>>
>> This adds documentation of device tree bindings for the
>> thermal sensor controller of hi3660 SoC.
>>
>> Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
>> ---
>>   .../devicetree/bindings/thermal/hisi-tsensor.txt   | 23 ++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>> new file mode 100644
>> index 0000000..2ab0eb9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>> @@ -0,0 +1,23 @@
>> +* Temperature Sensor on hisilicon SoC
>> +
>> +** Required properties :
>> +
>> +- compatible: "hisilicon,thermal-tsensor".
> 
> Needs an SoC specific compatible.
OK
> 
>> +- reg: physical base address of thermal sensor and length of memory mapped
>> +  region.
>> +- offset: reg offset of each sensor.
> 
> Should be implied by the compatible.
Do you mean that the reg offset should not in dts?
> 
>> +- coefficients:	An array of integers (one signed cell) containing
>> +		coefficients to turn adc value to temperture.
> 
> Needs a vendor prefix.
OK
> 
>> +- hisi,adc-range: adc value range, minimum value is followed by maximum value.
>> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
>> +
>> +Example :
>> +
>> +tsensor: tsensor@FFF3000 {
>> +	compatible = "hisilicon,tsensor";
>> +	reg = <0x0 0xfff30000 0x0 0x1000>;
>> +	offset = <0x1c 0x5c 0x9c>;
>> +	coefficients = <165000 (-40000)>;
>> +	hisi,adc-range = <0x74 0x39A>;
>> +	#thermal-sensor-cells = <1>;
>> +};
>> -- 
>> 2.8.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 

From: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Document the hi6220 thermal sensor
 bindings
Date: Tue, 7 Apr 2015 15:06:53 +0800
Message-ID: <5523820D.2050500@hisilicon.com>
References: <1427785162-15172-1-git-send-email-kong.kongxinwei@hisilicon.com> <1427785162-15172-2-git-send-email-kong.kongxinwei@hisilicon.com> <20150406140355.GI30984@beef> <5523530E.3000400@hisilicon.com> <20150407042727.GA30242@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150407042727.GA30242-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xweikong-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2015/4/7 12:27, Eduardo Valentin wrote:
> On Tue, Apr 07, 2015 at 11:46:22AM +0800, Xinwei Kong wrote:
>>
>>
>> On 2015/4/6 22:03, Matt Porter wrote:
>>> On Tue, Mar 31, 2015 at 02:59:21PM +0800, Xinwei Kong wrote:
>>>> From: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>>>
>>>> This adds documentation of device tree bindings for the
>>>> thermal sensor controller of hi6220 SoC.
>>>>
>>>> Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>> Signed-off-by: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>>> ---
>>>>  .../bindings/thermal/hisilicon-thermal.txt         | 45 ++++++++++++++++++++++
>>>>  1 file changed, 45 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
>>>> new file mode 100644
>>>> index 0000000..ceb6e2e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
>>>> @@ -0,0 +1,45 @@
>>>> +* Hisilicon Thermal
>>>> +
>>>> +This driver is for hi6220 SoC which contain 4 thermal sensor.
>>>> +
>>>> +	1. sensor 0: local sensor;
>>>> +	2. sensor 1: remote sensor for ACPU cluster 1;
>>>> +	3. sensor 2: remote sensor for ACPU cluster 2;
>>>> +	4. sensor 3: remote sensor for GPU.
>>>> +
>>>> +Every sensor use one child node to represent it, so thermal sensor include
>>>> +parent node and four child node. The parent node describe common feature and
>>>> +child node describe private feature for thermal sensor;
>>>> +
>>>> +** Required properties :
>>>> +
>>>> +- compatible: "hisilicon,tsensor".
>>>> +- reg: physical base address of thermal sensor and length of memory mapped
>>>> +  region.
>>>> +- interrupt: The interrupt number to the cpu. Defines the interrupt used
>>>> +  by SOCTHERM.
>>>> +- clock-names: Input clock name, should be 'thermal_clk'.
>>>> +- clocks: phandles for clock specified in "clock-names" property.
>>>> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
>>>> +
>>>> +** Required properties for child nodes :
>>>> +
>>>> +- hisilicon,tsensor-id: the index of thermal sensor and use it to distinguish
>>>> +  thermal sensor. For example: <0> stands for local sensor; <1> stands for
>>>> +  acpu1 sensor;
>>>
>>> Please show an example illustrating why this property is needed. The
>>> example below doesn't show any per sensor properties aside from the
>>> sensor id. Other bindings with a similar sub-sensor hardware design like
>>> tegra-soctherm and rockchip-thermal don't have a need for a vendor
>>> specific property like this. Their drivers simply iterate over an id
>>> index during thermal sensor registration.
>>>
>>> -Matt
>>>
>> Thermal Ip of hisilicon SoC can get four module temperature--local sensor, ACPU0
>> sensor, ACPU1 sensor and gpu sensor. In order to use these sensors, this driver
>> will make use of sensor id to distinguish sensor in using process.
>>
>> These four sensors only get one sensor temperature at the same times. Because
>> these sensor commonly use the same register by setting diff value to enable one
>> sensor. howerver, sensor id is key flag for these diff sensor modules.
>>
>> If deleting sensor id, this driver will define some value which set diff sensor
>> regitser and it difficult to understand sensor register operation.
> 
> The above still do not explain why you need a specific property.
> 
> Could you please check
> Documentation/devicetree/bindings/thermal/thermal.txt file?
> 
> There are several examples there on how to define DT nodes for the exact
> case you describe above.
> 
Good comments, thank you for Matt and Valentin and I will try to satisfy thermal.txt
file to realize this driver. Please wait for the next version patches.

Thanks
Xinwei
>>
>> Thanks
>> Xinwei
>>
>>>> +
>>>> +Example :
>>>> +
>>>> +	tsensor: tsensor@0,f7030700 {
>>>> +		compatible = "hisilicon,tsensor";
>>>> +		reg = <0x0 0xf7030700 0x0 0x1000>;
>>>> +		interrupts = <0 7 0x4>;
>>>> +		clocks = <&clock_sys HI6220_TSENSOR_CLK>;
>>>> +		clock-names = "thermal_clk";
>>>> +		#thermal-sensor-cells = <1>;
>>>> +
>>>> +		local_sensor {
>>>> +			hisilicon,tsensor-id = <0>;
>>>> +		}
>>>> +		.......
>>>> +	}
>>>> -- 
>>>> 1.9.1
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> .
>>>
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

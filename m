From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: Document the hi3660 thermal sensor
 bindings
Date: Mon, 4 Sep 2017 12:36:25 +0200
Message-ID: <4416373c-5269-d201-7db7-3fb39cc423a0@linaro.org>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
 <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1503994666-13954-2-git-send-email-kevin.wangtao@hisilicon.com>
 <d56428a6-ef27-4424-3ce5-4610fef3ac15@linaro.org>
 <38fdf052-97be-1b54-5e7d-9dd0bc11e9b4@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <38fdf052-97be-1b54-5e7d-9dd0bc11e9b4-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wangtao (Kevin, Kirin)" <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sunzhaosheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, gengyanping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 04/09/2017 08:39, Wangtao (Kevin, Kirin) wrote:
> 
> 
> 在 2017/9/1 2:24, Daniel Lezcano 写道:
>> On 29/08/2017 10:17, Tao Wang wrote:
>>> From: Tao Wang <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>
>>> This adds documentation of device tree bindings for the
>>> thermal sensor controller of hi3660 SoC.
>>>
>>> Signed-off-by: Tao Wang <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> ---
>>>   .../devicetree/bindings/thermal/hisi-tsensor.txt   | 37
>>> ++++++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>>> b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>>> new file mode 100644
>>> index 0000000..4643dbe
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
>>> @@ -0,0 +1,37 @@
>>> +* Temperature Sensor on hisilicon SoC
>>> +
>>> +Hisilicon SoC supplies temperature sensor feature, each CPU cluster
>>> and G3D
>>> +area contains a temperture sensor. The temperture sensor produces an
>>> output
>>> +value which has a linear relationship with the temperture of the area.
>>> +
>>
>> s/temperture/temperature/
> THX
>>
>>> +for Hi3660,
>>> +sensor0 monitors the temperture of A53;
>>> +sensor1 monitors the temperture of A72;
>>> +sensor2 monitors the temperture of GPU;
>>> +sensor3 is a virtual sensor, which produces the maximum value of all
>>> sensors;
>>> +sensor4 is a virtual sensor, which produces the average value of all
>>> sensors.
>>
>> I don't think we need to escribe the virtual sensors in the DT bindings.
> I just want to let user know the sensor id of virtual sensor, I also
> define it in header file, so the header file is enough?

The virtual sensor (or something else) should be a separate, generic
thing to be used for anyone.

>>> +** Required properties :
>>> +- compatible: "hisilicon,thermal-tsensor".
>>> +- reg: physical reg address of thermal sensor and length of memory
>>> mapped
>>> +  region.
>>> +- hisi,tsensors: number of hardware tsensors
>>> +- hisi,coef:    An array of integers (one signed cell) containing
>>> +        coefficients to turn adc value to temperture.
>>> +- hisi,adc-range: adc value range, minimum value is followed by
>>> maximum value.
>>> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a
>>> description.
>>> +
>>> +Example :
>>> +Hi3660:
>>> +tsensor: tsensor@fff30000 {
>>> +    compatible = "hisilicon,hi3660-tsensor";
>>> +    #address-cells = <2>;
>>> +    #size-cells = <2>;
>>> +    reg = <0x0 0xfff3001c 0x0 0x4>,
>>> +        <0x0 0xfff3005c 0x0 0x4>,
>>> +        <0x0 0xfff3009c 0x0 0x4>;
>>> +    hisi,tsensors = <HISI_MAX_TSENSORS>;
>>> +    hisi,coef = <165000 (-40000)>;
>>> +    hisi,adc-range = <0x74 0x39A>;
>>
>> Do we really need max sensors, coef and adc range to be specified in
>> the DT?
>>
>> Can't we assume the hi3660-tsensor has 3 sensors, and hard-code the
>> coef, adc, in the driver itself?
> My purpose is to make the driver be compitable with our future platform.

I don't see the point. The compatibility could be handled in the driver
itself, no?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

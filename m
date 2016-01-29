From: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] devicetree: Add UCS1002 USB Port Power Controller binding
Date: Fri, 29 Jan 2016 07:33:52 +0100
Message-ID: <CAFqH_52ZsWNfxwrfTMreG1u19Eu=0oMA09S2TStm4zjGJNi9Lw@mail.gmail.com>
References: <1453799541-5445-1-git-send-email-enric.balletbo@collabora.com>
	<1453799541-5445-2-git-send-email-enric.balletbo@collabora.com>
	<20160129023539.GA3092@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160129023539.GA3092@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Martyn Welch <martyn.welch-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

Thanks for the review.

2016-01-29 3:35 GMT+01:00 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Tue, Jan 26, 2016 at 10:12:20AM +0100, Enric Balletbo i Serra wrote:
>> The UCS1002-2 provides a USB port power switch for precise control of up
>> to 2.5 amperes continuous current.
>>
>> You can add support to your board with current binding.
>>
>> Example:
>>
>>     ucs1002: ucs1002@57 {
>>              compatible = "microchip,ucs1002";
>>              reg = <0x57>;
>>              microchip,pin-ignore;
>>     };
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> ---
>>  .../devicetree/bindings/power/ucs1002.txt          | 47 ++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/ucs1002.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/ucs1002.txt b/Documentation/devicetree/bindings/power/ucs1002.txt
>> new file mode 100644
>> index 0000000..1b89f0a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/ucs1002.txt
>> @@ -0,0 +1,47 @@
>> +UCS1002-2 Programmable USB Port Power Controller with Charger Emulation bindings
>> +
>> +Required properties:
>> +- compatible: "microchip,ucs1002"
>> +- reg: integer, the I2C address of the device.
>> +
>> +Required properties (if pin-ignore functionality is not set):
>> +- em-gpios: which GPIO to use for EM_EN pin.
>> +- pwr-gpios: which GPIO to use for PWR_EN pin.
>> +- m1-gpios: which GPIO to use for M1 pin.
>> +- m2-gpios: which GPIO to use for M2 pin.
>> +
>> +Optional properties:
>> +- interrupt-parent: the phandle of the interrupt controller that services
>> +    interrupts for this device.
>> +- interrupts: interrupt specifiers for two interrupt sources.
>> +    - First interrupt specifier is for A_DET interrupt.
>> +    - Second interrupt specifier is for ALERT interrupt.
>> +- microchip,current-limit: integer, maximum current in mA. Note that the default
>
> mA or ...
>
>> +    value is based on the resistor on the COMM_SEL/ILIM pin and this value cannot
>> +    be changed to be higher than hardware set value. Accepted values are: 500000,
>> +    900000, 1000000, 1200000, 1500000, 1800000, 2000000, 2500000 (uA)
>
> uA?
>
> Either way append units (-microamps)
>

Right, should be  microamps, will change in next version

>> +- microchip,pin-ignore: boolean, if present uses I2C for configuration, otherwise,
>> +    we must provide EM_EN, M1 and M2 gpio mapping.
>
> Wouldn't this be implied by absence of gpio properties?
>

Yes, would you prefer I get rid of this propriety and simply check if
gpio properties are absence or not in the driver ?

In such case I'll do in next version.

>> +
>> +Example (poll):
>> +
>> +     ucs1002: ucs1002@57 {
>> +             compatible = "microchip,ucs1002";
>> +             reg = <0x57>;
>> +             microchip,current-limit = <2000000>;
>> +             microchip,pin-ignore;
>> +     };
>> +
>> +Example (interrupts + pin control):
>> +
>> +     ucs1002: ucs1002@57 {
>> +             compatible = "microchip,ucs1002";
>> +             reg = <0x57>;
>> +             interrupt-parent = <&gpio0>;
>> +             interrupts = <30 0>, <31 0>;
>> +             microchip,current-limit = <2000000>;
>> +             em-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
>> +             m1-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
>> +             m2-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
>> +             pwr-gpios = <&gpio1 19 0>;
>> +     };
>> --
>> 2.1.0
>>

Best regards,
Enric
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

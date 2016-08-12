From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: imx6q-evi: Fix onboard hub reset line
Date: Fri, 12 Aug 2016 08:20:06 -0700
Message-ID: <57ADE926.8070703@gmail.com>
References: <20160810030254.GD1879@shlinux2>
 <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
 <1470933632-22133-4-git-send-email-stillcompiling@gmail.com>
 <20160812031158.GH18967@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160812031158.GH18967@shlinux2>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw3-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Peter,

On 08/11/2016 08:11 PM, Peter Chen wrote:
> On Thu, Aug 11, 2016 at 09:40:32AM -0700, Joshua Clayton wrote:
>> Previously the onboard hub was made to work by treating its
>> reset gpio as a regulator enable.
>> Get rid of that kludge now that pwseq has added reset gpio support
>> Move pin muxing the hub reset pin into the usbh1 group
>>
>> Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/imx6q-evi.dts | 25 +++++++------------------
>>  1 file changed, 7 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
>> index 4fa5601..49c6f61 100644
>> --- a/arch/arm/boot/dts/imx6q-evi.dts
>> +++ b/arch/arm/boot/dts/imx6q-evi.dts
>> @@ -54,18 +54,6 @@
>>  		reg = <0x10000000 0x40000000>;
>>  	};
>>  
>> -	reg_usbh1_vbus: regulator-usbhubreset {
>> -		compatible = "regulator-fixed";
>> -		regulator-name = "usbh1_vbus";
>> -		regulator-min-microvolt = <5000000>;
>> -		regulator-max-microvolt = <5000000>;
>> -		enable-active-high;
>> -		startup-delay-us = <2>;
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&pinctrl_usbh1_hubreset>;
>> -		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
>> -	};
>> -
>>  	reg_usb_otg_vbus: regulator-usbotgvbus {
>>  		compatible = "regulator-fixed";
>>  		regulator-name = "usb_otg_vbus";
>> @@ -204,12 +192,18 @@
>>  };
>>  
>>  &usbh1 {
>> -	vbus-supply = <&reg_usbh1_vbus>;
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usbh1>;
>>  	dr_mode = "host";
>>  	disable-over-current;
>>  	status = "okay";
>> +
>> +	usb2415host: hub@1 {
>> +		compatible = "usb424,2513";
>> +		reg = <1>;
>> +		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>> +		reset-duration-us = <3000>;
>> +	};
>>  };
>>  
>>  &usbotg {
>> @@ -467,11 +461,6 @@
>>  			MX6QDL_PAD_GPIO_3__USB_H1_OC 0x1b0b0
>>  			/* usbh1_b OC */
> This comment should be for above pin, do you mind I change it in
> this patch?
Better leave it alone

I checked te schematic. GPIO_0 (below that line) is indeed
connected to a second OC detect line for a second
usb port... It can't possibly be working as designed, but
that is how it is connected up.

I guess I need to consult with my EE colleagues
>
>>  			MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0
>> -		>;
>> -	};
>> -
>> -	pinctrl_usbh1_hubreset: usbh1hubresetgrp {
>> -		fsl,pins = <
>>  			MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x1b0b0
>>  		>;
>>  	};
> This changes remind me that I need to change the same thing for udoo
> board.
>
Sorry I didn't think of it first.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

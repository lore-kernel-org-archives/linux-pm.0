From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v4 3/4] ARM: dts: add main Thermal info to rk3288
Date: Wed, 10 Sep 2014 10:49:05 +0800
Message-ID: <540FBC21.2090504@rock-chips.com>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com> <1409710239-19941-4-git-send-email-caesar.wang@rock-chips.com> <3426113.Zcq8V2S7cg@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:53060 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbaIJCtP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 22:49:15 -0400
In-Reply-To: <3426113.Zcq8V2S7cg@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, dmitry.torokhov@gmail.com

Hi Heiko,

=E5=9C=A8 2014=E5=B9=B409=E6=9C=8809=E6=97=A5 19:37, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Am Mittwoch, 3. September 2014, 10:10:38 schrieb Caesar Wang:
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk328=
8.dtsi
>> index 36be7bb..3d672e3 100644
>> --- a/arch/arm/boot/dts/rk3288.dtsi
>> +++ b/arch/arm/boot/dts/rk3288.dtsi
>> @@ -224,6 +224,17 @@
>>   		status =3D "disabled";
>>   	};
>>
>> +	tsadc: tsadc@ff280000 {
> please keep the list of nodes sorted by register address. So when loo=
king at
> my v3.18-next/dts branch, it should be after uart4: serial@ff1c0000 a=
nd before
> usb_host0_ehci: usb@ff500000 .
>

oh...,I will fix it.
>> +		compatible =3D "rockchip,rk3288-tsadc";
>> +		reg =3D <0xff280000 0x100>;
>> +		interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +		clock-names =3D "tsadc", "apb_pclk";
>> +		pinctrl-names =3D "default";
>> +		pinctrl-1 =3D <&tsadc_int>;
>> +		status =3D "disabled";
>> +	};
>> +
>>   	/* NOTE: ohci@ff520000 doesn't actually work on hardware */
>>
>>   	usb_hsic: usb@ff5c0000 {
>> @@ -611,5 +622,12 @@
>>   				rockchip,pins =3D <5 15 3 &pcfg_pull_none>;
>>   			};
>>   		};
>> +
>> +		tsadc {
>> +			tsadc_int: tsadc-int {
>> +				rockchip,pins =3D <0 10 RK_FUNC_1 &pcfg_pull_up>;
>> +			};
>> +		};
> After looking this up in the schematics I see that this is the
> overtemperature-protection output pin ... labeled OTP_OUT.
> So I'd think the pinconfig should reflect this pin-name, especially a=
s tsadc-int
> suggests, that this would be an interrupt leading into the tsadc, whi=
le in
> fact it is an output to a separate circuit.
>
Maybe,I guess  your mean as the follows .
Please correct it and  Laugh out if I got it wrong.

tsadc {
             otp_out: otp-out {
                 rockchip,pins =3D <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
             };

             tsadc_int: tsadc-int {
                 rockchip,pins =3D <0 10 RK_FUNC_1 &pcfg_pull_none>;
             };
         };
Then,I deal with the otp_out in thermal driver.
I believe The "otp_out" will restart board if it's a high active.

tsadc_int: tsadc-int {
+				rockchip,pins =3D <0 10 RK_FUNC_1 &pcfg_pull_up>;
+			};

But,I think the about will be implemented in thermal driver.
> Heiko
>
>
>

--=20
Best regards,
Caesar



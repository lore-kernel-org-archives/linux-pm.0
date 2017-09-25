From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [RFC PATCH 6/7] arm64: allwinner: a64: add power
 supply nodes in AXP803 DTSI
Date: Mon, 25 Sep 2017 17:14:34 +0800
Message-ID: <D7CAB179-F2AF-434F-82F7-07F146842FCF@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io> <20170920151814.22461-7-icenowy@aosc.io> <7ce5c53e-70ba-456e-ecf7-5132ef2c2c64@free-electrons.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBVESUPHAKGQEPI7CIEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <7ce5c53e-70ba-456e-ecf7-5132ef2c2c64-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org



=E4=BA=8E 2017=E5=B9=B49=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885:=
11:57, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> =E5=86=99=E5=88=
=B0:
>Hi Icenowy,
>
>On 20/09/2017 17:18, Icenowy Zheng wrote:
>> AXP803 PMIC features AC/USB/Battery power supplies.
>>=20
>> As we have now the device tree bindings for them, add device tree
>> nodes for them.
>>=20
>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>> ---
>>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi
>b/arch/arm64/boot/dts/allwinner/axp803.dtsi
>> index ff8af52743ff..3a8615231b7c 100644
>> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
>> @@ -49,6 +49,16 @@
>>  	interrupt-controller;
>>  	#interrupt-cells =3D <1>;
>> =20
>> +	ac_power_supply: ac-power-supply {
>> +		compatible =3D "x-powers,axp221-ac-power-supply";
>> +		status =3D "disabled";
>> +	};
>> +
>> +	battery_power_supply: battery-power-supply {
>> +		compatible =3D "x-powers,axp803-battery-power-supply";
>> +		status =3D "disabled";
>> +	};
>> +
>>  	regulators {
>>  		/* Default work frequency for buck regulators */
>>  		x-powers,dcdc-freq =3D <3000>;
>> @@ -147,4 +157,9 @@
>>  			regulator-name =3D "rtc-ldo";
>>  		};
>>  	};
>> +
>> +	usb_power_supply: usb_power_supply {
>> +		compatible =3D "x-powers,axp803-usb-power-supply";
>> +		status =3D "disabled";
>> +	};
>
>No. You have added support for the AC and battery power supply drivers
>in this patchset, not for USB.

But I added its device tree binding.

>
>Quentin

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

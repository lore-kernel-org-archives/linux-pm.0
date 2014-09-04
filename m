From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
Date: Thu, 04 Sep 2014 09:02:08 +0800
Message-ID: <5407BA10.2030402@rock-chips.com>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com> <1409710239-19941-3-git-send-email-caesar.wang@rock-chips.com> <11280986.L6lv82O8Qv@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11280986.L6lv82O8Qv@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, dmitry.torokhov@gmail.com, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org


=E5=9C=A8 2014=E5=B9=B409=E6=9C=8803=E6=97=A5 16:07, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Am Mittwoch, 3. September 2014, 10:10:37 schrieb Caesar Wang:
>> This add the necessary binding documentation for the thermal
>> found on Rockchip SoCs
>>
>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   .../devicetree/bindings/thermal/rockchip-thermal.txt | 20
>> ++++++++++++++++++++ 1 file changed, 20 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt new=
 file
>> mode 100644
>> index 0000000..1ed4d4c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -0,0 +1,20 @@
>> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
>> +
>> +Required properties:
>> +- compatible: "rockchip,rk3288-tsadc"
>> +- reg: physical base address of the controller and length of memory=
 mapped
>> +       region.
>> +- interrupts: The interrupt number to the cpu. The interrupt specif=
ier
>> format +	      depends on the interrupt controller.
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +- clock-names: Shall be "tsadc" for the converter-clock, and "apb_p=
clk" for
>> +	       the peripheral clock.
> You're using the passive-temp, critical-temp and force-shut-temp prop=
erties in
> your driver without declaring them here.

frankly,the about are need be declared. but  there are 4 types[0] for=20
trip in thermal framework,
there is no force-shut for me. So I want to change it three additional=20
properties in [PATCH V4 4/4],


[0]
{
     THERMAL_TRIP_CRITICAL,
     THERMAL_TRIP_HOT,
     THERMAL_TRIP_PASSIVE,
     THERMAL_TRIP_ACTIVE,
}

> But more importantly, please use the generic trip-points for this. I =
guess it
> shouldn't be a problem to introduce a "forced-shutdown" trippoint [0]=
 for the
> additional trip-point you have - thermal maintainers, please shout if=
 I'm
> wrong :-)

It's a good option.
I can send a patch,but I don't know whether the thermal maintainers wil=
l=20
accept it.

Maybe,they have a better way to suggest it.:-)


PS:I will sent a new patch If I still have no received their suggestion=
s=20
in two days.

>
> Heiko
>
>
> [0] in a separate patch, changing
> - thermal_trip_type enum in include/linux/thermal.h
> - trip_types mapping in drivers/thermal/of-thermal.c
> - Documentation/devicetree/bindings/thermal/thermal.txt
>
>> +
>> +Example:
>> +tsadc: tsadc@ff280000 {
>> +	compatible =3D "rockchip,rk3288-tsadc";
>> +	reg =3D <0xff280000 0x100>;
>> +	interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +	clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +	clock-names =3D "tsadc", "apb_pclk";
>> +};
>
>
>

--=20
Best regards,
Caesar

From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: document Rockchip thermal
Date: Thu, 18 Sep 2014 21:25:44 +0800
Message-ID: <541ADD58.7070901@rock-chips.com>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com> <1410926353-15674-3-git-send-email-caesar.wang@rock-chips.com> <CAAObsKA61Ano85P6PehOY7WqR0FgTz_Rfur8UAt56ZXoNyoyqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:36244 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbaIRNZx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Sep 2014 09:25:53 -0400
In-Reply-To: <CAAObsKA61Ano85P6PehOY7WqR0FgTz_Rfur8UAt56ZXoNyoyqQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, dmitry.torokhov@gmail.com, addy.ke@rock-chips.com, zyf@rock-chips.com, cjf@rock-chips.com

Tomeu,

=E5=9C=A8 2014=E5=B9=B409=E6=9C=8818=E6=97=A5 17:27, Tomeu Vizoso =E5=86=
=99=E9=81=93:
> On 17 September 2014 05:59, Caesar Wang <caesar.wang@rock-chips.com> =
wrote:
>> This add the necessary binding documentation for the thermal
>> found on Rockchip SoCs
> Hi Caesar,
>
> is there any reason to not use the existing thermal bindings? You can
> find a description in
> Documentation/devicetree/bindings/thermal/thermal.txt and example cod=
e
> in omap, or in the patches for Tegra recently posted by Mikko
> Perttunen.
>
> Regards,
>
> Tomeu

Why should I use the existing thermal bindings?
I believe omap,tegar and rockchip are  the three seperate thermals driv=
er.

So far, I submitted the series Patchs for rockchip thermal.
>
>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   .../bindings/thermal/rockchip-thermal.txt          | 41 ++++++++++=
++++++++++++
>>   1 file changed, 41 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/rockc=
hip-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.tx=
t
>> new file mode 100644
>> index 0000000..6fc8bc3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -0,0 +1,41 @@
>> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
>> +
>> +Required properties:
>> +- compatible: "rockchip,rk3288-tsadc"
>> +- reg: physical base address of the controller and length of memory=
 mapped
>> +       region.
>> +- interrupts: The interrupt number to the cpu. The interrupt specif=
ier format
>> +             depends on the interrupt controller.
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +- clock-names: Shall be "tsadc" for the converter-clock, and "apb_p=
clk" for
>> +              the peripheral clock.
>> +- num-trips:  number of total trip points, this is required, set it=
 0 if none,
>> +             if greater than 0, the following properties must be de=
fined;
>> +- tripN-temp: temperature of trip point N, should be in ascending o=
rder;
>> +- tripN-type: type of trip point N, should be one of "active" "pass=
ive" "hot"
>> +             "critical";
>> +- tripN-cdev-num: number of the cooling devices which can be bound =
to trip
>> +                 point N, this is required if trip point N is defin=
ed, set it 0 if none,
>> +                 otherwise the following cooling device names must =
be defined;
>> +- tripN-cdev-nameM: name of the No. M cooling device of trip point =
N;
>> +
>> +Example:
>> +tsadc: tsadc@ff280000 {
>> +       compatible =3D "rockchip,rk3288-tsadc";
>> +       reg =3D <0xff280000 0x100>;
>> +       interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +       clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +       clock-names =3D "tsadc", "apb_pclk";
>> +
>> +       num-trips =3D <2>;
>> +
>> +       trip0-temp =3D <80>;
>> +       trip0-type =3D "passive";
>> +       trip0-cdev-num =3D <1>;
>> +       trip0-cdev-name0 =3D "thermal-cpufreq-0";
>> +
>> +       trip1-temp =3D <100>;
>> +       trip1-type =3D "critical";
>> +       trip1-cdev-num =3D <1>;
>> +       trip1-cdev-name0 =3D "thermal-cpufreq-0";
>> +};
>> --
>> 1.9.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Best regards,
Caesar



From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v16 2/5] dt-bindings: document Rockchip thermal
Date: Fri, 31 Oct 2014 08:44:25 +0800
Message-ID: <5452DB69.8030208@rock-chips.com>
References: <1414549959-13699-1-git-send-email-caesar.wang@rock-chips.com> <1414549959-13699-3-git-send-email-caesar.wang@rock-chips.com> <1823150.6k52MgLRcZ@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:45421 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161353AbaJaAoi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 20:44:38 -0400
In-Reply-To: <1823150.6k52MgLRcZ@phil>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: rui.zhang@intel.com, edubezval@gmail.com, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com

Heiko,

=E5=9C=A8 2014=E5=B9=B410=E6=9C=8831=E6=97=A5 04:17, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Am Mittwoch, 29. Oktober 2014, 10:32:36 schrieb Caesar Wang:
>> This add the necessary binding documentation for the thermal
>> found on Rockchip SoCs
>>
>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>   .../bindings/thermal/rockchip-thermal.txt          | 62
>> ++++++++++++++++++++++ 1 file changed, 62 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt new=
 file
>> mode 100644
>> index 0000000..3061982
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -0,0 +1,62 @@
>> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
>> +
>> +Required properties:
>> +- compatible : "rockchip,rk3288-tsadc"
>> +- reg : physical base address of the controller and length of memor=
y mapped
>> +	region.
>> +- interrupts : The interrupt number to the cpu. The interrupt speci=
fier
>> format +	       depends on the interrupt controller.
>> +- clocks : Must contain an entry for each entry in clock-names.
>> +- clock-names : Shall be "tsadc" for the converter-clock, and "apb_=
pclk"
>> for +		the peripheral clock.
>> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a desc=
ription.
>> +- hw-shut-temp : The hardware-controlled shutdown temperature value=
=2E +-
>> tsadc-tshut-mode : The hardware-controlled shutdown mode 0:CRU 1:GPI=
O. +-
>> tsadc-tshut-polarity : The hardware-controlled active polarity 0:LOW
>> 1:HIGH. +
>> +Exiample:
>> +tsadc: tsadc@ff280000 {
>> +	compatible =3D "rockchip,rk3288-tsadc";
>> +	reg =3D <0xff280000 0x100>;
>> +	interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +	clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +	clock-names =3D "tsadc", "apb_pclk";
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&otp_out>;
>> +	#thermal-sensor-cells =3D <1>;
>> +	hw-shut-temp =3D <125000>;
>> +	tsadc-tshut-mode =3D <0>;
>> +	tsadc-tshut-polarity =3D <0>;
> these last 3 seem to be specific to this tsadc so should probably hav=
e a
> "rockchip,"-prefix

=46ixed.

e.g  sync to driver

rockchip,hw-shut-temp =3D <125000>;
rockchip,tsadc-tshut-mode =3D <0>;
rockchip,tsadc-tshut-polarity =3D <0>;



I will sent next patch  v17 in 1-2 days if this series patchs haven't=20
any problems.

Thanks.

>
>
>
>

--=20
Best regards,
Caesar



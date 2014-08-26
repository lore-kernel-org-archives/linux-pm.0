From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH 1/2] dt-bindings: document Rockchip thermal
Date: Tue, 26 Aug 2014 08:50:12 +0800
Message-ID: <53FBD9C4.3010309@rock-chips.com>
References: <1408752934-18318-1-git-send-email-caesar.wang@rock-chips.com> <1408752934-18318-2-git-send-email-caesar.wang@rock-chips.com> <1504889.nDzfjZj9xp@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1504889.nDzfjZj9xp@diego>
Sender: linux-doc-owner@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: rui.zhang@intel.com, rdunlap@infradead.org, cf@rock-chips.com, grant.likely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, zyw@rock-chips.com, huangtao@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com, dianders@chromium.org, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hi Heiko,

=E5=9C=A8 2014=E5=B9=B408=E6=9C=8824=E6=97=A5 07:03, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Hi Caesar,
>
> Am Samstag, 23. August 2014, 08:15:33 schrieb Caesar Wang:
>> This add the necessary binding documentation for the thermal
>> found on Rockchip SoCs
>>
>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   .../bindings/thermal/rockchip-thermal.txt          |   33
>> ++++++++++++++++++++ 1 file changed, 33 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt new=
 file
>> mode 100644
>> index 0000000..b556eae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -0,0 +1,33 @@
>> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
>> +
>> +Required properties:
>> +- compatible : "rockchip,rk3288-tsadc"
>> +- reg : physical base address of the controller and length of memor=
y mapped
>> +  region.
>> +- interrupts : The interrupt number to the cpu. The interrupt speci=
fier
>> format +  depends on the interrupt controller.
>> +- clocks : Must contain an entry for each entry in clock-names.
>> +- clock-names : Shall be "tsadc_clk" for the transfer-clock, and
>> "tsadc_pclk" for +    the peripheral clock.
>> +Optional properties:
>> +- clock-frequency : Thermal sensor's clock frequency.
> see comment in patch2, this should probably use assigned-rate if at a=
ll
> necessary (and the assigned-rate is not necessary to document here)
>

yeah, it's necessary.

ok,I will fix it.
>> +- pinctrl-names : Should contain only one value - "default".
>> +- pinctrl-0 : Should contain only one value - &tsadc_int.
> in general pinctrl settings are just board-specific settings and do n=
ot
> need to be part of the binding documentation.
> And in this case, are you sure that the tsadc uses some pin as interr=
upt?
> Because in the TRM the TS-ADC interrupt is number 69 of the GIC itsel=
f
> and not some pin accessible via pinctrl.
>
>
>> +- passive-temp : Temperature of trip 0.
>> +- critical-temp : Temperature of trip 1.
>> +- force-shut-temp : Temperature of force shut down.
> please use the generic trip-points described in
> Documentation/devicetree/bindings/thermal/thermal.txt
> for this, instead of defining new properties
>
>
> Heiko
Ditto,
>
>> +Example:
>> +
>> +tsadc: tsadc@ff280000 {
>> +	compatible =3D "rockchip,rk3288-tsadc";
>> +	reg =3D <0xff280000 0x100>;
>> +	interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +	clock-frequency =3D <10000>;
>> +	clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +	clock-names =3D "tsadc_clk", "tsadc_pclk";
>> +	pinctrl-names =3D "default";
>> +	pinctrl-1 =3D <&tsadc_int>;
>> +	passive-temp =3D <80>;
>> +	critical-temp =3D <100>;
>> +	force-shut-temp =3D <120>;
>> +};
>
>
>

--=20
Best regards,
Caesar



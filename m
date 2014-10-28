From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v14 2/5] dt-bindings: document Rockchip thermal
Date: Tue, 28 Oct 2014 08:32:45 +0800
Message-ID: <544EE42D.3030208@rock-chips.com>
References: <1414377588-2237-1-git-send-email-caesar.wang@rock-chips.com> <1414377588-2237-3-git-send-email-caesar.wang@rock-chips.com> <20141028002915.GJ7594@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:59440 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbaJ1Acx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 20:32:53 -0400
In-Reply-To: <20141028002915.GJ7594@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com

Dmitry,

=E5=9C=A8 2014=E5=B9=B410=E6=9C=8828=E6=97=A5 08:29, Dmitry Torokhov =E5=
=86=99=E9=81=93:
> On Mon, Oct 27, 2014 at 10:39:45AM +0800, Caesar Wang wrote:
>> This add the necessary binding documentation for the thermal
>> found on Rockchip SoCs
>>
>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   .../bindings/thermal/rockchip-thermal.txt          | 53 ++++++++++=
++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/rockc=
hip-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.tx=
t
>> new file mode 100644
>> index 0000000..d5b1401
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -0,0 +1,53 @@
>> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
>> +
>> +Required properties:
>> +- compatible : "rockchip,rk3288-tsadc"
>> +- reg : physical base address of the controller and length of memor=
y mapped
>> +	region.
>> +- interrupts : The interrupt number to the cpu. The interrupt speci=
fier format
>> +	       depends on the interrupt controller.
>> +- clocks : Must contain an entry for each entry in clock-names.
>> +- clock-names : Shall be "tsadc" for the converter-clock, and "apb_=
pclk" for
>> +		the peripheral clock.
>> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a desc=
ription.
> I think you are missing description of hw-shut-temp, tsadc-tshut-mode
> and tsadc-tshut-mode
>   and optional pinctrl settings.

If it's really need,we just have hw-shut-temp,tsadc-tshut-mode
and tsadc-tshut-mode,no need  pinctrl setting,I think.

>> +
>> +Exiample:
>> +tsadc: tsadc@ff280000 {
>> +	compatible =3D "rockchip,rk3288-tsadc";
>> +	reg =3D <0xff280000 0x100>;
>> +	interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +	clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +	clock-names =3D "tsadc", "apb_pclk";
>> +};
>> +
>> +Example: referring to thermal sensors:
>> +thermal-zones {
>> +	cpu_thermal: cpu_thermal {
>> +		polling-delay-passive =3D <1000>; /* milliseconds */
>> +		polling-delay =3D <5000>; /* milliseconds */
>> +
>> +		/* sensor	ID */
>> +		thermal-sensors =3D <&tsadc	1>;
>> +
>> +		trips {
>> +			cpu_alert0: cpu_alert {
>> +				temperature =3D <80000>; /* millicelsius */
>> +				hysteresis =3D <2000>; /* millicelsius */
>> +				type =3D "passive";
>> +			};
>> +			cpu_crit: cpu_crit {
>> +				temperature =3D <120000>; /* millicelsius */
>> +				hysteresis =3D <2000>; /* millicelsius */
>> +				type =3D "critical";
>> +			};
>> +		};
>> +
>> +		cooling-maps {
>> +			map0 {
>> +				trip =3D <&cpu_alert0>;
>> +				cooling-device =3D
>> +					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +			};
>> +		};
>> +	};
>> +};
>> --=20
>> 1.9.1
>>
>>

--=20
Best regards,
Caesar



From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v15 2/5] dt-bindings: document Rockchip thermal
Date: Wed, 29 Oct 2014 11:02:47 +0800
Message-ID: <545058D7.8020302@rock-chips.com>
References: <1414486287-25498-1-git-send-email-caesar.wang@rock-chips.com> <1414486287-25498-3-git-send-email-caesar.wang@rock-chips.com> <20141028234624.GD19675@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141028234624.GD19675@dtor-ws>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com
List-Id: linux-pm@vger.kernel.org


=E5=9C=A8 2014=E5=B9=B410=E6=9C=8829=E6=97=A5 07:46, Dmitry Torokhov =E5=
=86=99=E9=81=93:
> On Tue, Oct 28, 2014 at 04:51:24PM +0800, Caesar Wang wrote:
>> This add the necessary binding documentation for the thermal
>> found on Rockchip SoCs
>>
>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Added.

Thank you!
>
>> ---
>>   .../bindings/thermal/rockchip-thermal.txt          | 62 ++++++++++=
++++++++++++
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/rockc=
hip-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.tx=
t
>> new file mode 100644
>> index 0000000..fc30e1b
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
fier format
>> +	       depends on the interrupt controller.
>> +- clocks : Must contain an entry for each entry in clock-names.
>> +- clock-names : Shall be "tsadc" for the converter-clock, and "apb_=
pclk" for
>> +		the peripheral clock.
>> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a desc=
ription.
>> +- hw-shut-temp : The hardware-controlled shutdown temperature value=
=2E
>> +- tsadc-tshut-mode : The hardware-controlled shutdown mode 0:CRU 1:=
GPIO.
>> +- tsadc-tshut-polarity : The hardware-controlled active polarity 0:=
LOW 1:HIGH.
>> +
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



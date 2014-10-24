From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v13 4/5] ARM: dts: add main Thermal info to rk3288
Date: Fri, 24 Oct 2014 10:06:43 +0800
Message-ID: <5449B433.5040003@rock-chips.com>
References: <1414057207-1576-1-git-send-email-caesar.wang@rock-chips.com> <1414057207-1576-5-git-send-email-caesar.wang@rock-chips.com> <20141024004625.GD9463@dtor-ws> <5449A6A4.3070608@rock-chips.com> <E4EEE800-5701-45E5-9E97-D3B036DC2F17@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <E4EEE800-5701-45E5-9E97-D3B036DC2F17@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com
List-Id: linux-pm@vger.kernel.org


=E5=9C=A8 2014/10/24 9:37, Dmitry Torokhov =E5=86=99=E9=81=93:
> On October 23, 2014 6:08:52 PM PDT, Caesar Wang <caesar.wang@rock-chi=
ps.com> wrote:
>> Dmitry,
>>
>> =E5=9C=A8 2014/10/24 8:46, Dmitry Torokhov =E5=86=99=E9=81=93:
>>> Hi Caesar,
>>>
>>> On Thu, Oct 23, 2014 at 05:40:06PM +0800, Caesar Wang wrote:
>>>> This patch is depend on rk3288-thermal.dtsi,or
>>>> it will compile error.
>>>>
>>>> If the temperature over a period of time High,over 120C
>>>> the resulting TSHUT gave CRU module,let it reset
>>>> the entire chip,or via GPIO give PMIC.
>>>>
>>>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>>>> ---
>>>>    arch/arm/boot/dts/rk3288.dtsi | 21 +++++++++++++++++++++
>>>>    1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/rk3288.dtsi
>> b/arch/arm/boot/dts/rk3288.dtsi
>>>> index cb18bb4..85fc17a 100644
>>>> --- a/arch/arm/boot/dts/rk3288.dtsi
>>>> +++ b/arch/arm/boot/dts/rk3288.dtsi
>>>> @@ -15,6 +15,7 @@
>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>    #include <dt-bindings/pinctrl/rockchip.h>
>>>>    #include <dt-bindings/clock/rk3288-cru.h>
>>>> +#include <dt-bindings/thermal/thermal.h>
>>>>    #include "skeleton.dtsi"
>>>>   =20
>>>>    / {
>>>> @@ -66,6 +67,7 @@
>>>>    				 216000  900000
>>>>    				 126000  900000
>>>>    			>;
>>>> +			#cooling-cells =3D <2>; /* min followed by max */
>>>>    			clock-latency =3D <40000>;
>>>>    			clocks =3D <&cru ARMCLK>;
>>>>    		};
>>>> @@ -346,6 +348,19 @@
>>>>    		status =3D "disabled";
>>>>    	};
>>>>   =20
>>>> +	tsadc: tsadc@ff280000 {
>>>> +		compatible =3D "rockchip,rk3288-tsadc";
>>>> +		reg =3D <0xff280000 0x100>;
>>>> +		interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>>>> +		clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>>>> +		clock-names =3D "tsadc", "apb_pclk";
>>>> +		pinctrl-names =3D "default";
>>>> +		pinctrl-0 =3D <&otp_out>;
>>>> +		#thermal-sensor-cells =3D <1>;
>>>> +		hw-shut-temp =3D <120000>;
>>> I do not think this is a good value. You have (in the other DTS fil=
e)
>>> passive trip point at 80 and critical (which should result in order=
ly
>>> shutdown) at 125. But here you define hardware-controlled shutdown =
at
>>> 120C, which is backwards. You should have:
>>>
>>> passive <=3D critical <=3D hardware
>> Hmmm....
>> but, the system will shutdown when temperature over critial value,
>> there is no chance of triggering the TSHUT.
>>
>> If the temperature over a period of time High,as we know,
>> the resulting TSHUT gave CRU module,let it hot-reset the entire chip=
,
>> or via GPIO give PMIC cold-reset the entire chip.
> Having tshut trigger is not the goal, tshut is the measure of last re=
sort. If we can handle thermal conditions without triggering tshut, we =
achieved our goal.
>
> Tshut triggering is " oh, crap, nothing we tried works" scenario.

I don't think so.

In general,We should have:
passive <=3D hardware(reset entire chip) <=3D critical(shutdown)

The temperature be rising qulckly if have some other conditions,
the "critical" will play a role.

Agreed?


>
> Thanks.
>

--=20
Best regards,
Caesar



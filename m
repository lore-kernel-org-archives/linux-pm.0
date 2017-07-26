From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH 10/10] ARM: dts: sun8i: Add SY8106A
 regulator to Orange Pi PC
Date: Wed, 26 Jul 2017 15:30:13 +0800
Message-ID: <CAGb2v64xXOmC44TKrSDZFAh6i_rgFEccCHj4EG+1fxFJd9fjjw@mail.gmail.com>
References: <20170723102749.17323-1-icenowy@aosc.io> <20170723102749.17323-11-icenowy@aosc.io>
 <CAGb2v66AGjazHT-+hWVLyNBLDw=DJ5yTmNxF-_=BtZFfjnni-A@mail.gmail.com> <25C8A89C-8495-4787-934C-8E9667CD70BF@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25C8A89C-8495-4787-934C-8E9667CD70BF@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Ondrej Jirman <megous@megous.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 26, 2017 at 3:16 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> 于 2017年7月26日 GMT+08:00 下午3:08:06, Chen-Yu Tsai <wens@csie.org> 写到:
>>On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>> From: Ondrej Jirman <megous@megous.com>
>>>
>>> Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
>>> Orange Pi PC, then set the power supply of the ARM cores to this
>>> regulator, in order to enable DVFS.
>>>
>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>>> [Icenowy: Enable DVFS in this patch, slight changes and change commit
>>>  message]
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>> index 998b60f8d295..d855f8b6254e 100644
>>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>> @@ -98,6 +98,10 @@
>>>         status = "okay";
>>>  };
>>>
>>> +&cpu0 {
>>> +       cpu-supply = <&reg_sy8106a>;
>>> +};
>>> +
>>>  &ehci0 {
>>>         status = "okay";
>>>  };
>>> @@ -160,6 +164,21 @@
>>>         };
>>>  };
>>>
>>> +&r_i2c {
>>> +       status = "okay";
>>> +
>>> +       reg_sy8106a: regulator@65 {
>>> +               compatible = "silergy,sy8106a";
>>> +               reg = <0x65>;
>>> +               regulator-name = "vdd-cpux";
>>> +               regulator-min-microvolt = <1000000>;
>>
>>According to the H3 datasheet, the minimum voltage is 1.1V, not 1V.
>
> But the Armbian OPP table for H3 contains several
> OPP under 1.1V...

Can you provide a link?

If Armbian users have actually field tested this (a big if),
then I would like to see some evidence of the SoC running
stably at those OPPs with those lower voltages under full load.

Even then you should still leave a note describing why we allow
voltages below the recommended range.

ChenYu

>
>>
>>Otherwse
>>
>>> +               regulator-max-microvolt = <1400000>;
>>> +               regulator-ramp-delay = <200>;
>>
>>Is this an actual constraint of the SoC? Or is it a characteristic
>>of the regulator? If it is the latter, it belongs in the driver.
>>AFAIK the regulator supports varying the ramp delay (slew rate).
>>
>>ChenYu
>>
>>> +               regulator-boot-on;
>>> +               regulator-always-on;
>>> +       };
>>> +};
>>> +
>>>  &r_pio {
>>>         leds_r_opc: led_pins@0 {
>>>                 pins = "PL10";
>>> --
>>> 2.13.0
>>>

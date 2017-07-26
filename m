From: Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [linux-sunxi] [PATCH 10/10] ARM: dts: sun8i: Add SY8106A regulator to Orange Pi PC
Date: Wed, 26 Jul 2017 15:16:16 +0800
Message-ID: <25C8A89C-8495-4787-934C-8E9667CD70BF@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io> <20170723102749.17323-11-icenowy@aosc.io> <CAGb2v66AGjazHT-+hWVLyNBLDw=DJ5yTmNxF-_=BtZFfjnni-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:52060 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbdGZHQ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jul 2017 03:16:29 -0400
In-Reply-To: <CAGb2v66AGjazHT-+hWVLyNBLDw=DJ5yTmNxF-_=BtZFfjnni-A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Ondrej Jirman <megous@megous.com>



于 2017年7月26日 GMT+08:00 下午3:08:06, Chen-Yu Tsai <wens@csie.org> 写到:
>On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> From: Ondrej Jirman <megous@megous.com>
>>
>> Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
>> Orange Pi PC, then set the power supply of the ARM cores to this
>> regulator, in order to enable DVFS.
>>
>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>> [Icenowy: Enable DVFS in this patch, slight changes and change commit
>>  message]
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>> index 998b60f8d295..d855f8b6254e 100644
>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>> @@ -98,6 +98,10 @@
>>         status = "okay";
>>  };
>>
>> +&cpu0 {
>> +       cpu-supply = <&reg_sy8106a>;
>> +};
>> +
>>  &ehci0 {
>>         status = "okay";
>>  };
>> @@ -160,6 +164,21 @@
>>         };
>>  };
>>
>> +&r_i2c {
>> +       status = "okay";
>> +
>> +       reg_sy8106a: regulator@65 {
>> +               compatible = "silergy,sy8106a";
>> +               reg = <0x65>;
>> +               regulator-name = "vdd-cpux";
>> +               regulator-min-microvolt = <1000000>;
>
>According to the H3 datasheet, the minimum voltage is 1.1V, not 1V.

But the Armbian OPP table for H3 contains several
OPP under 1.1V...

>
>Otherwse
>
>> +               regulator-max-microvolt = <1400000>;
>> +               regulator-ramp-delay = <200>;
>
>Is this an actual constraint of the SoC? Or is it a characteristic
>of the regulator? If it is the latter, it belongs in the driver.
>AFAIK the regulator supports varying the ramp delay (slew rate).
>
>ChenYu
>
>> +               regulator-boot-on;
>> +               regulator-always-on;
>> +       };
>> +};
>> +
>>  &r_pio {
>>         leds_r_opc: led_pins@0 {
>>                 pins = "PL10";
>> --
>> 2.13.0
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.

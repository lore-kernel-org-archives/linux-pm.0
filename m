From: Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 4/5] ARM: sun8i: h3: add operating-points-v2 table for CPU
Date: Mon, 17 Apr 2017 05:00:00 +0800
Message-ID: <40F4D1F2-EA59-4BD1-9A00-4C0AA7FED9D3@aosc.io>
References: <20170408185025.53841-1-icenowy@aosc.io> <20170408185025.53841-5-icenowy@aosc.io> <20170411091346.mcwyskezadabsobn@lukather> <b37490ed1282f45542168701dea332bb@aosc.io> <20170416205740.b5pk3kcxwaegij6g@lukather>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170416205740.b5pk3kcxwaegij6g@lukather>
Sender: linux-clk-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



于 2017年4月17日 GMT+08:00 上午4:57:40, Maxime Ripard <maxime.ripard@free-electrons.com> 写到:
>On Tue, Apr 11, 2017 at 09:28:55PM +0800, icenowy@aosc.io wrote:
>> 在 2017-04-11 17:13，Maxime Ripard 写道：
>> > On Sun, Apr 09, 2017 at 02:50:24AM +0800, Icenowy Zheng wrote:
>> > > The CPU on Allwinner H3 can do dynamic frequency scaling.
>> > > 
>> > > Add a DVFS table based on the one tweaked by Armbian developers,
>which
>> > > are proven to work stably on BSP kernels.
>> > > 
>> > > Frequencies higher than 1008MHz are temporarily dropped in the
>> > > table, as
>> > > they may lead to over voltage on boards without proper regulator
>> > > settings or over temperature on boards with proper regulator
>settings.
>> > > They will be added back once regulator settings are ready and
>thermal
>> > > sensor driver is merged.
>> > > 
>> > > In order to satisfy all different regulators (SY8106A which is
>50mV
>> > > per
>> > > level, SY8113B which have two states: 1.1V and 1.3V, and some
>board
>> > > with
>> > > non-tweakable regulators), all the OPPs are defined with a range
>> > > which has
>> > > the target value as the minimum allowed value, and 1.3V (the
>highest
>> > > VDD-CPUX voltage suggested by the datasheet) as the maximum
>allowed
>> > > value.
>> > > It's proven to work well with a board with SY8113B.
>> > > 
>> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > > ---
>> > >  arch/arm/boot/dts/sun8i-h3.dtsi | 38
>> > > +++++++++++++++++++++++++++++++++++++-
>> > >  1 file changed, 37 insertions(+), 1 deletion(-)
>> > > 
>> > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
>> > > b/arch/arm/boot/dts/sun8i-h3.dtsi
>> > > index b36f9f423c39..a0cee17fe44b 100644
>> > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> > > @@ -43,32 +43,68 @@
>> > >  #include "sunxi-h3-h5.dtsi"
>> > > 
>> > >  / {
>> > > +	cpu0_opp_table: opp_table0 {
>> > > +		compatible = "operating-points-v2";
>> > > +		opp-shared;
>> > > +
>> > > +		opp@480000000 {
>> > > +			opp-hz = /bits/ 64 <480000000>;
>> > > +			opp-microvolt = <980000 980000 1300000>;
>> > > +			clock-latency-ns = <244144>; /* 8 32k periods */
>> > > +		};
>> > > +
>> > > +		opp@648000000 {
>> > > +			opp-hz = /bits/ 64 <816000000>;
>> > > +			opp-microvolt = <1020000 1020000 1300000>;
>> > > +			clock-latency-ns = <244144>; /* 8 32k periods */
>> > > +		};
>> > > +
>> > > +		opp@912000000 {
>> > > +			opp-hz = /bits/ 64 <960000000>;
>> > > +			opp-microvolt = <1080000 1080000 1300000>;
>> > > +			clock-latency-ns = <244144>; /* 8 32k periods */
>> > > +		};
>> > > +
>> > > +		opp@1008000000 {
>> > > +			opp-hz = /bits/ 64 <1008000000>;
>> > > +			opp-microvolt = <1140000 1140000 1300000>;
>> > > +			clock-latency-ns = <244144>; /* 8 32k periods */
>> > > +		};
>> > > +	};
>> > > +
>> > 
>> > From your serie, I guess you never actually tested those OPPs on
>any
>> > board without SY8113B, right?
>> 
>> Yes. But I will test them on an Orange Pi PC (newly got) soon.
>
>The orange pi pc also uses the SY8113B.

I remember in H3 Orange Pi's only One, Lite and Zero uses SY8113B, and PC is SY8106A.

>
>> (After all PLL_CPUX-related things are well fixed)
>> 
>> P.S. how to implement such a thing:
>> 
>> - Before tweaking CPUX clock, first switch it to osc24M
>>   (implemented yet)
>> - Before tweaking PLL_CPUX clock (triggered by tweaking CPUX
>>   clock), first gate it
>> - After tweaking PLL_CPUX clock, ungate it and wait it to be stable
>> - After tweaking PLL_CPUX clock, change CPUX mux back to PLL_CPUX
>>   (implemented yet)
>> 
>> I think notifiers on PLL_CPUX can be used to implement the second
>> and third part?
>
>Do you still have any issues with the code we merged?

Chen-Yu's? I tested it and it has no issue at all.

>
>Maxime

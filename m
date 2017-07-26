From: icenowy@aosc.io
Subject: Re: [linux-sunxi] [PATCH 10/10] ARM: dts: sun8i: Add SY8106A
 regulator to Orange Pi PC
Date: Wed, 26 Jul 2017 20:42:23 +0800
Message-ID: <5d25fc45c7beb2e3958f16fd741f0620@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-11-icenowy@aosc.io>
 <CAGb2v66AGjazHT-+hWVLyNBLDw=DJ5yTmNxF-_=BtZFfjnni-A@mail.gmail.com>
 <25C8A89C-8495-4787-934C-8E9667CD70BF@aosc.io>
 <CAGb2v64xXOmC44TKrSDZFAh6i_rgFEccCHj4EG+1fxFJd9fjjw@mail.gmail.com>
 <82507f40a1ddba8517cf09f51d3afa33@aosc.io>
 <1501064628.14577.1.camel@megous.com> <20170726114420.ipirqgbluqmggcjy@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:34194 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbdGZMmc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jul 2017 08:42:32 -0400
In-Reply-To: <20170726114420.ipirqgbluqmggcjy@flea>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>, devicetree <devicetree@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, wens@csie.org, Mark Brown <broonie@kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

在 2017-07-26 19:44，Maxime Ripard 写道：
> Hi,
> 
> On Wed, Jul 26, 2017 at 12:23:48PM +0200, Ondřej Jirman wrote:
>> Hi,
>> 
>> icenowy@aosc.io píše v St 26. 07. 2017 v 15:36 +0800:
>> >
>> > > > >
>> > > > > Otherwse
>> > > > >
>> > > > > > +               regulator-max-microvolt = <1400000>;
>> > > > > > +               regulator-ramp-delay = <200>;
>> > > > >
>> > > > > Is this an actual constraint of the SoC? Or is it a characteristic
>> > > > > of the regulator? If it is the latter, it belongs in the driver.
>> > > > > AFAIK the regulator supports varying the ramp delay (slew rate).
>> >
>> > I don't know...
>> >
>> > Maybe I should ask Ondrej?
>> 
>> It is probably neither.
>> 
>> It is used to calculate a delay inserted by the kernel between setting
>> a new target voltage over I2C and changing the frequency of the CPU.
>> The actual delay is calculated by the difference between previous and
>> the new voltage.
>> 
>> I don't remember seeing anything in the datasheet of the regulator.
>> This is just some low value that works.
>> 
>> It would probably be dependent on the capacitance on the output of the
>> regulator, actual load (which varies), etc. So it is a board specific
>> value. One could measure it with an oscilloscope if there's a need to
>> optimize this.
> 
> If this is a reasonable default, then this should be in the
> driver. You can't expect anyone to properly calculate a ramp delay and
> have access to both a scope and the CPU power lines.

It seems that in regulator_desc structure a default value of ramp delay
can be set, and the ones specified in dt can override it.

So just add .ramp_delay = 200 in the driver's regulator_desc part?

Should a comment be added that explains it's only an experienced value
on Allwinner H3/H5 boards VDD-CPUX usage?

> 
> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
Date: Tue, 24 Nov 2015 14:42:26 +0800
Message-ID: <CAGb2v67aS+2vM8CLB=4ynFOvb14t+kiWjJvAa60U2nq22S8ZEw@mail.gmail.com>
References: <cover.1448263428.git.atx@atx.name> <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
 <20151123124356.GW32142@lukather> <CAGb2v65qfaTdQqXHD=-FHz1M1sHCTro97QETZUH=vA2BbRS+7A@mail.gmail.com>
 <20151124063808.GB32142@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151124063808.GB32142@lukather>
Sender: linux-clk-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Josef Gajdusek <atx@atx.name>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, gpatchesrdh@mveas.com, Mike Turquette <mturquette@linaro.org>, Hans De Goede <hdegoede@redhat.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Emilio Lopez <emilio@elopez.com.ar>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 24, 2015 at 2:38 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Nov 24, 2015 at 11:13:13AM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Mon, Nov 23, 2015 at 8:43 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi,
>> >
>> > On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote:
>> >> Add a node describing the Security ID memory to the
>> >> Allwinner H3 .dtsi file.
>> >>
>> >> Signed-off-by: Josef Gajdusek <atx@atx.name>
>> >> ---
>> >>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>> >>  1 file changed, 7 insertions(+)
>> >>
>> >> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> >> index 0faa38a..58de718 100644
>> >> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> >> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> >> @@ -359,6 +359,13 @@
>> >>                       #size-cells = <0>;
>> >>               };
>> >>
>> >> +             sid: eeprom@01c14000 {
>> >> +                     compatible = "allwinner,sun4i-a10-sid";
>> >> +                     reg = <0x01c14000 0x400>;
>> >
>> > The datasheet says it's 256 bytes wide, while the size here is of 1kB,
>> > is it intentional?
>>
>> My H3 datasheet (v1.1) says its 1 kB wide.
>
> Is it? in the Security ID section, it is said to be 2kb == 256B wide.

Right. I was looking at the memory map. Maybe it's sparsely mapped?
I guess we'll know soon.

ChenYu

>> It'd be nice if Allwinner actually listed the "usable" E-fuse
>> offsets and widths, instead of having us dig through the SDK code.
>
> Yep.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

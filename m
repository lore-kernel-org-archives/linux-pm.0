From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] ARM: dts: r7s72100: Add reset handler
Date: Wed, 15 Feb 2017 10:21:19 +0100
Message-ID: <CAMuHMdWBRJeU+f_Bn9pFPU1_LRG6WHSie8a0v+_qxKftujWAzw@mail.gmail.com>
References: <20170213182532.4042-1-chris.brandt@renesas.com> <20170213182532.4042-4-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170213182532.4042-4-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 13, 2017 at 7:25 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> For the RZ/A1, the only way to do a reset is to overflow the WDT.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  arch/arm/boot/dts/r7s72100.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
> index 614ba79..6fb4ef4 100644
> --- a/arch/arm/boot/dts/r7s72100.dtsi
> +++ b/arch/arm/boot/dts/r7s72100.dtsi
> @@ -371,6 +371,11 @@
>                         <0xe8202000 0x1000>;
>         };
>
> +       wdt: timer@fcfe0000 {
> +               compatible = "renesas,r7s72100-reset", "renesas,wdt-reset";
> +               reg = <0xfcfe0000 0x6>;

No clocks property, pointing to p0_clk?
No interrupts property?
Yes, those should be documented in the bindings, too.

> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v2 2/4] ARM: shmobile: r8a7791/koelsch dts(i): Switch
 from MSTP to MSSR
Date: Tue, 29 Sep 2015 14:45:57 +0200
Message-ID: <CAMuHMdV4yJj+17uvZz7m5hyrtWnO+O56RiO8C44vPduLxm+e7Q@mail.gmail.com>
References: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
	<1442936646-30362-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1442936646-30362-3-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 22, 2015 at 5:44 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Switch from the old "renesas,cpg-mstp-clocks" bindings to the new
> "renesas,r8a7791-cpg-mssr" bindings:

[...]

>   - Change the R8A7791_CLK_* macro definitions to include the MSTP
>     register number, so the user-visible numbers match the datasheet
>     clock numbers, and pack them to avoid wasting space in sparse
>     clk_onecell_data arrays.

Apparently the packing can be handled purely inside the driver, instead of
in <dt-bindings/clock/r8a7791-clock.h>, by passing a custom variant of
of_clk_src_onecell_get() to of_clk_add_provider().

> --- a/include/dt-bindings/clock/r8a7791-clock.h
> +++ b/include/dt-bindings/clock/r8a7791-clock.h
> @@ -23,141 +23,143 @@
>  #define R8A7791_CLK_RCAN               9
>  #define R8A7791_CLK_ADSP               10
>
> +#define MSTP(n)                                (n / 100 * 32 + n % 100)

Hence this macro can be removed...

> +
>  /* MSTP0 */
> -#define R8A7791_CLK_MSIOF0             0
> +#define R8A7791_CLK_MSIOF0             MSTP(0)

... and all of these can just become plain human-readable numbers that
match the datasheets.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

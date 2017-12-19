From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] ARM: dts: r8a7743: Add thermal device to DT
Date: Tue, 19 Dec 2017 12:44:57 +0100
Message-ID: <CAMuHMdUiabbd-Ry8AhZsfMiwVBBqYKaZEM_ROxCF-xJDkBgp1Q@mail.gmail.com>
References: <1513162673-31531-1-git-send-email-biju.das@bp.renesas.com> <1513162673-31531-3-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513162673-31531-3-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 13, 2017 at 11:57 AM, Biju Das <biju.das@bp.renesas.com> wrote:
> This patch instantiates the thermal sensor module with thermal-zone
> support.
>
> This patch is based on the commit cac68a56e34b
> ("ARM: dts: r8a7791: enable to use thermal-zone") by Kuninori Morimoto.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Minor nit below...

> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
> @@ -250,6 +250,38 @@
>                         resets = <&cpg 407>;
>                 };
>
> +               thermal: thermal@e61f0000 {
> +                       compatible = "renesas,thermal-r8a7743",
> +                                    "renesas,rcar-gen2-thermal",
> +                                    "renesas,rcar-thermal";
> +                       reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;

<0 0xe61f0000 0 0x10>?

The register at offset 0x10 seems to exist on R-Mobile APE6 only, but
all R-Car Gen2 .dtsis include it in the range...

Not that it matters much, mapping granularity is PAGE_SIZE anyway...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

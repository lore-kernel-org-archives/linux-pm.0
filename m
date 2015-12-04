From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] thermal: rcar: enable to use thermal-zone on DT
Date: Fri, 4 Dec 2015 09:32:36 +0100
Message-ID: <CAMuHMdUcQFcQuEmQZ4yMGwm=ouH+aQQhG3V95p=Pb56qWberQA@mail.gmail.com>
References: <871tb2hpn2.wl%kuninori.morimoto.gx@renesas.com>
	<87y4dagb0i.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y4dagb0i.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Morimoto-san,

CC devicetree

On Fri, Dec 4, 2015 at 4:17 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch enables to use thermal-zone on DT if it was call as
> "renesas,rcar-thermal-gen2".
> Previous style is still supported by "renesas,rcar-thermal".
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/thermal/rcar-thermal.txt   | 37 +++++++++++++++++-
>  drivers/thermal/rcar_thermal.c                     | 45 +++++++++++++++++++---
>  2 files changed, 74 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> index 332e625..904f204 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> @@ -1,8 +1,9 @@
>  * Renesas R-Car Thermal
>
>  Required properties:
> -- compatible           : "renesas,thermal-<soctype>", "renesas,rcar-thermal"
> -                         as fallback.
> +- compatible           : "renesas,thermal-<soctype>",
> +                          "renesas,rcar-thermal-gen2" (with thermal-zone) or

Ugh, another different scheme "<manuf>,<family>-<device>-<familyversion>"...

What about "renesas,rcar-gen2-thermal"?

> +                          "renesas,rcar-thermal" (without thermal-zone) as fallback.
>                           Examples with soctypes are:
>                             - "renesas,thermal-r8a73a4" (R-Mobile APE6)
>                             - "renesas,thermal-r8a7779" (R-Car H1)
> @@ -36,3 +37,35 @@ thermal@e61f0000 {
>                 0xe61f0300 0x38>;
>         interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
>  };
> +
> +Example (with thermal-zone):
> +
> +thermal-zones {
> +       cpu_thermal: cpu-thermal {
> +               polling-delay-passive   = <1000>;
> +               polling-delay           = <5000>;
> +
> +               thermal-sensors = <&thermal>;
> +
> +               trips {
> +                       cpu-crit {
> +                               temperature     = <1150000>;
> +                               hysteresis      = <0>;
> +                               type            = "critical";
> +                       };
> +               };
> +               cooling-maps {
> +               };
> +       };
> +};
> +
> +thermal: thermal@e61f0000 {
> +       compatible =    "renesas,thermal-r8a7790",
> +                       "renesas,rcar-thermal-gen2",
> +                       "renesas,rcar-thermal";
> +       reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
> +       interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
> +       power-domains = <&cpg_clocks>;
> +       #thermal-sensor-cells = <0>;
> +};

How are the two nodes above linked?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

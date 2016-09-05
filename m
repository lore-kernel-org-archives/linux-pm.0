From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5 v2] thermal: rcar_gen3_thermal: Document the R-Car Gen3
Date: Mon, 5 Sep 2016 11:57:38 +0200
Message-ID: <CAMuHMdUO1XptoeW6m1XOPigt5vtNq8eN5sLaTHhbnTRLb47tzA@mail.gmail.com>
References: <SIXPR06MB0906D63F01A4C5C79823EED0A8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SIXPR06MB0906D63F01A4C5C79823EED0A8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, Hien Dang <hien.dang.eb@renesas.com>, Toru Oishi <toru.oishi.zj@renesas.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 3, 2016 at 7:24 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> @@ -0,0 +1,79 @@
> +* DT bindings for Renesas R-Car Gen3 Thermal Sensor driver
> +
> +On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the thermal sensors (THS)
> +which are the analog circuits for measuring temperature (Tj) inside the LSI.
> +
> +Required properties:
> +- compatible           : "renesas,<soctype>-thermal",
> +                         Examples with soctypes are:
> +                           - "renesas,r8a7795-thermal" (R-Car H3)
> +                           - "renesas,r8a7796-thermal" (R-Car M3)

M3-W

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

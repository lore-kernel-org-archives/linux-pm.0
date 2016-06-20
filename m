From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/4] thermal: rcar_gen3_thermal: Document the R-Car Gen3
 thermal bindings
Date: Mon, 20 Jun 2016 09:49:38 +0200
Message-ID: <CAMuHMdX5UuFTwXHY08DJyGS_deK5iyf1QkGW1OeG5QPD4K3k+A@mail.gmail.com>
References: <57661211.7010900@rvc.renesas.com> <57661290.9000501@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57661290.9000501-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, "Hien Duy. Dang" <hien.dang.eb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, Toru Oishi <toru.oishi.zj-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Khiem,

On Sun, Jun 19, 2016 at 5:33 AM, Khiem Nguyen
<khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org> wrote:
>
> Signed-off-by: Hien Dang <hien.dang.eb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>

Thanks for your patch!

> ---
>  .../bindings/thermal/rcar-gen3-thermal.txt         | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> new file mode 100644
> index 0000000..ed6ce45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> @@ -0,0 +1,79 @@
> +* DT bindings for Renesas R-Car Gen3 Thermal Sensor driver
> +
> +Required properties:
> +- compatible           : "renesas,thermal-<soctype>",

Please use "renesas,<soctype>-thermal", as this is the preferred order for
new bindings.

> +                         Examples with soctypes are:
> +                           - "renesas,thermal-r8a7795" (R-Car H3)

renesas,r8a7795-thermal

> +                           - "renesas,thermal-r8a7796" (R-Car M3)

renesas,r8a7796-thermal, M3-W

> +                           - "renesas,rcar-gen3-thermal" as fallback
> +- reg                  : Address range of the thermal registers.
> +- clocks               : Must contain a reference to the functional clock.

According to the datasheet, the USB_EXTAL clock is also an input for the
thermal block. Should it be added?

> +- #thermal-sensor-cells : Please see ./thermal.txt
> +
> +Option properties:

Optional

> +
> +- interrupts           : Use interrupt
> +- power-domain         : Must contain a reference to the power domain. This property is
> +                         mandatory if the thermal sensor instance is part of a controllable power
> +                         domain.
> +
> +Example (non interrupt support):

Is there a good reason why you wouldn't want to use interrupts?
If not, please make it mandatory.

> +
> +       tsc1: thermal@e6198000 {
> +               compatible = "renesas,thermal-r8a7795",
> +                       "renesas,rcar-gen3-thermal";
> +               reg = <0 0xe6198000 0 0x5c>;

According to the datasheet, there are more registers beyond this range.
Shouldn't it be "reg = <0 0xe6198000 0 0x68>;"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

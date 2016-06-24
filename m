From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 04/14] dt-bindings: document sun8i_ths
Date: Fri, 24 Jun 2016 10:46:11 +0800
Message-ID: <CAGb2v64f6DmagOJMbj9YiLU+umpZ2m8YzpQjA3RhoymjEf+5cA@mail.gmail.com>
References: <20160623192104.18720-1-megous@megous.com> <20160623192104.18720-5-megous@megous.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160623192104.18720-5-megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Cc: dev <dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 24, 2016 at 3:20 AM,  <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org> wrote:
> From: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
>
> This patch adds the binding documentation for the sun8i_ths driver
>
> Signed-off-by: Ond=C5=99ej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/thermal/sun8i-ths.txt      | 31 ++++++++++++=
++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-t=
hs.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt =
b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> new file mode 100644
> index 0000000..826cd57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> @@ -0,0 +1,31 @@
> +* sun8i THS

An explanation of the acronym would be nice, both in the docs,
and in the commit message.

> +
> +Required properties:
> +- compatible : "allwinner,sun8i-h3-ths"
> +- reg : Address range of the thermal registers and location of the c=
alibration

                                        *sensor*

Also you only specify one address range in the example. The "location
of the calibration value" is handled by the nvram-* properties. Please
remove the description.

> +        value
> +- resets : Must contain an entry for each entry in reset-names.

This, and clocks below, should probably read "must contain phandles
to reset/clock controls matching the entries of the names".

Regards
ChenYu

> +           see ../reset/reset.txt for details
> +- reset-names : Must include the name "ahb"
> +- clocks : Must contain an entry for each entry in clock-names.
> +- clock-names : Must contain "ahb" for the bus gate and "ths" for th=
e THS
> +  clock
> +
> +Optional properties:
> +- nvmem-cells : Must contain an entry for each entry in nvmem-cell-n=
ames
> +- nvmem-cell-names : Must contain "calibration" for the cell contain=
ing the
> +  temperature calibration cell, if available
> +
> +Example:
> +ths: ths@01c25000 {
> +       #thermal-sensor-cells =3D <0>;
> +       compatible =3D "allwinner,sun8i-h3-ths";
> +       reg =3D <0x01c25000 0x400>;
> +       interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +       resets =3D <&bus_rst 136>;
> +       reset-names =3D "ahb";
> +       clocks =3D <&bus_gates 72>, <&ths_clk>;
> +       clock-names =3D "ahb", "ths";
> +       nvmem-cells =3D <&ths_calibration>;
> +       nvmem-cell-names =3D "calibration";
> +};
> --
> 2.9.0
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

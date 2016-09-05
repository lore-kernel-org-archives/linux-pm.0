From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 3/5 v2] arm64: dts: r8a7795: Add R-Car Gen3 thermal support
Date: Mon, 5 Sep 2016 12:07:58 +0200
Message-ID: <CAMuHMdU62emt_ujyMx_NgA_KpUD7ekqQQLqVEdE5UVppGgQ51A@mail.gmail.com>
References: <SIXPR06MB090693A361F296F1038319D0A8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <SIXPR06MB090693A361F296F1038319D0A8E40-ptTgG45MbElcr699GEGyj20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Khiem Nguyen <khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, Hien Dang <hien.dang.eb-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Toru Oishi <toru.oishi.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Khiem,

On Sat, Sep 3, 2016 at 7:27 AM, Khiem Nguyen
<khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi

> @@ -1692,5 +1695,85 @@
>                                 };
>                         };
>                 };
> +
> +               tsc1: thermal@e6198000 {
> +                       compatible = "renesas,r8a7795-thermal";
> +                       reg = <0 0xe6198000 0 0x5c>;

According to the datasheet, TSC1 has 3 more registers beyond this range.

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

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] thermal: rcar_gen3_thermal: fix initialization
 sequence for H3 ES2.0
Date: Mon, 16 Oct 2017 18:35:28 +0200
Message-ID: <CAMuHMdUW6HG5on0yKjqw=SrrdRucyoFWGebXjogjQAo+sM1Few@mail.gmail.com>
References: <20171016145259.27897-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47569 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbdJPQfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 12:35:30 -0400
In-Reply-To: <20171016145259.27897-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Niklas,

On Mon, Oct 16, 2017 at 4:52 PM, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The initialization sequence for H3 (r8a7795) ES1.x and ES2.0 is
> different. H3 ES2.0 and later uses the same sequence as M3 (r8a7796)
> ES1.0. Fix this by not looking at compatible strings and instead
> defaulting to the r8a7796 initialization sequence and use
> soc_device_match() to check for H3 ES1.x.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c

> @@ -371,7 +365,9 @@ static int rcar_gen3_thermal_probe(struct platform_de=
vice *pdev)
>         if (!priv)
>                 return -ENOMEM;
>
> -       priv->data =3D of_device_get_match_data(dev);
> +       priv->thermal_init =3D &rcar_gen3_thermal_init;

You can drop the "&".

> +       if (soc_device_match(r8a7795es1))
> +               priv->thermal_init =3D &rcar_gen3_thermal_init_r8a7795es1=
;

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

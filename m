From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: fix initialization sequence
 for H3 ES2.0
Date: Wed, 13 Sep 2017 15:37:31 +0200
Message-ID: <CAMuHMdVEbUx5N02eGYembN8-ZSRbfkeHgThA70TntdcC2MQhxg@mail.gmail.com>
References: <20170913105522.12880-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37148 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdIMNhc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2017 09:37:32 -0400
In-Reply-To: <20170913105522.12880-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Niklas,

On Wed, Sep 13, 2017 at 12:55 PM, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The initialization sequence for H3 (r8a7795) ES1.x and ES2.0 is
> different. H3 ES2.0 and later uses the same sequence as M3 (r8a7796)
> ES1.0. Fix this by swapping place of the two initialization functions
> and calling the r8a7796 init function from the r8a7795 init function if
> the ES version is not "ES1.*".
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Thanks for your patch!

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c

> -static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> +static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
>  {
> -       u32 reg_val;
> +       /* H3 ES2.0 and later uses same initialization sequence as M3 ES1=
.0 */

... use the same ...

> +       if (!soc_device_match(r8a7795es1)) {
> +               r8a7796_thermal_init(tsc);
> +               return;
> +       }

In general, I prefer soc_device_match() tests for pre-production SoCs to
use positive tests, not negative tests. That makes it easier to drop the
tests and the related code when support for these pre-production SoCs is
dropped later.

I.e.

        static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *ts=
c)
        {
                if (soc_device_match(r8a7795es1))
                        return r8a7795es1_thermal_init(tsc);

                [... common init code ...]
        }

Notes:
  - The above naming ("rcar_gen3_thermal_init") assumes other R-Car Gen3
    SoCs need the same initialization sequence.
  - Yes, you can call and return from a void function like that ;-)

However, that still leaves the test in the .thermal_init() callback, so it
will be evaluated multiple times, during probe and during each and every
resume.

You can avoid that by using a separate rcar_gen3_thermal_data structure for
H3 ES1.x, and changing the probe function like:

     priv->data =3D of_device_get_match_data(dev);
+       if (soc_device_match(r8a7795es1))
+               priv->data =3D &r8a7795es_data;

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

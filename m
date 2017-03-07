From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 7/7] thermal: rcar_gen3_thermal: add suspend and resume support
Date: Tue, 7 Mar 2017 16:38:26 +0100
Message-ID: <CAMuHMdVxa6qde2Czt46vVWgtUgbLMPQ1PJXazphmznfYyHAo8Q@mail.gmail.com>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se> <20170306200401.29923-8-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170306200401.29923-8-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 6, 2017 at 9:04 PM, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> To restore operation it's easiest to reinitialise all TSC. In order to

TSCs

> do this the current trip window needs to be stored in the TSC structure
> so that it can be restored upon resume.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 35 +++++++++++++++++++++++++++++++=
++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_g=
en3_thermal.c
> index 9168ac538f3b8cf5..84642871a628cb2a 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c

> +static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
> +{
> +       struct rcar_gen3_thermal_priv *priv =3D dev_get_drvdata(dev);
> +       int i;

unsigned int

> +
> +       for (i =3D 0; i < TSC_MAX_NUM; i++) {
> +               struct rcar_gen3_thermal_tsc *tsc =3D priv->tscs[i];
> +
> +               priv->data->thermal_init(tsc);
> +               rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
> +       }
> +
> +       rcar_thermal_irq_enable(priv);
> +
> +       return 0;
> +}

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

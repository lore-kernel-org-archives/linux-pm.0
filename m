From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/7] thermal: rcar_gen3_thermal: record more information
 about each TSC
Date: Tue, 7 Mar 2017 16:41:03 +0100
Message-ID: <CAMuHMdXN+tFE9b1MHb8Zrtemrxya+PWYPGU515ph6OtJjpR5-w@mail.gmail.com>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se> <20170306200401.29923-5-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170306200401.29923-5-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Niklas,

On Mon, Mar 6, 2017 at 9:03 PM, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The struct rcar_gen3_thermal_tsc benefits from knowing which TSC it
> represent. Record this at probe time before this information is lost.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_g=
en3_thermal.c
> index 5d4a5483eb13e796..65f7204936a18278 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -68,6 +68,8 @@ struct equation_coefs {
>  };
>
>  struct rcar_gen3_thermal_tsc {
> +       struct device *dev;
> +       int num;

BTW, adding the "int" here will introduce a 4-byte gap on 64-bit platforms.
Note that it doesn't hurt much in this case, as the struct will be padded t=
o a
multiple of 8 bytes anyway.

>         void __iomem *base;
>         struct thermal_zone_device *zone;
>         struct equation_coefs coef;

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

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/7] thermal: rcar_gen3_thermal: enable hardware
 interrupts for trip points
Date: Tue, 7 Mar 2017 16:36:00 +0100
Message-ID: <CAMuHMdWXw8dQKU4KkH8ouB4Kvngm_H4-4W11EBxnx=QXE3Ffjg@mail.gmail.com>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se> <20170306200401.29923-6-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33889 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbdCGPiw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2017 10:38:52 -0500
In-Reply-To: <20170306200401.29923-6-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Mon, Mar 6, 2017 at 9:03 PM, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Enable hardware trip points by implementing the set_trips callback. The
> thermal core will take care of setting the initial trip point window and
> to update it once the driver reports a TSC have moved outside it.

has moved

> The interrupt structure for this device is a bit odd. There is not a
> dedicated IRQ for each TSC, instead the interrupts are shared between
> all TSC. IRQn is fired if the temp monitored in IRQTEMPn is reached in

all TSCs

> any of the TSC, example IRQ3 is fired if temperature in IRQTEMP3 is

TSCs

> reached in either TSC0, TSC1 or TSC2.
>
> For this reason the usage of interrupts in this driver is a all on or

an all-on or all-off

> all off design. When an interrupt happens all TSC are checked and all

TSCs

> thermal zones are updated. This could be refined to be more fine grained
> but the thermal core takes care of only updating the thermal zones that
> have left there trip point window.

their

> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 137 ++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 137 insertions(+)
>
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_g=
en3_thermal.c
> index 65f7204936a18278..e52181015e589a7f 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c

> @@ -76,6 +87,7 @@ struct rcar_gen3_thermal_tsc {
>  };
>
>  struct rcar_gen3_thermal_priv {
> +       spinlock_t lock;

When declaring a spinlock, please add a comment what exactly is
protected by the lock.

> +static void rcar_thermal_irq_disable(struct rcar_gen3_thermal_priv *priv=
)
> +{
> +       int i;

unsigned int (for all positive loop counters)

> +
> +       for (i =3D 0; i < TSC_MAX_NUM; i++)
> +               rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0=
);
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

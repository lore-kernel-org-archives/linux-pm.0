From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/7] thermal: rcar_gen3_thermal: check that TSC exists
 before memory allocation
Date: Sat, 18 Mar 2017 15:06:54 +0100
Message-ID: <CAMuHMdWHFWTpLcf9dVut-0G359mCWuoknNJ+Y2Fuum+-+XFh_g@mail.gmail.com>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se> <20170317155300.21566-4-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170317155300.21566-4-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 17, 2017 at 4:52 PM, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Move the check for a TSC resource before allocating memory for a new
> TSC. If no TSC is found there is little point in allocating memory for
> it.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
Date: Tue, 13 Dec 2016 09:19:53 +0100
Message-ID: <CAMuHMdVpuWO9Do9VvkVjZoEOCbmd72Gah-d2f4GCZavpo9EGpQ@mail.gmail.com>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se> <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:32785 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbcLMITy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2016 03:19:54 -0500
In-Reply-To: <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

Hi Niklas,

On Mon, Dec 12, 2016 at 3:18 PM, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> +/*
> + * Linear approximation for temperature
> + *
> + * [reg] =3D [temp] * a + b =3D> [temp] =3D ([reg] - b) / a
> + *
> + * The constants a and b are calculated using two triplets of int values=
 PTAT
> + * and THCODE. PTAT and THCODE can either be read from hardware or use h=
ard
> + * coded values from driver. The formula to calculate a and b are taken =
from
> + * BSP and sparsely documented and understood.
> + *
> + * Examining the linear formula and the formula used to calculate consta=
nts a
> + * and b while knowing that the span for PTAT and THCODE values are betw=
een
> + * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff =3D=3D =
0xffe001.
> + * Integer also needs to be signed so that leaves 7 bits for decimal
> + * fixed point scaling, which amounts to a decimal scaling factor of 100=
.
> + */
> +
> +#define SCALE_FACTOR 100

What about using 128 instead?
Fixed point is much easier with shifts
(the compiler will turn multiplications in shifts where appropriate).

> +#define SCALE_INT(_x) ((_x) * SCALE_FACTOR)
> +#define SCALE_MUL(_a, _b) (((_a)*(_b)) / SCALE_FACTOR)
> +#define SCALE_DIV(_a, _b) (((_a)*SCALE_FACTOR)/(_b))

DIV_ROUND_CLOSEST()

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

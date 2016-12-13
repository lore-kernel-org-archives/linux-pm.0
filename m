From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
Date: Tue, 13 Dec 2016 09:25:04 +0100
Message-ID: <CAMuHMdXPZvHPRNx_VJ5VkowcTZbt_tOtRE1yPPVfv2fMYL8xLA@mail.gmail.com>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
 <20161212141805.14946-3-niklas.soderlund@ragnatech.se> <20161212214514.GA17631@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212214514.GA17631@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 12, 2016 at 10:45 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +/*
>> + * Linear approximation for temperature
>> + *
>> + * [reg] = [temp] * a + b => [temp] = ([reg] - b) / a
>> + *
>> + * The constants a and b are calculated using two triplets of int values PTAT
>> + * and THCODE. PTAT and THCODE can either be read from hardware or use hard
>> + * coded values from driver. The formula to calculate a and b are taken from
>> + * BSP and sparsely documented and understood.
>> + *
>> + * Examining the linear formula and the formula used to calculate constants a
>> + * and b while knowing that the span for PTAT and THCODE values are between
>> + * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff == 0xffe001.
>> + * Integer also needs to be signed so that leaves 7 bits for decimal
>> + * fixed point scaling, which amounts to a decimal scaling factor of 100.
>> + */
>> +
>> +#define SCALE_FACTOR 100
>> +#define SCALE_INT(_x) ((_x) * SCALE_FACTOR)
>> +#define SCALE_MUL(_a, _b) (((_a)*(_b)) / SCALE_FACTOR)
>> +#define SCALE_DIV(_a, _b) (((_a)*SCALE_FACTOR)/(_b))
>> +#define SCALE_TO_MCELSIUS(_x) ((_x) * 10)
>
> Spaces around operators everywhere, please.
>
> I wonder about SCALE_MUL; isn't that more like "unscaling" because _a
> and _b are already scaled?

No, it's a standard fixed point multiplication, where you have to compensate
for the double scaling due to the multiplication.

Perhaps the macros should be called e.g. FIXPT_MUL() and FIXPT_DIV()?

> And since _b is always a constant, couldn't we simply drop this macro
> and simply do _a * _b (with _a being scaled already and _b not)?

Yes, for multiplication by an integer (not a fixed point number), you can
just do the multiplication. Which also avoids having to care about rounding.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

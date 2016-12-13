From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal
 driver
Date: Tue, 13 Dec 2016 10:53:05 +0100
Message-ID: <20161213095305.GA28801@bigcity.dyn.berto.se>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
 <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
 <CAMuHMdVpuWO9Do9VvkVjZoEOCbmd72Gah-d2f4GCZavpo9EGpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVpuWO9Do9VvkVjZoEOCbmd72Gah-d2f4GCZavpo9EGpQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your feedback.

On 2016-12-13 09:19:53 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Mon, Dec 12, 2016 at 3:18 PM, Niklas Söderlund
> <niklas.soderlund@ragnatech.se> wrote:
> > +/*
> > + * Linear approximation for temperature
> > + *
> > + * [reg] = [temp] * a + b => [temp] = ([reg] - b) / a
> > + *
> > + * The constants a and b are calculated using two triplets of int values PTAT
> > + * and THCODE. PTAT and THCODE can either be read from hardware or use hard
> > + * coded values from driver. The formula to calculate a and b are taken from
> > + * BSP and sparsely documented and understood.
> > + *
> > + * Examining the linear formula and the formula used to calculate constants a
> > + * and b while knowing that the span for PTAT and THCODE values are between
> > + * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff == 0xffe001.
> > + * Integer also needs to be signed so that leaves 7 bits for decimal
> > + * fixed point scaling, which amounts to a decimal scaling factor of 100.
> > + */
> > +
> > +#define SCALE_FACTOR 100
> 
> What about using 128 instead?
> Fixed point is much easier with shifts
> (the compiler will turn multiplications in shifts where appropriate).

I tried using binary scaled instead of decimal scaled fixed point but 
noticed that the diff I got compared to the original formula which used 
decimal scaled (factor 1000) where larger so I picked decimal scaling.  

Maybe with feedback from Morimoto-san or Khiem we can switch to binary 
scaled number as it should over all increase the accuracy of the 
calculations, but then maybe some of the other hard coded constant also 
should be updated?

> 
> > +#define SCALE_INT(_x) ((_x) * SCALE_FACTOR)
> > +#define SCALE_MUL(_a, _b) (((_a)*(_b)) / SCALE_FACTOR)
> > +#define SCALE_DIV(_a, _b) (((_a)*SCALE_FACTOR)/(_b))
> 
> DIV_ROUND_CLOSEST()

Don't DIV_ROUND_CLOSEST() require the divisor to be a positive integer?  

  tj_2 = SCALE_DIV(SCALE_MUL(SCALE_INT(ptat[1] - ptat[2]), SCALE_INT(137)),
                   SCALE_INT(ptat[0] - ptat[2])) - SCALE_INT(41);

In this case if ptat[0] < (ptat[2] + 41) the divisor is negative so I 
think DIV_ROUND_CLOSEST() can't be used, or am I misunderstanding?

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Regards,
Niklas Söderlund

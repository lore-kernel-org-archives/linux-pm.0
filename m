From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: fix initialization sequence
 for H3 ES2.0
Date: Wed, 13 Sep 2017 15:47:48 +0200
Message-ID: <20170913134748.GJ2882@bigcity.dyn.berto.se>
References: <20170913105522.12880-1-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdVEbUx5N02eGYembN8-ZSRbfkeHgThA70TntdcC2MQhxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVEbUx5N02eGYembN8-ZSRbfkeHgThA70TntdcC2MQhxg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your feedback!

On 2017-09-13 15:37:31 +0200, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Wed, Sep 13, 2017 at 12:55 PM, Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > The initialization sequence for H3 (r8a7795) ES1.x and ES2.0 is
> > different. H3 ES2.0 and later uses the same sequence as M3 (r8a7796)
> > ES1.0. Fix this by swapping place of the two initialization functions
> > and calling the r8a7796 init function from the r8a7795 init function if
> > the ES version is not "ES1.*".
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Thanks for your patch!
> 
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> 
> > -static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> > +static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> >  {
> > -       u32 reg_val;
> > +       /* H3 ES2.0 and later uses same initialization sequence as M3 ES1.0 */
> 
> ... use the same ...

Thanks.

> 
> > +       if (!soc_device_match(r8a7795es1)) {
> > +               r8a7796_thermal_init(tsc);
> > +               return;
> > +       }
> 
> In general, I prefer soc_device_match() tests for pre-production SoCs to
> use positive tests, not negative tests. That makes it easier to drop the
> tests and the related code when support for these pre-production SoCs is
> dropped later.

Good point, I will update and send a v2.

> 
> I.e.
> 
>         static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
>         {
>                 if (soc_device_match(r8a7795es1))
>                         return r8a7795es1_thermal_init(tsc);
> 
>                 [... common init code ...]
>         }
> 
> Notes:
>   - The above naming ("rcar_gen3_thermal_init") assumes other R-Car Gen3
>     SoCs need the same initialization sequence.
>   - Yes, you can call and return from a void function like that ;-)
> 
> However, that still leaves the test in the .thermal_init() callback, so it
> will be evaluated multiple times, during probe and during each and every
> resume.
> 
> You can avoid that by using a separate rcar_gen3_thermal_data structure for
> H3 ES1.x, and changing the probe function like:
> 
>      priv->data = of_device_get_match_data(dev);
> +       if (soc_device_match(r8a7795es1))
> +               priv->data = &r8a7795es_data;

This seems like the best option for v2 so will go with that.

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

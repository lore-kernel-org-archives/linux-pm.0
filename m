From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 5/7] thermal: rcar_gen3_thermal: enable hardware
 interrupts for trip points
Date: Fri, 17 Mar 2017 11:07:58 +0100
Message-ID: <20170317100758.GB20587@bigcity.dyn.berto.se>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-6-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdWXw8dQKU4KkH8ouB4Kvngm_H4-4W11EBxnx=QXE3Ffjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33371 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdCQKIB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 06:08:01 -0400
Received: by mail-lf0-f43.google.com with SMTP id a6so31065581lfa.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2017 03:08:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMuHMdWXw8dQKU4KkH8ouB4Kvngm_H4-4W11EBxnx=QXE3Ffjg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Geert,

Thanks for your feedback.

On 2017-03-07 16:36:00 +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 6, 2017 at 9:03 PM, Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > Enable hardware trip points by implementing the set_trips callback. The
> > thermal core will take care of setting the initial trip point window and
> > to update it once the driver reports a TSC have moved outside it.
> 
> has moved
> 
> > The interrupt structure for this device is a bit odd. There is not a
> > dedicated IRQ for each TSC, instead the interrupts are shared between
> > all TSC. IRQn is fired if the temp monitored in IRQTEMPn is reached in
> 
> all TSCs
> 
> > any of the TSC, example IRQ3 is fired if temperature in IRQTEMP3 is
> 
> TSCs
> 
> > reached in either TSC0, TSC1 or TSC2.
> >
> > For this reason the usage of interrupts in this driver is a all on or
> 
> an all-on or all-off
> 
> > all off design. When an interrupt happens all TSC are checked and all
> 
> TSCs
> 
> > thermal zones are updated. This could be refined to be more fine grained
> > but the thermal core takes care of only updating the thermal zones that
> > have left there trip point window.
> 
> their
> 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I will fix all the spelling suggestions above, thanks! But I will not 
add your Reviewed-by since Wolframs comments suggest I need to update 
some parts of this patch.

> 
> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 137 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> >
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> > index 65f7204936a18278..e52181015e589a7f 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> 
> > @@ -76,6 +87,7 @@ struct rcar_gen3_thermal_tsc {
> >  };
> >
> >  struct rcar_gen3_thermal_priv {
> > +       spinlock_t lock;
> 
> When declaring a spinlock, please add a comment what exactly is
> protected by the lock.

Will do thanks.

> 
> > +static void rcar_thermal_irq_disable(struct rcar_gen3_thermal_priv *priv)
> > +{
> > +       int i;
> 
> unsigned int (for all positive loop counters)

Thanks, will fix.

> 
> > +
> > +       for (i = 0; i < TSC_MAX_NUM; i++)
> > +               rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
> > +}
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

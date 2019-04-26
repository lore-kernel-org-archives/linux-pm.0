Return-Path: <SRS0=x0P7=S4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD134C43219
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 09:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8961F20679
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 09:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDZJzR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:55:17 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45932 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZJzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2019 05:55:16 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6F9F925AD60;
        Fri, 26 Apr 2019 19:55:13 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 710219403ED; Fri, 26 Apr 2019 11:55:11 +0200 (CEST)
Date:   Fri, 26 Apr 2019 11:55:11 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH repost] thermal: rcar_thermal: update calculation formula
 for E3
Message-ID: <20190426095511.tkgbxkf43psesgkv@verge.net.au>
References: <20190418071514.13027-1-horms+renesas@verge.net.au>
 <20190418081209.GT28515@bigcity.dyn.berto.se>
 <CAMuHMdVX5t-Q5tM5bj95muAZ+8+phohtQSsAO-rCeCofiqVMKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVX5t-Q5tM5bj95muAZ+8+phohtQSsAO-rCeCofiqVMKQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 24, 2019 at 09:10:56AM +0200, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Thu, Apr 18, 2019 at 10:12 AM Niklas Söderlund
> <niklas.soderlund@ragnatech.se> wrote:
> > On 2019-04-18 09:15:14 +0200, Simon Horman wrote:
> > > From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > >
> > > HW manual changes temperature calculation formula for E3:
> >
> > Is this not also true for V3M and D3?
> >
> > > - When CTEMP is less than 24
> > >    T = CTEMP[5:0] * 5.5 - 72
> > > - When CTEMP is equal to/greater than 24
> > >    T = CTEMP[5:0] * 5 - 60
> > >
> > > This was inspired by a patch in the BSP by Van Do <van.do.xw@renesas.com>
> > >
> > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > > Tested-by: Simon Horman <horms+renesas@verge.net.au>
> > > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > >  drivers/thermal/rcar_thermal.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > > index 97462e9b40d8..11df0cc63bed 100644
> > > --- a/drivers/thermal/rcar_thermal.c
> > > +++ b/drivers/thermal/rcar_thermal.c
> > > @@ -52,6 +52,7 @@ struct rcar_thermal_chip {
> > >       unsigned int irq_per_ch : 1;
> > >       unsigned int needs_suspend_resume : 1;
> > >       unsigned int nirqs;
> > > +     unsigned int ctemp_bands;
> >
> > Would it be possible to rename this to something indicating that this is
> > a gen3 thing? Maybe move it to the bit fields above and name it gen3 ?
> 
> Is that really a good thing to do? This structure describes features of
> the thermal module, and we're already beyond the point where a simple
> check  for gen2 or gen3 was sufficient.
> Here the feature is having multiple temperature bands.
> What if some other Gen3 SoC starts having 3 temperature bands?
> 
> > > @@ -263,7 +267,12 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
> > >               return ret;
> > >
> > >       mutex_lock(&priv->lock);
> > > -     tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> > > +     if (priv->chip->ctemp_bands == 1)
> > > +             tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> > > +     else if (priv->ctemp < 24)
> > > +             tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
> > > +     else
> > > +             tmp = MCELSIUS((priv->ctemp * 5) - 60);
> >
> > I confirm that the calculations here are correct, but hard to read ;-)
> > With the rename about how about.
> >
> >     if (priv->chip->gen3) {
> >         if (priv->ctemp < 24)
> >                 tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
> >         else
> >                 tmp = MCELSIUS((priv->ctemp * 5) - 60);
> >     } else {
> >             tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> >     }
> 
> _Iff_ we decide on going for the rename, I'd still write it as:
> 
>     if (!priv->chip->gen3)
>             tmp =  MCELSIUS((priv->ctemp * 5) - 65);
>     else if (priv->ctemp < 24)
>             tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
>     else
>             tmp = MCELSIUS((priv->ctemp * 5) - 60);
> 
> Always fold your if/else if/else constructs to minimize the need for indentation
> and braces ;-)

From my PoV I think the patch is fine in its current form.
Niklas do you feel particularly strongly about changing it?

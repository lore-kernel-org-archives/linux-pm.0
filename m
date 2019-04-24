Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E5C282E1
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC859218B0
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfDXHLJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:11:09 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42509 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDXHLJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 03:11:09 -0400
Received: by mail-vk1-f196.google.com with SMTP id 195so3794095vkx.9;
        Wed, 24 Apr 2019 00:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nlLoanQoDogN7zFZcl1Xau0jCY9OPTPS0yU5xWm3Jpo=;
        b=r1c2KvtIQw6pRvSY2Bql72uzi1OgWlvEKkT7U8U5L7Vh72FlovoVbWge7qwoHkmAwy
         5C7VNQlmgu3yah+9s3C5cIF7XopPjN4uzsNZDZ5910Yu/KxzyZU7N/hnSCJAomftl4x7
         Kh1lS4109APDdsbbH9TOaTGQxGpmP7HN+v+ANbMtwFqqgCP4+XBeHTDzZwHitZQ73ZDa
         uMEllk5ti96SGOTkjRP1nZvg4lTFzaGMpxpqwCx24POj6uXP7f5r8VUpoWKVHjqjIAVp
         s5U3LjfYtAGctSAsLbcPhyTf01KBk7B4OVcD6eZm2ptELM7gu00lpm8oAR++Qy8gN0aV
         OEdg==
X-Gm-Message-State: APjAAAVDsvbwgaJOmHa50rjXuREosJ22Rn+LBbsbkwwP3cI8wsEEUXc5
        tTajlbDaWtfwzfUkQIJNtKG3NFWsFiKxFX6LTlI=
X-Google-Smtp-Source: APXvYqzs2bg3MYHeD+3xxsrVAL8DId20A45tYDHRo1NzsKID/4rfc1P61sBgG6IjA9WgEYz4KF+k3cg+0ikJazUO99g=
X-Received: by 2002:a1f:95d0:: with SMTP id x199mr16183480vkd.83.1556089868026;
 Wed, 24 Apr 2019 00:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190418071514.13027-1-horms+renesas@verge.net.au> <20190418081209.GT28515@bigcity.dyn.berto.se>
In-Reply-To: <20190418081209.GT28515@bigcity.dyn.berto.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Apr 2019 09:10:56 +0200
Message-ID: <CAMuHMdVX5t-Q5tM5bj95muAZ+8+phohtQSsAO-rCeCofiqVMKQ@mail.gmail.com>
Subject: Re: [PATCH repost] thermal: rcar_thermal: update calculation formula
 for E3
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Simon Horman <horms+renesas@verge.net.au>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Thu, Apr 18, 2019 at 10:12 AM Niklas Söderlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2019-04-18 09:15:14 +0200, Simon Horman wrote:
> > From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >
> > HW manual changes temperature calculation formula for E3:
>
> Is this not also true for V3M and D3?
>
> > - When CTEMP is less than 24
> >    T = CTEMP[5:0] * 5.5 - 72
> > - When CTEMP is equal to/greater than 24
> >    T = CTEMP[5:0] * 5 - 60
> >
> > This was inspired by a patch in the BSP by Van Do <van.do.xw@renesas.com>
> >
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > Tested-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  drivers/thermal/rcar_thermal.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > index 97462e9b40d8..11df0cc63bed 100644
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> > @@ -52,6 +52,7 @@ struct rcar_thermal_chip {
> >       unsigned int irq_per_ch : 1;
> >       unsigned int needs_suspend_resume : 1;
> >       unsigned int nirqs;
> > +     unsigned int ctemp_bands;
>
> Would it be possible to rename this to something indicating that this is
> a gen3 thing? Maybe move it to the bit fields above and name it gen3 ?

Is that really a good thing to do? This structure describes features of
the thermal module, and we're already beyond the point where a simple
check  for gen2 or gen3 was sufficient.
Here the feature is having multiple temperature bands.
What if some other Gen3 SoC starts having 3 temperature bands?

> > @@ -263,7 +267,12 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
> >               return ret;
> >
> >       mutex_lock(&priv->lock);
> > -     tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> > +     if (priv->chip->ctemp_bands == 1)
> > +             tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> > +     else if (priv->ctemp < 24)
> > +             tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
> > +     else
> > +             tmp = MCELSIUS((priv->ctemp * 5) - 60);
>
> I confirm that the calculations here are correct, but hard to read ;-)
> With the rename about how about.
>
>     if (priv->chip->gen3) {
>         if (priv->ctemp < 24)
>                 tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
>         else
>                 tmp = MCELSIUS((priv->ctemp * 5) - 60);
>     } else {
>             tmp =  MCELSIUS((priv->ctemp * 5) - 65);
>     }

_Iff_ we decide on going for the rename, I'd still write it as:

    if (!priv->chip->gen3)
            tmp =  MCELSIUS((priv->ctemp * 5) - 65);
    else if (priv->ctemp < 24)
            tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
    else
            tmp = MCELSIUS((priv->ctemp * 5) - 60);

Always fold your if/else if/else constructs to minimize the need for indentation
and braces ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

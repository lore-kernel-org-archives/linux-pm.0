Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF1C10F14
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5061206B6
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmbWMsOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfDPR6i (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:58:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41756 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbfDPR6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:58:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so18351382otb.8;
        Tue, 16 Apr 2019 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EidWfYVGkkRXMbcoVzWniJ1YzRfymLouJTDXgtCXrm8=;
        b=UmbWMsOeXT3ov6nrPgpTS+elXWa8vGaqeCrPb575FJUmDzeDXBEm+38/bKJS2b+sEa
         wJrHE94pplyZEAVhe3QpROyNLsKr/WpPOoNFTsispkuWpAXHPCivWKHKJHc5TWqiEAnh
         9cfQzehf0UqB73v6fWmRZjmbhaksH5I0ZZIwXLClqenyzL+AaTCw1i23O0UtmBWQg4Ys
         GaC7/+7TXBuxJbJMJLVdTBqc4e/bPYRyZPgLzsQZaYHLB7Gt3I/ngG7yPucyMuJrFBED
         3hMEoqhmsd5+XsT0WeJ6av0h0FePMWLjPGXsLVo7zafigLRTrH2bsaOS8Zy71Ca+IeY3
         uj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EidWfYVGkkRXMbcoVzWniJ1YzRfymLouJTDXgtCXrm8=;
        b=pNbS1NbAcp7A1ZEvrnIt3PqrVUnEljfHMQmPblVyiBifZEQrkDezUOCevtTpsSMsBE
         xX4HhjfNdWP4iTlSy+iJueVDSqLWDGtvhu8EkUizVXuw8bayWXJ/4lhtiW8/NWUd0c6V
         LdROi3zO8zVhrb7zsTVL80+rz+WLXPJoyV8H7meVy9lA4oecmq288LJUlR+P4s5mfC2M
         WuRhZUtqHNjfjgXlp49egYYxzhbq6Kyx7vUOGVXb1JrZBmfy+fzh/w4B7i67shAzGV3L
         hHFYxoApm9vUtfvJCtywjsu9ge//x6vwjdkNUNAXg0xDh4i2m5AJ2DoH9+nZwF8L61ow
         kHzw==
X-Gm-Message-State: APjAAAVtxsfBHtdBcRJsYYI/57xR1jy3WpCbOHTgWifBJAEYQbfFMQwQ
        3HJeLtClXL0boTwNiXuXbjoofHI8KMrxfWSr3TM=
X-Google-Smtp-Source: APXvYqyjyQpVkpt8UdZO6dJtGGHDvfdhgpCg1S4ZgKpSwCZV2AtTrr055NHEzz91Yf/vbUjpX7LT3j9OrNSnC6cunv4=
X-Received: by 2002:a9d:7359:: with SMTP id l25mr51832885otk.189.1555437517076;
 Tue, 16 Apr 2019 10:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <1553201273-16757-1-git-send-email-ykaneko0929@gmail.com>
 <20190401133753.5luent76gyzygtcb@verge.net.au> <20190411165034.GF30887@bigcity.dyn.berto.se>
In-Reply-To: <20190411165034.GF30887@bigcity.dyn.berto.se>
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date:   Wed, 17 Apr 2019 02:58:25 +0900
Message-ID: <CAH1o70+BHrDgjBKuE=mtk6VWdZ0qvedBnYw4aN23v=455a+wyA@mail.gmail.com>
Subject: Re: [PATCH/RFT] thermal: rcar_gen3_thermal: Update calculation
 formula due to HW evaluation
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Simon Horman <horms@verge.net.au>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas-san,

Thanks for your review.

2019=E5=B9=B44=E6=9C=8812=E6=97=A5(=E9=87=91) 1:50 Niklas S=C3=B6derlund <n=
iklas.soderlund@ragnatech.se>:
>
> Hi Kaneko-san,
>
> Thanks for your work.
>
> On 2019-04-01 15:37:57 +0200, Simon Horman wrote:
> > On Fri, Mar 22, 2019 at 05:47:53AM +0900, Yoshihiro Kaneko wrote:
> > > From: Dien Pham <dien.pham.ry@renesas.com>
> > >
> > > 1/ As evaluation of hardware team, temperature calculation formula
> > >  of M3-W is difference from all other SoCs as below:
> > >  - M3-W: Tj_1: 116 (so Tj_1 - Tj_3 =3D 157)
> > >  - Others: Tj_1: 126 (so Tj_1 - Tj_3 =3D 167)
> > >
> > > 2/ Update the formula to calculate CTEMP:
> > >   Currently, the CTEMP is average of val1 (is calculated by
> > >   formula 1) and val2 (is calculated by formula 2). But,
> > >   as description in HWM (chapter 10A.3.1.1 Setting of Normal Mode)
> > >
> > >   If (STEMP < Tj_T) CTEMP value should be val1.
> > >   If (STEMP > Tj_T) CTEMP value should be val2.
> > >
> > > 3/ Update the formula to calculate temperature:
> > >   Currently, current TEMP is calculated as
> > >   average of val1 (is calculated by formula 1)
> > >   and val2 (is calculated by formula 2). But,
> > >   as description in HWM (chapter 10A.3.1.2 Normal Mode.)
> > >
> > >   If (TEMP_CODE < THCODE2[11:0]) CTEMP value should be val1.
> > >   If (TEMP_CODE > THCODE2[11:0]) CTEMP value should be val2.
> > >
> > > Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> > > [ykaneko0929@gmail.com: use the data field of the of_device_id for Tj=
_1]
> > > [ykaneko0929@gmail.com: revise a description of case 1 of the commit =
log]
> > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >
> > I'm wondering if we could split this up into three patches,
> > one for each problem it solves? Partly because I think it is good to fi=
x
> > one problem per patch. And partly because am having trouble
> > verifying this patch - the new if statement in rcar_gen3_thermal_get_te=
mp()
> > seems to result in 0 temperature readings when the else case is used.
>
> I think the changes in this patch are good and correct but I agree with
> Simon here, this patch should be split.

I have split this patch and made fixes in v2.

Thanks,
Kaneko

>
> >
> > > ---
> > >  drivers/thermal/rcar_gen3_thermal.c | 86 +++++++++++++++++++++++++--=
----------
> > >  1 file changed, 58 insertions(+), 28 deletions(-)
> > >
> > > This patch is based on the master branch of Linus Torvalds's linux tr=
ee.
> > >
> > > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rc=
ar_gen3_thermal.c
> > > index 88fa41c..de6f244 100644
> > > --- a/drivers/thermal/rcar_gen3_thermal.c
> > > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > > @@ -63,6 +63,15 @@
> > >
> > >  #define TSC_MAX_NUM        3
> > >
> > > +static int tj_2;
> >
> > We need to avoid global variables. There can be multiple
> > instances of this driver. (Although they will all get the same
> > value for tj_2.
> >
> > Perhaps it can be added to struct rcar_gen3_thermal_tsc?
> >
> > ...
>
> --
> Regards,
> Niklas S=C3=B6derlund

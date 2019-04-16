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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89462C10F13
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F12075B
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpeZ1/Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfDPR4n (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:56:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44360 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbfDPR4m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:56:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id i21so17722234oib.11;
        Tue, 16 Apr 2019 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JY7nlLfsUk9s/cUDq7uRdqTtYQlcu4BPxZj/0OHgYIM=;
        b=BpeZ1/JelVLHrtWDtzElmSjWlUNsN/WDd+1OdqyQwmeQ8bAiGivR0uLE3bL2e5Q85H
         V0578NFzJXmZYlWKBA/A1HfpHhi4fVMuV0qf3L5BDKAdaqynzrJ3Muo/wpR95Cmm+6me
         J5ouqWNJC5DL4gFDJ8eypnxA3a6FaTNl/La9ff0LAHOe9O6jdq/juOPo9u33wXIFuZCX
         fdsZ5DJxXIDUn4n0PzDGXmcXEcLIviNfAkV2XHZQjna41UMxaGhl93s0FHdgWkDHdFUz
         y+14mA3oAAubLwdmIV+m/8+vhnyq1BMtc2eVZnVe/sOQ7oPOMj6YnrLcUXpkwnG/Assa
         3ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JY7nlLfsUk9s/cUDq7uRdqTtYQlcu4BPxZj/0OHgYIM=;
        b=MhsDC5k534Yx7jwMhLmbBn1E/SxySN9Njm3ymiln/aaEOnMSpwKE+FjcTA1GvuQG04
         t/t7WXlpCLfNS3yWezLcpkaiwNu5rd6Cz9oItwELzsGWA3lgaELPafMdQebAKPKJsj95
         xTJuAD2Gh1p1EgPW/K6NoYOm98GYzvh2huLxW7qnFqD/58yExkpeV6A0X2e0i4mF2ih2
         hEo0GKmhmFAYWjwerQkiajJGT4ak2OULu33jzfquDuIubQ0Y2xuVJ711W5plS0y7ghwO
         12+aiUSCwGXUAXIP+5jURHzduiS8qfcDL1g0olSPhnqFz8DJm0RlZCQS0kKWzuR4AArd
         Q/IQ==
X-Gm-Message-State: APjAAAW/pfCYp130AxbzbWCReYicm3CFwX1rRdswvZplv13g9oAGmb6E
        MUP5TxjZ46B3nydMTsUDdfAgwGm9k/SYL0rp7j8vdvnR
X-Google-Smtp-Source: APXvYqyWTb55odlXg0P2RDLhV9J+YHJv1w6b60JnT1l7q9OQdrzI0QwcrfymHg4sLsu/cc/nP3/kRsByuz6BjW5Ljfo=
X-Received: by 2002:aca:3084:: with SMTP id w126mr25236771oiw.102.1555437401186;
 Tue, 16 Apr 2019 10:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <1553201273-16757-1-git-send-email-ykaneko0929@gmail.com>
 <20190401133753.5luent76gyzygtcb@verge.net.au> <20190403092238.sy46nkpbhwo2izpa@verge.net.au>
In-Reply-To: <20190403092238.sy46nkpbhwo2izpa@verge.net.au>
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date:   Wed, 17 Apr 2019 02:56:30 +0900
Message-ID: <CAH1o70Jvw0ehTTRb4C1bNfCSz5diCQise4_GS8tek9NAdt4hMQ@mail.gmail.com>
Subject: Re: [PATCH/RFT] thermal: rcar_gen3_thermal: Update calculation
 formula due to HW evaluation
To:     Simon Horman <horms@verge.net.au>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
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

Hi Simon-san,

Thanks for your review.
I have split this patch and made fixes in v2.

Thanks,
Kaneko

2019=E5=B9=B44=E6=9C=883=E6=97=A5(=E6=B0=B4) 18:22 Simon Horman <horms@verg=
e.net.au>:
>
> On Mon, Apr 01, 2019 at 03:37:57PM +0200, Simon Horman wrote:
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
> Also, from just a little further down the patch
>
> > > +/* default THCODE values if FUSEs are missing */
> > > +static int thcode[TSC_MAX_NUM][3] =3D {
> > > +       { 3397, 2800, 2221 },
> > > +       { 3393, 2795, 2216 },
> > > +       { 3389, 2805, 2237 },
> > > +};
>
> I think thcode can be marked const.

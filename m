Return-Path: <SRS0=kGmN=SL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01356C10F0E
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 11:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B5020883
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 11:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fjjk5/dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfDILEd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:04:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39860 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDILEd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Apr 2019 07:04:33 -0400
Received: by mail-io1-f67.google.com with SMTP id e13so13849083ioq.6
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2019 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0EhV+7BMi42sYY58kzkNs3iubmQlT6Xn711Q8iv4dZw=;
        b=fjjk5/dvn4vvjcq/jWzJkNLB2ybcLA1h2jL2dNYG7I5ha4xo/vVDTAbxJV695tJcLp
         B9OhlmHfgI48Q4gc/pA4bea2FuLH51+elIJCydJ1lvkZ9CxoL7iS2h541YvCLNx3k3Lb
         q0DKwv+y9+5ku8lix5VaiknfZSnpIFRWV4kGyJPN3mSsjpG24XcwB30luPgOfJWWQjP1
         1gioHfcsSvAHCfP5qn4skOov1pW8HEuHekryz1sg6avgn2fYsW5vqGvgfFU7OIJHTBHu
         WV9YKbtgjUN7uJFwkh6DwxB30PyACYf0rkKums6lFajt9Qirxtyedlb9Cbv3zOHJ4Cnj
         EA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0EhV+7BMi42sYY58kzkNs3iubmQlT6Xn711Q8iv4dZw=;
        b=HJMQUcpcLJtziCdqgiHuDSa269+b4bT+4/oLZa1aVaPF9lNXh7PUA/BQ7Y43/I2roV
         3nIVwdYKfv5T9euuxt22Ul9ZkYpBi7ouanlugMXnxCQHvK4K2VLw9MGjsxqNEBSDtuJ+
         09ylmqphZKGoqIsGVcaFyDttODwyk7mMpWOxRluM5keWbyKoWp8FahCwTq5e7IONSnRz
         eBGBFbKhiFPvsH2guaZvHTp+15VLzzMZOZ9gOBhkfhipuJye2+vlcKMFHByWOUma439Q
         1wfNS3Q9zBXUwZ0TS8GK6yhMrrlFKwAo75Uur8cEUERk5qvChjZ6eV2crOpk/402lVcQ
         PyRw==
X-Gm-Message-State: APjAAAU1Nuaz5lCUdCc+NYijwaA1t4NBmBD1qZSjOqly43jRc1ntst0e
        TeDOGAZu6oEhtsJjMvlC23ff0V7YJcpbpo0aIARWdg==
X-Google-Smtp-Source: APXvYqxHQdpydahAFb1uM5EmRRXlBc1JJ8IhflmFGTlP4hj6rTGoad4eiWnt35V26oIqIH/OtyBMGyZb/B768faaKVY=
X-Received: by 2002:a6b:3b43:: with SMTP id i64mr22527637ioa.121.1554807872189;
 Tue, 09 Apr 2019 04:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190403090108.24788-1-brgl@bgdev.pl> <20190403090108.24788-3-brgl@bgdev.pl>
 <20190406070746.GA29624@bogus> <CAMRc=Mc+cTVrzywTydp-10Hj=-m=qCmtK1+4NRiOFHZ855fnDw@mail.gmail.com>
 <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com>
In-Reply-To: <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 9 Apr 2019 13:04:21 +0200
Message-ID:
 <CAMRc=Mc4HOn+Pjwf+sD4fU7gNoksRKXz9Yq6zE233CCoNskPiQ@mail.gmail.com>
Subject: Re: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for max77650
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190409110421.uZGSu6mh3C6pxOXUCawZaeg9ht7afnAks3oT-aFF3Uw@z>

wt., 9 kwi 2019 o 03:10 Rob Herring <robh@kernel.org> napisa=C5=82(a):
>
> On Mon, Apr 8, 2019 at 7:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > sob., 6 kwi 2019 o 09:07 Rob Herring <robh@kernel.org> napisa=C5=82(a):
> > >
> > > On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Add the DT binding document for the battery charger module of max77=
650.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++=
++++
> > > >  1 file changed, 27 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/power/supply/=
max77650-charger.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/power/supply/max7765=
0-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-cha=
rger.txt
> > > > new file mode 100644
> > > > index 000000000000..fef188144386
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charg=
er.txt
> > > > @@ -0,0 +1,27 @@
> > > > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > > > +
> > > > +This module is part of the MAX77650 MFD device. For more details
> > > > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > > +
> > > > +The charger is represented as a sub-node of the PMIC node on the d=
evice tree.
> > > > +
> > > > +Required properties:
> > > > +--------------------
> > > > +- compatible:                Must be "maxim,max77650-charger"
> > > > +
> > > > +Optional properties:
> > > > +--------------------
> > > > +- min-microvolt:     Minimum CHGIN regulation voltage (in microvol=
ts). Must be
> > > > +                     one of: 4000000, 4100000, 4200000, 4300000, 4=
400000,
> > > > +                     4500000, 4600000, 4700000.
> > > > +- current-limit-microamp:    CHGIN input current limit (in microam=
ps). Must
> > > > +                             be one of: 95000, 190000, 285000, 380=
000, 475000.
> > >
> > > To repeat what I said on v6, these should be common properties IMO (a=
nd
> > > therefore documented as such).
> > >
> >
> > Do you mean a separate "charger.txt" document in
> > Documentation/devicetree/bindings/power/supply/?
>
> Yes, though I thought we had something already.
>
> Rob

We don't AFAICT. There's only a binding document for "simple-battery"
in power supply.

Bart

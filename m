Return-Path: <SRS0=kGmN=SL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA415C10F14
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 01:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA63520818
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554772248;
	bh=udsn4aAsvTKiApOCJyOPVPRbRWdn4i433mxFi4XcIuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JSEcwsbw0UmImbPWMvn8Tpi1UkRjTO0+/69lCAJjW22JkeZm4pcxWeoUWYPy8p1oI
	 xW6ETnFc9exIJb4jJGSl+NTnIboxkg9hJKN5jGOUCmJJ0LJYtjeQ3hkZZ2xRZ04J/i
	 4HJfGNJnTHeGA3y/HXQOgh8xIUzDHPyWMTYfOgZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDIBKo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfDIBKo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Apr 2019 21:10:44 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61075218D2;
        Tue,  9 Apr 2019 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554772242;
        bh=udsn4aAsvTKiApOCJyOPVPRbRWdn4i433mxFi4XcIuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IOPmsLfWI4eXFcTKMnd+9dGBaY9G1Lq1AfojTte+WisTSh7eAnh5BgPaNne9+xQzd
         G1Xto8pEWQevHI3UV8LYIqginQan5OAjxX+7egTGUkpT3dIFUL9z+EJvGExvFG71X/
         5Rwxjf7bECA7AaZ3GTo3bdu11jUzakxwp9ZTZIuU=
Received: by mail-qk1-f176.google.com with SMTP id y5so9240124qkc.11;
        Mon, 08 Apr 2019 18:10:42 -0700 (PDT)
X-Gm-Message-State: APjAAAXlOx1IC3E/Oi6yuUH3RjujJ7lpxLSvxYTIuRIfAOe57lN3JDH2
        M+gPk2Oobynn0T2Hd+gQV3lYAt/y7uiP2E29AQ==
X-Google-Smtp-Source: APXvYqzaYjIRetkEt5M1YjX5yIvE26DvUM9AyZZiUx2/mNCLUp1okE3cOLsoTEjuDkPhAL61pw3grFBBKcWDlzbG6Zw=
X-Received: by 2002:ae9:e313:: with SMTP id v19mr24091020qkf.153.1554772241641;
 Mon, 08 Apr 2019 18:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190403090108.24788-1-brgl@bgdev.pl> <20190403090108.24788-3-brgl@bgdev.pl>
 <20190406070746.GA29624@bogus> <CAMRc=Mc+cTVrzywTydp-10Hj=-m=qCmtK1+4NRiOFHZ855fnDw@mail.gmail.com>
In-Reply-To: <CAMRc=Mc+cTVrzywTydp-10Hj=-m=qCmtK1+4NRiOFHZ855fnDw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Apr 2019 20:10:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com>
Message-ID:
 <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com>
Subject: Re: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for max77650
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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
Message-ID: <20190409011030.A13T1bpTz0p4cUW_Luf0MpFt_UYLF1KlGrJmmxKnBMA@z>

On Mon, Apr 8, 2019 at 7:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> sob., 6 kwi 2019 o 09:07 Rob Herring <robh@kernel.org> napisa=C5=82(a):
> >
> > On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Add the DT binding document for the battery charger module of max7765=
0.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++=
++
> > >  1 file changed, 27 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/supply/ma=
x77650-charger.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-=
charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charg=
er.txt
> > > new file mode 100644
> > > index 000000000000..fef188144386
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger=
.txt
> > > @@ -0,0 +1,27 @@
> > > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > > +
> > > +This module is part of the MAX77650 MFD device. For more details
> > > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > +
> > > +The charger is represented as a sub-node of the PMIC node on the dev=
ice tree.
> > > +
> > > +Required properties:
> > > +--------------------
> > > +- compatible:                Must be "maxim,max77650-charger"
> > > +
> > > +Optional properties:
> > > +--------------------
> > > +- min-microvolt:     Minimum CHGIN regulation voltage (in microvolts=
). Must be
> > > +                     one of: 4000000, 4100000, 4200000, 4300000, 440=
0000,
> > > +                     4500000, 4600000, 4700000.
> > > +- current-limit-microamp:    CHGIN input current limit (in microamps=
). Must
> > > +                             be one of: 95000, 190000, 285000, 38000=
0, 475000.
> >
> > To repeat what I said on v6, these should be common properties IMO (and
> > therefore documented as such).
> >
>
> Do you mean a separate "charger.txt" document in
> Documentation/devicetree/bindings/power/supply/?

Yes, though I thought we had something already.

Rob

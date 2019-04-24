Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829D0C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 08:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5382B218D3
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 08:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="C8Q2AxbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfDXIpM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:45:12 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53525 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbfDXIpM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 04:45:12 -0400
Received: by mail-it1-f196.google.com with SMTP id z4so704432itc.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2019 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nMprasNgB0HsdZ7Rf0IEpgfmXifCgCUHWARLRGNw5l4=;
        b=C8Q2AxbPg9IPm8fFhY7BQb+T9m5M9E7cvdXiJtAhdTJMZElIBJRzt7C5xxvO6lwM2M
         hAIf3kvZJvOF01bHYaosCp6FO2g4dWEzX71vlSy4bjqzkIlTxzhLkBVXt8zuX40Ek956
         0QYx/BxAP7ARhgF2Kp6+QOJ5j5iWDYL6Pk7KS9B30XapoOL0recjC4UK7/6lQh4Njmdn
         eE6pnXujoAcgo1NWAb7TNZuW2fM8JpIuhGQ7lV1PXbUfsiSF9IIerDWaAIRm08L9+L9i
         aoE/okc6ejpC0KiiYTPE5Ik3QUU9mz4r+VSQHswIwTPBhz1ntIXx8boj+5kQqEsnXBn7
         yP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nMprasNgB0HsdZ7Rf0IEpgfmXifCgCUHWARLRGNw5l4=;
        b=G514GOwzhtJN9r4+tkxmAgV0PkhnRhsKYmrdNx3FA8NFt21/34omLVCLlb5AUITq0+
         YX+eG/vL9L+RQjlWAaEMIsvbDInefjxCq1KGG6xjqo2f0K2mUDtw4ZAZ845ZyUXpl6jH
         2Z8eXNpeSLcfLqCUmHcbSA5UDuVL8vkjSDdsKmi1OKguPT8uU0q9yeAEhtoDJqfOxJJ1
         85RblmQorVr4O0SDWxhJyjPEWqApOSJovBREMzmgtE8GUckdHMCUI55YhSFJn2p3K5CJ
         FmEL/IHtH+ewdUecyAHIG3ZjdLvBTRFgDLPzzoQnlbvijBzX/nVhbb2xqaOvFNfO2+E7
         VUqg==
X-Gm-Message-State: APjAAAVSCvNGYJfeHEnH6/yRjHu9OXM7mc6FHeaZP5k5/s5KMlHjOkzk
        F29Vl+P5jA0rd49MKiGIQO9cY/JSI2VaNptI/nMBrg==
X-Google-Smtp-Source: APXvYqxFAvjlCEyvNCS6bCbAlBurPt3V5umT7fb7BraJ4Bf3bdLENVohU/w7QzXiusJv3+/W4C35UKyNd5XWV737uoU=
X-Received: by 2002:a02:924d:: with SMTP id y13mr20897713jag.24.1556095511507;
 Wed, 24 Apr 2019 01:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090451.23711-1-brgl@bgdev.pl> <20190424083127.GB6699@amd>
In-Reply-To: <20190424083127.GB6699@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 24 Apr 2019 10:45:00 +0200
Message-ID:
 <CAMRc=McN78_gJw_T4EPucM8veTC9XRUu7TGJ0J+zPsU=0Hu2GQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/11] mfd: add support for max77650 PMIC
To:     Pavel Machek <pavel@denx.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
Message-ID: <20190424084500.Ss8KCpQOWM16L5b6VY9KP7UY6oNcZBPC4Bu5m2UCwMs@z>

=C5=9Br., 24 kwi 2019 o 10:31 Pavel Machek <pavel@denx.de> napisa=C5=82(a):
>
> On Tue 2019-04-23 11:04:40, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This series adds support for max77650 ultra low-power PMIC. It provides
> > the core mfd driver and a set of five sub-drivers for the regulator,
> > power supply, gpio, leds and input subsystems.
> >
> > Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_dev=
ices().
> > Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for t=
his
> > device.
> >
> > The regulator part is already upstream.
>
> I see v10 in my inbox... and acks from all over the place, but patches
> not going in. Who takes these? I don't think I need another 10
> versions in my inbox...
>                                                                 Pavel

I think Lee Jones should take them through the MFD tree. With the ack
from Sebastian Reichel on the driver part and the example in the
charger binding fixed I think they are ready to be picked up.

Bart

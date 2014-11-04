From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Tue, 4 Nov 2014 18:01:44 +0100
Message-ID: <CAPDyKFr7fqwb77Xhnwf7ACFX7skrY2O+_-aB1T_yfShDA1jASA@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<20141104090521.GA13219@dtor-glaptop>
	<CAPDyKFrMMnOwOHuVcpxBWNARKUsVyq66yuH+=LcS3K7bBiUTVA@mail.gmail.com>
	<3036013.4SXEGIT6Kk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:54426 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbaKDRBp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 12:01:45 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so7820036qgd.8
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2014 09:01:44 -0800 (PST)
In-Reply-To: <3036013.4SXEGIT6Kk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron

>>
>> Devices that are created while "discoverable buses" are being probed
>> can't be attached to a PM domain before the probing is done, because
>> those simply doesn't exist.
>
> Honestly, I'm not sure what you're talking about.
>
> Devices on a "discoverable* bus (say PCI) are added when the *controller* is
> probed, not when *they* are probed.

Okay, so maybe "discoverable buses" isn't the proper term.

>
> You very much need to have a struct device registered to be able to call
> really_probe() for it.

Yes. But my point is that the struct device may be created dynamically
at some point in time.

This is how mmc/sd/sdio cards are handled. We don't have the
information about the card and thus not the struct device of it, until
we have detected it. Maybe we could at that point try to add the
device to its PM domain?

>
>> Now, I haven't yet seen a demand for such a cases, but it seems wrong
>> to not consider them. The current solution cover these.
>
> Oh dear.  Please rethink this.

Currently, dev_pm_domain_attach() is being invoked at the point when a
SDIO card has been found. From sdio_add_func(). How would that be
solved?

Kind regards
Uffe

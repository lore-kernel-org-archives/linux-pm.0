From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Thu, 07 May 2015 23:03:32 +0200
Message-ID: <1563819.JLKVYTDD3B@vostro.rjw.lan>
References: <1413881397.30379.7.camel@hadess.net> <26037972.gZDpmonflh@vostro.rjw.lan> <20150507175456.51376473@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54500 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751253AbbEGUi2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 16:38:28 -0400
In-Reply-To: <20150507175456.51376473@lxorguk.ukuu.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Chirantan Ekbote <chirantan@chromium.org>, Olof Johansson <olof@lixom.net>, John Stultz <john.stultz@linaro.org>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Linux PM list <linux-pm@vger.kernel.org>

On Thursday, May 07, 2015 05:54:56 PM One Thousand Gnomes wrote:
> On Tue, 05 May 2015 14:31:26 +0200
> 
> > For example, when you wake up from S3 on ACPI-based systems, the best you
> > can get is what devices have generated the wakeup events, but there's
> > no input available from that (like you won't know which key has been
> > pressed).  You may not get that even.  You may only know what GPEs have
> > caused the wakeup to happen and they may be shared.
> > 
> > For PCI wakeup, the wakeup event may be out of band.  You need to walk
> > the hierarchy and check the PME status bits to identify the wakeup device
> > and then you need to be careful enough not to reset it while putting into
> > D0 for the input data associated with the event to be available.  I'm not
> > sure how many device/driver combinations this actually works for.
> > 
> > For USB wakeup, you get the wakeup event from the controller which may be
> > a PCI device.  Getting to the USB device itself from there requires some
> > work and even then the device may not "remember" what exactly happened.
> > 
> > Further, if you wake up via the PC keyboard from suspend-to-idle, the
> > wakeup key code is not available, the only thing you know is that the
> > interrupts has occured (that may be changed, but it's how the current
> > code works).
> 
> It's probably got to change, otherwise once machines get able to sleep
> between keypresses it's going to suck every time you pause and think for
> a minute then begin typing. Remember display being off for suspend is
> purely a limitation of most current display panels.

Right.

It is just one example, though.

Take a PCI device in D3hot for another one.  It may not even have a buffer
to store input data while in that state.  The only thing it may be able to
do is to signal a PME from it.

Rafael


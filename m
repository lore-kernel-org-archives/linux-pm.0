From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Thu, 7 May 2015 17:54:56 +0100
Message-ID: <20150507175456.51376473@lxorguk.ukuu.org.uk>
References: <1413881397.30379.7.camel@hadess.net>
	<2236285.G0hRnmeVkc@vostro.rjw.lan>
	<CAAObsKBRs7iD2hHa0smhz-1c2e6HW+r2_CxPhv48Cs4yH+npUQ@mail.gmail.com>
	<26037972.gZDpmonflh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26037972.gZDpmonflh@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Chirantan Ekbote <chirantan@chromium.org>, Olof Johansson <olof@lixom.net>, John Stultz <john.stultz@linaro.org>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 05 May 2015 14:31:26 +0200

> For example, when you wake up from S3 on ACPI-based systems, the best you
> can get is what devices have generated the wakeup events, but there's
> no input available from that (like you won't know which key has been
> pressed).  You may not get that even.  You may only know what GPEs have
> caused the wakeup to happen and they may be shared.
> 
> For PCI wakeup, the wakeup event may be out of band.  You need to walk
> the hierarchy and check the PME status bits to identify the wakeup device
> and then you need to be careful enough not to reset it while putting into
> D0 for the input data associated with the event to be available.  I'm not
> sure how many device/driver combinations this actually works for.
> 
> For USB wakeup, you get the wakeup event from the controller which may be
> a PCI device.  Getting to the USB device itself from there requires some
> work and even then the device may not "remember" what exactly happened.
> 
> Further, if you wake up via the PC keyboard from suspend-to-idle, the
> wakeup key code is not available, the only thing you know is that the
> interrupts has occured (that may be changed, but it's how the current
> code works).

It's probably got to change, otherwise once machines get able to sleep
between keypresses it's going to suck every time you pause and think for
a minute then begin typing. Remember display being off for suspend is
purely a limitation of most current display panels.


Alan

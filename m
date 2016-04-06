From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 6 Apr 2016 09:15:26 +0800
Message-ID: <20160406011526.GB6301@shlinux2.ap.freescale.net>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <20160405064637.GA31351@shlinux2.ap.freescale.net>
 <CAMz4kuKWpFLbYJM+m3syT+aMNVxjBipU_3=qwz=X0L_oB5bR0w@mail.gmail.com>
 <20160405081222.GC31351@shlinux2.ap.freescale.net>
 <20160405165305.GD1924@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35576 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758870AbcDFBWJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 21:22:09 -0400
Content-Disposition: inline
In-Reply-To: <20160405165305.GD1924@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 05, 2016 at 09:53:05AM -0700, Mark Brown wrote:
> 
> > > The framework does not want to focus on charger detection too much,
> > > and just supplies one callback '->charger_detect()' for user to be
> > > implemented if they ensure they need to do the SW charger detection
> > > manually (Note: must at the right time to do the SW detection.). So
> > > the usb charger just focus on dealing with the usb gadget power
> > > negotiation, and it does not need to care much how to do charger
> > > detection on your platform.
> 
> > No, this comment is common one, but only for SW detection. Eg, when
> > the PMIC tells you it is a SDP, you can't notify to charger IC about
> > 500mA at once, you need to do it after host allows you to do it.
> 
> Note that this isn't just the charger device that needs to constrain
> current consumption - it's the entire system.  You can't charge to the
> limit for system power draw if the USB controller is supplying the main
> system rail.

Sorry, I can't catch up you. USB Host (SDP or CDP) supplies power for
USB device (not only USB controller, it is the whole system), it can
supply more power after set configuration. See 1.4.13 from BC 1.2.

An SDP expects a downstream device with a good battery to draw less than
2.5mA average when unconnected or suspended, up to 100mA maximum when
connected and not configured and not suspended, and up to 500mA maximum
if so configured and not suspended.

-- 

Best Regards,
Peter Chen

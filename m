From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Tue, 22 Mar 2016 12:29:40 +0100
Message-ID: <20160322112940.GB26924@xo-6d-61-c0.localdomain>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51002 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbcDJSbL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2016 14:31:11 -0400
Content-Disposition: inline
In-Reply-To: <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

Hi!

> > It's your HW :-) You tell me if it's really necessary. But, hey, if you
> > get enumerated @500mA, this is the host telling you it _CAN_ give you
> > 500mA. In that case, why wouldn't you ?

Dunno, perhaps not to drain battery in host too quickly?
Or perhaps you are charging from external battery?

> >>> why RW ? Who's going to use these ? Also, you're not documenting this
> >>> new sysfs file.
> >>
> >> Cause we have show and store operation for SDP type. If users want to
> >> know or set the SDP current, they can use the sysfs file.
> >> I'll add the documentation for it.
> >
> > but why would the user change it ? Here's the thing: you have a few
> > posibilities for this:
> >
> > a) you are connected to a dedicated charger
> >
> >         In this case, you can get up to 2000mA depending on the charger.
> >
> >         If $this charger can give you or not 2000mA is not detectable,
> >         so what do charging ICs do ? They slowly increase the attached
> >         load accross VBUS/GND and measure VBUS value. When IC notices
> >         VBUS dropping bit, step back to previous load.
> >
> >         This means you will always charger with maximum rating of DCP.
> >
> >         Why would user change this ? More is unsafe, less is just
> >         stupid.

Less is not neccessarily stupid. First, it is useful for debugging, second, you
don't know how much this charger can give you. You measured you can get 1.8A,
but the note on the charger says 1.5A. You may want to go with 1.5A.

Also, there are several incompatible standards for detecting "dedicated charger". IIRC
iPhone has different one from iPad. So it is quite important to be able to control this manually.


> > d) you are connected to a standard port and get enumerated with your
> > 100mA configuration.
> >
> >         you *know* 100mA is okay. So you connect a 100mA load and get it
> >         over with.
> >
> >         This means you will always charger with maximum rating for this
> >         SDP.
> >
> >         Why would user change this ? More is unsafe, less is just
> >         stupid.

I've needed to override 100mA default many times. Maybe it is unsafe,
but it is useful.

(And with USB 5V connected directly to pretty beefy PC power supply...
it is sometimes safer than it looks).

Plus, again, useful for debugging.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

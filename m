From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 15 Sep 2016 12:33:52 +0200
Message-ID: <20160915103352.GC13132@amd>
References: <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name>
 <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name>
 <20160909110727.GI27946@sirena.org.uk>
 <87pooc7n3t.fsf@notabene.neil.brown.name>
 <20160912122549.GZ27946@sirena.org.uk>
 <87inu11c5l.fsf@notabene.neil.brown.name>
 <20160912152627.GA27946@sirena.org.uk>
 <877fag1b6r.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877fag1b6r.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>USB <lin>
List-Id: linux-pm@vger.kernel.org

Hi!

> > That's not actually 100% clear to me - for what the wm831x is doing it
> > probably *does* want the higher limit.  This is a system inflow limit
> > (as it should be for this), at least the charger will adapt to voltage
> > variations though other users in the system are much less likely to do
> > so.
> 
> Interesting ... I hadn't considered that possibility.
> 
> As long as the current remains below the maximum, the charger will
> reduce the voltage towards 2V as load increases.  Somewhere before it
> gets there, the system will not be able to make use of the power as the
> voltage will be too low to be usable. So that will naturally limit the
> current being drawn.
> 
> Not having very much electrical engineering background, I cannot say for
> sure what will happen, but it seems likely that once the voltage drops
> much below 4.75V, the charger won't be operating at peak efficiency,
> which would be a waste.
> I can easily imagine that the hardware would switch off at some voltage
> level, rather than just making do with what is there.
> So I'm skeptical of this approach, but I'm open to being corrected by
> someone more knowledgeable than I.

Devices I seen charge down to ~4.2V. This is useful thing to play
with:

dx.com: 406496
1" USB Current & Voltage Detector Tester Meter w/ Red LED Display -
Blue

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

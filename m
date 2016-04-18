From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 13:23:28 +0200
Message-ID: <20160418112328.GA31284@amd>
References: <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <20160322113012.GC26924@xo-6d-61-c0.localdomain>
 <87fuujgwsm.fsf@intel.com>
 <20160418102316.GA27936@amd>
 <877ffvgqe9.fsf@intel.com>
 <20160418103945.GA29123@amd>
 <063D6719AE5E284EB5DD2968C1650D6D5F4A444E@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4A444E@AcuExch.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: Felipe Balbi <balbi@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

On Mon 2016-04-18 10:59:23, David Laight wrote:
> From: Pavel Machek
> > Sent: 18 April 2016 11:40
> ...
> > > >> > Actually, less is not stupid. Charging li-ion battery from li-ion battery might
> > > >> > be stupid. Imagine I'm on train, with device like N900 (50% battery) and power bank
> > > >> > (3Ah). I'm actively using the device. If I let it charge at full current, I'll waste
> > > >> > energy. If I limit current to approximately the power consumption, it will run the
> > > >> > powerbank empty, first, then empty the internal battery, maximizing total time I
> > > >> > can use the device.
> > > >>
> > > >> why would you waste energy ? What the charger chip would do is charge
> > > >> battery to maximum then just to maintenance charge from that point
> > > >> on. Where is energy being wasted other than normal heat dissipation ?
> > > >
> > > > Physics 101, of course wasted energy goes to heat. Lets not waste
> > > > energy by charging li-ion from li-ion when it is not required.
> > >
> > > your cellphone has no means to know that it's connected to a Li-Ion
> > > battery. We don't have visibility on what we're connected to, just how
> > > much it can source.
> > 
> > But cellphone user knows what he connected his charger to, and that's
> > why it is useful to be able to lower the current. Even when you said
> > "less is just stupid" I demonstrated it is not, at least in case when
> > your power source is a battery.
> 
> It reality you may want the phone/tablet to be configurable to take power
> from USB, but disable the li-ion charging circuit.
> That will maximise the time you get when running from an external battery.
> I connect my tablet to the 1A output (which discharges the internal battery
> slowly) rather than the 2A one (which will charge it with some
> cables).

Yes, being able to power device from external without charging the
battery is useful, too.

But I'd still like to control individual currents, too. If I have
power bank and two devices, I may want to select which one charges
faster.

Best regards,									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

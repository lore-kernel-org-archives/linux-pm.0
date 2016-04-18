From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 12:39:45 +0200
Message-ID: <20160418103945.GA29123@amd>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <20160322113012.GC26924@xo-6d-61-c0.localdomain>
 <87fuujgwsm.fsf@intel.com>
 <20160418102316.GA27936@amd>
 <877ffvgqe9.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877ffvgqe9.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2016-04-18 13:30:54, Felipe Balbi wrote:
> 
> Hi,
> 
> Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:
> >> > Very often, you want to charge using 1.8A from an old desktop PC.
> >> 
> >> if that old desktop's port is not a charging port, you shouldn't be
> >> allowed to do that. Not ever.
> >
> > Yes, Felipe just decided that I should not be able to charge my N900
> > in useful way.
> 
> you can do whatever you want with *your* kernel binary, but we're not
> gonna ship something potentially dangerous. If that PC port is telling
> you it can only allow 100mA, you should *not* be allowed to overcome
> that limitation from the device side, sorry.

Yes, and if your cpu tells you it can only run on 2GHz, you should not
be able to run it on 2.1GHz. And you should not be able to use
non-VESA VGA modes, because you could overheat coils in the monitor.

You are shipping something potentially dangerous already, because you
know, USB-A-to-micro-B cables with D+/D- connected to simulate charger
are actually very common. The world did not end, yet, so it is clearly
not as bad as you make it be.

> >> >> a) you are connected to a dedicated charger
> >> >> 
> >> >> 	In this case, you can get up to 2000mA depending on the charger.
> >> >> 
> >> >> 	If $this charger can give you or not 2000mA is not detectable,
> >> >> 	so what do charging ICs do ? They slowly increase the attached
> >> >> 	load accross VBUS/GND and measure VBUS value. When IC notices
> >> >> 	VBUS dropping bit, step back to previous load.
> >> >> 
> >> >> 	This means you will always charger with maximum rating of DCP.
> >> >> 
> >> >> 	Why would user change this ? More is unsafe, less is just
> >> >> 	stupid.
> >> >
> >> > Actually, less is not stupid. Charging li-ion battery from li-ion battery might
> >> > be stupid. Imagine I'm on train, with device like N900 (50% battery) and power bank
> >> > (3Ah). I'm actively using the device. If I let it charge at full current, I'll waste
> >> > energy. If I limit current to approximately the power consumption, it will run the
> >> > powerbank empty, first, then empty the internal battery, maximizing total time I
> >> > can use the device.
> >> 
> >> why would you waste energy ? What the charger chip would do is charge
> >> battery to maximum then just to maintenance charge from that point
> >> on. Where is energy being wasted other than normal heat dissipation ?
> >
> > Physics 101, of course wasted energy goes to heat. Lets not waste
> > energy by charging li-ion from li-ion when it is not required.
> 
> your cellphone has no means to know that it's connected to a Li-Ion
> battery. We don't have visibility on what we're connected to, just how
> much it can source.

But cellphone user knows what he connected his charger to, and that's
why it is useful to be able to lower the current. Even when you said
"less is just stupid" I demonstrated it is not, at least in case when
your power source is a battery.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

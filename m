From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 13:03:29 +0200
Message-ID: <20160418110329.GA29438@amd>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com>
 <20160322112940.GB26924@xo-6d-61-c0.localdomain>
 <87d1pngwjb.fsf@intel.com>
 <20160418103350.GB27936@amd>
 <871t63gpqj.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871t63gpqj.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> manually ??? Hell no! Charger IC should be able to do this no
> >> problem. I would be surprised if there's any charger IC out there which
> >> blindly connects a 1.8A load from the start. What these ICs do is that
> >> they slowly increment the load and check voltage level. They'll continue
> >> to do that up to the maximum you listed (1.8A, let's say). As soon as
> >> voltage drops a bit, charger IC knows that it use previous load.
> >
> > As I explained, if the note on the wall charger says 1.5A, you want to
> > do 1.5A, not 1.8A. You can measure voltage on the charger, but you
> > don't know its temperature.
> 
> phone can't read what it says in the wall charger, nor can it know that
> it's connected charger ABC and not charger XYZ. Think of the user
> experience. You can't expect users to tell you "okay phone, the charger
> reads that maximum is 1.5A, so please don't go over that."

Of course, we may do something sensible by default. But manual
controls should still be present. You called them "stupid" but they
are not.

Note that just because you detected wall charger does not even mean
you are connected to wall charger. See the link below.

> >> still unsafe. If you really wanna do that, you're welcome to removing
> >> safety margins from your own kernel, but we're definitely not going to
> >> ship this to millions of users.
> >
> > Not more unsafe than loading wall chargers with "lets see how much we
> > can get out of it" algorithm. Plus actually required to charge your
> 
> it actually _is_ more unsafe. You could burn mother boards with that. If
> host tells you it only has 100mA power budget left, why are you trying
> to get more ?

No, you can't burn motherboard like that... You can force emergency
shutdowns, which is also bad, but... There are many devices that break
this aspect of USB protocol.

https://www.kickstarter.com/projects/1785889318/doubbletime-charging-cable-full-battery-in-1-2-the

> > Unfortunately, there's more than one standard for detecting charger,
> > so manual control will probably be required.
> 
> n900 never had manual control of anything. It was just using information
> given by the battery IC, charger IC and twl4030 madc.

Manual control of n900 charging is done by:

echo 1800 > /sys/class/power_supply/bq24150a-0/current_limit

> >> > (And with USB 5V connected directly to pretty beefy PC power supply...
> >> > it is sometimes safer than it looks).
> >> 
> >> you're not considering the thermal dissipation on the USB connector
> >> itself. Many of them might not use good metals because they assume the
> >> maximum power dissipated is 500mA * 5V = 2.5W. If you try to draw more,
> >> you could, literally, melt the connector.
> >
> > If you are dissipating 2.5W at the connector, you are doing something
> > very wrong. You should not be short-circuiting your USB... even when
> > the ports are usually designed to survive that.
> 
> yes. You shouldn't. You also shouldn't go over that limit. If you have a
> 500mA total power budget, we should not let anybody try to draw more
> because we have no control over what's on the side of the wire.

They already can go over the limit, for example using cable linked
above. I have several such cables here. I also have various wall
supplies that are not detected as a wall supply by N900. So I either
have to remember and connect them with the "special" cable, or
(easier) use the override above to get useful charging.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

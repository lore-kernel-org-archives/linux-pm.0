From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 15:16:23 +0200
Message-ID: <20160418131623.GA4372@amd>
References: <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com>
 <20160322112940.GB26924@xo-6d-61-c0.localdomain>
 <87d1pngwjb.fsf@intel.com>
 <20160418103350.GB27936@amd>
 <871t63gpqj.fsf@intel.com>
 <20160418110329.GA29438@amd>
 <87potnf83c.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87potnf83c.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Of course, we may do something sensible by default. But manual
> > controls should still be present. You called them "stupid" but they
> > are not.
> >
> > Note that just because you detected wall charger does not even mean
> > you are connected to wall charger. See the link below.
> 
> that's a horrible product. So what ? If you want to use that, be my
> guest. Just, again, don't ask for support when things start falling
> apart ;-)

So you have USB spec? So what? There are many such products out there,
and I have at least two such cables here.

They did not cause end of the world, yet, and they are actually very useful.

> >> >> still unsafe. If you really wanna do that, you're welcome to removing
> >> >> safety margins from your own kernel, but we're definitely not going to
> >> >> ship this to millions of users.
> >> >
> >> > Not more unsafe than loading wall chargers with "lets see how much we
> >> > can get out of it" algorithm. Plus actually required to charge your
> >> 
> >> it actually _is_ more unsafe. You could burn mother boards with that. If
> >> host tells you it only has 100mA power budget left, why are you trying
> >> to get more ?
> >
> > No, you can't burn motherboard like that... You can force emergency
> > shutdowns, which is also bad, but... There are many devices that break
> > this aspect of USB protocol.
> >
> > https://www.kickstarter.com/projects/1785889318/doubbletime-charging-cable-full-battery-in-1-2-the
> 
> we can't prevent people from coming up with bad devices/cables/whatever,
> right ? But we can make sure that overcoming a 500mA power budget on a
> USB 2.0 port will not be allowed.

No, you can't, because you don't know if you are connected to USB 2.0
port. (Because non-compliant cables exist).

> >> > Unfortunately, there's more than one standard for detecting charger,
> >> > so manual control will probably be required.
> >> 
> >> n900 never had manual control of anything. It was just using information
> >> given by the battery IC, charger IC and twl4030 madc.
> >
> > Manual control of n900 charging is done by:
> >
> > echo 1800 > /sys/class/power_supply/bq24150a-0/current_limit
> 
> yes, that's fine. And if you're connected to a dedicated charger (DCP)
> which follows USB Battery Charger specification, we *know* that it
> should, per the spec, source up to 2A, so this is fine.

BTW have you ever seen such USB-compliant dedicated charger? I have
more than 5 chargers here, and not one of them is 2A. (Most are .5A,
some are 1A, one is 1.2A).

> However, if you're connected to SDP (regular PC port), which has a power
> budget of 500mA per-port (meaning, that if you're behind a bus powered
> hub, you can't even get 500mA), then this write() of yours should be
> invalid. It should *not* be a successful write() as that creates an
> unsafe and potentially dangerous scenario for the user.

Yes, USB is "potentially dangerous", because noone follows the
specs. Fortunately, everyone knows (except you?) that noone follows
the specs, so the hardware can deal with that, and they include
(poly?) fuses where neccessary.

> > They already can go over the limit, for example using cable linked
> > above. I have several such cables here. I also have various wall
> 
> people can use unsupported cable assemblies if they want, but you can't
> expect kernel to support you.

Then we won't have useful charging support in kernel.

> > supplies that are not detected as a wall supply by N900. So I either
> > have to remember and connect them with the "special" cable, or
> > (easier) use the override above to get useful charging.
> 
> those supplies are not supported by N900. N900 was designed with USB
> Battery Chaging specification in mind and Nokia is not around anymore to
> give you SW updates. Sorry, but that's not the kernel's fault.
> 
> The point is the following: there are a handful of people who would
> *know* how to fiddle with these limits, many would not. The vast
> majority would not. And, considering this is something completely out of
> spec, and, again, potentially dangerous to the user, we are not going to
> support it.

You speak about dangerous where little danger exist; number of
non-compliant cables and USB devices is very high (take your power
bank. Does it really limit to .5A when charging from computer?) and we
should support them, not cry "dangerous" and force everyone to come
with their own "solutions".

> You may use your hacked up cables, not a problem. I did that myself
> during N900 development (though I was using a lab power supply with a 2A
> current limit sourcing 5V) to test port type detection and charging
> algorithm. But that's really not something any company (or this
> community) will support.

Fortunately, that's not your decision and community already decided
the other way.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

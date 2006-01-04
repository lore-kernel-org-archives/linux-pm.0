From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Wed, 4 Jan 2006 22:34:05 +0100
Message-ID: <20060104213405.GC1761@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751770AbWADVeQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On =DAt 27-12-05 20:22:04, Patrick Mochel wrote:
>=20
>=20
> On Tue, 27 Dec 2005, Pavel Machek wrote:
>=20
> > Hi!
> >
> > > >  static ssize_t state_show(struct device * dev, struct device_a=
ttribute *attr, char * buf)
> > > >  {
> > > > -       return sprintf(buf, "%u\n", dev->power.power_state.even=
t);
> > > > +       if (dev->power.power_state.event)
> > > > +               return sprintf(buf, "suspend\n");
> > > > +       else
> > > > +               return sprintf(buf, "on\n");
> > > >  }
> > >
> > > Are you sure that having only 2 options (suspend/on) is enough at=
 the
> > > core level? I could envision having more levels, like "poweroff",=
 etc?
> >
> > Note that interface is 0/2, currently, so this is improvement :-).
>=20
> Heh, not really. You're not really solving any problems, only giving =
the
> illusion that you've actually fixed something.

Except perhaps userspace passing invalid values down to drivers in
pm_message_t.event?

> As I mentioned in the thread (currently happening, BTW) on the linux-=
pm
> list, what you want to do is accept a string that reflects an actual =
state
> that the device supports. For PCI devices that support low-power stat=
es,
> this would be "D1", "D2", "D3", etc. For USB devices, which only supp=
ort
> an "on" and "suspended" state, the values that this patch parses woul=
d
> actually work.

We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
"D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
and I'm not sure about those "D1" and "D2" parts. Userspace should not
have to know about details, it will mostly use "on"/"suspend" anyway.

> > One day, when we find device that needs it, we may want to add more
> > states. I don't know about such device currently.
>=20
> There are many devices already do - there are PCI, PCI-X, PCI Express=
,
> ACPI devices, etc that do. But, you simply cannot create a single
> decent

I asked for an example.
								Pavel
--=20
Thanks, Sharp!

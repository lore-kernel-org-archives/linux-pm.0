From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Fri, 6 Jan 2006 01:07:05 +0100
Message-ID: <20060106000704.GD3339@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz> <Pine.LNX.4.50.0601051359290.10834-100000@monsoon.he.net> <20060105224403.GJ2095@elf.ucw.cz> <Pine.LNX.4.50.0601051546380.10428-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932297AbWAFAHY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0601051546380.10428-100000@monsoon.he.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On =C4=8Ct 05-01-06 15:54:15, Patrick Mochel wrote:
>=20
> On Thu, 5 Jan 2006, Pavel Machek wrote:
>=20
> > On =C4=8Ct 05-01-06 14:15:39, Patrick Mochel wrote:
>=20
> > > It should be replaced with a file exported by the bus driver that=
 exports
> > > the actual states that the device supports. The parsing can easil=
y happen
> > > at this point, because the bus knows what a good value is.
> >
> > (1) would change core<->driver interface
>=20
> It's broken anyway for runtime power management.

Please explain. As far as I can see, it is fairly simple, but good
enough. pm_message_t.flags indicating it is runtime suspend would be
nice, but I do not think it is broken.

> > (2) is quite a lot of work
>=20
> In the long run, it's not.

Nobody fixed it in a year, so apparently it is a lot of work.

> > (3) ...with very little benefit, until drivers support >2 states
>=20
> Without it, you are preventing drivers from being able to support > 2
> states.

0 drivers support > 2 states. So it is indeed very little benefit.

> > If you want to rewrite driver model for >2 states, great, but that =
is
> > going to take at least a year AFAICS, so please let me at least fix
> > the bugs in meantime.
>=20
> It's a band-aid; it is not a long-term solution.

But band-aid is apparently neccessary unless you want drivers to see
invalid values.

> > > The userspace interface is broken. We can keep it for compatabili=
ty
> > > reasons, but there needs to be a new interface.
> >
> > I assumed we could fix the interface without actually introducing >=
2
> > states support. That can be done in reasonable ammount of code.
>=20
> The interface is irreparably broken. You can't fix it with an infinit=
e
> number of band aids.

Without "band aids", you'll get BUG()s all over the kernel.

> > > I don't understand what you're saying. If I have a driver that Iw=
ant to
> >                                          ~~~~~~~~~~~~~~~~~~
> > > make support another power state and I'm willing to write that co=
de, then
> > > there is a clear benefit to having the infrastructure for it to "=
just
> > > work".
> >
> > I do not see such drivers around me, that's all. It seems fair to m=
e
> > that first driver author wanting that is the one who introduces >2
> > states support to generic infrastructure.
>=20
> Just because you personally have not seen such things does not mean t=
hey
> do not exist.

Just because you claim they exist does not mean they exist.

> > Passing "on"/"off" down to radeon lets the driver decide what power
> > state it should enter.
>=20
> Driver implements power state policy? Sounds like that policy would f=
ind a
> much more comfortable home in userspace.

Userspace can't know that driver does not support D3 on this
particular hardware version because of hardware problems... or simply
because it is not yet implemented.
								Pavel
--=20
Thanks, Sharp!

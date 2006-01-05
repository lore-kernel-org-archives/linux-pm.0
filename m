From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Thu, 5 Jan 2006 22:14:46 +0100
Message-ID: <20060105211446.GD2095@elf.ucw.cz>
References: <200601051516.k05FGC5d023781@olwen.urbana.css.mot.com> <Pine.LNX.4.44L0.0601051136230.5520-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932208AbWAEVPN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601051136230.5520-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Scott E. Preece" <preece@motorola.com>, akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On =C4=8Ct 05-01-06 11:41:34, Alan Stern wrote:
> On Thu, 5 Jan 2006, Scott E. Preece wrote:
>=20
> > My inclination would be to have the sysfs interface know generic te=
rms,
> > with the implementation mapping them to device-specific terms. It o=
ught
> > to be possible to build portable tools that don't have to know abou=
t
> > device-specific states and have the device interfaces (in sysfs) do=
 the
> > necessary translation.
> >=20
> > However, I also think there is value in having the sysfs interface
> > recognize the device-specific values as well, so that device-specif=
ic
> > tools can also be written (offering the option of taking advantage =
of
> > special capabilities of a particular device).
>=20
> Yes, that was part of my point.
>=20
> > | > It would be good to make the details available so that they are=
 there when
> > | > needed.  For instance, we might export "D0", "on", "D1", "D2", =
"D3", and
> > | > "suspend", treating "on" as a synonym for "D0" and "suspend" as=
 a synonym
> > | > for "D3".
> > |=20
> > | Why to make it this complex?
> > |=20
> > | I do not think there's any confusion possible. "on" always corres=
ponds
> > | to "D0", and "suspend" is "D3". Anyone who knows what "D2" means,
> > | should know that, too...
>=20
> Not necessarily.  For instance, a particular driver might want to map=
=20
> "suspend" to D1 instead of to D3.

Ok, lets change that to "on" and "off". That way, hopefully all the
drivers will agree that "off" means as low Dstate as possible.
=20
> Given that "on" and "suspend" are generic names and not actual states=
 (at=20
> least, not for PCI devices and presumably not for others as well), I =
think=20
> it makes sense to treat them specially.
>=20
> And it's not all that complex.  Certainly no more complex than forcin=
g
> userspace tools to use {"on", "D1, "D2", "suspend"} instead of the
> much-more-logical {"D0", "D1", "D2", "D3"}.

It is not much more logical. First, noone really needs D1 and
D2. Plus, people want to turn their devices on and off, and don't want
and should not have to care about details like D1.
							Pavel
--=20
Thanks, Sharp!

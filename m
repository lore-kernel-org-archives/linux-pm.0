From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Mon, 21 Sep 2015 10:51:00 +0200
Message-ID: <20150921085100.GF19865@ulmo.nvidia.com>
References: <CAJZ5v0hYUfO87hGAjKRAZMt_G4NnkEOXuVybSsVmKzAm6vznDA@mail.gmail.com>
 <Pine.LNX.4.44L0.1509171253520.1270-100000@iolanthe.rowland.org>
 <CAJZ5v0gAsgsA+P_oL=KnAwBpkdJY_P733jBnXnGPdFOs5yiUfw@mail.gmail.com>
 <20150918155547.GB6692@ulmo.nvidia.com>
 <CAJZ5v0iFvnYxEfSN9VAdsBhhk9QgSJ+JS-4qsZPBGfatAY7j3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iFvnYxEfSN9VAdsBhhk9QgSJ+JS-4qsZPBGfatAY7j3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 01:07:56AM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 18, 2015 at 5:55 PM, Thierry Reding <thierry.reding@gmail.com=
> wrote:
[...]
> > Of course there's still the matter of some types of devices physically
> > disappearing (USB, PCI, ...).
>=20
> Right.  In some cases removal is simply necessary as part of the
> cleanup, like after a surprise hot-unplug of a device, for example.
> In those cases everything that depended on the device that went away
> should be unbound from drivers at least IMO.

Agreed.

> > Force-removing drivers that depend on a device that's being unbound
> > would be a possibility to solve the problem where consumers depend on a
> > device that could physically go away. It might also be the right thing
> > to do in any case. Presumably somebody unloading a module want to do
> > just that, and refusing to do so isn't playing very nice. Of course
> > allowing random modules to be removed even if a lot of consumers might
> > depend on it may not be friendly either. Consider if you unload a GPIO
> > driver that provides a pin that's used to enable power to an eMMC that
> > might have the root filesystem.
> >
> > Then again, if you unload a module you better know what you're doing
> > anyway, so maybe that's not something we need to be concerned about.
>=20
> I think that it's better to fail module unloads in such cases by
> default (to prevent simple silly mistakes from having possibly severe
> consequences), but if a "force" option is used, we should regard that
> as "the user really means it" and do as requested.  That would be very
> much analogous to the hot-unplug situation from the software
> perspective.

Sounds very reasonable to me.

> > I think this would also tie in nicely with Tomeu's patch set to do
> > on-demand probing. Essentially a [dev_]*_get() call could in turn call
> > this new "declare dependency" API, and the new API could underneath do
> > on-demand probing.
> >
> > Given that this isn't a strictly PM mechanism anymore, perhaps something
> > like:
> >
> >         int device_depend(struct device *dev, struct device *target);
> >
> > would be a more generic option.
>=20
> I thought about something like link_device(dev, target, flags), where
> the last argument would indicate what the core is supposed to use the
> link for (removal handling, system suspend/resume, runtime PM etc).

Sounds good to me. I think the core isn't quite consistent on the naming
of functions, so we have things like device_register/unregister() versus
get/put_device(). I'd lean towards device_link(dev, target, flags), but
I'll go with any color you'd like the shed to have.

> And I agree that this isn't really PM-specific.
>=20
> OK, thanks a lot for the feedback!
>=20
> Let me think about that a bit more and I'll try to come up with a more
> detailed design description.

This sounds like it's not going to make it into v4.3 anymore, so I'll
need to think about the easiest way to (temporarily) fix up the current
regression.

Is this something that you will have time to implement yourself? If so,
please keep me in the loop and Cc me on any patches that you need
tested. If you're short on time, let me know as well and I'll see if I
can take a stab at it myself, though I'm pretty sure I'll need further
guidance along the way.

Thierry

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV/8TxAAoJEN0jrNd/PrOhQN0QALorUGR5rgFM2Q8XXLYN8QQ5
t4kBQTnfh+c/AJMg+EU2CvAztW0Y9r17/Vb3LBnIewhg7sMcMG25qKYrYEMqwHt3
hmefbtRI2EH4O7i3SKn56o6ZiDl1knEDHg1yaIxweA5G2K22QQfDJqhx1GODyDmu
irLXYy/FVs8uFDK7NIYVYqAvrh10Hja2abf+hDzPia1+yxIGi4owter3e8IKbZg8
f8/boc6Gr2kPYmNCjqcyKWK/wDAAAWdXZCwo7wsGjIBbgfx3ctNn6evImZ2UKOG5
D6d6j7eATKlbdzH8Inp/RjlxhcO2s//t3MJ7ge+SMvf3oWrjPCO441jTqi0rB8F+
FSVVJB+9bFj9f23VAYXw+ZmzFDQM3m+Rbqr3azrPRAoh87GgFC9u4ced7svZXVrc
/VSv2kLBEQdTgGsxI+xr951mmjCl9eiFPC+WUh3Sz77JmdiCsEA3aTontqJf2pks
DsBYJRgkypQ8WELbxJ7zCYLYR3xgRlc+MAHYu6vBB0rzujly/J1mck9Z5KJBzfCY
qsAxFIPUTlHoU3KTd4UIaN6Qkl00I+aob/I2R/FBDkIQt+7NMhLLgmvGxqabFVxx
cpnlQCgmkZM0Hrr2mGm+kOmpy1Z5CgSC/JjpguUMga1k1hFoiF/kzJ9nwOYWJ+Vj
dCY4FZ76Sv0c4Z99b2Tu
=lieK
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--

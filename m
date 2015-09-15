From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Tue, 15 Sep 2015 18:10:48 +0200
Message-ID: <20150915161047.GC25966@ulmo.nvidia.com>
References: <20150911120345.GB16323@ulmo>
 <Pine.LNX.4.44L0.1509111445020.1667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37867 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbIOQKv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 12:10:51 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1509111445020.1667-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2015 at 03:01:14PM -0400, Alan Stern wrote:
> On Fri, 11 Sep 2015, Thierry Reding wrote:
>=20
> > On Fri, Sep 11, 2015 at 12:08:02AM +0200, Rafael J. Wysocki wrote:
> > > On Thursday, September 10, 2015 12:19:03 PM Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Deferred probe can lead to strange situations where a device that i=
s a
> > > > dependency for others will be moved to the end of the dpm_list. At =
the
> > > > same time the dependers may not be moved because at the time they w=
ill
> > > > be probed the dependee may already have been successfully reprobed =
and
> > > > they will not have to defer the probe themselves.
> > >=20
> > > So there's a bug in the implementation of deferred probing IMO.
> >=20
> > Well, yeah. The root problem here is that we don't have dependency
> > information and deferred probing is supposed to fix that. It does so
> > fairly well, but it breaks in this particular case.
> >=20
> > > > One example where this happens is the Jetson TK1 board (Tegra124). =
The
> > > > gpio-keys driver exposes the power key of the board as an input dev=
ice
> > > > that can also be used as a wakeup source. Commit 17cdddf0fb68 ("ARM:
> > > > tegra: Add gpio-ranges property") results in the gpio-tegra driver
> > > > deferring probe because one of its dependencies, the pinctrl-tegra
> > > > driver, has not successfully completed probing. Currently the defer=
red
> > > > probe code will move the corresponding gpio-tegra device to the end=
 of
> > > > the dpm_list, but by the time the gpio-keys device, depending on the
> > > > gpio-tegra device, is probed, gpio-tegra has already been reprobed,=
 so
> > > > the gpio-keys device is not moved to the end of dpm_list itself. As=
 a
> > > > result, the suspend ordering becomes pinctrl-tegra -> gpio-keys ->
> > > > gpio-tegra. That's problematic because the gpio-keys driver requests
> > > > the power key to be a wakeup source. However, the programming of the
> > > > wakeup interrupt registers happens in the gpio-tegra driver's suspe=
nd
> > > > callback, which is now called before that of the gpio-keys driver. =
The
> > > > result is that the wrong values are programmed and leaves the system
> > > > unable to be resumed using the power key.
> > > >=20
> > > > To fix this situation, always move devices to the end of the dpm_li=
st
> > > > before probing them. Technically this should only be done for devic=
es
> > > > that have been successfully probed, but that won't work for recursi=
ve
> > > > probing of devices (think an I2C master that instantiates children =
in
> > > > its ->probe()). Effectively the dpm_list will end up ordered the sa=
me
> > > > way that devices were probed, hence taking care of dependencies.
>=20
> I'm not worried about the overhead involved in moving a device to the=20
> end of the list every time it is probed.  That ought to be relatively=20
> small.
>=20
> There are a few things to watch out for.  Since the dpm_list gets
> modified during system sleep transitions, we would have to make sure
> that nothing gets probed during those times.  In principle, that's what
> the "prepare" stage is meant for, but there's still a race.  As long as
> no other kernel thread (such as the deferred probing mechanism) tries
> to probe a device once everything has been frozen, we should be okay.
> But if not, there will be trouble -- after the ->prepare callback runs,=
=20
> the device is no longer on the dpm_list and so we don't want this patch=
=20
> to put it back on that list.

Perhaps moving to the end of the list needs to be a little smarter. That
is it could check whether the device has been prepared for suspension or
not and only move when it hasn't?

Then again, shouldn't the core even prohibit new probes once the suspend
has been triggered? Sounds like asking for a lot of trouble if it didn't
=2E..

> There's also an issue about other types of dependencies.  For instance,
> it's conceivable that device B might be discovered and depend on device
> A, even before A has been bound to a driver.  (B might be discovered by=
=20
> A's subsystem rather than A's driver.)  In that case, moving A to the=20
> end of the list would cause B to come before A even though B depends on=
=20
> A.  Of course, deferred probing already has this problem.

But that's exactly the problem that I'm seeing. B isn't discovered by
A's subsystem, but the type of dependency is the same. A in this case
would be the GPIO controller and B the gpio-keys device. B clearly
depends on A, but deferred probe currently moves A to the end of the
list but not A, hence why the problem occurs.

That's also a problem that I think this patch solves. By moving every
device to the end of the list before it is probed we ensure that the
dpm_list is ordered in the same way as the probe order. For this to work
the precondition of course is that drivers know about the dependencies
and will defer probe if necessary.

> An easy way to check for this sort of thing would be to verify that a=20
> device about to be probed doesn't have any children.  This wouldn't=20
> catch all the potential dependencies, but it would be a reasonable=20
> start.  Do we currently check that after a device has been unbound, it=20
> doesn't have any remaining children?  We should do that too.

I think that would cover the other half of the cases where deferred
probe isn't implemented because drivers are written with the assumption
that children will be instantiated after their parent has been probed.

But it won't catch all the cases where there is no parent-child
relationship between the depender and the dependee.

Thierry

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV+EMEAAoJEN0jrNd/PrOhLOQQALQr/ehPSGS4014I8O6OH6Uq
CIxbtie2/yvSn1IzZLPNINxf5lytSu6mwkPWr9fKN6o5nQZyYBNpAtuvDI45SIzd
wS0AClvlP69PEXfMj+lQDkx+yDcwQQa12JuxwsP/DA6SRyvG4h09vNKQbzS5dOwF
v8ypdap1eaz133FmbePaZCMBeV5qSc+JVk53b5gbnrNywUmyRmWNGOWcBdpCgi+F
2oc8a5nFpIdf0yJbg8FkC+0DW3be5XoymyRF+Hw9oIpt812o/grli+HFpUGwuYhx
Y5equPUDwrf2Is0UguxRO5ipydipR65Vv+gpKmBJITqCG3fVTgKy72jpWZYI5PD8
bbvxgnYxvT/UmnQSItx63YqUttF1jf5Rs94UH2AqitikExmCyxLwfmEVmR81+4A6
RbzRMywDSVSc2GNR80ezd8PlZbAYqeZCWkdlIePXswPK0j8+OZuk6jm6STQiqYDZ
wQPPpQJvYPk+oWSW4pu0Uw18HotSs5kBlQD4S1xGKd3uiA9UrkHeQfmGhm62iFIU
7aTxobdMP8BF7Hye4cOt6V95TUkkv4t+CCTKeLJEIwV+XaiwTa1eFsKSI4lYZloA
pXeGOeXDh68iJwCzBVgdgs2S7oF0ibqYkZTKASCkZrPEuJiZlaSJ1xX85eJw5r3+
9/knCE0WSVV6vdQnXdJ0
=kO8d
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--

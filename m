From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Wed, 16 Sep 2015 15:16:43 +0200
Message-ID: <20150916131641.GA13618@ulmo>
References: <20150915161047.GC25966@ulmo.nvidia.com>
 <Pine.LNX.4.44L0.1509151505040.1420-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33478 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbIPNQq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 09:16:46 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1509151505040.1420-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 03:18:19PM -0400, Alan Stern wrote:
> On Tue, 15 Sep 2015, Thierry Reding wrote:
>=20
> > > There are a few things to watch out for.  Since the dpm_list gets
> > > modified during system sleep transitions, we would have to make sure
> > > that nothing gets probed during those times.  In principle, that's wh=
at
> > > the "prepare" stage is meant for, but there's still a race.  As long =
as
> > > no other kernel thread (such as the deferred probing mechanism) tries
> > > to probe a device once everything has been frozen, we should be okay.
> > > But if not, there will be trouble -- after the ->prepare callback run=
s,=20
> > > the device is no longer on the dpm_list and so we don't want this pat=
ch=20
> > > to put it back on that list.
> >=20
> > Perhaps moving to the end of the list needs to be a little smarter. That
> > is it could check whether the device has been prepared for suspension or
> > not and only move when it hasn't?
>=20
> Maybe.  But doesn't that mean it won't solve your problem completely?

It would solve the problem completely if probing was prohibited during
the suspend/resume cycle. But if that were true there'd be no need to
special-case in the first place.

> > Then again, shouldn't the core even prohibit new probes once the suspend
> > has been triggered? Sounds like asking for a lot of trouble if it didn't
> > ...
>=20
> The core prohibits new devices from being registered.  It does not=20
> prohibit probes of existing devices, because they currently do not=20
> affect the dpm_list.

My understanding was that the core was guaranteed not to call suspend or
resume callbacks for devices that haven't completed probe. At least I've
never seen any driver code specifically check in their suspend or resume
callbacks that they've been probed successfully. Allowing probes while a
suspend is happening sounds racy.

> In general, we rely on subsystems not to do any probing once a device=20
> is suspended.  It's probably reasonable to ask them not to do any=20
> probing once a device has gone through the "prepare" stage.

Perhaps the reason why we seem to be talking across purposes is that I
haven't thought much about devices where the bus does all the heavy
lifting. So suspending the device from a bus' perspective makes sense
even if the device hasn't been bound.

And yes, I agree that preventing a probe for a device that has been
prepared for suspension sounds like a very reasonable thing to do.

> > > There's also an issue about other types of dependencies.  For instanc=
e,
> > > it's conceivable that device B might be discovered and depend on devi=
ce
> > > A, even before A has been bound to a driver.  (B might be discovered =
by=20
> > > A's subsystem rather than A's driver.)  In that case, moving A to the=
=20
> > > end of the list would cause B to come before A even though B depends =
on=20
> > > A.  Of course, deferred probing already has this problem.
> >=20
> > But that's exactly the problem that I'm seeing.
>=20
> Not quite.
>=20
> >  B isn't discovered by
> > A's subsystem, but the type of dependency is the same. A in this case
> > would be the GPIO controller and B the gpio-keys device. B clearly
> > depends on A, but deferred probe currently moves A to the end of the
> > list but not A, hence why the problem occurs.
>=20
> The difference is that in my example, B can be probed before A.  In
> your case it can't.  Therefore the patch works for your case but not
> for mine.

How would that even work in practice? Essentially you have a dependency
between two devices and no way of guaranteeing any ordering. Either the
dependency is completely optional, in which case the ordering of the
dpm_list must be irrelevant to the interaction, or the drivers make too
many assumptions and it is only working by accident.

> > That's also a problem that I think this patch solves. By moving every
> > device to the end of the list before it is probed we ensure that the
> > dpm_list is ordered in the same way as the probe order. For this to work
> > the precondition of course is that drivers know about the dependencies
> > and will defer probe if necessary.
>=20
> Do I understand correctly?  You're saying a driver must defer a probe
> if the device it's probing depends on another device which hasn't
> been bound yet.  That does not sound like a reasonable sort of
> requirement -- we might know about the dependency but we shouldn't have
> to check whether the prerequisite device has been bound.

I guess that depends on the kind of dependency you have. For most cases
that I'm aware of the dependencies are required dependencies. That is, a
consumer uses a resource registered by a provider. The provider will
register the resource at probe time, so if the consumer is probed before
the provider, then the resource it needs isn't there. For a required
dependency that implies that the consumer must defer probe until the
provider has been bound because it simply can't continue without getting
access to the resource first.

I'm slightly confused by your statement. If a consumer depends on a
provider for a resource, how can we finish the consumer's probe without
checking that the provider has been bound? It's true that we don't
technically check for the device to have been bound, but the end result
is the same.

Unless I misunderstand what you're saying we'd need to have some
mechanism to notify the consumer (after it's been probed) that the
provider of it's resource has become available.

Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV+Wu3AAoJEN0jrNd/PrOhKAwP/Rv/2w7/x+FTd7YglBDKHXu9
G/Q0wwYjHHz/edGeabBs3zkcq/y83OaZX3BudSpEH4YXWbjUv3lzpobhL1MzPYKK
bkLHeqYga51y6bTP1OJkmSZTQmrM7NHyZlF8b/0jo5tAzW8r5Is0/7rXZOq+QFPf
Ko/McMbmv9smfz8OS1SDiCmEDsVNqXJT56EMm6ZuDoKEYr6beQhOvBJKNnHRCl8Q
csAhqnzR/MT1EKQWhnymgRn6XOiVvrjy8LBiXneWQ8uqSe6MdMRhNFAS+KHgrpx/
XU40zSxBcmUJjVBhuS5w1hlXMZLriEjNhg9zUUhhbt5B+tqPttf6ytZdZNpQ+q6s
hz83q1xY73P5peUGuOYmmxmfAau62M85xE9bohr3bcCXkkTpfGrif8/kvlQG+bge
RH+CSNg5LaxmtPzRtLkFxuxMpHNgsS93O7eBnjBaP/G90DL4IJAYXqncakXB2B6M
KLizq8Ml2jD2AcGcFis06Zuj2JsxgRQEaCbYfoKPGhTqDYec67aV/uOkdvmn6uLZ
/o7SM+9ocmEOzG+bHJUt5FpT3euKFuD3no/GV0HSt1wMpax0mLkfW5OlgBWa11ou
B7cR17h/eEn0mJJ4EN1hoxPvi2QiPmx4wwMRKc4K63jZRrixn4ODcztitTSJVWWv
w1KAhso0y/ZRsNTGzLHq
=nhCX
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

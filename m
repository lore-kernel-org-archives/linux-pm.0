From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Tue, 15 Sep 2015 17:53:02 +0200
Message-ID: <20150915155301.GB25966@ulmo.nvidia.com>
References: <1441880343-30852-1-git-send-email-thierry.reding@gmail.com>
 <10787470.V3kIoIEDW3@vostro.rjw.lan>
 <20150911120345.GB16323@ulmo>
 <4817586.89LbLFPz9W@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4817586.89LbLFPz9W@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2015 at 12:38:19AM +0200, Rafael J. Wysocki wrote:
> On Friday, September 11, 2015 02:03:46 PM Thierry Reding wrote:
> > On Fri, Sep 11, 2015 at 12:08:02AM +0200, Rafael J. Wysocki wrote:
> > > On Thursday, September 10, 2015 12:19:03 PM Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=3D20
> > > > Deferred probe can lead to strange situations where a device that i=
s a
> > > > dependency for others will be moved to the end of the dpm_list. At =
the
> > > > same time the dependers may not be moved because at the time they w=
ill
> > > > be probed the dependee may already have been successfully reprobed =
and
> > > > they will not have to defer the probe themselves.
> > >=3D20
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
> > > > the gpio-keys device is not moved to the end of dpm_list itself.
>=20
> At this point, when checking its dependencies, gpio-keys should also check
> if their ordering with respect to it in dpm_list is correct and move itse=
lf
> to the end of it otherwise.
>=20
> There might be a helper for that I suppose.

But that's essentially the same thing as what this patch proposes,
except that every driver now needs to call this helper, rather than
having the core take care of it.

> > > > As a
> > > > result, the suspend ordering becomes pinctrl-tegra -> gpio-keys ->
> > > > gpio-tegra. That's problematic because the gpio-keys driver requests
> > > > the power key to be a wakeup source. However, the programming of the
> > > > wakeup interrupt registers happens in the gpio-tegra driver's suspe=
nd
> > > > callback, which is now called before that of the gpio-keys driver. =
The
> > > > result is that the wrong values are programmed and leaves the system
> > > > unable to be resumed using the power key.
> > > >=3D20
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
> > > >=3D20
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > > Note that this commit is kind of the PM equivalent of 52cdbdd49853
> > > > ("driver core: correct device's shutdown order) and that we have two
> > > > lists that are essentially the same (dpm_list and devices_kset). I'm
> > > > wondering if it would be worth looking into getting rid of one of
> > > > them? I don't see any reason why the ordering for shutdown and
> > > > suspend/resume should be different, and having a single list would
> > > > help keep this in sync.
> > >=3D20
> > > We move away things from dpm_list during suspend and add them back to=
 it
> > > during resume to handle the situations in which some devices go away =
or
> > > appear during suspend/resume.  That makes this idea potentially probl=
emat=3D
> > ic.
> >=20
> > Okay, I see. If they are used for different purposes it's fine to keep
> > them both.
> >=20
> > > >  drivers/base/dd.c | 33 +++++++++++++++++++++++----------
> > > >  1 file changed, 23 insertions(+), 10 deletions(-)
> > > >=3D20
> > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > index be0eb4639128..56291b11049b 100644
> > > > --- a/drivers/base/dd.c
> > > > +++ b/drivers/base/dd.c
> > > > @@ -88,16 +88,6 @@ static void deferred_probe_work_func(struct work=
_str=3D
> > uct *work)
> > > >  		 */
> > > >  		mutex_unlock(&deferred_probe_mutex);
> > > > =3D20
> > > > -		/*
> > > > -		 * Force the device to the end of the dpm_list since
> > > > -		 * the PM code assumes that the order we add things to
> > > > -		 * the list is a good order for suspend but deferred
> > > > -		 * probe makes that very unsafe.
> > > > -		 */
> > > > -		device_pm_lock();
> > > > -		device_pm_move_last(dev);
> > > > -		device_pm_unlock();
> > > > -
> > > >  		dev_dbg(dev, "Retrying from deferred list\n");
> > > >  		bus_probe_device(dev);
> > > > =3D20
> > > > @@ -312,6 +302,29 @@ static int really_probe(struct device *dev, st=
ruct=3D
> >  device_driver *drv)
> > > >  	 */
> > > >  	devices_kset_move_last(dev);
> > > > =3D20
> > > > +	/*
> > > > +	 * Force the device to the end of the dpm_list since the PM code
> > > > +	 * assumes that the order we add things to the list is a good ord=
er
> > > > +	 * for suspend but deferred probe makes that very unsafe.
> > > > +	 *
> > > > +	 * Deferred probe can also cause situations in which a device tha=
t is
> > > > +	 * a dependency for others gets moved further down the dpm_list a=
s a
> > > > +	 * result of probe deferral. In that case the dependee will end up
> > > > +	 * getting suspended before any of its dependers.
> > > > +	 *
> > > > +	 * To ensure proper ordering of suspend/resume, move every device=
 that
> > > > +	 * is being probed to the end of the dpm_list. Note that technica=
lly
> > > > +	 * only successfully probed devices need to be moved, but that br=
eaks
> > > > +	 * for recursively added devices because they would end up in the=
 list
> > > > +	 * in reverse of the desired order, so we simply do it unconditio=
nally
> > > > +	 * for all devices before they are being probed. In the worst cas=
e the
> > > > +	 * list will be reordered a couple more times than necessary, whi=
ch
> > > > +	 * should be an insignificant amount of work.
> > > > +	 */
> > > > +	device_pm_lock();
> > > > +	device_pm_move_last(dev);
> > > > +	device_pm_unlock();
> > >=3D20
> > > So I don't agree with doing that for every driver being probed agains=
t the
> > > same device.  That's just wasteful IMO.
> >=20
> > I don't understand. At this point driver matching has already taken
> > place, so this will only every happen for one particular driver and the
> > corresponding device. In the most common case this will happen exactly
> > once, when the device is probed. Worst case it will happen a second or
> > more times if a driver defers probing for a specific device. But in that
> > case moving the device to the end of the list is absolutely required to
> > keep it properly ordered for suspend/resume. Note that this is already
> > done by the original code in deferred_probe_work_func() that is removed
> > in the first hunk. The fix here is to do it for every device to ensure
> > that inter-device dependencies are properly dealt with.
> >=20
> > I agree that it's a little wasteful, but that's completely in line with
> > deferred probe. It's a simple solution to a very difficult problem, so
> > naturally it comes at a cost. But it's also fairly elegant in how it
> > correctly solves the ordering problem with very little code. The only
> > other way that I can think of to avoid reordering the list for every
> > device probe would be to sort it in advance using dependency information
> > which we don't have. So we'd need to first add all that dependency
> > information, and using that information is likely to be more work than
> > simply reordering the list for each probe.
>=20
> But that is problematic too as Alan pointed it out.
>=20
> I'm always cautious about changes that make the core do something for eve=
ry
> device/driver, because they are very likely to step on corner cases that =
we
> don't need to worry about otherwise.

To me this seems more like a fundamental issue that should be fixed at
the root rather than be fixed up case by case as we find them. Keeping
the suspend/resume order the same as probe order sounds like the most
logical thing to do. I grant you that there could be cases where this
might break, but then I'd consider those cases to be broken rather than
the other way around.

With the current situation potentially every user of GPIOs (and the same
is true for other types of resources) is broken, though we may not
notice (immediately). In fact it was mostly by coincidence that I
noticed in this case. The GPIO key works perfectly fine for regular use,
it just doesn't work as a wakeup source anymore. That's not something
that people test very frequently, hence could've gone unnoticed for much
longer.

Of course reordering the dpm_list to follow the probe order has the
potential to break other setups in similarily subtle ways, so I do
understand your reluctance.

Perhaps it would help if we put this patch into some boot farm to get
more coverage, maybe that would give us a better picture for how
invasive the change is, or how bad the fallout could be?

I can of course go and come up with a more ad-hoc solution that fixes
the issue for this particular use-case, but I'd like to avoid a
situation where we end up having to patch up drivers one by one, when
we could have a solution that works in the general case.

Also note that a recent commit (52cdbdd49853 "driver core: correct
device's shutdown order") patch already made an equivalent change to the
shutdown order. I'd expect that most devices would fail with that patch
already if ordering is a real problem. Of course shutdown is a one-way
ticket, so failure might not be as relevant as for suspend/resume.

Grygorii, Greg: have you heard of any fallout caused by the above patch
yet?

Thierry

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV+D7aAAoJEN0jrNd/PrOhOJcP/0rJBD0KirlJWvABteyrze4u
bLKEFlcKr9+mSfApycHiCMqOqdnxZFCz7W/EvqqblTC9CB+YrN15q/0kuzhaHw9j
hxZyw3U6fDgswNd9n/KsDdR2JW8O2qGZsn4LK4XEidcYvaorEp7nTDX1mZRs1zxD
UwP51T7VA5ruP1LDP3epFQBgnSpddyVQPNSWgTjsEYf+kd6HtpYuh575r48yQYdT
B4JNTSfU/K17TOKFyiYCmpzQP6VtFFSAIK+P7fUUbhNH8A6e0W8N4vHxMIL2yftZ
XdF0a1+0CjrRAM88CVHYXz8s7/urXVLgcfHQgwPObrM0zSmG/zkUaWK5O5+lEDmH
BPrjyTJaNHnxvecas02A+ZcgmwgYz1TWClX1pYRSz2ZYbJGPsIMZ5VxRrhUza64f
cVJrB1CplFzU6NnYLw2rFvhdTp4bxdwf8F/ih1fBc+elE0ZfzlLZBEZgtlE2bo0+
xgp6n4lrujFLESzJBPX49khgVjgOuPGugGBrABj3e28S909Edl2cEs8GZ4GjEWPU
3LAA4OU6JtQ80LlGiApbQgPfX4NOitcugzY4IdEajBTE0V9B5to2cprOOr7kZ4kX
eOF3K6YzkZyxtxSrgs7QGRRDX7LOSOhh7IHPHiSZaOI63E4XE/CgXfZa8s1rlXm9
uW/XxuyofzqNh7imFubS
=7cgu
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

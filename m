From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sat, 15 Jul 2017 08:28:38 +0200
Message-ID: <20170715062838.GA20741@amd>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <6613228.WfFrGvAy1X@aspire.rjw.lan>
 <85441336-8d89-f7aa-4fbe-a4edaf478649@gmail.com>
 <2497538.J9F6XFeBfd@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2497538.J9F6XFeBfd@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2017-07-15 00:16:16, Rafael J. Wysocki wrote:
> On Wednesday, July 12, 2017 11:08:19 AM Florian Fainelli wrote:
> > On 06/29/2017 04:00 PM, Rafael J. Wysocki wrote:
> > > On Thursday, June 22, 2017 06:08:36 PM Florian Fainelli wrote:
> > >> Add an optional platform_suspend_ops callback: target_state, and a
> > >> helper function globally visible to get this called:
> > >> platform_suspend_target_state().
> > >>
> > >> This is useful for platform specific drivers that may need to take a
> > >> slightly different suspend/resume path based on the system's
> > >> suspend/resume state being entered.
> > >>
> > >> Although this callback is optional and documented as such, it requir=
es
> > >> a platform_suspend_ops::begin callback to be implemented in order to
> > >> provide an accurate suspend/resume state within the driver that
> > >> implements this platform_suspend_ops.
> > >>
> > >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > >> ---
> > >>  include/linux/suspend.h | 12 ++++++++++++
> > >>  kernel/power/suspend.c  | 15 +++++++++++++++
> > >>  2 files changed, 27 insertions(+)
> > >>
> > >> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > >> index d9718378a8be..d998a04a90a2 100644
> > >> --- a/include/linux/suspend.h
> > >> +++ b/include/linux/suspend.h
> > >> @@ -172,6 +172,15 @@ static inline void dpm_save_failed_step(enum su=
spend_stat_step step)
> > >>   *	Called by the PM core if the suspending of devices fails.
> > >>   *	This callback is optional and should only be implemented by plat=
forms
> > >>   *	which require special recovery actions in that situation.
> > >> + *
> > >> + * @target_state: Returns the suspend state the suspend_ops will be=
 entering.
> > >> + * 	Called by device drivers that need to know the platform specifi=
c suspend
> > >> + * 	state the system is about to enter.
> > >> + * 	This callback is optional and should only be implemented by pla=
tforms
> > >> + * 	which require special handling of power management states within
> > >> + * 	drivers. It does require @begin to be implemented to provide th=
e suspend
> > >> + * 	state. Return value is platform_suspend_ops specific, and may b=
e a 1:1
> > >> + * 	mapping to suspend_state_t when relevant.
> > >>   */
> > >>  struct platform_suspend_ops {
> > >>  	int (*valid)(suspend_state_t state);
> > >> @@ -184,6 +193,7 @@ struct platform_suspend_ops {
> > >>  	bool (*suspend_again)(void);
> > >>  	void (*end)(void);
> > >>  	void (*recover)(void);
> > >> +	int (*target_state)(void);
> > >=20
> > > I would use unsigned int (the sign should not matter).
> > >=20
> > >>  };
> > >=20
> > > That's almost what I was thinking about except that the values return=
ed by
> > > ->target_state should be unique, so it would be good to do something =
to
> > > ensure that.
> > >=20
> > > The concern is as follows.
> > >=20
> > > Say you have a driver develped for platform X where ->target_state re=
turns
> > > A for "mem" and B for "standby".  Then, the same IP is re-used on pla=
tform Y
> > > returning B for "mem" and C for "standby" and now the driver cannot
> > > distinguish between them.
> > >=20
> > > Moreover, even if they both returned A for "mem" there might be diffe=
rences
> > > in how "mem" was defined by each of them and therefore in what the dr=
iver was
> > > expected to do to handle "mem" on X and Y.
> >=20
> > That makes sense, would you need the core implementation in
> > platform_suspend_target_state() to range check what
> > suspend_ops->target_state() returns against a set of reserved value say,
> > checking from 0 up to ACPI_S_STATE_COUNT or is there another range you
> > would like to see being used?
>=20
> I had an idea of using an enum type encompassing all of the power states
> defined for various platforms and serving both as a registry (to ensure t=
he
> uniqueness of the values assigned to the states) and a common ground
> between platforms and drivers.
>=20
> Something like:
>=20
> enum platform_target_state {
> 	PLATFORM_STATE_UNKNOWN =3D -1,
> 	PLATFORM_STATE_WORKING =3D 0,
> 	PLATFORM_STATE_ACPI_S1,
> 	PLATFORM_STATE_ACPI_S2,
> 	PLATFORM_STATE_ACPI_S3,
> 	PLATFORM_STATE_MY_BOARD_1_GATE_CLOCKS,
> 	PLATFORM_STATE_MY_BOARD_1_GATE_POWER,
> 	PLATFORM_STATE_ANOTHER_BOARD_DO_CRAZY_STUFF,
> 	...
> };
>=20
> and define ->target_state to return a value of this type.
>=20
> Then, if a driver sees one of these and recognizes that value, it should
> know exactly what to do.

Remind me why this is good idea?

We currently have 1364+ boards in tree. That will be rather large
enum.

If board wants to know if certain regulator stays online during
suspend, it should invent an API for _that_.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllpthYACgkQMOfwapXb+vLUYgCcCqaZOu3fugVI0aWPyz/h63DK
sWkAnROJ96JVTI9/ytoqt/c1GFAvMhiI
=Z3kt
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] power: bq27xxx_battery: add configurable
 poll_interval by sysfs
Date: Mon, 24 Oct 2016 21:51:51 +0200
Message-ID: <20161024195151.GA5989@amd>
References: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
 <1474083775-30185-2-git-send-email-matt@ranostay.consulting>
 <20161007184910.GF19976@amd>
 <CAKzfze95nJMcRU2=FivDa72MX4P0md1VoWbUjUnt-75Vs_ektQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKzfze95nJMcRU2=FivDa72MX4P0md1VoWbUjUnt-75Vs_ektQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-pm@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2016-10-23 20:08:22, Matt Ranostay wrote:
> On Fri, Oct 7, 2016 at 11:49 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Fri 2016-09-16 20:42:54, Matt Ranostay wrote:
> >> Allow the poll_interval to be runtime configurable via an sysfs entry.
> >> This is needed for udev control of the poll interval.
> >>
> >> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> >
> > working mail address would be nice here.
> >
> > sysfs files should be documented.
> >
>=20
> Ok can do in next revision
>=20
> > Also... what is it good for?
> >
> > Do you have a device that needs non-standard interval?
>=20
> Basically we need to have the ability to dynamically change the
> intervals. So closer to a battery drain we need to up the reporting
> intervals.

Umm, there seems to be mechanism there to change that already...?

static const struct kernel_param_ops param_ops_poll_interval =3D {
        .get =3D param_get_uint,
 	.set =3D poll_interval_param_set,
};
	=09

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgOZlcACgkQMOfwapXb+vJBAwCgnHbPM3ldQK0K5AyMNeZ/x5Ho
KTEAnifLNg/lsONu130scoJ+auUES1kF
=/OWm
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

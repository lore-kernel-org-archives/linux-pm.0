From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v7 00/10] Add support for XO 1.75 to OLPC battery driver
Date: Fri, 19 Apr 2019 14:42:22 +0200
Message-ID: <20190419124222.yizj6krkdi236x74@earth.universe>
References: <20190418144655.18758-1-lkundrak@v3.sk>
 <20190418202000.hcojhcf2f47te44u@earth.universe>
 <20190419075716.GB6795@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fjpcncqz7gjt75yj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419075716.GB6795@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org


--fjpcncqz7gjt75yj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Fri, Apr 19, 2019 at 09:57:16AM +0200, Ingo Molnar wrote:
> > On Thu, Apr 18, 2019 at 04:46:45PM +0200, Lubomir Rintel wrote:
> > > This patch set modifies the OLPC battery driver so that it could even=
tually
> > > be used on an Arm-based OLPC XO 1.75 machine.
> > >=20
> > > Compared to the previous version, it addresses review comments for the
> > > x86 platform parts from Thomas Gleixner. Details in individual patche=
s'
> > > change logs.
> > >=20
> > > I've failed to version the previous iteration of the set that should'=
ve
> > > been "v6" for the change logs to make sense. Sorry for that.
> > >=20
> > > Thank you,
> > > Lubo
> >=20
> > I queued up the complete patchset via an immutable branch based on
> > v5.1-rc1. X86 maintainers can pull this signed immutable branch as
> > required. Thanks for the patches,
>=20
> Would you mind sending these patches to Linus yourself, as part of the=20
> power-supply tree?
>=20
> That's where it really belongs, the impact on arch/x86/ was mostly=20
> drive-by (and it's now all Acked-by Thomas), the meat of the changes is=
=20
> in the OLPC battery driver.

Yes, I merged the immutable branch into power-supply. You can either
also merge it (e.g. when you plan to add other changes), or just ignore
it :) This is what I usually do with other subsystems to avoid
pointless merge conflicts.

TLDR: Yes.

-- Sebastian

--fjpcncqz7gjt75yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly5wiQACgkQ2O7X88g7
+pohFhAAnMvGVvpZWUjOCSBeX6SHrawPkrxXf0+MNl9LXP58EPyPdlLep8CkDTWM
3l2z2RuOdWyPdUjRuJquk0GdiSum+DtTiUPj+E0c1TjgFxzqOxV5p+sY1J1aGlMP
ES6x5K1d3CFVDDYKY+e+0+SS8vU4Bhfxb+n1jOBQsEQDa6MdP7HDXDFt0QGDCqoM
2CdNIGWPjefYvwMJD7HthEoe7Rkahv81EVGv8RbkojNSd4vr5k7pTlYyNHsrv8sR
K3/+1BMQ+bDuvfwYFXO7FmR1UivLq+gNE+q0+TA+AkKZMpIJ6+P8fjxgspn2T8UI
PC8XR2HVmvVVA6VeiM/gcvPbX6GnVAlnXCxeLUkGwF+NZvyIIEgg1TIsDrmV21Nn
DQ02ELgvIXX5QdbBREP0aL83HqK4i5C0bJRO/+4kTrClP3clthuoA5GSEppOWxmP
2kZJUMdiWCU5Q9ReGjOaXq63HMNRMwrFi+2jABbM2FSc9+shv3M+O9tr2heJi1Kx
+e8RQkQ+iZn4w/Uz8EVIvwdfHgHKLMrip38A3iXqQABmIEk7nvI9/UXoC7nNcxDM
8E1FXpN5hoK+b2pTaTWMCfTlsjXM7kFg2J4Pgq4KMJIp2xcLmxMkrl/9cQg0pWwb
uO8IXoUm8ChpHvXHrS7wWPcbQCGTrV0LoVwMpbUyVF1vtVB8+Ck=
=NiHD
-----END PGP SIGNATURE-----

--fjpcncqz7gjt75yj--

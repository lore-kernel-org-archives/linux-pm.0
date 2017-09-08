From: Pavel Machek <pavel@ucw.cz>
Subject: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery: Add
 capacity handling
Date: Fri, 8 Sep 2017 13:32:31 +0200
Message-ID: <20170908113231.GJ18365@amd>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9pltayyoy9lWEMH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170829101147.debhadzyfrxhkrvt@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Marek Belisko <marek.belisko@open-nandra.com>, robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org


--M9pltayyoy9lWEMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +	case POWER_SUPPLY_PROP_CAPACITY:
> > +		{
> > +		int ret, curr, voltage;
> > +
> > +		ret =3D read_channel(adc_bat, POWER_SUPPLY_PROP_CURRENT_NOW, &curr);
> > +		ret |=3D read_channel(adc_bat, POWER_SUPPLY_PROP_VOLTAGE_NOW, &volta=
ge);
> > +		if (ret < 0)
> > +			goto err;
> > +
> > +		val->intval =3D fuel_level_LiIon(voltage, curr, 10);
> > +		}
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
>=20
> Without patch description: See Last Question in
>=20
> Documentation/power/power_supply_class.txt

=2E..should be done in libbattery, yet to be written. :-).

Do you have specific guidance what you'd like to see in libbattery?

I was thinking about creating lib_pocket_hardware -- that would hide
battery details, plus other phone-related stuff such as LEDs,
backlights, temperatures, ...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M9pltayyoy9lWEMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmyf88ACgkQMOfwapXb+vLoFwCguazvtEGTH+GyeBeH0AEp1qw/
LFEAoJ3ETBktPxp4mdaKaSfPFh+ZSbs4
=96kB
-----END PGP SIGNATURE-----

--M9pltayyoy9lWEMH--

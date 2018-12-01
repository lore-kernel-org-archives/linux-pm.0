From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/2] power: supply: add input voltage limit property.
Date: Sat, 1 Dec 2018 16:09:34 +0100
Message-ID: <20181201150934.GA7052@amd>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
 <20181123232203.GA3852@amd>
 <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org, linux-kernel@vger.kernel.org, groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com, bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> We have a problem with USBPD chargers which under certain conditions
> >> can result in system overheating if the voltage provided by the USBPD
> >> port is too high. While the preferred means to control this would be
> >> through devicetree or ACPI settings, this is not always possible, and
> >> we need to have a means to set a voltage limit.
> >>
> >> This patch exposes a new property, similar to input current limit, to
> >> re-configure the maximum voltage from the external supply at runtime
> >> based on system-level knowledge or user input.
> >=20
> > First, this should really be handled by dt / ACPI. If it is broken,
> > that's a hardware bug, and we can do DMI-based blacklists in kernel.
> >=20
>=20
> I think that handle this via dt / ACPI is not possible for our use case. =
It can
> be a hardware bug or a hardware/user constrain, let me try to explain bet=
ter
> with an example.
>=20
> On Pixel C's devices, userspace uses this to set a USB input limit of 5V =
when
> the screen is on for thermal reasons, but those go away when the screen is
> off/system is sleeping, so we allow 9V and 12V levels when sleeping.

So, on pixel C, what happens if userland ignores the constraint, keeps
display on and sets charger to 12V?

> > How are you supposed to fsck a system, for example?
> >=20
>=20
> hmm, I'm not sure I get the question, sorry, could you rephrase?

Ok, so I have just booted with init=3D/bin/bash, and would like to run
fsck.ext4 on my root filesystem.

> >> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
> >> +Date:		Nov 2018
> >> +Contact:	linux-pm@vger.kernel.org
> >> +Description:
> >> +		Details the incoming VBUS voltage limit currently set in the
> >> +		supply. Normally this is configured based on the type of
> >> +		connection made.
> >=20
> > "Details"?
> >=20
> > Who can write to this value and when? What is the limit? If USB
> > charger is plugged in, should it show 5.0V (because that's nominal on
> > the USB) or 5.25V (because that is the real limit)?
>=20
> The voltages here refer to the Typical or Nominal values defined by the U=
SB
> specification for a Fixed power supply (or Fixed PDO). 5.0V, 5.25V, 4.75V,
> 5.5V... all of those are considered "5V" according to the USB specificati=
ons.
>=20
> At the 5V level (defined in the USB PD specification as vSafe5V), a nomin=
al
> power source is allowed to have a voltage between 4.75V and 5.50V (5V -5%/
> +10%). For simplicity, we refer to this range as 5V, the typical value.
> For all higher voltage levels other than vSafe5V, MIN voltage is PDO Volt=
age *
> 0.95, and MAX voltage is PDO Voltage * 1.05, where PDO Voltage is the Typ=
ical
> value (9V, 12V, 15V, 20V). [1]

> > Who can write to this and when. And what happens on write? What
> > happens if I write value that charger can't provide there?
> >=20
> > Does it set the voltage power supply should produce? Or maximal it can
> > choose to produce?
> >=20
>=20
> This defines a maximal voltage. If you write a value it can't provide,
> it should go down to the next lowest level, and barring that, 5V is
> always allowed.
>=20
> That makes me think that maybe I should also improve the implementation.
>=20
> > This really needs better documentation.
>=20
> Ack, I'll send a next version improving that.

Thanks.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwCpC4ACgkQMOfwapXb+vJ7uACcCRDA8FIQmuQCK/hagMsggeRk
D5kAnA+7vLPHIhWH3NHCkoY8AhnasD5b
=Rpx/
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

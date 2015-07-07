From: Sebastian Reichel <sre@kernel.org>
Subject: Re: sysfs charge thresholds for ThinkPads (and possibly others),
 preparation for second try
Date: Wed, 8 Jul 2015 01:51:10 +0200
Message-ID: <20150707235110.GA19748@earth>
References: <20150707210728.GA7524@jak-x230>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150707210728.GA7524@jak-x230>
Sender: linux-acpi-owner@vger.kernel.org
To: Julian Andres Klode <jak@jak-linux.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, evgeni@debian.org
List-Id: linux-pm@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 07, 2015 at 11:07:28PM +0200, Julian Andres Klode wrote:
> Hi everyone (Thinkpad-ACPI, ACPI, and Power supply maintainers),
>=20
> some might know that I presented a patch set adding support for
> charge thresholds to thinkpad_acpi about 1.5 years ago.=20

Can you provide a link to the patch set?

> Back then, one of the major rejections was that the functionality
> for setting charge thresholds should be integrated into the
> power supply stack somehow. I did not know who to contact back
> then, but know I re-read MAINTAINERS and found all your addresses,
> so I give it a second try.
>=20
> One issue with just integrating it in the current battery
> directories would be that ThinkPads are able to set charge
> thresholds for batteries that are currently not inserted.

So the power supply device should be kept with
POWER_SUPPLY_PROP_PRESENT being disabled (and most properties
returning -ENODATA). The ACPI SBS driver seems to implement
POWER_SUPPLY_PROP_PRESENT, but I didn't test it.

> Back then I wrote:
> > The next step is to integrate this properly with power supply
> > and/or acpi battery. One way would be to add additional power
> > supply properties and then add get/set_property() pointers to
> > the acpi battery which it can fall back to if it does not support
> > a requested property (and we would locate the ACPI battery and
> > set those pointers to new thinkpad_acpi functions).
>=20
> If you, the ACPI and power supply people, have any preferred
> way (or any idea at all how) to proceed, that would be useful,
> so I don't start working on it again, and then somebody does
> not like it.

Adding charging thresholds as power_supply_property sounds
fine to me.

-- Sebastian

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVnGXrAAoJENju1/PIO/qaRkAP/R3PgbPDriyUHIG8HYOmMtqG
UJ/DczwgzBcDrqTMkYP/h6Fb8MNq+YjMdAAn2kgGcETTOUXStOCVQGfVsrwm1lae
xoluqLCtLLAv+j09b1AKjaMpL74YwOddUOX0j8mAJuyIvi8YHIUs8f3lEA7bdffN
GxSsHP5eBvTUEuHCpysaD7hihQ9LLRKTeTb8nUGvEv0HwBkQV/hdE8SM9wPZvISF
rVb9ZK8tcoFqs/MwFcpzDTm2QnCputBCngiJTtY2Jy6q0vTyL0SKjJ1s1W09fisy
fkTqOkNVGuPNab/AJlPfKDn6Pgu0ArWkwGsrhfWceDcLJdZPQDm1QUX3E4CASau4
cVPqVeytdQldgbZ5PPUQVPdiwuAUhnquFDrS4opz02d/7HD2OU7Bn8LJQ4UhZlZC
eazYtqlNF+vDbXMESPzuK5BWykdS1L7cqnLlHyep2q0x/DDPAeCyCxtyscR8Gg66
8j8AO0G0PfSHLjS0ns8wqE8OAYBB95BISx0CHRveR1HHCrxx4Kq/nn78viS3/oPV
hUhUfx3CUhhozo+gy4g/LgXbsmUnocuM2Pbh4AAShzRi6LVzU9KuOXX3pnUppW79
GpOM+RqQOxf958lqXmNdxvQw555n1w4dBP2GDtWqiE8pVvVJyLyIsCAcZOfsQjNf
RNXH8fzVOva83OCToN42
=FLtA
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

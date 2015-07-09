From: Sebastian Reichel <sre@kernel.org>
Subject: Re: sysfs charge thresholds for ThinkPads (and possibly others),
 preparation for second try
Date: Thu, 9 Jul 2015 06:46:49 +0200
Message-ID: <20150709044649.GB13805@earth>
References: <20150707210728.GA7524@jak-x230>
 <20150707235110.GA19748@earth>
 <20150708113624.GA25015@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150708113624.GA25015@debian.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Julian Andres Klode <jak@jak-linux.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, evgeni@debian.org
List-Id: linux-pm@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 08, 2015 at 11:40:00AM +0200, Julian Andres Klode wrote:
> On Wed, Jul 08, 2015 at 01:51:10AM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Jul 07, 2015 at 11:07:28PM +0200, Julian Andres Klode wrote:
> > > Hi everyone (Thinkpad-ACPI, ACPI, and Power supply maintainers),
> > >=20
> > > some might know that I presented a patch set adding support for
> > > charge thresholds to thinkpad_acpi about 1.5 years ago.=20
> >=20
> > Can you provide a link to the patch set?
>=20
> Sure:
> http://thread.gmane.org/gmane.linux.acpi.ibm-acpi.devel/3175
>=20
> (it was not on the ACPI and Power MLs back then)

Thanks.

> [...]

> > > Back then I wrote:
> > > > The next step is to integrate this properly with power supply
> > > > and/or acpi battery. One way would be to add additional power
> > > > supply properties and then add get/set_property() pointers to
> > > > the acpi battery which it can fall back to if it does not support
> > > > a requested property (and we would locate the ACPI battery and
> > > > set those pointers to new thinkpad_acpi functions).
> > >=20
> > > If you, the ACPI and power supply people, have any preferred
> > > way (or any idea at all how) to proceed, that would be useful,
> > > so I don't start working on it again, and then somebody does
> > > not like it.
> >=20
> > Adding charging thresholds as power_supply_property sounds
> > fine to me.
>=20
> Right, it gets a bit more complicated though: Since the code is
> platform-specific, it should live in the platform driver, so a
> way is needed to extend the existing device with new properties
> from the platform driver.

Yes, my answer was only from the power supply subsystem's point of
view, since I do not know much about the thinkpad-acpi and SBS
driver. It seems the SBS driver has already minimal support for
handling platform specifics via the acpi_sbs_dmi_table, though. I
suggest to add a Thinkpad entry and modify the SBS driver, so that
it calls your additional code.

It would be nice, if the Thinkpad specific code could also be used
to add a label to the batteries, so that it's easier to distinguish
batteries in case of multiple ones being available.

-- Sebastian

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVnfy2AAoJENju1/PIO/qa4WkP/3tM2pfcYf8NPq8x04VemjnZ
2HheAFSjWfidXFFZ+M1mYTyW1PQPgJQ5g+qELYl/qKlZFWdGW73PQVmQtfS1yTIZ
njrULoqlAWx/oRxIEbnSE0TU5ObhVIgJKoQXDb5t8JUmbohZIruoFDFa/s5JxdHp
RTRV+z28ZauyziFgXz++QbGfnN0HnAm68DQEmM8F/kzE3IQY8PHBeERDMOuWB9HM
wblVTKRqk3Gd7HDGRfaeyl3ypHUSdoSjQJc1v4/uXMXn95gqYv6FJCEDVXNj5UZH
+ohzY2/hedpiFlDWMBMNyDvKv6YwJ+IXl2NvN32ZfgBkC14iwkxvM0FvJV5g4qrM
Qjjk5fG9+bK9NNF5PuitKxLlq/TGKYldW/s8EcAHSUPUUuB4ZIrGGQXLYhM3fbcB
mKIgYKNKKEAcRarhk96ZzbPdRunw9qVau5gYNUy3XJVzyTG+3eqy1TFErS6mR7h2
xn3rGpi660L6NXUF4yPyoYhqKQFGoh/smzhcT8qudsMbMCcR4b2unMWnKWYoQjyC
g5TXmexP0WjITbeEcaPb3SzJOQKUez0M8+pOlF/TS2/QG/GKZlyYEbEW/PlZXk2O
3g8WTVJxB8tdvZmzmxRx1dnMU0zssgRbqC71j/PTnOAtOCJj8x1NzxhCxHUeA69J
mkB/lXLfonlWkZrQbiRr
=+/mi
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

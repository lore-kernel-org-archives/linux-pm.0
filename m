From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / ACPI: Removed unused function
Date: Fri, 6 Oct 2017 14:14:55 +0200
Message-ID: <20171006121455.GA14483@amd>
References: <1507273714-26394-1-git-send-email-ulf.hansson@linaro.org>
 <20171006121230.GA14256@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006121230.GA14256@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-10-06 14:12:30, Pavel Machek wrote:
> On Fri 2017-10-06 09:08:34, Ulf Hansson wrote:
> > acpi_dev_pm_get_node() isn't used or implemented, let's remove it.
> >=20
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>

I was too quick sending this.

How is it unused?

=2E/drivers/acpi/device_pm.c: * acpi_dev_pm_attach - Prepare device for
ACPI power management.
=2E/drivers/acpi/device_pm.c:int acpi_dev_pm_attach(struct device *dev,
bool power_on)
=2E/drivers/acpi/device_pm.c:EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
Binary file ./drivers/acpi/device_pm.o matches
Binary file ./drivers/base/power/common.o matches
=2E/drivers/base/power/common.c:		  ret =3D
acpi_dev_pm_attach(dev, power_on);

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnXc78ACgkQMOfwapXb+vJ8VwCfTInliKC1703aeNwfyHfWn4Mk
VYkAnioPwx3WcG6LqxHaY8xxFwH/p27b
=7F5u
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

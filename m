From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] power: reset: Add reset driver for R-Mobile platforms
Date: Mon, 12 Jan 2015 20:04:27 +0100
Message-ID: <20150112190426.GA1714@earth.universe>
References: <1421078245-5531-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421078245-5531-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 04:57:25PM +0100, Geert Uytterhoeven wrote:
> Add a reset driver for Renesas R-Mobile and SH-Mobile SoCs. It registers
> a restart handler to trigger a soft power-on reset through the R-Mobile
> System Controller.
> As this is controlled by DT, the priority of this restart handler is 192,
> to allow a watchdog driver to use priority 128.
>=20
> Note that we do not use syscon-reboot, as the HPB (Peripheral Bus
> Bridge) semaphore should be acquired on systems where both the ARM and
> SH core are in use. The driver can be extended later to support this,
> when needed.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Tested on R-Mobile A1 (r8a7740) and SH-Mobile AG5 (sh73a0).

Please add DT binding documentation.

-- Sebastian

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUtBq4AAoJENju1/PIO/qaTIgP/1hYilrB6SrhdepJqJcB25x6
BiBwDJr5sULGjH2ZEj3Whha4Uq1ZoAu5g4yJ7FiCrUAVhzJjqAYpZC3gOr5Mivtq
2reoMmPjzbOLvp7VJBj3skyhKYbRGa3YdTNSCx7M9KWd9mTd/0UXWq+YZ9YLwe5l
fy+IdrWeMAIC8fnJLqsGPmT6zPh0cx2Aw/LJCrjdigoDzvEbYzF5aiKvHlqfn5WW
Wul+O3T+IffoH6ouNgNL/o2AbSqXWlhkXW6VOU/Fl1l/YIStCyQjUIlZmc40iqBa
Ny3s2rUfMWth/PAz8NfjFXcY4wutserHyjGqtxJyNXtFPVEBNv5+RqVZI6plIdy+
3/eg/mVu03eVd02kDZojjB42FLfvDx1a0KrwMGSPvPweM9ZhrAsVaOtKeaf561hl
2LZ8VN/Hgb9Ss4PDzxZtO7vquaEWQv1TDGqLFCXmnJAQ6NU4cB9GtY6nDf9r6yjH
Llbo1QVwmo2RO6RROlCm8MXL2B9SPH1/RbJsy+uAumE5+c3PQJAcPxSK7IAdmFOs
6EfwaFOT7tAsO9vjbXC2kFUjS0FoFdr2Kaq/k1vXpwUrlT24n0r/G/i+DT2oONWn
KhhknIiuOHWMFRt0JLRH6cax6GvqoZVQ9t8ES9EinEzm7SaU+P2owL8/pbADj5re
/ws8kYrYPmfQZraKS/l3
=/Oe2
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

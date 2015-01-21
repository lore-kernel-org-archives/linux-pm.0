From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: reset: Add reset driver for R-Mobile platforms
Date: Wed, 21 Jan 2015 16:58:46 +0100
Message-ID: <20150121155846.GE13715@earth.universe>
References: <1417707201-589-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417707201-589-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 04, 2014 at 04:33:21PM +0100, Geert Uytterhoeven wrote:
> Add a reset driver for Renesas R-Mobile and SH-Mobile SoCs. It registers
> a restart handler to trigger a soft power-on reset through the R-Mobile
> System Controller.
> The priority of this restart handler is 192, to allow a watchdog driver
> to use priority 128.
>=20
> Note that we do not use syscon-reboot, as the HPB (Peripheral Bus
> Bridge) semaphore should be acquired on systems where both the ARM and
> SH core are in use. The driver can be extended later to support this,
> when needed.

Applied with Reviewed-By from Guenter Roeck.

-- Sebastian

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUv8yuAAoJENju1/PIO/qa3ZAP/im+KkTLmn41Z/SUdBT4wZSd
v1R8kVWAc8Rf5ir9lxgaQToYqFQVPJOp6dIR1wMNgfNWUA//gT6XeC8UOUxxKE/m
/w3RXzyKN6/DMYzFOtsrxoP5mzRmj33IXgNYY4JMEaclfy652J1NgOopF/3bgdrF
9UYcqVoH2AoQ7gIwYhZFqrTzEMUYPvPPIoxdIe1EhmrxGTbA+bOTDEqAstRG3xCw
M701RgoXSUPUYoAcBXX/LQHoL3arto2cTGkpkm/RX9bHZRwTXvhw2/EiSWf0e0jU
mnbQRSBQbLBQ06mt2IJUhGih7EJq4s0U+f/ba84OpEmsQ9q5a049S+jNa2TlZSM/
p7v9KvpjvtCjmK0iCub6Wa97fZCoFP5DduoyqVzmS/v1YdrhHzAMAO/BsY+XWiwv
HuR/HpTd8yCahSLNM7B5clCjPUV7zjQkTQXFmnWUizbqtqVKCz6ENmJ/gNJBirPR
QhtOBdN96nPEqMwGr61m18eVc+40XKS/tUHvdp8j1QE+JJrZZiRitP0LrcHterAt
SvHx2LmXwMpXTST2r3YVlcLwyJQWu5lmnzrDARKJtcoFJHoOeOVt6WfxnTVTFTzj
sJvvkLse0s/dGIdYYRkfMsmmx9xUw0c5hQYTHHWs5xZx/LtGGHWZbhCFr1fM9yZ6
vVU9hkZV0AkeV5UW2BkJ
=vnTs
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--

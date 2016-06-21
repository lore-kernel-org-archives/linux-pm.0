From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v12 4/4] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 21 Jun 2016 15:53:54 +0100
Message-ID: <20160621145354.GD26099@sirena.org.uk>
References: <cover.1466497505.git.baolin.wang@linaro.org>
 <7dc384248d51b1de0df54909f3c5550584b31357.1466497506.git.baolin.wang@linaro.org>
 <878txyomue.fsf@linux.intel.com>
 <20160621110332.GC26099@sirena.org.uk>
 <87r3bqn4l8.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1C2QhcYtVTlNtC1j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87r3bqn4l8.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--1C2QhcYtVTlNtC1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 21, 2016 at 02:50:27PM +0300, Felipe Balbi wrote:
> Mark Brown <broonie@kernel.org> writes:

> > The wm831x has no DT support currently.

> okay, perhaps its time to add it.

The only platform using it would need the DT connector overlays
completing in order to be able to convert to DT.  I'm really not
convinced it's worth the effort either.

--1C2QhcYtVTlNtC1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaVUBAAoJECTWi3JdVIfQd3IH/12YEamL0U2d9yIBz4tCseth
z/O3xQcIXO1jsmol8J+xmuqTDGNirpmplrtXSjy6IFYguHMMrCRNK4njx3DxIbut
bVsSi7qxzPLCz7xBW1DtgkRtZxLXqBZAis/lQ8YC2/mejo4T6OxKElCVIS89ydwF
LcuVQk+fiYwmdTW0X7VjjapHv+3IA964LEf4jYfsDtMkprmgc7lAq2E+G64UQFLJ
YreMpqlTNLDDZtHKr4QC6vyujvz/U9a6X3YWJsNQdn/Qs59PhaPfSZJNSOupSRd0
ijAjFXqflbNZE/26nOzv/9mMJPmNPfZ0f3qjeJQzzgo8ALvS7fG8H45Cx3tT5L0=
=A2Bj
-----END PGP SIGNATURE-----

--1C2QhcYtVTlNtC1j--

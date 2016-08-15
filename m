From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power:bq27xxx: 27000/10 read FLAGS register as single
Date: Mon, 15 Aug 2016 21:27:48 +0200
Message-ID: <20160815192748.f5qvtvncqjwiuo52@earth>
References: <6ff28e18f78d1b9581cba5fd214fcc00e4a6d23a.1468858328.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oeoiiwg4owibixfh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ff28e18f78d1b9581cba5fd214fcc00e4a6d23a.1468858328.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-pm@vger.kernel.org


--oeoiiwg4owibixfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 18, 2016 at 06:12:09PM +0200, H. Nikolaus Schaller wrote:
> The bq27000 and bq27010 have a single byte FLAGS register.
> Other gauges have 16 bit FLAGS registers.
>=20
> For reading the FLAGS register it is sufficient to read the single
> register instead of reading RSOC at the next higher address as
> well and then ignore the high byte.
>=20
> This does not change functionality but optimizes i2c and hdq
> traffic.

Thanks, queued into power-supply's -next branch.

-- Sebastian

--oeoiiwg4owibixfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXshe0AAoJENju1/PIO/qaGrYP/2P/SxD3TsJ0CRnn59hklPqh
Xi8zZbvpKVLSQVZRiHrb2hh8xiGvswtPCrNolxIImm+hLXNAu73PoGB4TDfu368V
IQ2SBuCIzbj8lIN0ODui+Keh6UA20Q0eQmCmbKEPu7VNg+vWWzSsUuo7fsM8r9CI
34t07awDtlKclRFDQsL24mE18d78++kfBn/GRmOIT8avP/2f+yGnMWq+jCh59QCL
yiaRlbXAg3ozzVteITzr1s3lsv5CSFzYpwAIFGBrIPKyZmK5ioLzipVdOdqIqeu7
UUKnE5p8mIko6w5SRq8VtBofbPC/dZPYf4tMRcUZd8zz4OCdpiLaYAtJS0jeZDtG
9D0q3Qd/WPG7M64uoFnQSm47gvVcjQ5kCS/JSki40j7GOzSEhM5Wv9Cee5lAg/D4
Wp1f93bt8ugRl59bp+VUEdVV1ClPyNmDPHDz7onCaKCpJEotOwiznj0KoMgGDi5t
57L+E/Q9+JBtBT3HJF1yN+o2j0KklhMKZpWuI6C1pVJFJwn/gxBRDlnxqQAbtK6i
gRLyg5JKjgKm5+YkJ86xuKfuQbnYcgNAfk7buqM5lFgjJ27JriqL4rc3pbO//1HF
A3f620RBeD1//3jLK/o+NuNrJlI7PbgVCxrmC4BE6LHTHMTKTqaOEb3RgOoDXC//
Xb1vnyV7VYm95bIXPyN9
=hSNb
-----END PGP SIGNATURE-----

--oeoiiwg4owibixfh--

From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] Add support for OneWire (W1) devices family 0x26
 (MAX17211/MAX17215)
Date: Sat, 29 Apr 2017 17:59:11 +0200
Message-ID: <20170429155911.7li5torcliaoerxh@earth>
References: <20170429143429.5685-1-minimumlaw@rambler.ru>
 <20170429143429.5685-2-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pkjpwo5oqpkdddhl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170429143429.5685-2-minimumlaw@rambler.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, zbr@ioremap.net
List-Id: linux-pm@vger.kernel.org


--pkjpwo5oqpkdddhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 29, 2017 at 05:34:28PM +0300, Alex A. Mihaylov wrote:
> Maxim Semiconductor MAX17211/MAX17215 single/multi-cell fuel gauge
> monitor with M5 Fuel Gauge algorithm
>=20
> Slave device provide software layer for access to internal registers
> MAX17211/MAX17215 chip.

Please convert this to regmap. There should be lots of docs and
examples around, for example:

http://elinux.org/images/a/a3/Regmap-_The_Power_of_Subsystems_and_Abstracti=
ons.pdf

There is no generic w1 handler, but you can provide custom
read/write functions. Also it would be nice to have this
based on https://lkml.org/lkml/2017/3/16/604. Then everything
could go into the power-supply driver.

-- Sebastian

--pkjpwo5oqpkdddhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkEuEwACgkQ2O7X88g7
+pq2og//Qwbok9TDmQzL0HJ1VPin7hQiCSQMwDvNtuuEXzbmIZANJSHLpdhuo0ts
30O8MR/kRdTtVgFFlKMJAggEnJaL7rfFESgd80Ohbr45MQCGvSrXAO3QVnl4bhl1
yXBQy4jxYwBvRFnQ56btG6v+QvM6k7JCtBohENTOLsLHdYMIExT+xuVHq/dD4wN2
v/zAFgd2M2igVDIB1egbu2US3wN/tEZfbqATJ9M68bbesDG1UKyAiulRnCs8vzkz
zWutM07/EFv4sqZPcM6n9bLDnE8UeOrGcNMt3815sGDS/hrC4YEYvGfjz9h69QNS
2spIeNdh+pulcmeX5jyuPTHGGLR9v9kGdFmcTOEDEKh6yHbGQR+brujVrEasCtzC
Ac+GO3ZfvAaN0OxH+cm4Pz3ce3A8QCU9s/F8XbJ+0pkMu0OoFMnmaESGVxnLUY+u
F7E7VibM+QnJ1jrtMCIeRRaFyjDNhKJlormacnkgXofsRtBcy4rPy6FgEh+s3E8/
qcdGIjkiPW+CzNfCgJ+ykrkxLVEfFBh/sS7DtbaCoygXfymZ3UpNuMPIQtfDAk3n
YkqHwKGqyzirSL69GDnL7NwyMiDx67dWCO/0RewyEhVk5xebxktJ/f+agIiIMC96
9fhQyHhcEqdhcIKVJhIVZUb7mgZfl6F3+yfBrNeVDG/irmYF6GA=
=DoK5
-----END PGP SIGNATURE-----

--pkjpwo5oqpkdddhl--

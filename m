From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power_supply: bq24735: Convert to using managed
 resources
Date: Mon, 27 Jul 2015 16:12:03 +0200
Message-ID: <20150727141202.GC12993@earth>
References: <20150725035316.GA10621@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150725035316.GA10621@vaishali-Ideapad-Z570>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Frans Klaver <fransklaver@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 25, 2015 at 09:23:16AM +0530, Vaishali Thakkar wrote:
> Use managed resource functions like devm_kasprintf and
> devm_power_supply_register in bq24735_charger_probe. To be
> compatible with the change, replace various gotos by direct
> returns and drop unneeded labels.
>=20
> Also, remove bq24735_charger_remove as it is now redundant.

Thanks, queued.

-- Sebastian

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVtjwyAAoJENju1/PIO/qaoqMP/A0Sh6Zk1l7kZpAH9L5bJNjb
wfQ/wYLIKsautphuaSomNsPWcmoB0n3nZkVQaMZKBljhm4s+O/h+Xa0VNnIB+xh1
una9+h2OECcUnOC+JpN3DZ8Uu/d+H9u3sEGvnH0PnFnx9B+UTSswuHr9kE7wDLoI
W0jd+7qAwh/kEquogJmS+MrDJdxaJbOpgevzS3h6oNpNpD7hQug7PyMY4sVkCZNf
ZVd90jPMaoq5cegVKMHMiAQ90ObSiR/4gfkjzp+R7hgMYTUNTOSGu1kXWlsnIttg
rC8lhh77OUunhLPip8XUmp/tUSERNdMerHzTxvnv1rtXNWiYbFXBISWJvSpr5a1F
wQRnauDYFFltS2qi7bboocFf0GKFMALfm496+5W9FvppfucnZPdCBZBpxo83AyoV
j10ts75felM/dMKyFsK32d/jrs5U+P595h5E3YL2UhMo7G9dN3xpKlUNh9oNCLtI
AyAv8KlNKPL18luMK8sgjlPaijhuo4aCmRhQ0p/SX2rtraSK0eVqzfkIJ5f31YK5
BuAixhrGcubpNWGU2KZt8mQYUPSx2yXRcrB0WpH6XwjArh0Ge4yXiqEoGE0suXpp
Z8cdKtH8zqfrtP84SiuZzAbX9xrlfWm9ESEu/PhqYkA+68ciTcPoFAvYSF5T+sfq
lR+OkHTc5WHtakSbOT2z
=HymS
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--

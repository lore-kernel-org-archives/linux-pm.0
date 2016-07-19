From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] power: Adds support for Smart Battery System
 Manager
Date: Tue, 19 Jul 2016 06:17:29 +0200
Message-ID: <20160719041729.GC1640@katana>
References: <1bIiDr-0004G1-0P>
 <1468349295-4935-1-git-send-email-karl-heinz@schneider-inet.de>
 <1468349295-4935-3-git-send-email-karl-heinz@schneider-inet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468349295-4935-3-git-send-email-karl-heinz@schneider-inet.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	data->muxc = i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
> +				   I2C_MUX_LOCKED, &sbsm_select, NULL);
> +	if (!data->muxc) {
> +		dev_err(dev, "failed to alloc i2c mux\n");

Don't print errors on ENOMEM.

Other than that, looks good to me, yet Peter has more insight to
i2c-muxes these days.


--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjanZAAoJEBQN5MwUoCm2GIYQAKSkSVgD9XZRQ9tPpAuqkWpY
32tKIbgXaBX3ZCj2VIftzI9U7S7EgipDl9D2ikVUOOf+WVWmtSbp4nKhA1S8TQlv
0vQo2w7WdB0a51fOrl/aMh+bkrKdPKK8iXPP75uY5j2P0GVXhEJau9x/Sm47SNur
jL0GTbahD8QR+dgbpTFT4GYGyxK9uPXcLuRRtM2xYFJ1acw7gvMBqUHTkhKS6sjV
xah6NGxN0n7imil/FF3OC/I1/+hq9Y95OILCiQCD8GpsSCy8v3XWEcXeQof+5Bgx
m2WhWW2fOTrtFY1+QVc/9XLgC85AEYSfndGQ3B/9UT3T4hGma7+IBCkeGL7Mf/nr
ESbV/8YGcOBUf084VuCjgBiWdC9BNQttF7hkHN9PjSGeJDu+BVBzC0spy8eotFby
G59HxYWLk8gcvuKDQCwXJZTlRCuizLd1KcNCnIhQHrGQ5vqTrYS6lD4j9a9xNM8n
owWgmazfEiS5xMCWNcoGWWa2+3dc4iGlQGlx1Da7NnA4FipFbjcUWwjFTuPztAWw
NenSieMlOeXM5PBkUPnE9C9iXav/sPTf2MsdhLzJrCaSoXnDHCU39tWPivGVSISU
2Lw5wEsBeuUga17vxXe4kptLRhFX3jqZHbFk/9nz9cIfb+nIjoVYPHvsh9sQtBoZ
GvWSWCSNM5pacXzscB/W
=dzDV
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--

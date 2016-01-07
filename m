From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power, test_power: correctly handle empty writes
Date: Thu, 7 Jan 2016 18:40:47 +0100
Message-ID: <20160107174047.GA29563@earth>
References: <1450806216-22600-1-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43858 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbcAGRkv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Jan 2016 12:40:51 -0500
Content-Disposition: inline
In-Reply-To: <1450806216-22600-1-git-send-email-sasha.levin@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, john.stultz@linaro.org, cbouatmailru@gmail.com


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 22, 2015 at 12:43:36PM -0500, Sasha Levin wrote:
> Writing 0 length data into test_power makes it access an invalid array
> location and kill the system.
>=20
> Fixes: f17ef9b2d ("power: Make test_power driver more dynamic.")
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>

Thanks, queued.

-- Sebastian

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWjqMcAAoJENju1/PIO/qaVvIQAJ5ZXjOt46qRKUqiQRz6/h1D
ddQBpwDe9yrjWfGPd9nTTMbkmwv7jO4OXNofbQlyajmc8pObP5SEEm3CRjNSRtYF
58fpVVHgBrxNNpb8IUqYs9+0fLD3rSQbEcBv/Jb9Vk14EFYGyrg3BbE8q6k1C3RY
fsL7iNgkcbMyf0jZlkVG5wlmEN8shYC1LG3GOx4jE1tZqWwlBuLLX04aF58JzD7t
7Bj6I/Gc61UUGLzu96zuVJCZ65mCXLoPYBTGYYzcbkD3CTh+P26aHGWpem+yv8nn
da/hlrTmdA2vsro12/WRfMPy07A0Ti7JRrP0die4SyfJqIk6WHHYz7vuIr9ErJg4
TEYuOztaxt1XRnj2i3XSG7fv9sEOEq/oeBTtXwxoPznIoWijE/zutLu9fRnFw+qU
3gf+IkQ2S91Eom3ju7bc/rgUTp3f6yzihlrls0b/aWLEs2pXhoUiRAOTuf3TQw/M
VemObSmGUA51y9pLhTzXXGJ6F1FBp8laFuo12WmwjgAEbswySZTq38fgFt1wweoX
JZi42H0oUCWCqpKKITeYiYY2qHitOY41rfYoYfTMK5zPK6W5xSFPp30nd8I0meos
3oAQp2gWBbOUazi2+eJVa+CiE4/vMKUC+10CUYmFFOoVJ+K0uX8cPxGxf1xRm2jN
MuvDv7/8t7m0a2QDYXts
=q+qD
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

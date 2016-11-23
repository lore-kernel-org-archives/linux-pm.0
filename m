From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: ab8500_btemp: use builtin_platform_driver
Date: Wed, 23 Nov 2016 16:47:11 +0100
Message-ID: <20161123154711.spvfn2iguovkgp4h@earth>
References: <e9ca1fc1443a01e115a7603b7c6584dc3235fd76.1479912980.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="laa7zw7q6ytqfgmt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965221AbcKWPrQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Nov 2016 10:47:16 -0500
Content-Disposition: inline
In-Reply-To: <e9ca1fc1443a01e115a7603b7c6584dc3235fd76.1479912980.git.geliangtang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--laa7zw7q6ytqfgmt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 23, 2016 at 10:56:52PM +0800, Geliang Tang wrote:
> Use builtin_platform_driver() helper to simplify the code.
>=20
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>
> [...]
>
> +builtin_platform_driver(ab8500_btemp_driver);
>  module_exit(ab8500_btemp_exit);

builtin_XYZ() followed by module_XYZ() is obviously wrong. I think
the driver could be made tristate, so lets do that (and then use
module_platform_driver() instead).

-- Sebastian

--laa7zw7q6ytqfgmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg1ufkACgkQ2O7X88g7
+poD4xAAqPzlZJAE9sIBjdwDQHZXqqEUFzVs6/kC7gyv6d3+JwgpaVrtSFh/5H0J
V9DJomZiFDlpi7yybytyt9tGfpmxDokEYGHeoKg3AcVfcujaQlKmLBQQ7VQykrPw
R1n4q/S+NbjR7srb327Gq6owB73FAfjw0ZNPWx+2VmHGPtbLepdtZbbjNpgs2DjV
2T+KZM9Y+dyDKM/PfaHzDYkJ9PyBE0Ly6ERl4ogwLjfp41w04fft6Ds7P/6lY/Nl
CYPyjvsftni6Zssn+D5Yet3KodXfqXWdVZI0KugaqjoAhFb12rmWhnOcx9cgTbZZ
jIoBhq/ufxwcEBC1/+9t2HNW4vrJBw16tO824g4jePTTADbIhrSq1Z0VOIkcRyk5
l2pM2ml5dnoUBapn9tQuK8Gwfd1PSA4T2oh7tGghiyWqxu2hPmTVlCVX0E8zn2Zi
kA34XmgWZJ1/ZQ8HBZmWzha2XfGaxWMcLf1cHV9UQ/csX9nlEl5oeaxxwEU7XgzE
kYEN59YMEED3IFcn+egBRHRJTBe4lCtQXGQBZ7wKqUlgeUfVZZ3RgFoQmw/Ph8tg
jr2amLbbjO++MUHIkpLeuZ8MzoJRLhuoA788FiI8P+HMxZQqMuL3upGaSrgzb+R/
ilnrQFQ37W2QOEbuIJZ0yntdSCTJVDJwPIMIWQoDbAy22AGzqvI=
=D7Cy
-----END PGP SIGNATURE-----

--laa7zw7q6ytqfgmt--

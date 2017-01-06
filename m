From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 11/11] power: supplies: bq275xx: adds device tree
 binding documentation.
Date: Fri, 6 Jan 2017 01:06:05 +0100
Message-ID: <20170106000604.fluyyo4uwysyifrs@earth>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-12-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ndt7ucngkhyn2nzw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754707AbdAFAIi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Jan 2017 19:08:38 -0500
Content-Disposition: inline
In-Reply-To: <1482451507-37676-12-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: pali.rohar@gmail.com, afd@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--ndt7ucngkhyn2nzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 23, 2016 at 11:05:07AM +1100, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
>=20
> The bq275xx binding is a standard i2c style binding, however the
> deprecated compatible fields and different revisions warrant its own
> documentation.

Please add the other supported i2c bq27xxx chips and name the file
bq27xxx.txt. Otherwise maintaining this will become annoying.

-- Sebastian

--ndt7ucngkhyn2nzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhu32wACgkQ2O7X88g7
+poZgA/8D6hdw/ZLr+RgR7fg4P0KKFCAIVB185T4GXOGzVumfNRQ+28frRrPEqLZ
Y2+7/t6L/FYX5jk03Wp9n1KiD7fTEzSk1NRQFp1A70iHP1KHwzCsiCCBzD6K9/gN
cAQUY7OBnQGxdyZvsjk2zkwUDYZn6Q242Q+lYsp9vuv9yNyKPz//v3nXlYtnRsdg
rLHz1i+Y+hPYQrktrtajbpKSIkGaUjsBCGBv0tFwxvV0z8/FNVPKaCyQfXUuAeAI
uzSEgyenpSK9GwIwzu9xCXJPLe/XcXs7dd7vR9w0IV0mAbTz2DyXAQTsKbn6uyaw
/Dt1519vim7nNXOB1se+94M+nb9qjlSsEaTUsEYXDQiRTi43jy+0K/jneoBVp/qN
EemrCA7H2sI5BJp49+b5vBEY9i2sl53k6+m36RUbcndU17uzrwmeFiWZko+08IIc
utdkpIsH6Vz9XvJVN3lDyh73XaC9SXpA5m8XopFUzsgBl+dl6QZgFKFnHB2+LhW8
dxCbykCWYbcZvjzqWeEcH+RL6pnl1PqLaQguIU0zDS5Uras0Vj1WurpkKRBP3VtE
djQZQNfKASPZDj1HFPkJyOqOxvz+PiCSdbmLsP81xNDeb7vPuzsE6/ZyPtNItYsu
f0LmGGE775Us8N1zmbEN/XNxVcV33zzr2GwywyGqH+YssPcjtRI=
=6mx/
-----END PGP SIGNATURE-----

--ndt7ucngkhyn2nzw--

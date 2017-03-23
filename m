From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery
 device .type=unknown
Date: Thu, 23 Mar 2017 11:52:21 +0100
Message-ID: <20170323105221.qnyw2m4cgjcb24cl@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-8-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kwrlitqydavvxhwe"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932224AbdCWKwh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 06:52:37 -0400
Content-Disposition: inline
In-Reply-To: <20170321220921.5834-8-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>


--kwrlitqydavvxhwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 21, 2017 at 03:09:21PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Not for upstream.

Obviously.

> Temporary workaround to prevent bq24190-battery device
> from interfering with a fuel gauge that has .type=3Dpower_supply_type_bat=
tery
>=20
> I'll move properties from -battery device to -charger in a subsequent ver=
sion.

I thought about the transistor, which can take the battery
offline and IMHO it should be exposed as regulator.

That still leaves the health status reading, though. From
userspace's point-of-view this should be merged into the
battery device, if fuel-gauge can't provide that information.

-- Sebastian

--kwrlitqydavvxhwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTqOMACgkQ2O7X88g7
+pojrA//UcedlJOoTa+cMCfIpChwky2HXzJFjNgNH6w6YFQkLoQzhwMLPbePvN6G
+fgUen+TmNYIxhICJT6VInFpbM+kpGXGmL99mvIXnyVuOate1LCXr0VrkHvviCFf
G9pyL/KNHR1a5qlyxnLlFQo9y1K/jbUT2bNJW5Yhxiv6D6hJ0pMDNIf459uxSyQM
ebqVSFc2NPMjD38ZThAzfNFQmRh6MkhZtD1zABnwkrfqu9wdn9cjkwYmmk0Qfy9x
UR1699wZFcE0tiUuq39MUw3OyoAJRNypniG82KUXCuQlX6GRFFQmpfowwV+uSk/O
g7YXMU/rszezjupwJ+Zhm74DU/cbA3zug95wYhd3lZA0J92WFQwWSxitqwH/Wfu4
ErHGXn88SwV1gB2kibhJJuUv+n3yiqlTyQIoLvL3yPS6aKmC9vYVUIeUr2WQSHp+
wsZaAaHKpwU4Zcc2YXKgy7lHsPx5mPvH8EVCMMH1bFdjywTFf5eDhMz+FO50TBFy
r6xEXknYELBeMn3K/79K/AU/r+qsrdgTPnesCy74XfsekbYABQ7ZYEXg3K+guupv
RUZeh1vAvygTkNH3A0NFW8qAFptquTeVR/JJCCmjY8/8ck4OkPvegrhJXDb75ogA
vxtnuSo0IW05CXueZeq3mXM5rMFYidGMm6c9eZoTe/mFsaCtNtU=
=0ex7
-----END PGP SIGNATURE-----

--kwrlitqydavvxhwe--

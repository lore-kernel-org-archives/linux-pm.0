From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] two fixes for new bq27000/10 and bq27500 driver
Date: Sat, 19 Dec 2015 09:00:48 +0100
Message-ID: <20151219080048.GA11317@earth>
References: <cover.1450347172.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1450347172.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com
List-Id: linux-pm@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Dec 17, 2015 at 11:12:52AM +0100, H. Nikolaus Schaller wrote:
> H. Nikolaus Schaller (2):
>   power:bq27xxx: fix reading for bq27000 and bq27010
>   power:bq27xxx: fix register numbers of bq27500
>=20
>  drivers/power/bq27xxx_battery.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Can you give me your Acked-By (or Tested-By) for those patches?
Also I wonder if you would be available as official reviewer for
the driver.

-- Sebastian

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWdQ6tAAoJENju1/PIO/qaOykP/RwkYYcibgZavJZRSEYVlR/A
05POzdW1fYgQrmaH7cEzvJuv+OO6Y6Svb/xP5hA/DbPO8I89tFgj57ZsfSa6cAiM
wHc9P82zthnvQzzUS31mmSamZ7EAF3iv0mXPTw+99lsgllvIWiciKANjaCpPAfsb
o8vrtk4pnK3z66WCWxLsLE09Gc250rAljNg3CLkBav/87mzAhPz7aUypDvQbTnf6
qMcvGXIY85rf3OILQgnQVfwTT0hUQNq+BxMSRDzciOSXUnOIqXgXkuFaGKAqTrF6
lHeaR0L+rZ/Rlahb4rZlbw2TUlTwyOA/m013XUBPhPbv2hSkoGrKxVb6R9uKpe7K
RSiadXmd0uyzd5c4MayyNbbCgaj2zox4a8/wSyGk8hW6ZUbKotf7QndS3zVpnhYx
l/2j5IUUWAqLFEZqYCFxljCu7iguoFCtjk3lHvXtlQxShndAKSjRiwfYjypUqSOX
BWzl1jI6YveQku7EHnuTzPehn9uE4+411G8CtBylSe43S2H4gB31756p/3P+RbkN
LklFOCSP5LdO5geroubenORBa/WaqS3D19P7WU9lntBzq0rUqDT2EeP2QovYaYlP
pe+omuZKQW7PUvEevyv7JsgLLcggIIGyPNIum3JYhvKkBlf5oFKzznOsUK17C6RM
ZvHRhu7Aqn6D5mcr+cO/
=2NaQ
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

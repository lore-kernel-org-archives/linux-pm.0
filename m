From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/4] power: supply: axp288_fuel_gauge: Read 15 bit values
 2 registers at a time
Date: Sat, 17 Dec 2016 15:58:04 +0100
Message-ID: <20161217145804.vusj3ayihnxkmdol@earth>
References: <20161214163853.454-1-hdegoede@redhat.com>
 <20161214163853.454-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sjigynujnhkoir5g"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161214163853.454-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--sjigynujnhkoir5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 14, 2016 at 05:38:51PM +0100, Hans de Goede wrote:
> In order for the MSB -> LSB latching to work correctly we must read the
> 2 8 bit registers of a 15 bit value in one consecutive read.
>=20
> This fixes charge_full reporting 3498768 on some reads and 3354624 one
> other reads on my tablet (for the 3354624 value the raw LSB is 0x00).
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks for your patch. We are currently in the merge
window and your patch will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--sjigynujnhkoir5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVUnwACgkQ2O7X88g7
+pqEQQ/7BwaE1bEcDfpHDRnEZ2s+aB5XMaSYqmJYCr0o4T4KU4GMehaAbgfcMUtf
eSBTYynp6Mw2rQTtnk/bjf3Y7wJ6NgIyOKuS2A7JheYnIEk05q0R/GSMeipvILuU
PBqzmqK7M36EC6iyIhab9tQXO2WelltEpDW9e5yrXXLG9O3Cy5lF/AwYIaL+oyQD
eWmojdHCfW/0jorhStW0tnC62jGbgWMJOk/Q1c8XkL9LJfZRWxqpfR/jN6gxzg4J
jx9sUXqnNfmPYufZEhh+QsYWhfrziKa9sh1qfHO1QDQcGz1mlUFi8c8ARAxdowFY
ymMlwHJqtbOyDgRVM5a8mfzFuWHcawVj4OIiv70DBqAC+oGc/KyVMGH/i6ydylSH
KlBcCFqfyY4P60Q1IcLTQqHJwoSNNodoCtlL6VImxbZni7tt1GYnGjN6lkpvAF8i
JKUwh90S0osJrreJfqhw/rBTymXqJYdGscZJjlHaFgzgXtP8WqIl9fNPFWFr6E3A
brSXiHwQQ6wKpT5hU44WnsbS9HFBklerO7BV2++DvRfkOjPZxSgoJVd5ngE8jYQH
N9ATnhRclXUU1AiXIEg63J96cGyfkZJSbAy7Q8HqJ+k8hcNktHx7XQR3nN88Wdh+
u/TaQjphEid9FY95ii6D+rt0yv1uOIKlSIz0se1eKx0qPBUE3x8=
=Gck8
-----END PGP SIGNATURE-----

--sjigynujnhkoir5g--

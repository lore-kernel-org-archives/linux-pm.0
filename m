From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] power: supply: axp288_fuel_gauge: Drop platform_data
 dependency
Date: Sat, 17 Dec 2016 16:00:47 +0100
Message-ID: <20161217150046.2eeohjflddcrkjow@earth>
References: <20161214163853.454-1-hdegoede@redhat.com>
 <20161214163853.454-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tg7ddeqlbq4vpzyu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161214163853.454-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--tg7ddeqlbq4vpzyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 14, 2016 at 05:38:53PM +0100, Hans de Goede wrote:
> When the axp288_faul_gauge driver was originally merged, it was
> merged with a dependency on some other driver providing platform
> data for it.
>=20
> However the battery-data-framework which should provide that data
> never got merged, resulting in x86 tablets / laptops with an axp288
> having no working battery monitor, as before this commit the driver
> would simply return -ENODEV if there is no platform data.
>=20
> This commit removes the dependency on the platform_data instead
> checking that the firmware has initialized the fuel-gauge and
> reading the info back from the pmic.
>=20
> What is missing from the read-back info is the table to map raw adc
> values to temperature, so this commit drops the temperature and
> temperature limits properties. The min voltage, charge design and
> model name info is also missing. Note that none of these are really
> important for userspace to have.
>=20
> All other functionality is preserved and actually made available
> by this commit.
>=20
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D88471
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks fine to me, thanks for the cleanup. I will wait
a bit with merging it to give others a chance to comment.

-- Sebastian

--tg7ddeqlbq4vpzyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVUx4ACgkQ2O7X88g7
+pqSZg//a+/ExQE2GRzD2m6TW0HgqKSVZbJFY6M6gYx+TYLjIVYaKWTp8SbMaVUm
HY3HKCj5euryIgqOIKKSHDGEhKG+hJohs/89yEYZLYkulYe0B0qfanHvC4MnhtUr
JzB9BkcumgbxnDw0zeinSfHxA8aB8AepPK9fLObr/dbRDExTFGtKnb9t6XUY2EUB
GkLAZD18vbELvjmNRhTjRfepQ25z/DJoZA9+/v5+FzstXo0bI767sUREnL8PxjEM
H8g4wp4YB7snaGtxjDe9l8agp2Ol2281YYv20EcIjyW5y2JFQJhccUICTfpaMl2a
64M+8IeE/rIQ2Y5EVe/9guGTg3x/T0R3Q55JoWvIob2plPm2xHaSy5UtxLIuFIOE
9/NEtIT7wRDXubB+f9NU91kSVhXgUEfqOZp8we1k/5Frt4kT9x12aU+yc1DuYkUu
+Wx0C6xDmosEIXGbTTdprTswPEUtM/SuCYfhNf7gHyup+TlCrm41BHx5nPCy/yrZ
QoogHAhzZ3bQ6ygL5NaTAsb+Ov4YQzrI1LDa3XE2x2o/lm6kP9sCMmHlUykK4cyx
fJdR438GVSOQeGyogoz8ltJo0nFFnvhk+0g2FXOy7VCdMM5Ig0OMhz/Wjj1G6LD+
Ky6AvStBQu62h4DyfbQ4lpzUYPcgbX5/KJCml15AlMQUMNwwmNk=
=kp/L
-----END PGP SIGNATURE-----

--tg7ddeqlbq4vpzyu--

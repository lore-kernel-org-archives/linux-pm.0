From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v4 0/4] Add the BQ25896 charger IC
Date: Thu, 30 Aug 2018 23:46:30 +0200
Message-ID: <20180830214630.4mqnqlllnqrv77pu@earth.universe>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731174909.9392-1-angus@akkea.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tyhv7vpy24npt4i4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180731174909.9392-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, angus.ainslie@puri.sm, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--tyhv7vpy24npt4i4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 31, 2018 at 11:49:05AM -0600, Angus Ainslie (Purism) wrote:
> Changes since v3:
>=20
> Corrected reviewed-by tags.
> Fix typos.
> Clarify desscriptions of patches.
>=20
> Changes since v2:
>=20
> Remove additional un-used table entries.
> Use the exsisting compitble string for the new part.
> Voltage now doesn't depend on state "online".

Thanks, queued.

-- Sebastian

> Angus Ainslie (Purism) (4):
>   power: bq25890_charger.c: Add debugging output of failed
>     initialization
>   power: bq25890_charger.c: Remove unused table entries
>   power: bq25890_charger.c: Add the BQ25896 part
>   power: bq25890_charger.c: Read back the current battery voltage
>=20
>  .../bindings/power/supply/bq25890.txt         |  3 +
>  drivers/power/supply/bq25890_charger.c        | 62 ++++++++++++++-----
>  2 files changed, 50 insertions(+), 15 deletions(-)
>=20
> --=20
> 2.17.1
>=20

--tyhv7vpy24npt4i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluIZa4ACgkQ2O7X88g7
+pq9ABAAicydsx1uBq5osJO8Q7prWE3tfvEUsB6oj87fzSanq05A0Yc6diizLv8G
sQqTnDkFcdgkTgUQ4vvGEpX3cTkvAvpJypWvnmMSipUw7jvEF85Op0OR3SqQDeXX
spEXWezKcTDM9bW54IscRY0QSZLQq87nSNh267z04ORbEqIanT2/IwxQAr0VkYRo
1Olc1YkXR5hPRObOiDbWvLPMqqCCMA7qQ9CxY1QDx1kX1LQW76lsZhV5XZLLnV6M
/Nnqdj6P/g3P+cvAMXlRjg77n37EbRkUvWLj/rSAT8pikFm2+ovvHvIMM+DG7qrx
K5honNTmOPb1JRl88G1zFZxbMgUBh6HhJCm49Ae4k6QEGbl/BPoHHIXOYmUCu6fM
rBedPdeUK5DhSZN3k/6curGHB7A9okAtmPuoRr9swL+52j0HXJ/JhzyD9RJELUZz
0QPdohPhgzrtnQ8Nwk0XszL3+7A5oT5Brscbp7LJmzAwMmzYNlndzUoJn+lKLBC9
0mJFskFJebSHe1rhPqoXYS1s06RSXPMV7s+9SUYReozHSKc43Yxf87wA73+ES4Jh
RvJ7qCSZ8TJAOKUq7aGCzlAOBvLfD1oup4SZOfGj9e7h2urQhuoCYnygcC5kloIC
YrZPx8ERX46qAYZihkUxJhX+TseWN+CvMh4eNshizNHB1iC/Vgk=
=n10L
-----END PGP SIGNATURE-----

--tyhv7vpy24npt4i4--

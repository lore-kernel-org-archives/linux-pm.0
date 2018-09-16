From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 0/6] shutdown procedure verification for SAMA5D2
Date: Sun, 16 Sep 2018 12:43:01 +0200
Message-ID: <20180916104301.dcrm333ydo5kh5bj@earth.universe>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ajzuh2r3fda6zumn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--ajzuh2r3fda6zumn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 30, 2018 at 02:50:05PM +0300, Claudiu Beznea wrote:
> Hi,
>=20
> Patch 1 from this series implement a fix for shutdown procedure
> for SAMA5D2.
>=20
> The rest of the patch are improvements as follows:
> patch 2 - use only one function for poweroff
> patches 3-6 - cosmetic improvements
>=20
> The patches are based on latest sys-reset/for-next [1].
>=20
> Thank you,
> Claudiu Beznea
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-suppl=
y.git

Thanks, queued.

-- Sebastian

>=20
> Claudiu Beznea (6):
>   power: reset: at91-poweroff: switch to slow clock before shutdown
>   power: reset: at91-poweroff: use only one poweroff function
>   power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
>   power: reset: at91-poweroff: make sclk part of struct shdwc
>   power: reset: at91-poweroff: rename at91_shdwc_base member of struct
>     shdwc
>   power: reset: at91-poweroff: do not procede if at91_shdwc is allocated
>=20
>  arch/arm/mach-at91/pm_suspend.S          |   8 +++
>  drivers/power/reset/at91-sama5d2_shdwc.c | 119 +++++++++++++++++++++----=
------
>  2 files changed, 88 insertions(+), 39 deletions(-)
>=20
> --=20
> 2.7.4
>=20

--ajzuh2r3fda6zumn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueM7UACgkQ2O7X88g7
+pqq7BAAgtqyJinnPFBoPoGojnN9x354oOu5o3BN4Z0gMoP4Wv5qjhHA269uimJh
BtI26ravSSDVFHDmHeQiTvAFYsHUSuXsTMVvdJg95rbFv7M990+hUo7wTMFxU6xL
XOVXT9cV/acYNC7F0XCedMRKxyUcFdlmTEszMnokgpJuUMtO6kU/5M/jI5rgx8j7
+JZjRd2CC6U42Ru45OGt4SHbkcTS8aaQL2g1Zsg9XdtJ4MPePWTAhRGl5NxfqRv8
bxTuabXZ30XgZD0LmFm5LXUFuwlSy1+cn3KTUxwe/78SbBJWsu7bgj9R1h2Ie390
k8p9jJmBJYJYdibBpNv1itGiACkf/OL8uPRWoVlfIZiFHryET8UQDBA/4T8FTmY8
jK5u8jiUh8aDi1R5QRBnKLK/WWtaW0qC4BNTG23pSo7dCB+9GTm/AFkelnEjkZel
DSpVhWuGWAtE190SZomUg0ZvRWR3kJUHE0clgI4mLl+ZqZjTOu3lrZ0kU9L8bFOm
80E5u4bqjL395AB8SykuEgJ3dnWGR3nQecKqJb0gJsnslf2UKTjk6RrzemMAr3DZ
tW34Cgdkj53bIXfXc/YJeuWpjQk/tVIwOS6uNspnhYJ/A5Z5GhYhna+LIfES+NNj
6YHlWldjgTRH1n6s5XR7k4VGvMlZSkrefHiOVCoFcSCguA+GZQM=
=Twvn
-----END PGP SIGNATURE-----

--ajzuh2r3fda6zumn--

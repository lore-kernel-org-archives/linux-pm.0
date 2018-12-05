From: Sebastian Reichel <sre@collabora.com>
Subject: Re: [PATCH] power: supply: cpcap-battery: make array
 cpcap_battery_irqs static, shrinks object size
Date: Wed, 5 Dec 2018 18:28:41 +0100
Message-ID: <20181205172841.2ivcisxk2h7kul7e@earth.universe>
References: <20181129230342.4300-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phpln7qmp3skcy3j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181129230342.4300-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--phpln7qmp3skcy3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 29, 2018 at 11:03:42PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Don't populate the array cpcap_battery_irqs  on the stack but instead
> make it static. Makes the object code smaller by 99 bytes:
>=20
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   13673	   2448	      0	  16121	   3ef9	cpcap-battery.o
>=20
> After:
>    text	   data	    bss	    dec	    hex	filename
>   13510	   2512	      0	  16022	   3e96	cpcap-battery.o
>=20
> (gcc version 8.2.0 x86_64)
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 98ba07869c3b..204e22e3e9b4 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -620,7 +620,7 @@ static int cpcap_battery_init_irq(struct platform_dev=
ice *pdev,
>  static int cpcap_battery_init_interrupts(struct platform_device *pdev,
>  					 struct cpcap_battery_ddata *ddata)
>  {
> -	const char * const cpcap_battery_irqs[] =3D {
> +	static const char * const cpcap_battery_irqs[] =3D {
>  		"eol", "lowbph", "lowbpl",
>  		"chrgcurr1", "battdetb"
>  	};
> --=20
> 2.19.1
>=20

--phpln7qmp3skcy3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwICsUACgkQ2O7X88g7
+ppspQ//W2sTS7H/gv4ulEdipPoxlBt+xPHgvJ61Z4jRsVB1pm36U/sIJ8wSDBjN
uWMjHTB8cjB39Saa9aDkX1nBWSVX3Gjrw6dh9LlfAa03PCWTOr1kNgSo8jRluVsQ
JFKsRjQrCdtN0Gzked4dQOa0oqHfRksV2VspaeQQfYa6gQ2ONLJOTNNY3NL/0LSK
IgqWah5fc0MUZGjvfto+PWmSXQfKN5gHHSugHuu1Xq1eGNwG1RMMb4AWnbFyH+K7
v9eGQATiav8be0RJ9k1WG5EUZ9zmkSqjl17KxEFUJl/tETSkCWSQsaLFyKoV/r9F
JCWsQT9go+D4ftiRqys+Vk0j7BNRF+o8cwY8Io6XmSlSC6JgkDc/53bS9OPsMRiR
BhjJJJP6sezgumKo1D7hwPrrrCoOENvGXBoeh2S1C7c2ZBRURN/nOF4j3m2ceDAz
5B6gdtmW7S2v6oxNwUuo1IzaH31T4nUKJGolzkhQA8PLmD/6X5gwiDP0xUxQJVtn
WFmyEky2e4yu74fKzvQbkeCrzXXyedNkGHAIqrsRQNyihPXmnPj0/KpwglJujJCC
F5UUvB4EoMaUZYROwBgBo8lnsRhcG002z0uWHwqlbAV8yfSJ1EjcgfSQHM6+4U0C
l0ES2zLgQUMvYnAIGxB9HVUzcIUgczyd3nk8YarRAe2+ffwdYiY=
=JDfb
-----END PGP SIGNATURE-----

--phpln7qmp3skcy3j--

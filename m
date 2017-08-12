From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: lp8788: Make several arrays static const
 * const
Date: Sat, 12 Aug 2017 14:03:56 -0400
Message-ID: <20170812180356.fth4xnltlccnyiyz@earth>
References: <20170811215212.9985-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="goxs6yl665dszigg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170811215212.9985-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Milo Kim <milo.kim@ti.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--goxs6yl665dszigg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 11, 2017 at 10:52:12PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Don't populate various read only arrays on the stack but make them
> static const, making the object code smaller and saves 148 bytes
> overall:
>=20
> Before:
>    text    data     bss     dec     hex filename
>   11940    4496      64   16500    4074 lp8788-charger.o
>=20
> After:
>    text    data     bss     dec     hex filename
>   11472    4816      64   16352    3fe0 lp8788-charger.o
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/supply/lp8788-charger.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index 677f7c40b25a..0f3432795f3c 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -626,7 +626,7 @@ static ssize_t lp8788_show_charger_status(struct devi=
ce *dev,
>  {
>  	struct lp8788_charger *pchg =3D dev_get_drvdata(dev);
>  	enum lp8788_charging_state state;
> -	char *desc[LP8788_MAX_CHG_STATE] =3D {
> +	static const char * const desc[LP8788_MAX_CHG_STATE] =3D {
>  		[LP8788_OFF] =3D "CHARGER OFF",
>  		[LP8788_WARM_UP] =3D "WARM UP",
>  		[LP8788_LOW_INPUT] =3D "LOW INPUT STATE",
> @@ -650,8 +650,10 @@ static ssize_t lp8788_show_eoc_time(struct device *d=
ev,
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct lp8788_charger *pchg =3D dev_get_drvdata(dev);
> -	char *stime[] =3D { "400ms", "5min", "10min", "15min",
> -			"20min", "25min", "30min", "No timeout" };
> +	static const char * const stime[] =3D {
> +		"400ms", "5min", "10min", "15min",
> +		"20min", "25min", "30min", "No timeout"
> +	};
>  	u8 val;
> =20
>  	lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);
> @@ -665,9 +667,13 @@ static ssize_t lp8788_show_eoc_level(struct device *=
dev,
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct lp8788_charger *pchg =3D dev_get_drvdata(dev);
> -	char *abs_level[] =3D { "25mA", "49mA", "75mA", "98mA" };
> -	char *relative_level[] =3D { "5%", "10%", "15%", "20%" };
> -	char *level;
> +	static const char * const abs_level[] =3D {
> +			"25mA", "49mA", "75mA", "98mA"
> +	};
> +	static const char * const relative_level[] =3D {
> +			"5%", "10%", "15%", "20%"
> +	};
> +	const char *level;
>  	u8 val;
>  	u8 mode;
> =20
> --=20
> 2.11.0
>=20

--goxs6yl665dszigg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPQwwACgkQ2O7X88g7
+ppzshAAqPPsMNiMUMjRb0q1EWJD4NlIH/NeiavHOmrPLNuzwBvd22jlhKVMFVsL
6zzVPj8MpM6/EGZxigiUiK3fpqYKHjL1YwG+DlT2vVmnO8FS9ZM8s2fOH142dG1n
FbZgKHJfyx360OqgPdJi26d5BPVX8N1kR4sY4ZkOQ993ykFjKRMlMInS804jvMPX
AEO779ako6Y/711Of/z1IzcKLxRGSq9wKBVCAFbMXpp1bnmHPfc3qsfOMv2R6llp
k/eYzCYlatcT/RLvhdpIIKjLoqWqaHspeIYIRibcIquf4x3W2JjVoQ1rc7HryYEV
XqNxLF6c2PSuM7to8NHZowp+8BKentPjUakYO13fZZE0hls0/WmIrM5dhiQMQElN
xE2hKRwa4K/6ui2ZEQe4zPjtA+5PeNEO9DKJNqEaDqFLdI97/UdWJuBzxCOBUUPP
/BhTyIfosKqry9UTMFuq9gQwyUL7/e0mp3O9wS6y7B+J95RkJYnGJG77nXNH0oMb
ffzmGvfZiKTQd7vrtvSdYL3WYwpb3Fm76wzzPpzrox2W68KU2a85hya0rGOvdH5s
NgU2MWmLAPxXYpUMYk5pbQVFJTpUVyO0mNGGNZWO3Upal4AQdm/gr5GuujgkONYF
7OiGbMnTyR3zZkM8Tl5hRTr+98/ElQFVcSGwl0Air6OF6JGF6fY=
=YJ2N
-----END PGP SIGNATURE-----

--goxs6yl665dszigg--

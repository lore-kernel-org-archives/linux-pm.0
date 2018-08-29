From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: ab8500_fg: fix obsolete function
Date: Thu, 30 Aug 2018 00:33:20 +0200
Message-ID: <20180829223320.rhfusyuywofjmpx7@earth.universe>
References: <1535366955-12733-1-git-send-email-dingxiang@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37hn7rqsvit6mk4s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535366955-12733-1-git-send-email-dingxiang@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--37hn7rqsvit6mk4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 27, 2018 at 06:49:15AM -0400, Ding Xiang wrote:
> simple_strtoul is obsolete, and use kstrtoint instead
>=20
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 02356f9..2bdadb5 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -2582,11 +2582,12 @@ static ssize_t ab8505_powercut_flagtime_write(str=
uct device *dev,
>  				  const char *buf, size_t count)
>  {
>  	int ret;
> -	long unsigned reg_value;
> +	int reg_value;
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> =20
>  	if (reg_value > 0x7F) {
>  		dev_err(dev, "Incorrect parameter, echo 0 (1.98s) - 127 (15.625ms) for=
 flagtime\n");
> @@ -2636,7 +2637,9 @@ static ssize_t ab8505_powercut_maxtime_write(struct=
 device *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> +
>  	if (reg_value > 0x7F) {
>  		dev_err(dev, "Incorrect parameter, echo 0 (0.0s) - 127 (1.98s) for max=
time\n");
>  		goto fail;
> @@ -2684,7 +2687,9 @@ static ssize_t ab8505_powercut_restart_write(struct=
 device *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> +
>  	if (reg_value > 0xF) {
>  		dev_err(dev, "Incorrect parameter, echo 0 - 15 for number of restart\n=
");
>  		goto fail;
> @@ -2777,7 +2782,9 @@ static ssize_t ab8505_powercut_write(struct device =
*dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> +
>  	if (reg_value > 0x1) {
>  		dev_err(dev, "Incorrect parameter, echo 0/1 to disable/enable Pcut fea=
ture\n");
>  		goto fail;
> @@ -2849,7 +2856,9 @@ static ssize_t ab8505_powercut_debounce_write(struc=
t device *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> +
>  	if (reg_value > 0x7) {
>  		dev_err(dev, "Incorrect parameter, echo 0 to 7 for debounce setting\n"=
);
>  		goto fail;
> --=20
> 1.8.3.1
>=20
>=20
>=20

--37hn7rqsvit6mk4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluHHzAACgkQ2O7X88g7
+ppnEA//f6e2u3qwcvI1Eh6rrXjU/ST9096xpUNfHttE/gilKC5gQOU3V1qKV1lt
7L7OOMQGZZRAIdVz0mSPckryW3d/d+Tn3xqzzHO9VpV0SQmo+GcNTxOAIIJ7giPr
uXU6/YEVTBHm5kt7dkbTqhOJqq7dMGDYMd0dDTXl+aT/PyEAStL0ybGvHmQsFIap
2xVMzTkpkQWjPw9Ffm5yL4FZEFKc3tdPl0tCgOKRTW8zsO0u2VrDBveF+YFWJUM2
aiP54r56YbEPMTxsDO4gxY/QKOzwklIW+7BEH4RyGBkYhlJOYg9eGhZQ+Ca4JQ9H
9+i4yfrqbPgP8HFnPl0/EbuXGBfSjbf1xmu0efPhJZNhgE/mIG3w5qhVf0RgzGHz
7L5gmyaAGc32s2+jPMDQs8WJxI6TrwkJyRGRsK3r6DrUP/NTqzzW+DCaWFFSe/15
5P5qAUjxYku5626Em9vrQPRd5appDwCU470WYpHz73wzo9f7IqLXx1Ni8lVf4d3C
RDr5S90M10xP6M7SDxpNFqnPNZzKxkWV5L6Z3tDBMCxkTuUPsfsZl4tsR0AiTdVt
25i590tMGlUBEPlaOxd/I7/TuGKa4ERIha5D+PsiS+GDytAqblJ70ok99jUdVSyt
f3bZMofVrT+9JTRkkXGgBB1xaA1z2fmDqAAFxTJWxHQaudmBsgY=
=Mvg/
-----END PGP SIGNATURE-----

--37hn7rqsvit6mk4s--

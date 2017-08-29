From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: max17042_battery: Fix compiler warning
Date: Tue, 29 Aug 2017 12:13:37 +0200
Message-ID: <20170829101337.7spvvle4zcvpaija@earth>
References: <20170829092728.15039-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="acrnoi5faxiko7vf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56072 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbdH2KNl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 06:13:41 -0400
Content-Disposition: inline
In-Reply-To: <20170829092728.15039-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org


--acrnoi5faxiko7vf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 29, 2017 at 11:27:28AM +0200, Hans de Goede wrote:
> Fix drivers/power/supply/max17042_battery.c:1059:6:
> warning: 'acpi_id' may be used uninitialized in this function.
>=20
> No idea why my gcc version did not catch this.
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 18a44e4ed6ff..5b556a13f517 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -983,7 +983,7 @@ static int max17042_probe(struct i2c_client *client,
>  	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
>  	const struct power_supply_desc *max17042_desc =3D &max17042_psy_desc;
>  	struct power_supply_config psy_cfg =3D {};
> -	const struct acpi_device_id *acpi_id;
> +	const struct acpi_device_id *acpi_id =3D NULL;
>  	struct device *dev =3D &client->dev;
>  	struct max17042_chip *chip;
>  	int ret;
> --=20
> 2.13.4
>=20

--acrnoi5faxiko7vf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlPlEACgkQ2O7X88g7
+prukw//cmZUEzJtLIr3GISb/rYkJfc+KGhKb/1+gUXQPF8egrlcj5dxWPGDmvEL
ytKiuM+zQ9lcZHS8bc73GYlZEpQK1AG9I/DOYVBfpj/ywj9Fn2ADN5Mj0sS2CFYt
WpivOFSV4f2CjbiYwYDVpcG1H+MarXXOZbSuk0VobMDzGzlbzi8eKY+huDzz1raI
e4V4+Q52blleCmso62NVsX58Xduq8Tuv6cJ+AGY6QGUxaiyAmNIHL4xp03GMHLyI
0sCwBF4KnmeA7CE5cnGYP8rhjCgmjd0wSQ3E7IAGifHWvFMRhgfJ7cJVE9X7DrWq
dwbMFNy9BBGg2lyqCPvyhYJPRQS3p3a5o4bUmNbFkzY0YByjB4B9rv/Xtc0Dp0EZ
Lw07nNBAouZuTOTheOiHlo3GVGeYwTBGafBbFMdUN+cUAp2/tFgRnLqPcailrYP8
GlDf3Rm3l0gCIdVlN1dlIYfoghdy1TkM5RwUAXs8/wXNOdB6h9Oc2djjUnq3XzYc
pSXYZRGg9Y15TGXtDNpDCci9F5D0vY9KPbPI7nFqabXjl79FvSLa0Hr5XhV9IPFf
2EElUvdYEdT0JfFvpF7jsS85KKmDU+15BJoHQmdVeVa6Csm+ziLQSz8ItfItYYe/
AhC3mFFFE41TnrNSvHsoEaZ+laGgJ73ui0FftmgFXhgZ2s1yTMU=
=MVaB
-----END PGP SIGNATURE-----

--acrnoi5faxiko7vf--

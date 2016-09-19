From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/1] power: supply: sbs-battery: Cleanup removal of
 chip->pdata
Date: Mon, 19 Sep 2016 20:47:31 +0200
Message-ID: <20160919184731.uuba5vkwv4xf3vxs@earth>
References: <1474278372-38077-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="daulgqnbglp5lfzi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbcISSri (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 14:47:38 -0400
Content-Disposition: inline
In-Reply-To: <1474278372-38077-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: linux-pm@vger.kernel.org


--daulgqnbglp5lfzi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 19, 2016 at 05:46:12PM +0800, Phil Reid wrote:
> There where still a few lingering references to pdata after commit
> power: supply: sbs-battery: simplify DT parsing.
>=20
> Remove pdata from struct=B7sbs_info and conditional checks to ser if this
> was set from the i2c read / write functions.
> Instead of call max in each function for incrementing poll_retry_count
> do it once in the probe function.
> Fixup null pointer dereference in to pdata in sbs_external_power_changed.
>=20
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/power/supply/sbs-battery.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 248a5dd..3ffa0ec 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -163,7 +163,6 @@ static enum power_supply_property sbs_properties[] =
=3D {
>  struct sbs_info {
>  	struct i2c_client		*client;
>  	struct power_supply		*power_supply;
> -	struct sbs_platform_data	*pdata;
>  	bool				is_present;
>  	struct gpio_desc		*gpio_detect;
>  	bool				enable_detection;
> @@ -185,8 +184,7 @@ static int sbs_read_word_data(struct i2c_client *clie=
nt, u8 address)
>  	s32 ret =3D 0;
>  	int retries =3D 1;
> =20
> -	if (chip->pdata)
> -		retries =3D max(chip->i2c_retry_count + 1, 1);
> +	retries =3D chip->i2c_retry_count + 1;

Why + 1? This should already be done in probe().

>  	while (retries > 0) {
>  		ret =3D i2c_smbus_read_word_data(client, address);
> @@ -213,10 +211,8 @@ static int sbs_read_string_data(struct i2c_client *c=
lient, u8 address,
>  	int retries_length =3D 1, retries_block =3D 1;
>  	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
> =20
> -	if (chip->pdata) {
> -		retries_length =3D max(chip->i2c_retry_count + 1, 1);
> -		retries_block =3D max(chip->i2c_retry_count + 1, 1);
> -	}
> +	retries_length =3D chip->i2c_retry_count;
> +	retries_block =3D chip->i2c_retry_count;
> =20
>  	/* Adapter needs to support these two functions */
>  	if (!i2c_check_functionality(client->adapter,
> @@ -280,8 +276,7 @@ static int sbs_write_word_data(struct i2c_client *cli=
ent, u8 address,
>  	s32 ret =3D 0;
>  	int retries =3D 1;
> =20
> -	if (chip->pdata)
> -		retries =3D max(chip->i2c_retry_count + 1, 1);
> +	retries =3D max(chip->i2c_retry_count + 1, 1);

Here we should be able to drop max() and +1, too.

>  	while (retries > 0) {
>  		ret =3D i2c_smbus_write_word_data(client, address,
> @@ -707,7 +702,7 @@ static void sbs_external_power_changed(struct power_s=
upply *psy)
>  	cancel_delayed_work_sync(&chip->work);
> =20
>  	schedule_delayed_work(&chip->work, HZ);
> -	chip->poll_time =3D chip->pdata->poll_retry_count;
> +	chip->poll_time =3D chip->poll_retry_count;
>  }
> =20
>  static void sbs_delayed_work(struct work_struct *work)
> @@ -791,7 +786,7 @@ static int sbs_probe(struct i2c_client *client,
>  	rc =3D of_property_read_u32(client->dev.of_node, "sbs,i2c-retry-count",
>  				  &chip->i2c_retry_count);
>  	if (rc)
> -		chip->i2c_retry_count =3D 1;
> +		chip->i2c_retry_count =3D 0;

I think 0 was correct, since you do a + 1 later.

>  	rc =3D of_property_read_u32(client->dev.of_node, "sbs,poll-retry-count",
>  				  &chip->poll_retry_count);
> @@ -802,6 +797,7 @@ static int sbs_probe(struct i2c_client *client,
>  		chip->poll_retry_count =3D pdata->poll_retry_count;
>  		chip->i2c_retry_count  =3D pdata->i2c_retry_count;
>  	}
> +	chip->i2c_retry_count =3D max(chip->i2c_retry_count + 1, 1);
> =20
>  	chip->gpio_detect =3D devm_gpiod_get_optional(&client->dev,
>  			"sbs,battery-detect", GPIOD_IN);

I still think we should make i2c_retry_count and poll_retry_count
unsigned and skip the max() part completely.

-- Sebastian

--daulgqnbglp5lfzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4DLAAAoJENju1/PIO/qallUP/A9VPkii05G3x+d0KCDd7Tb/
3QpW5CudsC/ujbjb8NdO3/O8i9Vzs7d9Q5FbQ2qAn0uXG6mPWcF8DkIINF0SW3vo
xVcTIGWBrTjKLNTQx2oak7u7xMGdkvT/Zi4LAB7zgL2wUaAiWPhnx3h03nY2rE3V
/iPDcHyP/Y7txRbDOwbuPuZ3OeITld8StqQGe6M9IKeruoiy/ccsqhK0nhOYOIFZ
a7agb2dpEjYSH0v/Zss8VX5qAcKfRWrBP+OWHWqDKlPfmPz2LNoPe8CjrAeQj3TH
hJhsjYKl5drJZG6hTHbqoxKQSbn69Uf2oLdRhradG4fxLiTXMKwEUbu1mTWoNMOg
5ldl3mo3AOzkSMf+GB1jZbqD8LTiRtjsKAUIroCo4Mnp9kQfIaqSV4frsHZlhFhN
GUffX2KE2P3FCAsx5GuOZk6kNKS2u5ngtgiWg7ZOPPVo+XrAcXSHVv09MVLbDJlz
y+UdCNa/UD0ZTN/oLcplfv44OFx7HN6O0FSZjbUFeJh+YZPdTChViRhLwlYpnRIs
T5F9yVzmFUk1kWP8aTi1xegR6+/b6NmdRvVA1SZJWLABJugiEU5nx9byDAP17Ob3
fw0trM6UfDb/Mc24Wq0ZHKF1qQ9UPnzQubkY2Vggtzyw+s/Kp2sG39+GfjBNczgN
JAq1UAO1IAfnTbPlyBQD
=fxgJ
-----END PGP SIGNATURE-----

--daulgqnbglp5lfzi--

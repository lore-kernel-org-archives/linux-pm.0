From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH V3 1/1] power: sbs-battery: Use gpio_desc and sleeping
 calls for battery detect
Date: Wed, 31 Aug 2016 17:46:42 +0200
Message-ID: <20160831154642.nvbb2fdfkspicbq7@earth>
References: <1472636131-82477-1-git-send-email-preid@electromag.com.au>
 <1472636131-82477-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhvh5tonliegqsrd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933887AbcHaPqs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Aug 2016 11:46:48 -0400
Content-Disposition: inline
In-Reply-To: <1472636131-82477-2-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org


--mhvh5tonliegqsrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Wed, Aug 31, 2016 at 05:35:31PM +0800, Phil Reid wrote:
> Switch to using new gpio_desc interface and devm gpio get calls to
> automatically manage gpio resource. Use gpiod_get_value which handles
> active high / low calls.
>=20
> If gpio_detect is set then force loading of the driver as it is
> reasonable to assume that the battery may not be present.
>=20
> Update the is_present flag immediately in the IRQ.
>=20
> pdata is always allocated in probe, which removes need to do check for
> not null in driver.
>=20
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/power/supply/sbs-battery.c | 129 ++++++++++++++-----------------=
------
>  include/linux/power/sbs-battery.h  |   6 +-
>  2 files changed, 51 insertions(+), 84 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index e1dfb3e..28670e4 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -26,7 +26,7 @@
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of.h>
>  #include <linux/stat.h>
> =20
> @@ -165,7 +165,6 @@ struct sbs_info {
>  	struct power_supply		*power_supply;
>  	struct sbs_platform_data	*pdata;
>  	bool				is_present;
> -	bool				gpio_detect;
>  	bool				enable_detection;
>  	int				last_state;
>  	int				poll_time;
> @@ -183,8 +182,7 @@ static int sbs_read_word_data(struct i2c_client *clie=
nt, u8 address)
>  	s32 ret =3D 0;
>  	int retries =3D 1;
> =20
> -	if (chip->pdata)
> -		retries =3D max(chip->pdata->i2c_retry_count + 1, 1);
> +	retries =3D max(chip->pdata->i2c_retry_count + 1, 1);
> =20
>  	while (retries > 0) {
>  		ret =3D i2c_smbus_read_word_data(client, address);
> @@ -211,10 +209,8 @@ static int sbs_read_string_data(struct i2c_client *c=
lient, u8 address,
>  	int retries_length =3D 1, retries_block =3D 1;
>  	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
> =20
> -	if (chip->pdata) {
> -		retries_length =3D max(chip->pdata->i2c_retry_count + 1, 1);
> -		retries_block =3D max(chip->pdata->i2c_retry_count + 1, 1);
> -	}
> +	retries_length =3D max(chip->pdata->i2c_retry_count + 1, 1);
> +	retries_block =3D max(chip->pdata->i2c_retry_count + 1, 1);
> =20
>  	/* Adapter needs to support these two functions */
>  	if (!i2c_check_functionality(client->adapter,
> @@ -278,8 +274,7 @@ static int sbs_write_word_data(struct i2c_client *cli=
ent, u8 address,
>  	s32 ret =3D 0;
>  	int retries =3D 1;
> =20
> -	if (chip->pdata)
> -		retries =3D max(chip->pdata->i2c_retry_count + 1, 1);
> +	retries =3D max(chip->pdata->i2c_retry_count + 1, 1);
> =20
>  	while (retries > 0) {
>  		ret =3D i2c_smbus_write_word_data(client, address,
> @@ -306,13 +301,11 @@ static int sbs_get_battery_presence_and_health(
>  	s32 ret;
>  	struct sbs_info *chip =3D i2c_get_clientdata(client);
> =20
> -	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT &&
> -		chip->gpio_detect) {
> -		ret =3D gpio_get_value(chip->pdata->battery_detect);
> -		if (ret =3D=3D chip->pdata->battery_detect_present)
> -			val->intval =3D 1;
> -		else
> -			val->intval =3D 0;
> +	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT && chip->pdata->gpio_detect) {
> +		ret =3D gpiod_get_value_cansleep(chip->pdata->gpio_detect);
> +		if (ret < 0)
> +			return ret;
> +		val->intval =3D ret;
>  		chip->is_present =3D val->intval;
>  		return ret;
>  	}
> @@ -654,7 +647,7 @@ static int sbs_get_property(struct power_supply *psy,
>  	if (!chip->enable_detection)
>  		goto done;
> =20
> -	if (!chip->gpio_detect &&
> +	if (!chip->pdata->gpio_detect &&
>  		chip->is_present !=3D (ret >=3D 0)) {
>  		chip->is_present =3D (ret >=3D 0);
>  		power_supply_changed(chip->power_supply);
> @@ -683,7 +676,12 @@ static irqreturn_t sbs_irq(int irq, void *devid)
>  {
>  	struct sbs_info *chip =3D devid;
>  	struct power_supply *battery =3D chip->power_supply;
> +	int ret;
> =20
> +	ret =3D gpiod_get_value_cansleep(chip->pdata->gpio_detect);
> +	if (ret < 0)
> +		return ret;
> +	chip->is_present =3D ret;
>  	power_supply_changed(battery);
> =20
>  	return IRQ_HANDLED;
> @@ -750,21 +748,20 @@ static const struct of_device_id sbs_dt_ids[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, sbs_dt_ids);
> =20
> -static struct sbs_platform_data *sbs_of_populate_pdata(
> -		struct i2c_client *client)
> +static struct sbs_platform_data *sbs_of_populate_pdata(struct sbs_info *=
chip)
>  {
> +	struct i2c_client *client =3D chip->client;
>  	struct device_node *of_node =3D client->dev.of_node;
> -	struct sbs_platform_data *pdata =3D client->dev.platform_data;
> -	enum of_gpio_flags gpio_flags;
> +	struct sbs_platform_data *pdata;
>  	int rc;
>  	u32 prop;
> =20
> -	/* verify this driver matches this device */
> -	if (!of_node)
> -		return NULL;
> +	pdata =3D devm_kzalloc(&client->dev, sizeof(struct sbs_platform_data),
> +				GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> =20
> -	/* if platform data is set, honor it */
> -	if (pdata)
> +	if (!of_node)
>  		return pdata;

I think we should just return ERR_PTR(-ENODATA) for missing of_node.

>  	/* first make sure at least one property is set, otherwise
> @@ -775,11 +772,6 @@ static struct sbs_platform_data *sbs_of_populate_pda=
ta(
>  		!of_get_property(of_node, "sbs,battery-detect-gpios", NULL))
>  		goto of_out;
> =20
> -	pdata =3D devm_kzalloc(&client->dev, sizeof(struct sbs_platform_data),
> -				GFP_KERNEL);
> -	if (!pdata)
> -		goto of_out;
> -
>  	rc =3D of_property_read_u32(of_node, "sbs,i2c-retry-count", &prop);
>  	if (!rc)
>  		pdata->i2c_retry_count =3D prop;
> @@ -788,27 +780,29 @@ static struct sbs_platform_data *sbs_of_populate_pd=
ata(
>  	if (!rc)
>  		pdata->poll_retry_count =3D prop;
> =20
> -	if (!of_get_property(of_node, "sbs,battery-detect-gpios", NULL)) {
> -		pdata->battery_detect =3D -1;
> -		goto of_out;
> -	}
> -
> -	pdata->battery_detect =3D of_get_named_gpio_flags(of_node,
> -			"sbs,battery-detect-gpios", 0, &gpio_flags);
> -
> -	if (gpio_flags & OF_GPIO_ACTIVE_LOW)
> -		pdata->battery_detect_present =3D 0;
> -	else
> -		pdata->battery_detect_present =3D 1;
> +	pdata->gpio_detect =3D devm_gpiod_get_optional(&client->dev,
> +			"sbs,battery-detect", GPIOD_IN);
> =20
> +	if (IS_ERR(pdata->gpio_detect)) {
> +		dev_err(&client->dev, "Failed to get gpio: %ld\n",
> +			PTR_ERR(pdata->gpio_detect));
> +		return ERR_PTR(PTR_ERR(pdata->gpio_detect));
> +	}
>  of_out:
>  	return pdata;
>  }
>  #else
>  static struct sbs_platform_data *sbs_of_populate_pdata(
> -	struct i2c_client *client)
> +	struct sbs_info *client)
>  {
> -	return client->dev.platform_data;
> +	struct sbs_platform_data *pdata;
> +
> +	pdata =3D devm_kzalloc(&client->dev, sizeof(struct sbs_platform_data),
> +			     GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return pdata;

    just return ERR_PTR(-ENOSYS);

>  }
>  #endif
> =20
> @@ -846,7 +840,6 @@ static int sbs_probe(struct i2c_client *client,
> =20
>  	chip->client =3D client;
>  	chip->enable_detection =3D false;
> -	chip->gpio_detect =3D false;
>  	psy_cfg.of_node =3D client->dev.of_node;
>  	psy_cfg.drv_data =3D chip;
>  	/* ignore first notification of external change, it is generated
> @@ -855,38 +848,22 @@ static int sbs_probe(struct i2c_client *client,
>  	chip->ignore_changes =3D 1;
>  	chip->last_state =3D POWER_SUPPLY_STATUS_UNKNOWN;
> =20
> -	pdata =3D sbs_of_populate_pdata(client);
> -
> -	if (pdata) {
> -		chip->gpio_detect =3D gpio_is_valid(pdata->battery_detect);
> -		chip->pdata =3D pdata;
> -	}
> +	if (!pdata)
> +		pdata =3D sbs_of_populate_pdata(chip);
> =20
> -	i2c_set_clientdata(client, chip);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> =20
> -	if (!chip->gpio_detect)
> -		goto skip_gpio;
> +	chip->pdata =3D pdata;
> =20
> -	rc =3D gpio_request(pdata->battery_detect, dev_name(&client->dev));
> -	if (rc) {
> -		dev_warn(&client->dev, "Failed to request gpio: %d\n", rc);
> -		chip->gpio_detect =3D false;
> -		goto skip_gpio;
> -	}
> +	i2c_set_clientdata(client, chip);
> =20
> -	rc =3D gpio_direction_input(pdata->battery_detect);
> -	if (rc) {
> -		dev_warn(&client->dev, "Failed to get gpio as input: %d\n", rc);
> -		gpio_free(pdata->battery_detect);
> -		chip->gpio_detect =3D false;
> +	if (!pdata->gpio_detect)
>  		goto skip_gpio;
> -	}
> =20
> -	irq =3D gpio_to_irq(pdata->battery_detect);
> +	irq =3D gpiod_to_irq(pdata->gpio_detect);
>  	if (irq <=3D 0) {
>  		dev_warn(&client->dev, "Failed to get gpio as irq: %d\n", irq);
> -		gpio_free(pdata->battery_detect);
> -		chip->gpio_detect =3D false;
>  		goto skip_gpio;
>  	}
> =20
> @@ -895,8 +872,6 @@ static int sbs_probe(struct i2c_client *client,
>  		dev_name(&client->dev), chip);
>  	if (rc) {
>  		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
> -		gpio_free(pdata->battery_detect);
> -		chip->gpio_detect =3D false;
>  		goto skip_gpio;
>  	}
> =20
> @@ -905,7 +880,7 @@ skip_gpio:
>  	 * Before we register, we might need to make sure we can actually talk
>  	 * to the battery.
>  	 */
> -	if (!force_load) {
> +	if (!(force_load || pdata->gpio_detect)) {
>  		rc =3D sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> =20
>  		if (rc < 0) {
> @@ -934,9 +909,6 @@ skip_gpio:
>  	return 0;
> =20
>  exit_psupply:
> -	if (chip->gpio_detect)
> -		gpio_free(pdata->battery_detect);
> -
>  	return rc;
>  }
> =20
> @@ -944,9 +916,6 @@ static int sbs_remove(struct i2c_client *client)
>  {
>  	struct sbs_info *chip =3D i2c_get_clientdata(client);
> =20
> -	if (chip->gpio_detect)
> -		gpio_free(chip->pdata->battery_detect);
> -
>  	cancel_delayed_work_sync(&chip->work);
> =20
>  	return 0;
> diff --git a/include/linux/power/sbs-battery.h b/include/linux/power/sbs-=
battery.h
> index 2b0a9d9..711ced2 100644
> --- a/include/linux/power/sbs-battery.h
> +++ b/include/linux/power/sbs-battery.h
> @@ -26,15 +26,13 @@
> =20
>  /**
>   * struct sbs_platform_data - platform data for sbs devices
> - * @battery_detect:		GPIO which is used to detect battery presence
> - * @battery_detect_present:	gpio state when battery is present (0 / 1)
> + * @gpio_detect:		GPIO which is used to detect battery presence
>   * @i2c_retry_count:		# of times to retry on i2c IO failure
>   * @poll_retry_count:		# of times to retry looking for new status after
>   *				external change notification
>   */
>  struct sbs_platform_data {
> -	int battery_detect;
> -	int battery_detect_present;
> +	struct gpio_desc *gpio_detect;
>  	int i2c_retry_count;
>  	int poll_retry_count;
>  };

GPIOs are not supposed to be set in the platform data for the
gpiod interface. Move it from "struct sbs_platform_data" into
"struct sbs_info". Then move the gpiod_get from the DT specific
part into the common probe code.

boardcode can assign the gpio using the interface described in
Documentation/gpio/board.txt (section "Platform Data")

-- Sebastian

--mhvh5tonliegqsrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxvvfAAoJENju1/PIO/qaCjMP/2NGSCYUkSb66ApSFCWOJpHC
/D7C2zY7CCdB8E+sWgBjzzXIfPzT7FDBmTUTFsA6/mEISsFULrxLdBrui3519BdL
WKMC9nXC74VpO2wJVDlCcpHgDhjqZrXcE3liuiCq7T58cWCGLba+NVZ+5PhSw6BJ
52dDbW0haBPYXUNq0F+fnsXo+WMC8y7ywvOvSJKRtCnn4aFu6Zw2snyrps2fsLSN
hmOT/TvRDNdh/4TZSOp8baMYfrZ3RjDxl40vB2IA0Cystd6F17JFrK+zFFctFCLd
70HQXbZ461Hj7LrM9UwEN/BAZSEP9GK1amNkP16gqynA6ZsEgIJrjShRcG/v6cOA
4/VuaX9FMH8KKdPOZa72jXj9uQCKKxFA7hhu761/LATzxJ4golOGc1sJ5VR0Vwnu
tyBZZMDnWA5BQtSUDPmfi1XollWYcRQHbwjkbCdYZ/TLnmdLUyBAm7VSdx0n86JN
YPQv7i/buZqDGm8QCahqoOIKmlTgx65WO6CG91FFSlzFgw4jHkcuFRU0XnuNvwat
QmU4m8O5c6XoDPNJUc4xPnEEMboUzKoaF+iuav4yf+Bz/ZB+cTQAlQ3OEcdIGxZl
SLRIlbkRDg8SPzPsEp2UYs4XzjQ3zHadwJYJ0vdpTmY9dacg0mONfoCNMDMgj/26
jZurkrDKZ6Vj8+sSRWAy
=JZpA
-----END PGP SIGNATURE-----

--mhvh5tonliegqsrd--

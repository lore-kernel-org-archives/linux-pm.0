From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] bq2415x_charger: Allow to load and use driver even if
 notify device is not registered yet
Date: Wed, 5 Aug 2015 15:26:52 +0200
Message-ID: <20150805132652.GB26280@pali>
References: <1437860816-14141-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38529 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbbHEN0z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 09:26:55 -0400
Content-Disposition: inline
In-Reply-To: <1437860816-14141-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 25 July 2015 23:46:56 Pali Roh=C3=A1r wrote:
> Driver bq2415x_charger works also without notify power supply device =
for
> charger detection. But when charger detection is specified in DT, the=
n
> bq2415x_charger refused to loaded with -EPROBE_DEFER.
>=20
> This patch rewrites code so that notify device for charger detection =
is
> checked when power supply event is received and not when registering =
power
> supply device. So this patch allows to use bq2415x_charger driver als=
o when
> kernel is compiled without driver for notify power supply device.
>=20
> Now after this patch scheduled workqueue is called after INIT_DELAYED=
_WORK,
> so it also fix problem when scheduled workqueue was called before ini=
t.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  drivers/power/bq2415x_charger.c |  143 +++++++++++++++++++++--------=
----------
>  1 file changed, 79 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_=
charger.c
> index e98dcb6..739ef5b 100644
> --- a/drivers/power/bq2415x_charger.c
> +++ b/drivers/power/bq2415x_charger.c
> @@ -170,7 +170,7 @@ struct bq2415x_device {
>  	struct power_supply *charger;
>  	struct power_supply_desc charger_desc;
>  	struct delayed_work work;
> -	struct power_supply *notify_psy;
> +	struct device_node *notify_node;
>  	struct notifier_block nb;
>  	enum bq2415x_mode reported_mode;/* mode reported by hook function *=
/
>  	enum bq2415x_mode mode;		/* currently configured mode */
> @@ -792,22 +792,47 @@ static int bq2415x_set_mode(struct bq2415x_devi=
ce *bq, enum bq2415x_mode mode)
> =20
>  }
> =20
> +static bool bq2415x_update_reported_mode(struct bq2415x_device *bq, =
int mA)
> +{
> +	enum bq2415x_mode mode;
> +
> +	if (mA =3D=3D 0)
> +		mode =3D BQ2415X_MODE_OFF;
> +	else if (mA < 500)
> +		mode =3D BQ2415X_MODE_NONE;
> +	else if (mA < 1800)
> +		mode =3D BQ2415X_MODE_HOST_CHARGER;
> +	else
> +		mode =3D BQ2415X_MODE_DEDICATED_CHARGER;
> +
> +	if (bq->reported_mode =3D=3D mode)
> +		return false;
> +
> +	bq->reported_mode =3D mode;
> +	return true;
> +}
> +
>  static int bq2415x_notifier_call(struct notifier_block *nb,
>  		unsigned long val, void *v)
>  {
>  	struct bq2415x_device *bq =3D
>  		container_of(nb, struct bq2415x_device, nb);
>  	struct power_supply *psy =3D v;
> -	enum bq2415x_mode mode;
>  	union power_supply_propval prop;
>  	int ret;
> -	int mA;
> =20
>  	if (val !=3D PSY_EVENT_PROP_CHANGED)
>  		return NOTIFY_OK;
> =20
> -	if (psy !=3D bq->notify_psy)
> -		return NOTIFY_OK;
> +	/* Ignore event if it was not send by notify_node/notify_device */
> +	if (bq->notify_node) {
> +		if (psy->dev.parent &&
> +		    psy->dev.parent->of_node !=3D bq->notify_node)
> +			return NOTIFY_OK;

There is missing branch for case when psy->dev.parent is NULL. Logical
error... I will send new version of patch.

Correct logic should be: ignore psy dev which sent event if it is not
notify dev specified in board/DT config of bq2415x psy dev.

> +	} else if (bq->init_data.notify_device) {
> +		if (strcmp(psy->desc->name, bq->init_data.notify_device) !=3D 0)
> +			return NOTIFY_OK;
> +	}
> =20
>  	dev_dbg(bq->dev, "notifier call was called\n");
> =20
> @@ -816,22 +841,9 @@ static int bq2415x_notifier_call(struct notifier=
_block *nb,
>  	if (ret !=3D 0)
>  		return NOTIFY_OK;
> =20
> -	mA =3D prop.intval;
> -
> -	if (mA =3D=3D 0)
> -		mode =3D BQ2415X_MODE_OFF;
> -	else if (mA < 500)
> -		mode =3D BQ2415X_MODE_NONE;
> -	else if (mA < 1800)
> -		mode =3D BQ2415X_MODE_HOST_CHARGER;
> -	else
> -		mode =3D BQ2415X_MODE_DEDICATED_CHARGER;
> -
> -	if (bq->reported_mode =3D=3D mode)
> +	if (!bq2415x_update_reported_mode(bq, prop.intval))
>  		return NOTIFY_OK;
> =20
> -	bq->reported_mode =3D mode;
> -
>  	/* if automode is not enabled do not tell about reported_mode */
>  	if (bq->automode < 1)
>  		return NOTIFY_OK;
> @@ -1536,6 +1548,8 @@ static int bq2415x_probe(struct i2c_client *cli=
ent,
>  	struct device_node *np =3D client->dev.of_node;
>  	struct bq2415x_platform_data *pdata =3D client->dev.platform_data;
>  	const struct acpi_device_id *acpi_id =3D NULL;
> +	struct power_supply *notify_psy =3D NULL;
> +	union power_supply_propval prop;
> =20
>  	if (!np && !pdata && !ACPI_HANDLE(&client->dev)) {
>  		dev_err(&client->dev, "Neither devicetree, nor platform data, nor =
ACPI support\n");
> @@ -1569,25 +1583,6 @@ static int bq2415x_probe(struct i2c_client *cl=
ient,
>  		goto error_2;
>  	}
> =20
> -	if (np) {
> -		bq->notify_psy =3D power_supply_get_by_phandle(np,
> -						"ti,usb-charger-detection");
> -
> -		if (IS_ERR(bq->notify_psy)) {
> -			dev_info(&client->dev,
> -				 "no 'ti,usb-charger-detection' property (err=3D%ld)\n",
> -				PTR_ERR(bq->notify_psy));
> -			bq->notify_psy =3D NULL;
> -		} else if (!bq->notify_psy) {
> -			ret =3D -EPROBE_DEFER;
> -			goto error_2;
> -		}
> -	} else if (pdata && pdata->notify_device) {
> -		bq->notify_psy =3D power_supply_get_by_name(pdata->notify_device);
> -	} else {
> -		bq->notify_psy =3D NULL;
> -	}
> -
>  	i2c_set_clientdata(client, bq);
> =20
>  	bq->id =3D num;
> @@ -1607,32 +1602,35 @@ static int bq2415x_probe(struct i2c_client *c=
lient,
>  					       "ti,current-limit",
>  					       &bq->init_data.current_limit);
>  		if (ret)
> -			goto error_3;
> +			goto error_2;
>  		ret =3D device_property_read_u32(bq->dev,
>  					"ti,weak-battery-voltage",
>  					&bq->init_data.weak_battery_voltage);
>  		if (ret)
> -			goto error_3;
> +			goto error_2;
>  		ret =3D device_property_read_u32(bq->dev,
>  				"ti,battery-regulation-voltage",
>  				&bq->init_data.battery_regulation_voltage);
>  		if (ret)
> -			goto error_3;
> +			goto error_2;
>  		ret =3D device_property_read_u32(bq->dev,
>  					       "ti,charge-current",
>  					       &bq->init_data.charge_current);
>  		if (ret)
> -			goto error_3;
> +			goto error_2;
>  		ret =3D device_property_read_u32(bq->dev,
>  				"ti,termination-current",
>  				&bq->init_data.termination_current);
>  		if (ret)
> -			goto error_3;
> +			goto error_2;
>  		ret =3D device_property_read_u32(bq->dev,
>  					       "ti,resistor-sense",
>  					       &bq->init_data.resistor_sense);
>  		if (ret)
> -			goto error_3;
> +			goto error_2;
> +		if (np)
> +			bq->notify_node =3D of_parse_phandle(np,
> +						"ti,usb-charger-detection", 0);
>  	} else {
>  		memcpy(&bq->init_data, pdata, sizeof(bq->init_data));
>  	}
> @@ -1642,56 +1640,72 @@ static int bq2415x_probe(struct i2c_client *c=
lient,
>  	ret =3D bq2415x_power_supply_init(bq);
>  	if (ret) {
>  		dev_err(bq->dev, "failed to register power supply: %d\n", ret);
> -		goto error_3;
> +		goto error_2;
>  	}
> =20
>  	ret =3D bq2415x_sysfs_init(bq);
>  	if (ret) {
>  		dev_err(bq->dev, "failed to create sysfs entries: %d\n", ret);
> -		goto error_4;
> +		goto error_3;
>  	}
> =20
>  	ret =3D bq2415x_set_defaults(bq);
>  	if (ret) {
>  		dev_err(bq->dev, "failed to set default values: %d\n", ret);
> -		goto error_5;
> +		goto error_4;
>  	}
> =20
> -	if (bq->notify_psy) {
> +	if (bq->notify_node || bq->init_data.notify_device) {
>  		bq->nb.notifier_call =3D bq2415x_notifier_call;
>  		ret =3D power_supply_reg_notifier(&bq->nb);
>  		if (ret) {
>  			dev_err(bq->dev, "failed to reg notifier: %d\n", ret);
> -			goto error_6;
> +			goto error_4;
>  		}
> =20
> -		/* Query for initial reported_mode and set it */
> -		bq2415x_notifier_call(&bq->nb, PSY_EVENT_PROP_CHANGED,
> -				      bq->notify_psy);
> -		bq2415x_set_mode(bq, bq->reported_mode);
> -
>  		bq->automode =3D 1;
> -		dev_info(bq->dev, "automode enabled\n");
> +		dev_info(bq->dev, "automode supported, waiting for events\n");
>  	} else {
>  		bq->automode =3D -1;
>  		dev_info(bq->dev, "automode not supported\n");
>  	}
> =20
> +	/* Query for initial reported_mode and set it */
> +	if (bq->nb.notifier_call) {
> +		if (np) {
> +			notify_psy =3D power_supply_get_by_phandle(np,
> +						"ti,usb-charger-detection");
> +			if (IS_ERR(notify_psy))
> +				notify_psy =3D NULL;
> +		} else if (bq->init_data.notify_device) {
> +			notify_psy =3D power_supply_get_by_name(
> +						bq->init_data.notify_device);
> +		}
> +	}
> +	if (notify_psy) {
> +		ret =3D power_supply_get_property(notify_psy,
> +					POWER_SUPPLY_PROP_CURRENT_MAX, &prop);
> +		power_supply_put(notify_psy);
> +
> +		if (ret =3D=3D 0) {
> +			bq2415x_update_reported_mode(bq, prop.intval);
> +			bq2415x_set_mode(bq, bq->reported_mode);
> +		}
> +	}
> +
>  	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
>  	bq2415x_set_autotimer(bq, 1);
> =20
>  	dev_info(bq->dev, "driver registered\n");
>  	return 0;
> =20
> -error_6:
> -error_5:
> -	bq2415x_sysfs_exit(bq);
>  error_4:
> -	bq2415x_power_supply_exit(bq);
> +	bq2415x_sysfs_exit(bq);
>  error_3:
> -	if (bq->notify_psy)
> -		power_supply_put(bq->notify_psy);
> +	bq2415x_power_supply_exit(bq);
>  error_2:
> +	if (bq->notify_node)
> +		of_node_put(bq->notify_node);
>  	kfree(name);
>  error_1:
>  	mutex_lock(&bq2415x_id_mutex);
> @@ -1707,10 +1721,11 @@ static int bq2415x_remove(struct i2c_client *=
client)
>  {
>  	struct bq2415x_device *bq =3D i2c_get_clientdata(client);
> =20
> -	if (bq->notify_psy) {
> +	if (bq->nb.notifier_call)
>  		power_supply_unreg_notifier(&bq->nb);
> -		power_supply_put(bq->notify_psy);
> -	}
> +
> +	if (bq->notify_node)
> +		of_node_put(bq->notify_node);
> =20
>  	bq2415x_sysfs_exit(bq);
>  	bq2415x_power_supply_exit(bq);

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

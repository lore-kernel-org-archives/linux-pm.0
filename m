From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH] power: charger-manager: Avoid recursive thermal get_temp
 call
Date: Tue, 07 Oct 2014 11:20:48 +0900
Message-ID: <54334E00.9030403@samsung.com>
References: <1412611212-24803-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1412611212-24803-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Anton Vorontsov <anton@enomsg.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On 2014=EB=85=84 10=EC=9B=94 07=EC=9D=BC 01:00, Krzysztof Kozlowski wro=
te:

> The charger manager supports POWER_SUPPLY_PROP_TEMP property and acts
> as a thermal zone if any of these conditions match:
> 1. Fuel gauge used by charger manager supports POWER_SUPPLY_PROP_TEMP=
=2E
> 2. 'cm-thermal-zone' property is present in DTS (then it will superse=
de
>    the fuel gauge temperature property).
>=20
> However in case 1 (fuel gauge reports temperature and 'cm-thermal-zon=
e'
> is not set) the charger manager forwards its get_temp calls to fuel
> gauge thermal zone.
>=20
> This leads to reporting by lockdep a false positive deadlock for ther=
mal
> zone's mutex because of nested calls to thermal_zone_get_temp(). This=
 is
> false positive because these are different mutexes: one for charger
> manager thermal zone and second for fuel gauge thermal zone.
>=20


Yes, this happens because power_supply_subsystem automatically creates
thermal_zone when POWER_SUPPLY_PROP_TEMP is available at the time of
power_supply registering. And as you point out, it makes duplicate ther=
mal_zone
when some power_supply references other power_supply's. I hope it would=
 become
to be a selectable option or change the manner of charger-manager itsel=
f (if the
charger-manager is only one who references other power_supply's tempera=
ture
sensing ability).

Anyway, the code looks fine to me.

Acked-by : Jonghwa Lee <jonghwa3.lee@samsung.com>

Thanks,
Jonghwa.

> Get rid of false lockdep alert and recursive call by accessing fuel g=
auge
> temperature through power supply property instead of thermal zone API=
=2E
>=20

> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/power/charger-manager.c       | 21 +++++++++++----------
>  include/linux/power/charger-manager.h |  2 --
>  2 files changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-=
manager.c
> index c1ed3c99c059..871fb91429c8 100644
> --- a/drivers/power/charger-manager.c
> +++ b/drivers/power/charger-manager.c
> @@ -559,16 +559,18 @@ static int cm_get_battery_temperature(struct ch=
arger_manager *cm,
>  	if (!cm->desc->measure_battery_temp)
>  		return -ENODEV;
> =20
> -#ifdef CONFIG_THERMAL
> -	ret =3D thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
> -	if (!ret)
> -		/* Calibrate temperature unit */
> -		*temp /=3D 100;
> -#else
> -	ret =3D cm->fuel_gauge->get_property(cm->fuel_gauge,
> +	if (IS_ENABLED(CONFIG_THERMAL) && cm->tzd_batt) {
> +		ret =3D thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp)=
;
> +		if (!ret)
> +			/* Calibrate temperature unit */
> +			*temp /=3D 100;
> +	} else {
> +		/* No external thermometer or no CONFIG_THERMAL */
> +		ret =3D cm->fuel_gauge->get_property(cm->fuel_gauge,
>  				POWER_SUPPLY_PROP_TEMP,
>  				(union power_supply_propval *)temp);
> -#endif
> +	}
> +
>  	return ret;
>  }
> =20
> @@ -1501,9 +1503,8 @@ static int cm_init_thermal_data(struct charger_=
manager *cm)
>  		cm->charger_psy.num_properties++;
>  		cm->desc->measure_battery_temp =3D true;
>  	}
> -#ifdef CONFIG_THERMAL
> -	cm->tzd_batt =3D cm->fuel_gauge->tzd;
> =20
> +#ifdef CONFIG_THERMAL
>  	if (ret && desc->thermal_zone) {
>  		cm->tzd_batt =3D
>  			thermal_zone_get_zone_by_name(desc->thermal_zone);
> diff --git a/include/linux/power/charger-manager.h b/include/linux/po=
wer/charger-manager.h
> index 07e7945a1ff2..743ed6d472c6 100644
> --- a/include/linux/power/charger-manager.h
> +++ b/include/linux/power/charger-manager.h
> @@ -256,9 +256,7 @@ struct charger_manager {
>  	struct power_supply *fuel_gauge;
>  	struct power_supply **charger_stat;
> =20
> -#ifdef CONFIG_THERMAL
>  	struct thermal_zone_device *tzd_batt;
> -#endif
>  	bool charger_enabled;
> =20
>  	unsigned long fullbatt_vchk_jiffies_at;

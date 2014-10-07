From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power: charger-manager: Avoid recursive thermal get_temp
 call
Date: Tue, 07 Oct 2014 09:13:14 +0200
Message-ID: <1412665994.11780.3.camel@AMDC1943>
References: <1412611212-24803-1-git-send-email-k.kozlowski@samsung.com>
 <54334E00.9030403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34678 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaJGHNT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Oct 2014 03:13:19 -0400
In-reply-to: <54334E00.9030403@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Anton Vorontsov <anton@enomsg.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


On wto, 2014-10-07 at 11:20 +0900, jonghwa3.lee@samsung.com wrote:
> Hi,
> On 2014=EB=85=84 10=EC=9B=94 07=EC=9D=BC 01:00, Krzysztof Kozlowski w=
rote:
>=20
> > The charger manager supports POWER_SUPPLY_PROP_TEMP property and ac=
ts
> > as a thermal zone if any of these conditions match:
> > 1. Fuel gauge used by charger manager supports POWER_SUPPLY_PROP_TE=
MP.
> > 2. 'cm-thermal-zone' property is present in DTS (then it will super=
sede
> >    the fuel gauge temperature property).
> >=20
> > However in case 1 (fuel gauge reports temperature and 'cm-thermal-z=
one'
> > is not set) the charger manager forwards its get_temp calls to fuel
> > gauge thermal zone.
> >=20
> > This leads to reporting by lockdep a false positive deadlock for th=
ermal
> > zone's mutex because of nested calls to thermal_zone_get_temp(). Th=
is is
> > false positive because these are different mutexes: one for charger
> > manager thermal zone and second for fuel gauge thermal zone.
> >=20
>=20
>=20
> Yes, this happens because power_supply_subsystem automatically create=
s
> thermal_zone when POWER_SUPPLY_PROP_TEMP is available at the time of
> power_supply registering. And as you point out, it makes duplicate th=
ermal_zone
> when some power_supply references other power_supply's. I hope it wou=
ld become
> to be a selectable option or change the manner of charger-manager its=
elf (if the
> charger-manager is only one who references other power_supply's tempe=
rature
> sensing ability).
>=20
> Anyway, the code looks fine to me.
>=20
> Acked-by : Jonghwa Lee <jonghwa3.lee@samsung.com>

Thank you for looking at patch. However later I started to wonder
whether my fix is sufficient. For the case when fuel gauge is used as
source of temperature it is. But for the case when external sensor is
used it is not - still there will be recursive call and false positive
from lockdep.

Also minor fix is needed in my patch - s/IS_ENABLED/config_enabled/.

I can send a v2 fixing this but first question - what about second
recursive issue (when external sensor is used instead of fuel gauge)?

Best regards,
Krzysztof


>=20
> Thanks,
> Jonghwa.
>=20
> > Get rid of false lockdep alert and recursive call by accessing fuel=
 gauge
> > temperature through power supply property instead of thermal zone A=
PI.
> >=20
>=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/power/charger-manager.c       | 21 +++++++++++----------
> >  include/linux/power/charger-manager.h |  2 --
> >  2 files changed, 11 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/power/charger-manager.c b/drivers/power/charge=
r-manager.c
> > index c1ed3c99c059..871fb91429c8 100644
> > --- a/drivers/power/charger-manager.c
> > +++ b/drivers/power/charger-manager.c
> > @@ -559,16 +559,18 @@ static int cm_get_battery_temperature(struct =
charger_manager *cm,
> >  	if (!cm->desc->measure_battery_temp)
> >  		return -ENODEV;
> > =20
> > -#ifdef CONFIG_THERMAL
> > -	ret =3D thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp=
);
> > -	if (!ret)
> > -		/* Calibrate temperature unit */
> > -		*temp /=3D 100;
> > -#else
> > -	ret =3D cm->fuel_gauge->get_property(cm->fuel_gauge,
> > +	if (IS_ENABLED(CONFIG_THERMAL) && cm->tzd_batt) {
> > +		ret =3D thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)tem=
p);
> > +		if (!ret)
> > +			/* Calibrate temperature unit */
> > +			*temp /=3D 100;
> > +	} else {
> > +		/* No external thermometer or no CONFIG_THERMAL */
> > +		ret =3D cm->fuel_gauge->get_property(cm->fuel_gauge,
> >  				POWER_SUPPLY_PROP_TEMP,
> >  				(union power_supply_propval *)temp);
> > -#endif
> > +	}
> > +
> >  	return ret;
> >  }
> > =20
> > @@ -1501,9 +1503,8 @@ static int cm_init_thermal_data(struct charge=
r_manager *cm)
> >  		cm->charger_psy.num_properties++;
> >  		cm->desc->measure_battery_temp =3D true;
> >  	}
> > -#ifdef CONFIG_THERMAL
> > -	cm->tzd_batt =3D cm->fuel_gauge->tzd;
> > =20
> > +#ifdef CONFIG_THERMAL
> >  	if (ret && desc->thermal_zone) {
> >  		cm->tzd_batt =3D
> >  			thermal_zone_get_zone_by_name(desc->thermal_zone);
> > diff --git a/include/linux/power/charger-manager.h b/include/linux/=
power/charger-manager.h
> > index 07e7945a1ff2..743ed6d472c6 100644
> > --- a/include/linux/power/charger-manager.h
> > +++ b/include/linux/power/charger-manager.h
> > @@ -256,9 +256,7 @@ struct charger_manager {
> >  	struct power_supply *fuel_gauge;
> >  	struct power_supply **charger_stat;
> > =20
> > -#ifdef CONFIG_THERMAL
> >  	struct thermal_zone_device *tzd_batt;
> > -#endif
> >  	bool charger_enabled;
> > =20
> >  	unsigned long fullbatt_vchk_jiffies_at;
>=20


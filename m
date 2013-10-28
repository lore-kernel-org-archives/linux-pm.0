From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH 2/3] charger-manager : Add default battery temperature
 checking funtion.
Date: Mon, 28 Oct 2013 11:26:18 +0900
Message-ID: <526DCB4A.5010009@samsung.com>
References: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
 <1382669253-23629-3-git-send-email-jonghwa3.lee@samsung.com>
 <20131025234436.GC13859@teo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55812 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833Ab3J1C0U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Oct 2013 22:26:20 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVC0004TXFDOXE0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 28 Oct 2013 11:26:19 +0900 (KST)
In-reply-to: <20131025234436.GC13859@teo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On 2013=EB=85=84 10=EC=9B=94 26=EC=9D=BC 08:44, Anton Vorontsov wrote:

> On Fri, Oct 25, 2013 at 11:47:32AM +0900, Jonghwa Lee wrote:
>> During the charger manager driver's probing time, it can't succeed
>> if there's no pre-defined .temperature_out_of_range callback functio=
n.
>> But if fuel gauge supports battery temperature measurement, we
>> can use it directly. That's what cm_default_get_temp() function does=
=2E
>>
>> With flag measure_batter_temp ON, we normally use cm_default_get_tem=
p()
>> for .temperature_out_of_range callback funtion.
>> The TEMP_AMBIENT property is only used for pre-defined one.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>> ---
> ...
>> +static int cm_default_get_temp(struct charger_manager *cm)
>> +{
>> +	struct charger_desc *desc =3D cm->desc;
>> +	union power_supply_propval val;
>> +	static int temp_alert_min =3D 0;
>=20
> No. Never.


Can I assume that you worried about initialization of a variable which =
would be
used to hold minimum value to zero not INT_MAX or something big?
Anyway, come to think of it, it looks ugly for me either. I'll fix it.

>=20
>> +	static int temp_alert_max =3D 0;
>> +	static int temp_alert_diff =3D 0;
>> +	static int last_temp_status =3D 0;
>> +	int ret;
>> +
>> +	if (!temp_alert_min && !temp_alert_max) {
>> +		/* Initialize minimum temperature for alert */
>> +		ret =3D cm->fuel_gauge->get_property(cm->fuel_gauge,
>> +					POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
>> +					&val);
>> +		temp_alert_min =3D ret ? desc->temp_alert_min :
>> +					min(desc->temp_alert_min, val.intval);
>=20
> Is it a minimum temperature of a bettery below which we should alert?
> Should it be max() then?


Yes, you're right. I'll fix it.

>=20
>> +		if (!temp_alert_min)
>> +			temp_alert_min =3D CM_DEFAULT_TEMP_ALERT_MIN;
>=20
> The whole function is ugly as hell.  Please tidy it up, split it into=
 two,
> three or whatever amount needed to make it readable and comprehendabl=
e.
> Use temporary variables for things like
> cm->fuel_gauge->get_property(cm->fuel_gauge, ....).
>=20


Okay, I'll re-post it.

Thanks for comments
Jonghwa.

>> +
>> +		/* Initialize maximum temperature for alert */
>> +		ret =3D cm->fuel_gauge->get_property(cm->fuel_gauge,
>> +					POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
>> +					&val);
>> +		temp_alert_max =3D ret ? desc->temp_alert_max :
>> +					min(desc->temp_alert_max, val.intval);
>=20
> Thanks,
>=20
> Anton
>=20



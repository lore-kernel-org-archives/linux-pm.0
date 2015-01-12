From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv7 02/10] devfreq: event: Add the list of supported
 devfreq-event type
Date: Mon, 12 Jan 2015 20:17:20 +0900
Message-ID: <54B3AD40.3040308@samsung.com>
References: <768125446.886831421046952335.JavaMail.weblogic@epmlwas09a>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62252 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbALLRX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 06:17:23 -0500
In-reply-to: <768125446.886831421046952335.JavaMail.weblogic@epmlwas09a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Dear Myungjoo,

On 01/12/2015 04:15 PM, MyungJoo Ham wrote:
>>  =20
>>  This patch adds the list of supported devfreq-event type as followi=
ng.
>> Each devfreq-event device driver would support the various devfreq-e=
vent type
>> for devfreq governor at the same time.
>> - DEVFREQ_EVENT_TYPE_RAW_DATA
>> - DEVFREQ_EVENT_TYPE_UTILIZATION
>> - DEVFREQ_EVENT_TYPE_BANDWIDTH
>> - DEVFREQ_EVENT_TYPE_LATENCY
>=20
> Did you try to say:
>=20
> A devfreq-event device may support multiple devfreq-event types
> simultaneously.

I think that one devfreq-event device can support multiple devfreq-even=
t types.
but, devfreq-event device might provide only value at one point.

But,
This patch is ambiguous and includes a bug according to your comment
(below switch statement). I'll drop this patch on next patch-set.

This patch will be posted on further patch-set after resolving some iss=
ue.

Best Regards,
Chanwoo Choi

>=20
> If so, your switch expressions are going to screw up.
>=20
>=20
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq-event.c | 58 ++++++++++++++++++++++++++++++=
++++++-----
>>  include/linux/devfreq-event.h   | 25 +++++++++++++++---
>>  2 files changed, 73 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfr=
eq-event.c
>> index 81448ba..64c1764 100644
>> --- a/drivers/devfreq/devfreq-event.c
>> +++ b/drivers/devfreq/devfreq-event.c
>> =20
> []
>> -	mutex_lock(&edev->lock);
>> -	ret =3D edev->desc->ops->get_event(edev, edata);
>> -	mutex_unlock(&edev->lock);
>> +	switch (type) {
>=20
> Bitwise value with switch? (what if type =3D RAW_DATA | BANDWIDTH, me=
aning
> this is raw data of the bandwitdh.)
>=20
>> +	case DEVFREQ_EVENT_TYPE_RAW_DATA:
>> +	case DEVFREQ_EVENT_TYPE_BANDWIDTH:
>> +	case DEVFREQ_EVENT_TYPE_LATENCY:
>> +		if ((edata->event > EVENT_TYPE_RAW_DATA_MAX) ||
>> +			(edata->total_event > EVENT_TYPE_RAW_DATA_MAX)) {
>=20
> Is it possible for unsigned long edata->event/total_event to be
>   > EVENT_TYPE_RAW_DATA_MAX =3D ULONG_MAX?
>=20
> What was your intention?
>=20
> If you were trying to detect overflow, you need to rethink about it.
> If not, (overflow is harmless or not going to happen) you don't need =
to
> check it.
>=20
>=20
>> +			edata->event =3D edata->total_event =3D 0;
>> +			ret =3D -EINVAL;
>> +		}
>> +		break;
>> +	case DEVFREQ_EVENT_TYPE_UTILIZATION:
>> +		edata->total_event =3D EVENT_TYPE_UTILIZATION_MAX;
>> =20
>> -	if ((edata->total_event <=3D 0)
>> -		|| (edata->event > edata->total_event)) {
>> +		if (edata->event > EVENT_TYPE_UTILIZATION_MAX) {
>> +			edata->event =3D edata->total_event =3D 0;
>> +			ret =3D -EINVAL;
>> +		}
>> +		break;
>> +	default:
>>  		edata->event =3D edata->total_event =3D 0;
>>  		ret =3D -EINVAL;
>> +		break;
>>  	}
>> =20
>> +	mutex_unlock(&edev->lock);
>> +
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(devfreq_event_get_event);
>> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-e=
vent.h
>> index b7363f5..13a5703 100644
>> --- a/include/linux/devfreq-event.h
>> +++ b/include/linux/devfreq-event.h
>> @@ -36,6 +36,14 @@ struct devfreq_event_dev {
>>  	const struct devfreq_event_desc *desc;
>>  };
>> =20
>> +/* The supported type by devfreq-event device */
>> +enum devfreq_event_type {
>> +	DEVFREQ_EVENT_TYPE_RAW_DATA	=3D BIT(0),
>> +	DEVFREQ_EVENT_TYPE_UTILIZATION	=3D BIT(1),
>> +	DEVFREQ_EVENT_TYPE_BANDWIDTH	=3D BIT(2),
>> +	DEVFREQ_EVENT_TYPE_LATENCY	=3D BIT(3),
>> +};
>> +
>=20
> (Being curious) Is it possible to have multiple types
> simultaneously?
>=20
>=20
> []
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDx,=EF=BF=BD=C8=A7=EF=BF=BD=17=EF=BF=
=BD=EF=BF=BD=DC=A8}=EF=BF=BD=EF=BF=BD=EF=BF=BD=C6=A0z=EF=BF=BD&j:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=
=EF=BF=BD+zf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDi=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD&=EF=BF=BD)=DF=A2=1Bfl=3D=3D=3D
>=20


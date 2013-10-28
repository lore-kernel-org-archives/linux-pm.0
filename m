From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH] battery: max17042: Fix temperature unit to milli
 centigrade.
Date: Mon, 28 Oct 2013 11:00:52 +0900
Message-ID: <526DC554.30506@samsung.com>
References: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
 <20131025231720.GB9015@teo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59940 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab3J1CAz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Oct 2013 22:00:55 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVC00FHRW92F7D0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 28 Oct 2013 11:00:53 +0900 (KST)
In-reply-to: <20131025231720.GB9015@teo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

Hi,
On 2013=EB=85=84 10=EC=9B=94 26=EC=9D=BC 08:17, Anton Vorontsov wrote:

> On Fri, Oct 25, 2013 at 01:53:18PM +0900, Jonghwa Lee wrote:
>> Standard temp node represents temperature of power supply class
>> in milli centigrade. So fix max17042 fuel gauge driver to follow
>> the standard. (deci-centigrade --> milli-centigrade)
>=20
> Maybe I am confused, but the doc says:
>=20
>  * All voltages, currents, charges, energies, time and temperatures i=
n uV,     =20
>  * =C2=B5A, =C2=B5Ah, =C2=B5Wh, seconds and tenths of degree Celsius =
unless otherwise         =20
>  * stated
>=20
> So, the current code seems to be correct.
>=20


Honestly, I missed the above paragraph you showed rather I read followi=
ng one.

TEMP - temperature of the power supply.
TEMP_ALERT_MIN - minimum battery temperature alert value in milli centi=
grade.
TEMP_ALERT_MAX - maximum battery temperature alert value in milli centi=
grade.
TEMP_AMBIENT - ambient temperature.
TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert value in mil=
li
centigrade.
TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert value in mil=
li
centigrade.

So, we use different unit for properties related temperature, right?
current temperature is in tenth of centigrade and threshold temperature=
s and
ambient temperature are in milli centigrade. Wouldn't it have to be in =
same unit?

Thanks,
Jonghwa

> Thanks,
>=20
> Anton
>=20
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>> ---
>>  drivers/power/max17042_battery.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max170=
42_battery.c
>> index d664ef5..892ecfc 100644
>> --- a/drivers/power/max17042_battery.c
>> +++ b/drivers/power/max17042_battery.c
>> @@ -220,9 +220,9 @@ static int max17042_get_property(struct power_su=
pply *psy,
>>  			val->intval =3D (0x7fff & ~val->intval) + 1;
>>  			val->intval *=3D -1;
>>  		}
>> -		/* The value is converted into deci-centigrade scale */
>> +		/* The value is converted into milli-centigrade scale */
>>  		/* Units of LSB =3D 1 / 256 degree Celsius */
>> -		val->intval =3D val->intval * 10 / 256;
>> +		val->intval =3D val->intval * 1000 / 256;
>>  		break;
>>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>  		if (chip->pdata->enable_current_sense) {
>> --=20
>> 1.7.9.5
>=20



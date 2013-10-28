From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH] power_supply: Fix documentation for TEMP_*ALERT* properties
Date: Mon, 28 Oct 2013 15:22:53 +0900
Message-ID: <526E02BD.5080107@samsung.com>
References: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
 <20131025231720.GB9015@teo> <526DC554.30506@samsung.com>
 <20131028052743.GA31070@teo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:19394 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab3J1GW4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 02:22:56 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVD00EC78DEO220@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 28 Oct 2013 15:22:54 +0900 (KST)
In-reply-to: <20131028052743.GA31070@teo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Ramakrishna Pallala <ramakrishna.pallala@intel.com>

On 2013=EB=85=84 10=EC=9B=94 28=EC=9D=BC 14:27, Anton Vorontsov wrote:

> All temperatures should be in tenth degrees Celsius.
>=20


Let me tell you one thing that thermal framework uses milli centigrade =
for
temperature. And also we have some relation with thermal framework alre=
ady in
power suppply core. So, what do think of using milli centigrade in powe=
r supply
class either?

Thanks,
Jonghwa

> bq24190_charger.c probably should be fixed.
>=20
> Reported-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Signed-off-by: Anton Vorontsov <anton@enomsg.org>
> ---
>=20
> On Mon, Oct 28, 2013 at 11:00:52AM +0900, jonghwa3.lee@samsung.com wr=
ote:
>>>  * All voltages, currents, charges, energies, time and temperatures=
 in uV,     =20
>>>  * =C2=B5A, =C2=B5Ah, =C2=B5Wh, seconds and tenths of degree Celsiu=
s unless otherwise         =20
>>>  * stated
>>>
>>> So, the current code seems to be correct.
>>
>> Honestly, I missed the above paragraph you showed rather I read foll=
owing one.
>>
>> TEMP - temperature of the power supply.
>> TEMP_ALERT_MIN - minimum battery temperature alert value in milli ce=
ntigrade.
>> TEMP_ALERT_MAX - maximum battery temperature alert value in milli ce=
ntigrade.
>> TEMP_AMBIENT - ambient temperature.
>> TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert value in =
milli
>> centigrade.
>> TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert value in =
milli
>> centigrade.
>>
>> So, we use different unit for properties related temperature, right?
>> current temperature is in tenth of centigrade and threshold temperat=
ures and
>> ambient temperature are in milli centigrade. Wouldn't it have to be =
in same unit?
>=20
> :( They should. Thanks for spotting.
>=20
> The patch down below should fix the issue...
>=20
> Documentation/power/power_supply_class.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/power/power_supply_class.txt b/Documentati=
on/power/power_supply_class.txt
> index 3f10b39..89a8816 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -135,11 +135,11 @@ CAPACITY_LEVEL - capacity level. This correspon=
ds to
>  POWER_SUPPLY_CAPACITY_LEVEL_*.
> =20
>  TEMP - temperature of the power supply.
> -TEMP_ALERT_MIN - minimum battery temperature alert value in milli ce=
ntigrade.
> -TEMP_ALERT_MAX - maximum battery temperature alert value in milli ce=
ntigrade.
> +TEMP_ALERT_MIN - minimum battery temperature alert.
> +TEMP_ALERT_MAX - maximum battery temperature alert.
>  TEMP_AMBIENT - ambient temperature.
> -TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert value in =
milli centigrade.
> -TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert value in =
milli centigrade.
> +TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert.
> +TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert.
> =20
>  TIME_TO_EMPTY - seconds left for battery to be considered empty (i.e=
=2E
>  while battery powers a load)



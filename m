From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH] power: charger-manager: Avoid recursive thermal get_temp
 call
Date: Tue, 07 Oct 2014 22:05:28 +0900
Message-ID: <5433E518.40300@samsung.com>
References: <1412611212-24803-1-git-send-email-k.kozlowski@samsung.com>
 <54334E00.9030403@samsung.com> <1412665994.11780.3.camel@AMDC1943>
 <5433BE0D.6000306@samsung.com> <1412686205.15309.1.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1412686205.15309.1.camel@AMDC1943>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Anton Vorontsov <anton@enomsg.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2014=EB=85=84 10=EC=9B=94 07=EC=9D=BC 21:50, Krzysztof Kozlowski wro=
te:

> On wto, 2014-10-07 at 19:18 +0900, jonghwa3.lee@samsung.com wrote:
>> On 2014=EB=85=84 10=EC=9B=94 07=EC=9D=BC 16:13, Krzysztof Kozlowski =
wrote:
>>
>>>
>>> On wto, 2014-10-07 at 11:20 +0900, jonghwa3.lee@samsung.com wrote:
>>>> Hi,
>>>> On 2014=EB=85=84 10=EC=9B=94 07=EC=9D=BC 01:00, Krzysztof Kozlowsk=
i wrote:
>>>>
>>>>> The charger manager supports POWER_SUPPLY_PROP_TEMP property and =
acts
>>>>> as a thermal zone if any of these conditions match:
>>>>> 1. Fuel gauge used by charger manager supports POWER_SUPPLY_PROP_=
TEMP.
>>>>> 2. 'cm-thermal-zone' property is present in DTS (then it will sup=
ersede
>>>>>    the fuel gauge temperature property).
>>>>>
>>>>> However in case 1 (fuel gauge reports temperature and 'cm-thermal=
-zone'
>>>>> is not set) the charger manager forwards its get_temp calls to fu=
el
>>>>> gauge thermal zone.
>>>>>
>>>>> This leads to reporting by lockdep a false positive deadlock for =
thermal
>>>>> zone's mutex because of nested calls to thermal_zone_get_temp(). =
This is
>>>>> false positive because these are different mutexes: one for charg=
er
>>>>> manager thermal zone and second for fuel gauge thermal zone.
>>>>>
>>>>
>>>>
>>>> Yes, this happens because power_supply_subsystem automatically cre=
ates
>>>> thermal_zone when POWER_SUPPLY_PROP_TEMP is available at the time =
of
>>>> power_supply registering. And as you point out, it makes duplicate=
 thermal_zone
>>>> when some power_supply references other power_supply's. I hope it =
would become
>>>> to be a selectable option or change the manner of charger-manager =
itself (if the
>>>> charger-manager is only one who references other power_supply's te=
mperature
>>>> sensing ability).
>>>>
>>>> Anyway, the code looks fine to me.
>>>>
>>>> Acked-by : Jonghwa Lee <jonghwa3.lee@samsung.com>
>>>
>>> Thank you for looking at patch. However later I started to wonder
>>> whether my fix is sufficient. For the case when fuel gauge is used =
as
>>> source of temperature it is. But for the case when external sensor =
is
>>> used it is not - still there will be recursive call and false posit=
ive
>>> from lockdep.
>>>
>>> Also minor fix is needed in my patch - s/IS_ENABLED/config_enabled/=
=2E
>>>
>>> I can send a v2 fixing this but first question - what about second
>>> recursive issue (when external sensor is used instead of fuel gauge=
)?
>>>
>>
>>
>> Yes, you're right, it still had problem for external temperature sen=
sor case.
>> How about we change the core not to make duplicate thermal zone if i=
t already
>> existed. It's not the common case, but it looks worthy.
>>
>> like as below,
>>
>> static int psy_register_thermal(struct power_supply *psy)
>> {
>> ...
>> +	if (psy->tzd)
>> +		return 0;
>> ...
>>
>> We also needs some modification at charger-manager driver, however w=
e can avoid
>> recursive call problem with this way :)
>=20
> Yes, that would remove recursive call but this would also remove ther=
mal
> zone for charger manager's power supply. Does anyone (user space?)
> depend and use charger managers thermal zone?
>=20


AFAIK, no,, charger manager's thermal zone means nothing but just repli=
ca of
other thermal zone related with battery. It is better to remove it.

Thanks,
Jonghwa.

> Best regards,
> Krzysztof
>=20
>=20

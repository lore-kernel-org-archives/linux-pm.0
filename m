From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: Bug: power supply - NULL pointer dereference in bq27x00 driver
Date: Mon, 18 May 2015 18:03:46 +0200
Message-ID: <273E9F9E-B512-4F7F-B016-1F8FF324ED1F@goldelico.com>
References: <BA8989FA-6ABE-43D4-A8D5-2949F8AE8B24@goldelico.com> <CAJKOXPfA-3-SKD-UBACd9+wu0t71pOAduxTqAbNZKknyQTdJhg@mail.gmail.com> <9C32507E-DA37-4BB0-BD62-00DE9311EC50@goldelico.com> <CAJKOXPfpHKogPPe9-X4PZ0OgJ+mKxo3rx=Fp034Ab9dit4w57A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:11452 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbbERQEV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 12:04:21 -0400
In-Reply-To: <CAJKOXPfpHKogPPe9-X4PZ0OgJ+mKxo3rx=Fp034Ab9dit4w57A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Rodolfo Giometti <giometti@linux.it>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>


Am 18.05.2015 um 16:09 schrieb Krzysztof Kozlowski <k.kozlowski@samsung=
=2Ecom>:

> 2015-05-18 22:30 GMT+09:00 Dr. H. Nikolaus Schaller <hns@goldelico.co=
m>:
>> Hi Krzysztof,
>>=20
>> Am 18.05.2015 um 14:32 schrieb Krzysztof Kozlowski <k.kozlowski@sams=
ung.com>:
>>=20
>>> 2015-05-18 18:40 GMT+09:00 Dr. H. Nikolaus Schaller <hns@goldelico.=
com>:
>>>> Hi,
>>>> we tried to upgrade from 4.0 to 4.1-rc3 kernel and ran into a NULL=
 pointer problem within the bq27x00 driver.
>>>>=20
>>>> It appears to be introduced by your patch 297d716f6260cc9421d971b1=
24ca196b957ee458
>>>>=20
>>>> The problem appears to be that bq27x00_powersupply_init() calls po=
wer_supply_register_no_ws() and
>>>> sets di->bat *after* return. The old code did pass an uninitialize=
d struct pointer.
>>>>=20
>>>> Now for reasons I don=92t understand, the power_supply_register_no=
_ws() appears to call
>>>> uevent related stuff which in turn calls bq27x00_battery_get_prope=
rty() before di->bat
>>>> is properly initialized.
>>>>=20
>>>> I have checked with printk in bq27x00_battery_get_property() that =
di>bat =3D=3D NULL in this case and
>>>> right before we see the segfault.
>>>>=20
>>>> The old code simply did pass a zeroed struct power_supply and perh=
aps initialized its components
>>>> during registration.
>>>>=20
>>>> Returning some -EINVAL if di->bat =3D=3D NULL would likely solve t=
he NULL pointer dereference but
>>>> I don=92t know what it does to the uevent and if it restores previ=
ous operation.
>>>>=20
>>>> It could have been that it was for good purpose that power_supply_=
register_no_ws() did not return
>>>> by value, but by reference to the di->bat struct:
>>>>=20
>>>> -       ret =3D power_supply_register_no_ws(di->dev, &di->bat, NUL=
L);
>>>> +       di->bat =3D power_supply_register_no_ws(di->dev, psy_desc,=
 &psy_cfg);
>>>>=20
>>>> So that code called within the context of power_supply_register_no=
_ws() could already
>>>> refer to initialized di->bat.
>>>=20
>>> Indeed this issue was not present in previous design however I thin=
k
>>> the architecture was still error-prone. Starting from driver's prob=
e:
>>> - some_driver_probe()
>>>  - power_supply_register(&psy)
>>>    - device_add()
>>>      - kobject_uevent() - notify userspace
>>>       - power_supply_uevent()
>>>         - power_supply_show_property()
>>>           - power_supply_get_property()
>>>             - some_driver_get_property()
>>>=20
>>> So before probe() ends the power supply core calls driver's
>>> get_property(). In that time the driver internal structures may not=
 be
>>> ready yet, because the probe did not end.
>>=20
>> Yes, that is indeed a problem. Maybe it did work with the bq27x00 dr=
iver
>> earlier because the call to power_supply_register(&psy) was the last
>> activity.
>=20
> Right, for most of the drivers it is the last part of probe.
>=20
>>=20
>>> The get_property() could
>>> access some registers or other core functions which will be ready
>>> after power_supply_register() call. For example the
>>> bq27x00_battery_get_property() accesses delayed work which could be
>>> (by mistake) not yet initialized.
>>>=20
>>> I looked at other dev_uevent implementations and almost all of them=
 do
>>> not call back the driver.
>>>=20
>>> Of course this does not change that I introduced the issue and I fe=
el
>>> bad about it.
>>> I got some ideas for resolving it:
>>> 1. Fix bq27x00_battery and maybe others so they won't access the 'p=
sy'
>>> member of its state container. This does not solve the issue from
>>> architectural point of view - still some uninitialised data may be
>>> accessed because probe() is in progress. However this would be the
>>> fastest and the least intrusive.
>>=20
>> The problem might be that it fundamentally changes the driver code
>> architecture. For example one call using di->bat is in
>>=20
>> bq27x00_battery_status() {
>> =85
>>                else if (power_supply_am_i_supplied(di->bat))
>>                        status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>> =85
>> }
>>=20
>>>=20
>>> 2. Remove calls to get_property() (and other functions provided by
>>> driver) from power_supply_uevent(). Unfortunately this may break
>>> userspace which expects that some data will be present in uevent.
>>>=20
>>> 3. Change the API to the previous convention, which you pointed as =
a remedy:
>>> ret =3D power_supply_register_no_ws(di->dev, &di->bat, psy_desc, &p=
sy_cfg);
>>> This also won't solve the issue from 1. that uevent will be called
>>> before probe ends.
>>=20
>> Well, we could require that power_supply_register_no_ws() is the las=
t
>> activity to be done in any_driver_probe().
>=20
> Some drivers (like drivers/power/lp8727_charger.c) register multiple
> power supplies and there can be only one last call. What is even
> important in this lp8727 case, is that it registers:
> - a battery,
> - two chargers which supply this battery.
>=20
> So when power supplies are registered, the delayed work is executed
> for each supplied battery. Hopefully the the battery is registered as
> last... but I am not quite sure that this is still safe.
>=20
>>> 4. Block the power_supply_uevent() from calling the get_property()
>>> functions until device_add() finishes. This would solve this issue =
but
>>> first uevent messages (from adding device) won't contain all of dev=
ice
>>> data (just like in solution no 2.) and this won't solve other race =
-
>>> someone may call sysfs show() on created device nodes and thus acce=
ss
>>> the get_property() before probe finishes.
>>=20
>>>=20
>>> Any ideas?
>>=20
>> 5. is it possible to delay the call to kobject_uevent() after some_d=
river_probe()
>> is finished? E.g. by registering a one-shot delayed work?
>>=20
>> There seems to be a shared workqueue (mentioned e.g. in
>> <http://www.makelinux.net/ldd3/chp-7-sect-6>)
>> but that is an area of the kernel I am not familiar with.
>=20
> Unfortunately there is no guarantee that delayed work will be execute=
d
> after probe ends. It should be but=85 who knows when it be scheduled?

Ah, I see. It would be necessary to schedule the worker thread only aft=
er
probing is successful. So this would deeply go into general driver prob=
ing
mechanisms. Or it would need a =93call me as soon as my probe function
has successfully completed=94 callback that a driver can register somew=
here.

> Anyway thanks for reporting the issue and ideas.

Please let me know if we can test something.

BR and thanks,
Nikolaus


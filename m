From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: Bug: power supply - NULL pointer dereference in bq27x00 driver
Date: Mon, 18 May 2015 22:32:50 +0900
Message-ID: <CAJKOXPcpoGmruRQiM6q8LaCCyOS9V-dVLEsF771cupz+dLxekw@mail.gmail.com>
References: <BA8989FA-6ABE-43D4-A8D5-2949F8AE8B24@goldelico.com>
	<CAJKOXPfA-3-SKD-UBACd9+wu0t71pOAduxTqAbNZKknyQTdJhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f50.google.com ([209.85.216.50]:37414 "EHLO
	mail-vn0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbbERNcw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 09:32:52 -0400
In-Reply-To: <CAJKOXPfA-3-SKD-UBACd9+wu0t71pOAduxTqAbNZKknyQTdJhg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Rodolfo Giometti <giometti@linux.it>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>

2015-05-18 21:32 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com=
>:
> 2015-05-18 18:40 GMT+09:00 Dr. H. Nikolaus Schaller <hns@goldelico.co=
m>:
>> Hi,
>> we tried to upgrade from 4.0 to 4.1-rc3 kernel and ran into a NULL p=
ointer problem within the bq27x00 driver.
>>
>> It appears to be introduced by your patch 297d716f6260cc9421d971b124=
ca196b957ee458
>>
>> The problem appears to be that bq27x00_powersupply_init() calls powe=
r_supply_register_no_ws() and
>> sets di->bat *after* return. The old code did pass an uninitialized =
struct pointer.
>>
>> Now for reasons I don=E2=80=99t understand, the power_supply_registe=
r_no_ws() appears to call
>> uevent related stuff which in turn calls bq27x00_battery_get_propert=
y() before di->bat
>> is properly initialized.
>>
>> I have checked with printk in bq27x00_battery_get_property() that di=
>bat =3D=3D NULL in this case and
>> right before we see the segfault.
>>
>> The old code simply did pass a zeroed struct power_supply and perhap=
s initialized its components
>> during registration.
>>
>> Returning some -EINVAL if di->bat =3D=3D NULL would likely solve the=
 NULL pointer dereference but
>> I don=E2=80=99t know what it does to the uevent and if it restores p=
revious operation.
>>
>> It could have been that it was for good purpose that power_supply_re=
gister_no_ws() did not return
>> by value, but by reference to the di->bat struct:
>>
>> -       ret =3D power_supply_register_no_ws(di->dev, &di->bat, NULL)=
;
>> +       di->bat =3D power_supply_register_no_ws(di->dev, psy_desc, &=
psy_cfg);
>>
>> So that code called within the context of power_supply_register_no_w=
s() could already
>> refer to initialized di->bat.
>
> Indeed this issue was not present in previous design however I think
> the architecture was still error-prone. Starting from driver's probe:
>  - some_driver_probe()
>    - power_supply_register(&psy)
>      - device_add()
>        - kobject_uevent() - notify userspace
>         - power_supply_uevent()
>           - power_supply_show_property()
>             - power_supply_get_property()
>               - some_driver_get_property()
>
> So before probe() ends the power supply core calls driver's
> get_property(). In that time the driver internal structures may not b=
e
> ready yet, because the probe did not end. The get_property() could
> access some registers or other core functions which will be ready
> after power_supply_register() call. For example the
> bq27x00_battery_get_property() accesses delayed work which could be
> (by mistake) not yet initialized.
>
> I looked at other dev_uevent implementations and almost all of them d=
o
> not call back the driver.
>
> Of course this does not change that I introduced the issue and I feel
> bad about it.
> I got some ideas for resolving it:
> 1. Fix bq27x00_battery and maybe others so they won't access the 'psy=
'
> member of its state container. This does not solve the issue from
> architectural point of view - still some uninitialised data may be
> accessed because probe() is in progress. However this would be the
> fastest and the least intrusive.
>
> 2. Remove calls to get_property() (and other functions provided by
> driver) from power_supply_uevent(). Unfortunately this may break
> userspace which expects that some data will be present in uevent.
>
> 3. Change the API to the previous convention, which you pointed as a =
remedy:
> ret =3D power_supply_register_no_ws(di->dev, &di->bat, psy_desc, &psy=
_cfg);
> This also won't solve the issue from 1. that uevent will be called
> before probe ends.
>
> 4. Block the power_supply_uevent() from calling the get_property()
> functions until device_add() finishes. This would solve this issue bu=
t
> first uevent messages (from adding device) won't contain all of devic=
e
> data (just like in solution no 2.) and this won't solve other race -
> someone may call sysfs show() on created device nodes and thus access
> the get_property() before probe finishes.

Unfortunately similar issue is with changed_work of power supply. The
power_supply_register() calls at the end power_supply_changed_work()
which through leds calls get_property().

Best regards,
Krzysztof

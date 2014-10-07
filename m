From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power: charger-manager: Avoid recursive thermal get_temp
 call
Date: Tue, 07 Oct 2014 17:05:34 +0200
Message-ID: <1412694334.1185.1.camel@AMDC1943>
References: <1412611212-24803-1-git-send-email-k.kozlowski@samsung.com>
 <54334E00.9030403@samsung.com> <1412665994.11780.3.camel@AMDC1943>
 <5433BE0D.6000306@samsung.com> <1412686205.15309.1.camel@AMDC1943>
 <5433E518.40300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:22299 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbaJGPFi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Oct 2014 11:05:38 -0400
In-reply-to: <5433E518.40300@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Anton Vorontsov <anton@enomsg.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On wto, 2014-10-07 at 22:05 +0900, jonghwa3.lee@samsung.com wrote:
> On 2014=EB=85=84 10=EC=9B=94 07=EC=9D=BC 21:50, Krzysztof Kozlowski w=
rote:
>=20
> > On wto, 2014-10-07 at 19:18 +0900, jonghwa3.lee@samsung.com wrote:
> >> On 2014=EB=85=84 10=EC=9B=94 07=EC=9D=BC 16:13, Krzysztof Kozlowsk=
i wrote:
> >>
> >>>
> >>> On wto, 2014-10-07 at 11:20 +0900, jonghwa3.lee@samsung.com wrote=
:
> >>>> Hi,
> >>>> On 2014=EB=85=84 10=EC=9B=94 07=EC=9D=BC 01:00, Krzysztof Kozlow=
ski wrote:
> >>>>
> >>>>> The charger manager supports POWER_SUPPLY_PROP_TEMP property an=
d acts
> >>>>> as a thermal zone if any of these conditions match:
> >>>>> 1. Fuel gauge used by charger manager supports POWER_SUPPLY_PRO=
P_TEMP.
> >>>>> 2. 'cm-thermal-zone' property is present in DTS (then it will s=
upersede
> >>>>>    the fuel gauge temperature property).
> >>>>>
> >>>>> However in case 1 (fuel gauge reports temperature and 'cm-therm=
al-zone'
> >>>>> is not set) the charger manager forwards its get_temp calls to =
fuel
> >>>>> gauge thermal zone.
> >>>>>
> >>>>> This leads to reporting by lockdep a false positive deadlock fo=
r thermal
> >>>>> zone's mutex because of nested calls to thermal_zone_get_temp()=
=2E This is
> >>>>> false positive because these are different mutexes: one for cha=
rger
> >>>>> manager thermal zone and second for fuel gauge thermal zone.
> >>>>>
> >>>>
> >>>>
> >>>> Yes, this happens because power_supply_subsystem automatically c=
reates
> >>>> thermal_zone when POWER_SUPPLY_PROP_TEMP is available at the tim=
e of
> >>>> power_supply registering. And as you point out, it makes duplica=
te thermal_zone
> >>>> when some power_supply references other power_supply's. I hope i=
t would become
> >>>> to be a selectable option or change the manner of charger-manage=
r itself (if the
> >>>> charger-manager is only one who references other power_supply's =
temperature
> >>>> sensing ability).
> >>>>
> >>>> Anyway, the code looks fine to me.
> >>>>
> >>>> Acked-by : Jonghwa Lee <jonghwa3.lee@samsung.com>
> >>>
> >>> Thank you for looking at patch. However later I started to wonder
> >>> whether my fix is sufficient. For the case when fuel gauge is use=
d as
> >>> source of temperature it is. But for the case when external senso=
r is
> >>> used it is not - still there will be recursive call and false pos=
itive
> >>> from lockdep.
> >>>
> >>> Also minor fix is needed in my patch - s/IS_ENABLED/config_enable=
d/.
> >>>
> >>> I can send a v2 fixing this but first question - what about secon=
d
> >>> recursive issue (when external sensor is used instead of fuel gau=
ge)?
> >>>
> >>
> >>
> >> Yes, you're right, it still had problem for external temperature s=
ensor case.
> >> How about we change the core not to make duplicate thermal zone if=
 it already
> >> existed. It's not the common case, but it looks worthy.
> >>
> >> like as below,
> >>
> >> static int psy_register_thermal(struct power_supply *psy)
> >> {
> >> ...
> >> +	if (psy->tzd)
> >> +		return 0;
> >> ...
> >>
> >> We also needs some modification at charger-manager driver, however=
 we can avoid
> >> recursive call problem with this way :)
> >=20
> > Yes, that would remove recursive call but this would also remove th=
ermal
> > zone for charger manager's power supply. Does anyone (user space?)
> > depend and use charger managers thermal zone?
> >=20
>=20
>=20
> AFAIK, no,, charger manager's thermal zone means nothing but just rep=
lica of
> other thermal zone related with battery. It is better to remove it.

Great! I'll send a patch fixing both paths of recursive call.

Best regards,
Krzysztof



From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH] sbs-battery: fix power status when battery is dry
Date: Tue, 29 Mar 2016 09:52:33 +0800
Message-ID: <1459216353.16645.20.camel@mtksdaap41>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
	 <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
	 <1458801832.16645.7.camel@mtksdaap41>
	 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
	 <1459132330.16645.14.camel@mtksdaap41>
	 <CAGS+omBVStB3mfXtDHdbsOK+y2UesGYtZBtYm=ctcpBfm88VEg@mail.gmail.com>
	 <56F95451.5040607@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:25058 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754307AbcC2Bwj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 21:52:39 -0400
In-Reply-To: <56F95451.5040607@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 2016-03-28 at 11:57 -0400, Rhyland Klein wrote:
> On 3/28/2016 6:05 AM, Daniel Kurtz wrote:
> > +Rhyland Klein who original wrote this code...
> >=20
> > On Mon, Mar 28, 2016 at 10:32 AM, YH Huang <yh.huang@mediatek.com> =
wrote:
> >>
> >> On Fri, 2016-03-25 at 11:06 +0800, Daniel Kurtz wrote:
> >>> On Thu, Mar 24, 2016 at 2:43 PM, YH Huang <yh.huang@mediatek.com>=
 wrote:
> >>>>
> >>>> Hi Daniel,
> >>>>
> >>>> On Thu, 2016-03-24 at 12:01 +0800, Daniel Kurtz wrote:
> >>>>> Hi YH,
> >>>>>
> >>>>> On Wed, Mar 23, 2016 at 5:53 PM, YH Huang <yh.huang@mediatek.co=
m> wrote:
> >>>>>> When the battery is dry and BATTERY_FULL_DISCHARGED is set,
> >>>>>> we should check BATTERY_DISCHARGING to decide the power status=
=2E
> >>>>>> If BATTERY_DISCHARGING is set, the power status is not chargin=
g.
> >>>>>> Or the power status should be charging.
> >>>>>>
> >>>>>> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> >>>>>> ---
> >>>>>>  drivers/power/sbs-battery.c |   22 ++++++++++++----------
> >>>>>>  1 file changed, 12 insertions(+), 10 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-b=
attery.c
> >>>>>> index d6226d6..d86db0e 100644
> >>>>>> --- a/drivers/power/sbs-battery.c
> >>>>>> +++ b/drivers/power/sbs-battery.c
> >>>>>> @@ -382,11 +382,12 @@ static int sbs_get_battery_property(stru=
ct i2c_client *client,
> >>>>>>
> >>>>>>                 if (ret & BATTERY_FULL_CHARGED)
> >>>>>>                         val->intval =3D POWER_SUPPLY_STATUS_FU=
LL;
> >>>>>> -               else if (ret & BATTERY_FULL_DISCHARGED)
> >>>>>> -                       val->intval =3D POWER_SUPPLY_STATUS_NO=
T_CHARGING;
> >>>>>> -               else if (ret & BATTERY_DISCHARGING)
> >>>>>> -                       val->intval =3D POWER_SUPPLY_STATUS_DI=
SCHARGING;
> >>>>>> -               else
> >>>>>> +               else if (ret & BATTERY_DISCHARGING) {
> >>>>>> +                       if (ret & BATTERY_FULL_DISCHARGED)
> >>>>>> +                               val->intval =3D POWER_SUPPLY_S=
TATUS_NOT_CHARGING;
> >>>>>> +                       else
> >>>>>> +                               val->intval =3D POWER_SUPPLY_S=
TATUS_DISCHARGING;
> >>>>>> +               } else
> >>>>>
> >>>>>
> >>>>> I think (BATTERY_DISCHARGING && BATTERY_FULL_DISCHARGED) is sti=
ll
> >>>>> POWER_SUPPLY_STATUS_DISCHARGING.
> >>>>> So, let's just report what the battery says and do:
> >>>>>
> >>>>>                else if (ret & BATTERY_DISCHARGING)
> >>>>>                                val->intval =3D POWER_SUPPLY_STA=
TUS_DISCHARGING;
> >>>>>
> >>>> So we just ignore the special situation (BATTERY_DISCHARGING &&
> >>>> BATTERY_FULL_DISCHARGED).
> >>>> Isn't POWER_SUPPLY_STATUS_NOT_CHARGING a useful information?
> >>>
> >>> The battery is discharging.  The fact that it is also reporting t=
hat
> >>> it is already "discharged" just seems premature.   I would expect=
 to
> >>> only see NOT_CHARGING if completely discharged *and* not discharg=
ing.
> >>
> >> I check the "Smart Battery Data Specification Revision 1.1".
> >> And there are some words about FULLY_DISCHARGED.
> >> "Discharge should be stopped soon."
> >> "This status bit may be set prior to the
> >> =E2=80=98TERMINATE_DISCHARGE_ALARM=E2=80=99 as an early or first l=
evel warning of end of
> >> battery charge."
> >> It looks like the FULLY_DISCHARGED status is used to announce the
> >> warning of battery charge and it is still discharging if there is =
no one
> >> takes care of it.
>=20
>=20
> The only difference I see in the patch above is that in the case wher=
e
> DISCHARGING isn't set, it won't check FULL_DISCHARGE. Nothing seems t=
o
> be changed in the case where FULL_DISCHARGE & DISCHARGING are set.

If battery is dry(FULLY_DISCHARGED) and is charging(No
BATTERY_DISCHARGING) by AC at the same time,
I think it is better to mark as POWER_SUPPLY_STATUS_CHARGING.
Is this right?

>=20
> I think in the case that both flags are set, it makes sense to
> prioritize the FULL_DISCHARGE, since as quote above actually starts w=
ith
> "FULLY_DISCHARGED bit is set when the Smart Battery determines that i=
t
> has supplied all the charge it can." I think at the point where both
> statuses are reported, the fact that it is still DISCHARGING doesn't
> matter. The code as is handles this in that manner, so I don't see a
> need to change it.
>=20
> -rhyland
>=20
>=20



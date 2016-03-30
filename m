From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH] sbs-battery: fix power status when battery is dry
Date: Wed, 30 Mar 2016 16:58:30 +0800
Message-ID: <1459328310.29450.24.camel@mtksdaap41>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
	 <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
	 <1458801832.16645.7.camel@mtksdaap41>
	 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
	 <1459132330.16645.14.camel@mtksdaap41>
	 <CAGS+omBVStB3mfXtDHdbsOK+y2UesGYtZBtYm=ctcpBfm88VEg@mail.gmail.com>
	 <56F95451.5040607@nvidia.com> <1459216353.16645.20.camel@mtksdaap41>
	 <56FA99D0.1010004@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FA99D0.1010004@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-03-29 at 11:05 -0400, Rhyland Klein wrote:
> On 3/28/2016 9:52 PM, YH Huang wrote:
> > On Mon, 2016-03-28 at 11:57 -0400, Rhyland Klein wrote:
> >> On 3/28/2016 6:05 AM, Daniel Kurtz wrote:
> >>> +Rhyland Klein who original wrote this code...
> >>>
> >>> On Mon, Mar 28, 2016 at 10:32 AM, YH Huang <yh.huang@mediatek.com=
> wrote:
> >>>>
> >>>> On Fri, 2016-03-25 at 11:06 +0800, Daniel Kurtz wrote:
> >>>>> On Thu, Mar 24, 2016 at 2:43 PM, YH Huang <yh.huang@mediatek.co=
m> wrote:
> >>>>>>
> >>>>>> Hi Daniel,
> >>>>>>
> >>>>>> On Thu, 2016-03-24 at 12:01 +0800, Daniel Kurtz wrote:
> >>>>>>> Hi YH,
> >>>>>>>
> >>>>>>> On Wed, Mar 23, 2016 at 5:53 PM, YH Huang <yh.huang@mediatek.=
com> wrote:
> >>>>>>>> When the battery is dry and BATTERY_FULL_DISCHARGED is set,
> >>>>>>>> we should check BATTERY_DISCHARGING to decide the power stat=
us.
> >>>>>>>> If BATTERY_DISCHARGING is set, the power status is not charg=
ing.
> >>>>>>>> Or the power status should be charging.
> >>>>>>>>
> >>>>>>>> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/power/sbs-battery.c |   22 ++++++++++++----------
> >>>>>>>>  1 file changed, 12 insertions(+), 10 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs=
-battery.c
> >>>>>>>> index d6226d6..d86db0e 100644
> >>>>>>>> --- a/drivers/power/sbs-battery.c
> >>>>>>>> +++ b/drivers/power/sbs-battery.c
> >>>>>>>> @@ -382,11 +382,12 @@ static int sbs_get_battery_property(st=
ruct i2c_client *client,
> >>>>>>>>
> >>>>>>>>                 if (ret & BATTERY_FULL_CHARGED)
> >>>>>>>>                         val->intval =3D POWER_SUPPLY_STATUS_=
=46ULL;
> >>>>>>>> -               else if (ret & BATTERY_FULL_DISCHARGED)
> >>>>>>>> -                       val->intval =3D POWER_SUPPLY_STATUS_=
NOT_CHARGING;
> >>>>>>>> -               else if (ret & BATTERY_DISCHARGING)
> >>>>>>>> -                       val->intval =3D POWER_SUPPLY_STATUS_=
DISCHARGING;
> >>>>>>>> -               else
> >>>>>>>> +               else if (ret & BATTERY_DISCHARGING) {
> >>>>>>>> +                       if (ret & BATTERY_FULL_DISCHARGED)
> >>>>>>>> +                               val->intval =3D POWER_SUPPLY=
_STATUS_NOT_CHARGING;
> >>>>>>>> +                       else
> >>>>>>>> +                               val->intval =3D POWER_SUPPLY=
_STATUS_DISCHARGING;
> >>>>>>>> +               } else
> >>>>>>>
> >>>>>>>
> >>>>>>> I think (BATTERY_DISCHARGING && BATTERY_FULL_DISCHARGED) is s=
till
> >>>>>>> POWER_SUPPLY_STATUS_DISCHARGING.
> >>>>>>> So, let's just report what the battery says and do:
> >>>>>>>
> >>>>>>>                else if (ret & BATTERY_DISCHARGING)
> >>>>>>>                                val->intval =3D POWER_SUPPLY_S=
TATUS_DISCHARGING;
> >>>>>>>
> >>>>>> So we just ignore the special situation (BATTERY_DISCHARGING &=
&
> >>>>>> BATTERY_FULL_DISCHARGED).
> >>>>>> Isn't POWER_SUPPLY_STATUS_NOT_CHARGING a useful information?
> >>>>>
> >>>>> The battery is discharging.  The fact that it is also reporting=
 that
> >>>>> it is already "discharged" just seems premature.   I would expe=
ct to
> >>>>> only see NOT_CHARGING if completely discharged *and* not discha=
rging.
> >>>>
> >>>> I check the "Smart Battery Data Specification Revision 1.1".
> >>>> And there are some words about FULLY_DISCHARGED.
> >>>> "Discharge should be stopped soon."
> >>>> "This status bit may be set prior to the
> >>>> =E2=80=98TERMINATE_DISCHARGE_ALARM=E2=80=99 as an early or first=
 level warning of end of
> >>>> battery charge."
> >>>> It looks like the FULLY_DISCHARGED status is used to announce th=
e
> >>>> warning of battery charge and it is still discharging if there i=
s no one
> >>>> takes care of it.
> >>
> >>
> >> The only difference I see in the patch above is that in the case w=
here
> >> DISCHARGING isn't set, it won't check FULL_DISCHARGE. Nothing seem=
s to
> >> be changed in the case where FULL_DISCHARGE & DISCHARGING are set.
> >=20
> > If battery is dry(FULLY_DISCHARGED) and is charging(No
> > BATTERY_DISCHARGING) by AC at the same time,
> > I think it is better to mark as POWER_SUPPLY_STATUS_CHARGING.
> > Is this right?
> >
>=20
> Hmm. I can see where you patch would address that situation. From the
> spec, it looks like its expected that the flags should look something
> like this:
>=20
> capacity (in the course of running from fully_charged to dry to
> recharging...)
>=20
> full: FULLY_CHARGED
> <unplug>
> high->low: DISCHARGING
> ~0%: (DISCHARGING & FULLY_DISCHARGED)
> <plug in>
> ->~20%: FULLY_DISCHARGED
> >~20%: <nothing> =3D charging
>=20
> From this understanding, it seems like we can't expect FULLY_DISCHARG=
ED
> to ever be the only flag, nor can we expect it to go away when the
> system is initially plugged in. In light of this, I can see why your
> patch is preferable to the existing code, as the existing code could
> imply that the system is either still near 0% when it is in fact
> charging. Of course, ideally the status returned would be "LOW BUT
> CHARGING" but I can see how CHARGING seems like a better option.
>=20
> I think this patch would be fine if we wanted to cover that case, tho=
ugh
> if we do merge this, we should probably flush out the patch descripti=
on
> better to clarify why we have to treat FULLY_DISCHARGED as only
> applicable while DISCHARGING. This, IMHO, isn't because the
> FULLY_DISCHARGED flag comes on early, but rather because it doesn't t=
urn
> off until ~20%.

If I revise the description in this way(using your clear explanation):
-----------------------------------------------------------------------=
-
The battery capacity changing course is like this:

full: BATTERY_FULLY_CHARGED =3D> POWER_SUPPLY_STATUS_FULL
<unplug AC>
high->low: BATTERY_DISCHARGING =3D> POWER_SUPPLY_STATUS_DISCHARGING
~0%: DISCHARGING & FULLY_DISCHARGED =3D> POWER_SUPPLY_STATUS_NOT_CHARGI=
NG
<plug in AC>
0%~20%: FULLY_DISCHARGED =3D> POWER_SUPPLY_STATUS_CHARGING
20%~: No flag =3D> POWER_SUPPLY_STATUS_CHARGING

=46or now, it is not exactly right to show the status as
POWER_SUPPLY_STATUS_NOT_CHARGING when the battery is dry
(FULLY_DISCHARGED) and AC is plugged in.
Although the battery is in a low level, system works fine with the AC
charging.
It is better to say that the battery is charging.
-----------------------------------------------------------------------=
-

How about this?
By the way, should I also revise the title?

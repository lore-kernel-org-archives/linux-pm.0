From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 11:28:56 +0200
Message-ID: <4212243.RcCUWlsaar@amdc3058>
References: <1523436077.16235.5.camel@intel.com>
        <3546651.LUmDXQgY88@amdc3058>
        <16cbc915-ad89-7bab-c644-8086cfef082f@linaro.org>
        <CGME20180413092901epcas2p43245301152a01c782620f0ab95b2a692@epcas2p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <16cbc915-ad89-7bab-c644-8086cfef082f@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, April 13, 2018 11:19:40 AM Daniel Lezcano wrote:
> On 13/04/2018 11:08, Bartlomiej Zolnierkiewicz wrote:
> > On Friday, April 13, 2018 11:00:43 AM Daniel Lezcano wrote:
> >> On 13/04/2018 10:55, Bartlomiej Zolnierkiewicz wrote:
> >>> On Friday, April 13, 2018 01:39:05 PM Zhang Rui wrote:
> >>>> Hi, Eduardo,
> >>>>
> >>>> On =E5=9B=9B, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:=

> >>>>> Hello,
> >>>>>
> >>>>> On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:=

> >>>>>>
> >>>>>> On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.c=
om>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> could you please illustrate me what the kconfig & warning is?=

> >>>>>> Just "make allmodconfig" and the warning is about a uninitiali=
zed
> >>>>>> variable.
> >>>>>>
> >>>>>> Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> >>>>>> history
> >>>>>> is to be believed.
> >>>>>>
> >>>>>>                 Linus
> >>>>> Yeah, this has also passed my local compilation error. Somehow =
my
> >>>>> gcc4.9
> >>>>> is not catching it. Using an older gcc (gcc4.6) does catch it.
> >>>>>
> >>>>> Anyways, given that the conversion functions are written to cov=
er
> >>>>> for unexpected cal_type, the right way of fixing this is to rew=
rite
> >>>>> the conversion functions to allow for returning error codes and=

> >>>>> adjusting the callers as expected.
> >>>>>
> >>>>> Rui, bzolnier, please consider the following fix:
> >>>>>
> >>>> as it is late in this merge window, I'd prefer to
> >>>> 1. drop all the thermal-soc material in the first pull request w=
hich I
> >>>> will send out soon.
> >>>> 2. you can prepare another pull request containing the thermal-s=
oc
> >>>> materials except the exynos fixes
> >>>> 3. exynos fixes with the problem solved can be queued for -rc2 o=
r
> >>>> later.
> >>>
> >>> Could you please just merge the obvious fix from Arnd instead?
> >>>
> >>> [ it was posted two weeks ago and ACKed by me ]
> >>>
> >>> https://patchwork.kernel.org/patch/10313313/
> >>
> >> I'm not sure these are correct fixes.
> >>
> >> The change 480b5bfc16e1 tells:
> >>
> >> "There should be no functional changes caused by this patch."
> >>
> >> but the fix above returns 0 as a default value instead of '50' or =
'25'
> >> for the 5440 and that impacts the threshold etc ...
> >>
> >> IMO, the correct fix would be to define a default value '50', over=
ride
> >> it at init time to '25' if it is a 5440. And then the variable 'te=
mp'
> >> and 'temp_code' get this value in the default case.
> >=20
> > It is okay to return 0 because this code-path (the default one) wil=
l be
> > never hit by the driver (probe makes sure of it) - the default case=
 is
> > here is just to silence compilation errors..
>=20
> The init function is making sure cal_type is one or another. Can you =
fix
> it correctly by replacing the 'switch' by a 'if' instead of adding de=
ad
> branches to please gcc?
>=20
> if (data->cal_type =3D=3D TYPE_TWO_POINT_TRIMMING) {
> =09return ...;
> }
>=20
> return ...;

I'm not the one that added this switch statement (it has been there sin=
ce
2011) and I would be happy to remove it.  However could we please defer=

this to v4.17 and merge the current set of Exynos thermal fixes/cleanup=
s
(they simplify the driver a lot and make ground for future changes)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

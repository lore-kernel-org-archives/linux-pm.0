From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 11:08:18 +0200
Message-ID: <3546651.LUmDXQgY88@amdc3058>
References: <1523436077.16235.5.camel@intel.com>
        <2944702.qKZ0LXufY7@amdc3058>
        <5afdb571-8aaa-941f-ff4f-7c4b031b5efb@linaro.org>
        <CGME20180413090820epcas1p17dd97e3815909e0714f9d5a80eb82be9@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5afdb571-8aaa-941f-ff4f-7c4b031b5efb@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, April 13, 2018 11:00:43 AM Daniel Lezcano wrote:
> On 13/04/2018 10:55, Bartlomiej Zolnierkiewicz wrote:
> > On Friday, April 13, 2018 01:39:05 PM Zhang Rui wrote:
> >> Hi, Eduardo,
> >>
> >> On =E5=9B=9B, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> >>> Hello,
> >>>
> >>> On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> >>>>
> >>>> On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com=
>
> >>>> wrote:
> >>>>>
> >>>>>
> >>>>> could you please illustrate me what the kconfig & warning is?
> >>>> Just "make allmodconfig" and the warning is about a uninitialize=
d
> >>>> variable.
> >>>>
> >>>> Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> >>>> history
> >>>> is to be believed.
> >>>>
> >>>>                 Linus
> >>> Yeah, this has also passed my local compilation error. Somehow my=

> >>> gcc4.9
> >>> is not catching it. Using an older gcc (gcc4.6) does catch it.
> >>>
> >>> Anyways, given that the conversion functions are written to cover=

> >>> for unexpected cal_type, the right way of fixing this is to rewri=
te
> >>> the conversion functions to allow for returning error codes and
> >>> adjusting the callers as expected.
> >>>
> >>> Rui, bzolnier, please consider the following fix:
> >>>
> >> as it is late in this merge window, I'd prefer to
> >> 1. drop all the thermal-soc material in the first pull request whi=
ch I
> >> will send out soon.
> >> 2. you can prepare another pull request containing the thermal-soc=

> >> materials except the exynos fixes
> >> 3. exynos fixes with the problem solved can be queued for -rc2 or
> >> later.
> >=20
> > Could you please just merge the obvious fix from Arnd instead?
> >=20
> > [ it was posted two weeks ago and ACKed by me ]
> >=20
> > https://patchwork.kernel.org/patch/10313313/
>=20
> I'm not sure these are correct fixes.
>=20
> The change 480b5bfc16e1 tells:
>=20
> "There should be no functional changes caused by this patch."
>=20
> but the fix above returns 0 as a default value instead of '50' or '25=
'
> for the 5440 and that impacts the threshold etc ...
>=20
> IMO, the correct fix would be to define a default value '50', overrid=
e
> it at init time to '25' if it is a 5440. And then the variable 'temp'=

> and 'temp_code' get this value in the default case.

It is okay to return 0 because this code-path (the default one) will be=

never hit by the driver (probe makes sure of it) - the default case is
here is just to silence compilation errors..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Fri, 24 Oct 2014 13:04:15 +0100
Message-ID: <20141024120415.GB25401@red-moon>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-6-git-send-email-lina.iyer@linaro.org>
 <5448E103.9070505@linaro.org>
 <20141023124303.GA16417@red-moon>
 <544A1443.8000707@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <544A1443.8000707@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 24, 2014 at 09:56:35AM +0100, Daniel Lezcano wrote:
> On 10/23/2014 02:43 PM, Lorenzo Pieralisi wrote:
> > On Thu, Oct 23, 2014 at 12:05:39PM +0100, Daniel Lezcano wrote:
> >
> > [...]
> >
> >>> diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpu=
idle-qcom.c
> >>> new file mode 100644
> >>> index 0000000..0a65065
> >>> --- /dev/null
> >>> +++ b/drivers/cpuidle/cpuidle-qcom.c
> >>> @@ -0,0 +1,79 @@
> >>> +/*
> >>> + * Copyright (c) 2014, Linaro Limited.
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or=
 modify
> >>> + * it under the terms of the GNU General Public License version =
2 and
> >>> + * only version 2 as published by the Free Software Foundation.
> >>> + *
> >>> + * This program is distributed in the hope that it will be usefu=
l,
> >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty o=
f
> >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + * GNU General Public License for more details.
> >>> + *
> >>> + */
> >>> +
> >>> +#include <linux/cpu_pm.h>
> >>> +#include <linux/cpuidle.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/platform_device.h>
> >>> +
> >>> +#include <soc/qcom/pm.h>
> >>> +#include "dt_idle_states.h"
> >>> +
> >>> +static void (*qcom_idle_enter)(enum pm_sleep_mode);
> >>> +
> >>> +static int qcom_lpm_enter_stby(struct cpuidle_device *dev,
> >>> +                             struct cpuidle_driver *drv, int ind=
ex)
> >>> +{
> >>> +     qcom_idle_enter(PM_SLEEP_MODE_STBY);
> >>
> >> Could you replace this function by a generic one ?
> >>
> >> It would be nice to have qcom_cpu_standby(void) and
> >> qcom_cpu_powerdown(void) and let behind the mysterious words 'Sing=
le
> >> Power Collapse' in the low level code which is qcom specific :)
> >>
> >> I guess you had to create a single "qcom_idle_enter" because of a =
single
> >> pointer in the platform data. I am working on a common structure t=
o be
> >> shared across the drivers as a common way to pass the different
> >> callbacks without including a soc specific header.
> >>
> >> struct cpuidle_ops {
> >>          int (*standby)(void *data);
> >>          int (*retention)(void *data);
> >>          int (*poweroff)(void *data);
> >> };
> >>
> >> So maybe you can either:
> >>
> >> 1. wait I post this structure and provide the driver with this one
> >> 2. create a similar structure and I will take care to upgrade when=
 I
> >> post the patchset with the common structure.
> >>
> >> The issue I see with this common structure is the initialization o=
f the
> >> qcom_idle_state_match array.
> >
> > Because you do not know which function to call when right ?
>=20
> Hi Lorenzo,
>=20
> that's correct.
>=20
> Perhaps an alternative could be to use the 'weak' attribute instead o=
f a=20
> structure and define the different ops like the cpu_do_idle() does.

Do you mean arch_cpu_idle() ? I still do not see how the CPUidle driver
can make out what function to call when, unless it is the driver that
initializes those functions itself, I think we should see how it works
with an example.

> > That's why
> > I think it is up to the CPUidle back-end to make that decision and =
why
> > I think that the contract between the CPUidle driver and the back-e=
nd
> > should be the idle index. Even if you have pointers to functions,
> > the CPUidle driver do not know what parameter it has to chuck into
> > the void data, which is likely to be platform specific too. Granted=
,
> > you can make those cpuidle_ops a set of pairs, {function, parameter=
}
> > associated with an idle index, but then you will end up implementin=
g
> > what I suggest below.
>=20
> I don't see where is the problem if the backend driver passes the=20
> different CPU PM ops. If the cpuidle driver and the backend PM code w=
ant=20
> to pass an index as 'data', I don't like that but it is ok. But I don=
't=20
> want to provide the index as part of the API.
>=20
> We can see the mess when the code began to play with the indexes as a=
=20
> specific idle state (cf. CPUIDLE_DRIVER_STATE_START magic).

I think that it can be done, but I also agree that there is a lot
of legacy and you are looking for an interface to unify the idle
drivers, inclusive of legacy ones so that's convoluted.

As I mentioned below, we need a solution that works well on the majorit=
y
of idle drivers, inclusive of bL one MCPM based, otherwise things get
out of control. I already have to update the bL driver for core gating
states, and in the process that requires a clean interface between MCPM
calls and the backend, which at the moment is based on passing the
state residency. We can't deploy different solutions to the same
problem, that's my point.

Thanks,
Lorenzo

> > If you have a look at how the MCPM wrapper works on bL driver, that=
's
> > exactly the same problem. At the moment we are supporting only clus=
ter
> > shutdown. If we were to add a core gating idle state, how could the
> > MCPM back-end differentiate between core and cluster states ? At th=
e
> > moment the only way would consist in passing the residency through
> > mcpm_suspend() parameter. We could pass the idle state index, it is=
 the
> > same story.
> >
> > That's the reasoning behind cpu_suspend on ARM64, the index determi=
nes
> > what should be done, it is up to the platform back end to execute t=
he
> > required actions (and it is not because we have PSCI on ARM64, that
> > concept is generic and should be made similar on ARM32 IMHO).
> >
> > DT idle states are sorted by definition, and they can be parsed by
> > the arch back-end too to determine the actions required by an idle
> > state index (eg most likely information coming from power domains).
> >
> > The glue code on arm64 is cpu_init_idle(), which takes charge of
> > initializing the idle state platform specific actions/parameters/et=
c.
> >
> > Everything is open to debate, as long as we nail down an interface =
on
> > arm32 and we stick to that from now onwards, I do not think you are=
 far
> > from achieving that at all.
>=20
>=20
>=20
>=20
> --=20
>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software =
for ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
>=20

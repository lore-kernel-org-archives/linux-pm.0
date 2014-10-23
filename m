From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Thu, 23 Oct 2014 13:43:03 +0100
Message-ID: <20141023124303.GA16417@red-moon>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-6-git-send-email-lina.iyer@linaro.org>
 <5448E103.9070505@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <5448E103.9070505@linaro.org>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 23, 2014 at 12:05:39PM +0100, Daniel Lezcano wrote:

[...]

> > diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpuidle-qcom.c
> > new file mode 100644
> > index 0000000..0a65065
> > --- /dev/null
> > +++ b/drivers/cpuidle/cpuidle-qcom.c
> > @@ -0,0 +1,79 @@
> > +/*
> > + * Copyright (c) 2014, Linaro Limited.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 and
> > + * only version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/cpu_pm.h>
> > +#include <linux/cpuidle.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <soc/qcom/pm.h>
> > +#include "dt_idle_states.h"
> > +
> > +static void (*qcom_idle_enter)(enum pm_sleep_mode);
> > +
> > +static int qcom_lpm_enter_stby(struct cpuidle_device *dev,
> > +                             struct cpuidle_driver *drv, int index)
> > +{
> > +     qcom_idle_enter(PM_SLEEP_MODE_STBY);
> 
> Could you replace this function by a generic one ?
> 
> It would be nice to have qcom_cpu_standby(void) and
> qcom_cpu_powerdown(void) and let behind the mysterious words 'Single
> Power Collapse' in the low level code which is qcom specific :)
> 
> I guess you had to create a single "qcom_idle_enter" because of a single
> pointer in the platform data. I am working on a common structure to be
> shared across the drivers as a common way to pass the different
> callbacks without including a soc specific header.
> 
> struct cpuidle_ops {
>         int (*standby)(void *data);
>         int (*retention)(void *data);
>         int (*poweroff)(void *data);
> };
> 
> So maybe you can either:
> 
> 1. wait I post this structure and provide the driver with this one
> 2. create a similar structure and I will take care to upgrade when I
> post the patchset with the common structure.
> 
> The issue I see with this common structure is the initialization of the
> qcom_idle_state_match array.

Because you do not know which function to call when right ? That's why
I think it is up to the CPUidle back-end to make that decision and why
I think that the contract between the CPUidle driver and the back-end
should be the idle index. Even if you have pointers to functions,
the CPUidle driver do not know what parameter it has to chuck into
the void data, which is likely to be platform specific too. Granted,
you can make those cpuidle_ops a set of pairs, {function, parameter}
associated with an idle index, but then you will end up implementing
what I suggest below.

If you have a look at how the MCPM wrapper works on bL driver, that's
exactly the same problem. At the moment we are supporting only cluster
shutdown. If we were to add a core gating idle state, how could the
MCPM back-end differentiate between core and cluster states ? At the
moment the only way would consist in passing the residency through
mcpm_suspend() parameter. We could pass the idle state index, it is the
same story.

That's the reasoning behind cpu_suspend on ARM64, the index determines
what should be done, it is up to the platform back end to execute the
required actions (and it is not because we have PSCI on ARM64, that
concept is generic and should be made similar on ARM32 IMHO).

DT idle states are sorted by definition, and they can be parsed by
the arch back-end too to determine the actions required by an idle
state index (eg most likely information coming from power domains).

The glue code on arm64 is cpu_init_idle(), which takes charge of
initializing the idle state platform specific actions/parameters/etc.

Everything is open to debate, as long as we nail down an interface on
arm32 and we stick to that from now onwards, I do not think you are far
from achieving that at all.

Cheers,
Lorenzo

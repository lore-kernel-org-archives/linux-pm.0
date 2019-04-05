From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 13/13] thermal: qoriq: Add hwmon support
Date: Fri, 5 Apr 2019 11:38:00 -0700
Message-ID: <CAHQ1cqGfRCCD0vL+6xUWnHyL2FPQhMB=2f6nkdQ0wTWXZR0NCA@mail.gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-14-andrew.smirnov@gmail.com> <4c6ef4cb-8214-cda6-bfa9-8f0887fc2170@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c6ef4cb-8214-cda6-bfa9-8f0887fc2170@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 4, 2019 at 2:12 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Expose thermal readings as a HWMON device, so that it could be
> > accessed using lm-sensors.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 9d227654f879..7fb9321a0d8c 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/thermal.h>
> >
> >  #include "thermal_core.h"
> > +#include "thermal_hwmon.h"
> >
> >  #define SITES_MAX    16
> >
> > @@ -103,7 +104,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >               case -ENODEV:
> >                       continue;
> >               case 0:
> > -                     break;
> > +                     ret = devm_thermal_add_hwmon_sysfs(tzd);
> > +                     if (!ret)
> > +                             break;
> > +                     /* fallthrough */
>
> Do we really want to disable the thermal zone if the hwmon fails to
> register ?

Original code already disables all thermal zones if any single one
fails to register, so I though we may as well be as strict for hwmon
registration as well. Doesn't have to be though. Will change in v4.

Thanks,
Andrey Smirnov

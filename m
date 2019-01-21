From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 4/9] cpufreq: Add a flag to auto-register a cooling device
Date: Mon, 21 Jan 2019 19:53:50 +0530
Message-ID: <CAHLCerNHWh5odX5d27RqTR=jgq_OMexto9mfQVWDTpxZPzCu+Q@mail.gmail.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <e195496f42375259f1b202eae39d20a56725f4a7.1547458732.git.amit.kucheria@linaro.org>
 <154751027198.169631.16299398103212295726@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154751027198.169631.16299398103212295726@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Andy Gross <andy.gross@linaro.org>, Taniya Das <tdas@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 15, 2019 at 5:27 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-01-14 02:21:06)
> > All cpufreq drivers do similar things to register as a cooling device.
> > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > to register the cooling device on their behalf. This allows us to get
> > rid of duplicated code in the drivers.
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> >  include/linux/cpufreq.h   |  6 ++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 6f23ebb395f1..7faebfc61e60 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/syscore_ops.h>
> >  #include <linux/tick.h>
> >  #include <trace/events/power.h>
> > +#include <linux/cpu_cooling.h>
>
> Maybe this is supposed to be ordered alphabetically? If so, this should
> be much higher.

Fixed

> >
> >  static LIST_HEAD(cpufreq_policy_list);
> >
> > @@ -1318,6 +1319,12 @@ static int cpufreq_online(unsigned int cpu)
> >         if (cpufreq_driver->ready)
> >                 cpufreq_driver->ready(policy);
> >
> > +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> > +               struct thermal_cooling_device **cdev = &policy->cooldev;
> > +
> > +               *cdev = of_cpufreq_cooling_register(policy);
> > +       }
>
> This seems to be some complicated way of writing:
>
>                 policy->cooldev = of_cpufreq_cooling_register(policy);
>
> ?

Indeed. Fixed.

> > +
> >         pr_debug("initialization complete\n");
> >
> >         return 0;
> > @@ -1411,6 +1418,12 @@ static int cpufreq_offline(unsigned int cpu)
> >         if (has_target())
> >                 cpufreq_exit_governor(policy);
> >
> > +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> > +               struct thermal_cooling_device **cdev = &policy->cooldev;
> > +
> > +               cpufreq_cooling_unregister(*cdev);
>
> Similar? I'm confused!
>

_un_register as opposed to register above. :-)

Thanks for the review.

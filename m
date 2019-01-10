From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v1 5/7] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date: Thu, 10 Jan 2019 14:33:31 +0530
Message-ID: <CAHLCerPwzJ75Z+AdnrAyV2kY5AV4p5NFbGR1VUEufagGq=2bDw@mail.gmail.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <3c7d0e4a8373e89d6922543ccf56749970de5567.1547078153.git.amit.kucheria@linaro.org>
 <20190110061210.lz5i5wf7wxh22q7c@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110061210.lz5i5wf7wxh22q7c@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Andy Gross <andy.gross@linaro.org>, Taniya Das <tdas@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2019 at 11:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 10-01-19, 05:30, Amit Kucheria wrote:
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 649dddd72749..1c01311e5927 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/bitfield.h>
> >  #include <linux/cpufreq.h>
> > +#include <linux/cpu_cooling.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -216,7 +217,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >  static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> >  {
> >       void __iomem *base = policy->driver_data - REG_PERF_STATE;
> > +     struct thermal_cooling_device *cdev = policy->cooldev;
> >
> > +     if (cdev)
> > +             cpufreq_cooling_unregister(cdev);
> >       kfree(policy->freq_table);
> >       devm_iounmap(&global_pdev->dev, base);
> >
> > @@ -238,6 +242,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> >       .init           = qcom_cpufreq_hw_cpu_init,
> >       .exit           = qcom_cpufreq_hw_cpu_exit,
> >       .fast_switch    = qcom_cpufreq_hw_fast_switch,
> > +     .ready          = generic_cpufreq_ready,
> >       .name           = "qcom-cpufreq-hw",
> >       .attr           = qcom_cpufreq_hw_attr,
> >  };
>
> I liked the idea of reducing code duplication, but not much the
> implementation. All we were able to get rid of was a call to
> of_cpufreq_cooling_register() and nothing else. Is it worth it ?
>
> Maybe we can add another flag in cpufreq.h:
>
> #define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
>
> and let the core do it all automatically by itself, that will get rid
> of code duplication actually.

I like the idea of a flag. I'll spin something implementing it in the next rev.

> @Rafael: What do you say ?

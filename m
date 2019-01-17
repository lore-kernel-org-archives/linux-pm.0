From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 9/9] thermal: cpu_cooling: Clarify error message
Date: Thu, 17 Jan 2019 11:34:28 +0100
Message-ID: <CAJZ5v0j2-RPckRigk+gjo4ffiB+04VE_v6Dnw90E-Q7X2knpvA@mail.gmail.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <2de2d178380525191d99d6c3619ad8c45efdbab4.1547458732.git.amit.kucheria@linaro.org>
 <20190117055730.7hxe37ngcubo6htw@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117055730.7hxe37ngcubo6htw@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, bjorn.andersson@linaro.org, Eduardo Valentin <edubezval@gmail.com>, Andy Gross <andy.gross@linaro.org>, Taniya Das <tdas@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 17, 2019 at 6:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-01-19, 15:51, Amit Kucheria wrote:
> > Make it clear that it is a failure if the cpufreq driver was unable to
> > register as a cooling device. Makes it easier to find in logs and
> > grepping for words like fail, err, warn.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/cpu_cooling.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index dfd23245f778..6fff16113628 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -774,7 +774,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
> >
> >               cdev = __cpufreq_cooling_register(np, policy, capacitance);
> >               if (IS_ERR(cdev)) {
> > -                     pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
> > +                     pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
> >                              policy->cpu, PTR_ERR(cdev));
> >                       cdev = NULL;
> >               }
>
> Always keep such cleanup patches at the top, so the maintainers can
> pick them up easily even if the entire series doesn't get in.

Actually, if nothing in the series depends on this change and this
change doesn't depend on anything in the series, why is it part of the
series at all?

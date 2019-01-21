From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v1 01/10] cpufreq: Add thermal_cooling_device pointer to
 struct cpufreq_policy
Date: Mon, 21 Jan 2019 21:05:45 +0530
Message-ID: <CAHLCerOLXwdMmRci9wSr8+LjVf4m3CdLd85WWjd1Q3VriQy_MA@mail.gmail.com>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <168294311714f269b1050bcbf5d3324eae0808f2.1547481320.git.amit.kucheria@linaro.org>
 <1718046.8NPD0iV1Wv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1718046.8NPD0iV1Wv@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Boyd <swboyd@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 17, 2019 at 4:27 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, January 14, 2019 5:34:53 PM CET Amit Kucheria wrote:
> > Several cpufreq drivers register themselves as thermal cooling devices.
> > Adding a pointer to struct cpufreq_policy removes the need for them to
> > store this pointer in a private data structure.
> >
> > We can then auto-register the cpufreq driver as a thermal cooling device
> > from cpufreq core code.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  include/linux/cpufreq.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index c86d6d8bdfed..7d0cf54125fa 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -95,6 +95,11 @@ struct cpufreq_policy {
> >       struct cpufreq_frequency_table  *freq_table;
> >       enum cpufreq_table_sorting freq_table_sorted;
> >
> > +#ifdef CONFIG_CPU_THERMAL
> > +     /* Pointer to the cooling device if used for thermal mitigation */
> > +     struct thermal_cooling_device *cooldev;
> > +#endif
> > +
>
> Why here and not at the end of the struct?

Fixed

> >       struct list_head        policy_list;
> >       struct kobject          kobj;
> >       struct completion       kobj_unregister;
> >
>
> Also, I would suggest combining this one with patch [02/10].

Will do.

Thanks for the review.

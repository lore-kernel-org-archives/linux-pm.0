From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH 03/44] cpufreq: exynos: call
 cpufreq_frequency_table_put_attr()
Date: Mon, 19 Aug 2013 06:59:49 +0900
Message-ID: <15fd01ce9c5e$42670630$c7351290$@org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
 <c2157d44d4933c5fa9cea06e0d621786a3d03671.1376116345.git.viresh.kumar@linaro.org>
 <CADGdYn79B4d3joAF53E5MoeNB10RWm5fnQCs30-MbM38Jq2uhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CADGdYn79B4d3joAF53E5MoeNB10RWm5fnQCs30-MbM38Jq2uhg@mail.gmail.com>
Content-language: ko
Sender: cpufreq-owner@vger.kernel.org
To: 'amit daniel kachhap' <amit.daniel@samsung.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

amit daniel kachhap wrote:
> 
> On Sat, Aug 10, 2013 at 12:13 PM, Viresh Kumar <viresh.kumar@linaro.org>
> wrote:
> > Drivers which have an exit path must call
> cpufreq_frequency_table_put_attr() if
> > they have called cpufreq_frequency_table_get_attr() in their init path.
> >
> > This driver was missing this part and is fixed with this patch.
> >
> > Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> The changes looks fine, please free to add
> Acked-By: Amit Daniel Kachhap <amit.daniel@samsung.com>
> 
> Thanks.
> Amit Daniel
> 
> 
> > ---
> >  drivers/cpufreq/exynos5440-cpufreq.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/cpufreq/exynos5440-cpufreq.c
> b/drivers/cpufreq/exynos5440-cpufreq.c
> > index 1ac93e0..b9dfc91 100644
> > --- a/drivers/cpufreq/exynos5440-cpufreq.c
> > +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> > @@ -336,12 +336,18 @@ static int exynos_cpufreq_cpu_init(struct
> cpufreq_policy *policy)
> >         return 0;
> >  }
> >
> > +static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       cpufreq_frequency_table_put_attr(policy->cpu);
> > +}
> > +
> >  static struct cpufreq_driver exynos_driver = {
> >         .flags          = CPUFREQ_STICKY,
> >         .verify         = exynos_verify_speed,
> >         .target         = exynos_target,
> >         .get            = exynos_getspeed,
> >         .init           = exynos_cpufreq_cpu_init,
> > +       .exit           = exynos_cpufreq_cpu_exit,
> >         .name           = CPUFREQ_NAME,
> >  };
> >
> > --
> > 1.7.12.rc2.18.g61b472e
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> On Sat, Aug 10, 2013 at 12:13 PM, Viresh Kumar <viresh.kumar@linaro.org>
> wrote:
> > Drivers which have an exit path must call
> cpufreq_frequency_table_put_attr() if
> > they have called cpufreq_frequency_table_get_attr() in their init path.
> >
> > This driver was missing this part and is fixed with this patch.
> >
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/exynos5440-cpufreq.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/cpufreq/exynos5440-cpufreq.c
> b/drivers/cpufreq/exynos5440-cpufreq.c
> > index 1ac93e0..b9dfc91 100644
> > --- a/drivers/cpufreq/exynos5440-cpufreq.c
> > +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> > @@ -336,12 +336,18 @@ static int exynos_cpufreq_cpu_init(struct
> cpufreq_policy *policy)
> >         return 0;
> >  }
> >
> > +static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       cpufreq_frequency_table_put_attr(policy->cpu);
> > +}
> > +
> >  static struct cpufreq_driver exynos_driver = {
> >         .flags          = CPUFREQ_STICKY,
> >         .verify         = exynos_verify_speed,
> >         .target         = exynos_target,
> >         .get            = exynos_getspeed,
> >         .init           = exynos_cpufreq_cpu_init,
> > +       .exit           = exynos_cpufreq_cpu_exit,
> >         .name           = CPUFREQ_NAME,
> >  };
> >
> > --
> > 1.7.12.rc2.18.g61b472e


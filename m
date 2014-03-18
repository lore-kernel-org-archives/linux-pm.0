From: "Zhuoyu.Zhang@freescale.com" <Zhuoyu.Zhang@freescale.com>
Subject: RE: [PATCH] cpufreq: powerpc: add cpufreq transition latency for
 FSL e500mc Socs
Date: Tue, 18 Mar 2014 05:58:46 +0000
Message-ID: <059015c0cc9647d0a881847291679a05@BN1PR03MB154.namprd03.prod.outlook.com>
References: <1395037497-5737-1-git-send-email-Zhuoyu.Zhang@freescale.com>
 <CAKohpondZpWryz4VWYQM=ym7VKmORkoXWvhfDswAb6hnPceSyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpondZpWryz4VWYQM=ym7VKmORkoXWvhfDswAb6hnPceSyQ@mail.gmail.com>
Content-Language: en-US
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Yuantian Tang <Yuantian.Tang@freescale.com>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Tuesday, March 18, 2014 12:27 PM
> To: Zhang Zhuoyu-B46552
> Cc: Rafael J. Wysocki; cpufreq@vger.kernel.org; linux-pm@vger.kernel.org;
> Tang Yuantian-B29983
> Subject: Re: [PATCH] cpufreq: powerpc: add cpufreq transition latency for
> FSL e500mc Socs
> 
> On 17 March 2014 11:54, Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com> wrote:
> > According to the data provided by HW Team, at least 12 internal
> > platform clock cycles are required to stabilize a DFS clock switch on
> FSL e500mc Socs.
> > This patch replaces the CPUFREQ_ETERNAL with appropriate HW clock
> > transition latency to make DFS governors work normally on Freescale
> e500mc boards.
> >
> > Signed-off-by: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
> > ---
> >  drivers/cpufreq/ppc-corenet-cpufreq.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c
> > b/drivers/cpufreq/ppc-corenet-cpufreq.c
> > index 051000f..88f08a6 100644
> > --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> > +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/of.h>
> >  #include <linux/slab.h>
> >  #include <linux/smp.h>
> > +#include <sysdev/fsl_soc.h>
> >
> >  /**
> >   * struct cpu_data - per CPU data struct @@ -133,7 +134,7 @@ static
> > int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)  {
> >         struct device_node *np;
> >         int i, count, ret;
> > -       u32 freq, mask;
> > +       u32 freq, sysclk, mask;
> >         struct clk *clk;
> >         struct cpufreq_frequency_table *table;
> >         struct cpu_data *data;
> > @@ -205,7 +206,8 @@ static int corenet_cpufreq_cpu_init(struct
> cpufreq_policy *policy)
> >         for_each_cpu(i, per_cpu(cpu_mask, cpu))
> >                 per_cpu(cpu_data, i) = data;
> >
> > -       policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> > +       sysclk = fsl_get_sys_freq();
> 
> You don't need this extra variable. Simply use fsl_get_sys_freq() in the
> below equation..

OK, I will rewrite it. 
Thanks, Viresh.

Zhuoyu
> 
> > +       policy->cpuinfo.transition_latency = (12 * NSEC_PER_SEC) /
> > + sysclk;
> >         of_node_put(np);
> 
> Other than that: Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 


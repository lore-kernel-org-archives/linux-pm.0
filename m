From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] cpufreq: exynos: Use simple approach to asses if cpu
 cooling can be used
Date: Wed, 04 Feb 2015 10:00:25 +0100
Message-ID: <20150204100025.565ee2b0@amdc2363>
References: <1422015260-14225-1-git-send-email-l.majewski@samsung.com>
 <1422264327-17483-1-git-send-email-l.majewski@samsung.com>
 <CAKohponEXCsCu=WdbEb8eAnFpVdt1i2BWx+U7RcTX1cDi9A9ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50663 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbbBDJAe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 04:00:34 -0500
In-reply-to: <CAKohponEXCsCu=WdbEb8eAnFpVdt1i2BWx+U7RcTX1cDi9A9ZA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Eduardo,

> On 26 January 2015 at 14:55, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > Commit: e725d26c4857e5e41975b5e74e64ce6ab09a7121 provided
> > possibility to use device tree to asses if cpu can be used as
> > cooling device. Since the code was somewhat awkward, simpler
> > approach has been proposed.
> >
> > Test HW: Exynos 4412 - Odroid U3.
> >
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> >  drivers/cpufreq/exynos-cpufreq.c | 21 ++++++---------------
> >  1 file changed, 6 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/cpufreq/exynos-cpufreq.c
> > b/drivers/cpufreq/exynos-cpufreq.c index 5e98c6b..b640da0 100644
> > --- a/drivers/cpufreq/exynos-cpufreq.c
> > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > @@ -159,7 +159,7 @@ static struct cpufreq_driver exynos_driver = {
> >
> >  static int exynos_cpufreq_probe(struct platform_device *pdev)
> >  {
> > -       struct device_node *cpus, *np;
> > +       struct device_node *cpu0, *np;
> >         int ret = -EINVAL;
> >
> >         exynos_info = kzalloc(sizeof(*exynos_info), GFP_KERNEL);
> > @@ -206,28 +206,19 @@ static int exynos_cpufreq_probe(struct
> > platform_device *pdev) if (ret)
> >                 goto err_cpufreq_reg;
> >
> > -       cpus = of_find_node_by_path("/cpus");
> > -       if (!cpus) {
> > -               pr_err("failed to find cpus node\n");
> > +       cpu0 = of_get_cpu_node(0, NULL);
> > +       if (!cpu0) {
> > +               pr_err("failed to find cpu0 node\n");
> >                 return 0;
> >         }
> >
> > -       np = of_get_next_child(cpus, NULL);
> > -       if (!np) {
> > -               pr_err("failed to find cpus child node\n");
> > -               of_node_put(cpus);
> > -               return 0;
> > -       }
> > -
> > -       if (of_find_property(np, "#cooling-cells", NULL)) {
> > -               cdev = of_cpufreq_cooling_register(np,
> > +       if (of_find_property(cpu0, "#cooling-cells", NULL)) {
> > +               cdev = of_cpufreq_cooling_register(cpu0,
> >                                                    cpu_present_mask);
> >                 if (IS_ERR(cdev))
> >                         pr_err("running cpufreq without cooling
> > device: %ld\n", PTR_ERR(cdev));
> >         }
> > -       of_node_put(np);
> > -       of_node_put(cpus);
> >
> >         return 0;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Could you apply this patch to yours linux-soc-thermal tree?


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 07/18] thermal: exynos: Modify exynos thermal code to
 use device tree for cpu cooling configuration
Date: Wed, 21 Jan 2015 10:47:19 +0100
Message-ID: <20150121104719.69f20ca8@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-8-git-send-email-l.majewski@samsung.com>
 <20150121093304.7ac02a27@amdc2363>
 <CAKohpomgDrBu1Ug0uk233dSVTTDo4rixJiBEsbnJLRF3PDg0QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32744 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbbAUJr3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jan 2015 04:47:29 -0500
In-reply-to: <CAKohpomgDrBu1Ug0uk233dSVTTDo4rixJiBEsbnJLRF3PDg0QA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Viresh,

> On 21 January 2015 at 14:03, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> >> diff --git a/drivers/cpufreq/exynos-cpufreq.c
> 
> >>  static int exynos_cpufreq_probe(struct platform_device *pdev)
> >>  {
> >> +     struct device_node *cpus, *np;
> >>       int ret = -EINVAL;
> >>
> >>       exynos_info = kzalloc(sizeof(*exynos_info), GFP_KERNEL);
> >> @@ -198,9 +202,31 @@ static int exynos_cpufreq_probe(struct
> >> platform_device *pdev) /* Done here as we want to capture boot
> >> frequency */ locking_frequency =
> >> clk_get_rate(exynos_info->cpu_clk) / 1000;
> >> -     if (!cpufreq_register_driver(&exynos_driver))
> >> -             return 0;
> >> +     if (cpufreq_register_driver(&exynos_driver))
> 
> You should return the error returned by cpufreq_register_driver().

OK.

> 
> >> +             goto err;
> >>
> >> +     cpus = of_find_node_by_path("/cpus");
> >> +     if (!cpus) {
> >> +             pr_err("failed to find cpus node\n");
> >> +             return -ENOENT;
> >> +     }
> >> +
> >> +     for (np = of_get_next_child(cpus, NULL); np;
> >> +          of_node_put(np), np = of_get_next_child(cpus, np)) {
> >> +             if (of_find_property(np, "#cooling-cells", NULL)) {
> 
> Shouldn't you be checking this just for cpu 0 ?

In previous versions I've only checked for cpu 0.

If you think that it is enough to explicitly check only for cpu 0 and
forget about above "fail safe" code (when. e.g. CPU3 has defined
cooling-cells), then I'm fine with it.

> 
> >> +                     cdev = of_cpufreq_cooling_register(np,
> >> +
> >> cpu_present_mask);
> >> +                     if (IS_ERR(cdev))
> >> +                             pr_err("running cpufreq without
> >> cooling device: %ld\n",
> >> +                                    PTR_ERR(cdev));
> >> +                     break;
> >> +             }
> >> +     }
> >> +     of_node_put(np);
> >> +     of_node_put(cpus);
> >> +
> >> +     return 0;
> >> + err:
> >>       dev_err(&pdev->dev, "failed to register cpufreq driver\n");
> >>       regulator_put(arm_regulator);
> >>  err_vdd_arm:
> >
> > Viresh, the above is a small part of the cpufreq related code,
> > which is necessary for Exynos thermal rework to use device tree.
> >
> > It is NOT adding any new functionality, but preserves possibility to
> > use cpufreq as a colling device.
> >
> > Normally I would exclude this part from this commit, but then I
> > cannot assure that between commits no regression is slipping in.
> 
> Mostly looks fine. Just few nits.
> 
> But another important thing is to split this patch, so that there is
> a separate patch for cpufreq driver.

As I've mention - it would be maintainer's call if one trades potential
regression for patch separation.

Thanks for a prompt reply.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

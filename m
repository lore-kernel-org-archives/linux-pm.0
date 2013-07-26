From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 6/8] cpufreq:exynos:Extend Exynos cpufreq driver to
 support boost framework
Date: Fri, 26 Jul 2013 15:56:53 +0530
Message-ID: <CAKohponC=S=3=mrTpWvPvejqSeqfndVOwb2GDkQ0jKxXXa0TOQ@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-7-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:43146 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558Ab3GZK0y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2013 06:26:54 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so3568261obc.26
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2013 03:26:53 -0700 (PDT)
In-Reply-To: <1374770011-22171-7-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com

On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com> wrote:

> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 9ae1871..175172d9 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -270,6 +270,9 @@ static int exynos_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>
>  static struct freq_attr *exynos_cpufreq_attr[] = {
>         &cpufreq_freq_attr_scaling_available_freqs,
> +#ifdef CONFIG_CPU_FREQ_BOOST_SW

Use ARM_EXYNOS_CPU_FREQ_BOOST_SW instead.

> +       &cpufreq_freq_attr_scaling_boost_freqs,
> +#endif
>         NULL,
>  };
>
> @@ -332,6 +335,9 @@ static int __init exynos_cpufreq_probe(struct platform_device *pdev)
>
>         locking_frequency = exynos_getspeed(0);
>
> +#ifdef CONFIG_CPU_FREQ_BOOST_SW
> +       exynos_driver.boost_supported = true;
> +#endif

So, why here and not in the definition of exynos_driver?

>         register_pm_notifier(&exynos_cpufreq_nb);
>
>         if (cpufreq_register_driver(&exynos_driver)) {
> --
> 1.7.10.4
>

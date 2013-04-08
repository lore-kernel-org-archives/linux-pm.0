From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH V5 1/4] cpufreq: exynos: Add cpufreq driver for exynos5440
Date: Mon, 8 Apr 2013 13:55:10 +0530
Message-ID: <CADGdYn7PCAPPuAe6Y+VTGq=98i0_6YvDdJsRiLcwMyfsoohbag@mail.gmail.com>
References: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
	<1364457923-8499-2-git-send-email-amit.daniel@samsung.com>
	<CAKohpon5BYW0Ypx8SbBsSUuugUnmYU=rBCMizz-CxuHjCzObpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36406 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934384Ab3DHIZM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2013 04:25:12 -0400
In-Reply-To: <CAKohpon5BYW0Ypx8SbBsSUuugUnmYU=rBCMizz-CxuHjCzObpQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Inderpal Singh <inderpal.singh@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Thu, Mar 28, 2013 at 6:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28 March 2013 13:35, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> > +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> > +static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       policy->cur = dvfs_info->cur_frequency;
> > +       cpufreq_frequency_table_get_attr(dvfs_info->freq_table, policy->cpu);
> > +
> > +       /* set the transition latency value */
> > +       policy->cpuinfo.transition_latency = dvfs_info->latency;
> > +
> > +       cpumask_setall(policy->cpus);
> > +
> > +       return cpufreq_frequency_table_cpuinfo(policy, dvfs_info->freq_table);
>
> I missed this earlier and saw this mistake in yet another driver.
> You need to call cpufreq_frequency_table_get_attr() only when
> cpufreq_frequency_table_cpuinfo() has passed.

ok. Submitted the V6 version with this change.

>
>
> > +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

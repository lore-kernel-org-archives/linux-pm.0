From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
Date: Thu, 31 Jan 2013 09:50:37 +0530
Message-ID: <CAOh2x==GeK4qM=kjy-tzhbEh4L9AmRXoG_0tUzov1SK+uRFxcw@mail.gmail.com>
References: <1887364.fvxYYNb7Mm@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:38196 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592Ab3AaEUi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jan 2013 23:20:38 -0500
In-Reply-To: <1887364.fvxYYNb7Mm@amdc1227>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, Nov 13, 2012 at 2:56 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> On Exynos SoCs all cores share the same frequency setting, so changing
> frequency of one core will affect rest of cores.
>
> This patch modifies the exynos-cpufreq driver to inform cpufreq core
> about this behavior and broadcast frequency change notifications for all
> cores.

>         /* When the new frequency is lower than current frequency */
>         if ((freqs.new < freqs.old) ||
> @@ -235,6 +237,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 cpumask_copy(policy->related_cpus, cpu_possible_mask);
>                 cpumask_copy(policy->cpus, cpu_online_mask);
>         } else {
> +               policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>                 cpumask_setall(policy->cpus);

I couldn't understand the use of this change. Can you please explain ?

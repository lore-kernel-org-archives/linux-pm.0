From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
Date: Thu, 31 Jan 2013 15:45:19 +0100
Message-ID: <1520677.WES295RohH@amdc1227>
References: <1887364.fvxYYNb7Mm@amdc1227>
 <CAOh2x==GeK4qM=kjy-tzhbEh4L9AmRXoG_0tUzov1SK+uRFxcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAOh2x==GeK4qM=kjy-tzhbEh4L9AmRXoG_0tUzov1SK+uRFxcw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Thursday 31 of January 2013 09:50:37 Viresh Kumar wrote:
> On Tue, Nov 13, 2012 at 2:56 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > On Exynos SoCs all cores share the same frequency setting, so changing
> > frequency of one core will affect rest of cores.
> > 
> > This patch modifies the exynos-cpufreq driver to inform cpufreq core
> > about this behavior and broadcast frequency change notifications for
> > all cores.
> > 
> >         /* When the new frequency is lower than current frequency */
> >         if ((freqs.new < freqs.old) ||
> > 
> > @@ -235,6 +237,7 @@ static int exynos_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)> 
> >                 cpumask_copy(policy->related_cpus, cpu_possible_mask);
> >                 cpumask_copy(policy->cpus, cpu_online_mask);
> >         
> >         } else {
> > 
> > +               policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> > 
> >                 cpumask_setall(policy->cpus);
> 
> I couldn't understand the use of this change. Can you please explain ?

All cores on Exynos SoCs share the same clock source, which means that 
they all always run at the same frequency. So setting frequency on one 
core sets the frequency on all cores and so it doesn't matter on which 
core the frequency setting operation is done.

As you can see in include/linux/cpufreq.h:

#define CPUFREQ_SHARED_TYPE_ANY  (3) /* Freq can be set from any dependent 
CPU*/

which basically tells (together with rest of the patch) the cpufreq 
subsystem about what I wrote earlier.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform

From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH V3 1/6] cpufreq: suspend governors on system suspend/hibernate
Date: Tue, 26 Nov 2013 21:23:15 +0100
Message-ID: <4253729.doK7ubnxKx@vostro.rjw.lan>
References: <cover.1385374819.git.viresh.kumar@linaro.org> <40779593.MBXsTetiKz@vostro.rjw.lan> <CAKohpok0E=m=63KXM22usiW7Rsu59cD7Q=+k3tRcW=8269tZnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpok0E=m=63KXM22usiW7Rsu59cD7Q=+k3tRcW=8269tZnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Patch Tracking <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Kgene Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jinchoi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonghwan Choi <jhbird.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 26, 2013 07:56:19 AM Viresh Kumar wrote:
> On 26 November 2013 04:59, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> >> @@ -1259,6 +1262,8 @@ int dpm_suspend(pm_message_t state)
> >>
> >>       might_sleep();
> >>
> >> +     cpufreq_suspend();
> >> +
> >>
> >>       mutex_lock(&dpm_list_mtx);
> >>       pm_transition = state;
> >>       async_error = 0;
> >
> > Shouldn't it do cpufreq_resume() on errors?
> 
> Yes and this is already done I believe. In case dpm_suspend() fails,
> dpm_resume() gets called. Isn't it?

OK

> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> +void cpufreq_suspend(void)
> >> +{
> >> +     struct cpufreq_policy *policy;
> >> +
> >> +     if (!has_target())
> >> +             return;
> >> +
> >> +     pr_debug("%s: Suspending Governors\n", __func__);
> >> +
> >> +     list_for_each_entry(policy, &cpufreq_policy_list, policy_list)
> >> +             if (__cpufreq_governor(policy, CPUFREQ_GOV_STOP))
> >> +                     pr_err("%s: Failed to stop governor for policy: %p\n",
> >> +                                     __func__, policy);
> >
> > This appears to be racy.  Is it really racy, or just seemingly?
> 
> Why does it look racy to you? Userspace should be frozen by now,
> policy_list should be stable as well as nobody would touch it.

You're stopping governors while they may be in use in principle.  Do we have
suitable synchronization in place for that?

Rafael

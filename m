From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 16/17] cpufreq: remove check for cpufreq_disabled() from cpufreq_cpu_{get|put}()
Date: Mon, 26 Jan 2015 01:39:04 +0100
Message-ID: <1867080.dIa4P6m09i@vostro.rjw.lan>
References: <cover.1420181916.git.viresh.kumar@linaro.org> <49250a2946ff12500a5474eb9384c125b3ede23c.1420181916.git.viresh.kumar@linaro.org> <CAKohpomwDr2B+4ncjFyfem1o03gJ+N6bdDEDtdJTvreN6ivp9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55977 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751146AbbAZAQW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 19:16:22 -0500
In-Reply-To: <CAKohpomwDr2B+4ncjFyfem1o03gJ+N6bdDEDtdJTvreN6ivp9Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On Sunday, January 25, 2015 06:54:27 PM Viresh Kumar wrote:
> On 2 January 2015 at 12:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > In most of the cases cpufreq wouldn't be disabled and this adds unnecessary
> > delay for its users. In the case if cpufreq is really disabled, then the per-cpu
> > variable will also return NULL and things will continue working as is. Remove
> > this unnecessary check.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 14d637a28dd8..62c6a0b8b0d1 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -202,9 +202,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
> >         struct cpufreq_policy *policy = NULL;
> >         unsigned long flags;
> >
> > -       if (cpufreq_disabled())
> > -               return NULL;
> > -
> >         if (!down_read_trylock(&cpufreq_rwsem))
> >                 return NULL;
> >
> > @@ -229,9 +226,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
> >
> >  void cpufreq_cpu_put(struct cpufreq_policy *policy)
> >  {
> > -       if (cpufreq_disabled())
> > -               return;
> > -
> >         kobject_put(&policy->kobj);
> >         up_read(&cpufreq_rwsem);
> >  }
> 
> @Rafael: Are you fine with this patch as is? I meant, you just left it for
> rebase conflict or because you want it to be part of the WARN() you
> suggested?

It depended on [15/17] that I didn't apply.

> The WARN here might not be a good idea as this can be called by
> users while cpufreq is disabled. But we don't need this check because
> of the reasons I mentioned in commit log.

I'm not sure which commit log are you talking about, this one or the [15/17] one?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

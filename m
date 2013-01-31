From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH] cpufreq: governors: implement generic policy_is_shared
Date: Thu, 31 Jan 2013 09:55:55 +0100
Message-ID: <20130131085555.GB30667@balto.lan>
References: <1359620064-14751-1-git-send-email-fabio.baltieri@linaro.org>
 <CAKohponV-PPO8sqF=rzONLzPi7q-YFOPbrQgoBcNt_NjTJO6WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponV-PPO8sqF=rzONLzPi7q-YFOPbrQgoBcNt_NjTJO6WQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 31, 2013 at 02:01:27PM +0530, Viresh Kumar wrote:
> On 31 January 2013 13:44, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> > Implement a generic helper function policy_is_shared() to replace the
> > current dbs_sw_coordinated_cpus() at cpufreq level, so that it can be
> > used by code other than cpufreq governors.
> >
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 2 +-
> >  drivers/cpufreq/cpufreq_governor.c     | 8 --------
> >  drivers/cpufreq/cpufreq_governor.h     | 1 -
> >  drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
> >  include/linux/cpufreq.h                | 5 +++++
> 
> Great,
> 
> But, you missed few places:
> 
> drivers/cpufreq/acpi-cpufreq.c:        if (bios_with_sw_any_bug &&
> cpumask_weight(policy->cpus) == 1) {
> drivers/cpufreq/cpufreq_stats.c:       if (policy &&
> (cpumask_weight(policy->cpus) == 1)) {

This doesn't look like the same thing to me!  Isn't this check here just
to trigger during init (exit) on the first (last) cpu?  How would you
replace it?

Fabio

> get these fixed too and add my
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
Fabio Baltieri

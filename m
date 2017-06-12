From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: intel_pstate: Provide resolve_freq() to fix
 regression
Date: Mon, 12 Jun 2017 09:11:08 +0530
Message-ID: <20170612034108.GC5297@vireshk-i7>
References: <cover.1497002895.git.viresh.kumar@linaro.org>
 <eb1c4db95f52dbd4014438b901cc21dd693df005.1497002895.git.viresh.kumar@linaro.org>
 <CAJWu+ooKaGZ6rWYmSmE0Auii9QLROKA4rGwUHXEj2v4XB8hBcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36071 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbdFLDlM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jun 2017 23:41:12 -0400
Received: by mail-pg0-f48.google.com with SMTP id a70so40894138pge.3
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2017 20:41:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJWu+ooKaGZ6rWYmSmE0Auii9QLROKA4rGwUHXEj2v4XB8hBcQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, linaro-kernel@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Patrick Bellasi <patrick.bellasi@arm.com>, john.ettedgui@gmail.com, Morten Rasmussen <morten.rasmussen@arm.com>

On 10-06-17, 02:26, Joel Fernandes wrote:
> On Fri, Jun 9, 2017 at 3:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > When the schedutil governor calls cpufreq_driver_resolve_freq() for the
> > intel_pstate (in passive mode) driver, it simply returns the requested
> > frequency as there is no ->resolve_freq() callback provided.
> >
> > The result is that get_next_freq() doesn't get a chance to know the
> > frequency which will be set eventually and we can hit a potential
> > regression as explained in the following paragraph.
> >
> > For example, consider the possible range of frequencies as 900 MHz, 1
> > GHz, 1.1 GHz, and 1.2 GHz. If the current frequency is 1.1 GHz and the
> > next frequency (based on current utilization) is 1 GHz, then the
> > schedutil governor will try to set the average of these as the next
> > frequency (i.e. 1.05 GHz).
> >
> > Because we always try to find the lowest frequency greater than equal to
> > the target frequency, the intel_pstate driver will end up setting the
> > frequency as 1.1 GHz.
> >
> > Though the sg_policy->next_freq field gets updated with the average
> > frequency only. And so we will finally select the min frequency when the
> > next_freq is 1 more than the min frequency as the average then will be
> > equal to the min frequency. But that will also take lots of iterations
> > of the schedutil update callbacks.
> >
> > Fix that by providing a resolve_freq() callback.
> >
> > Tested on desktop with Intel Skylake processors.
> >
> > Fixes: 39b64aa1c007 ("cpufreq: schedutil: Reduce frequencies slower")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 029a93bfb558..e177352180c3 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2213,6 +2213,19 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
> >         return 0;
> >  }
> >
> > +unsigned int intel_cpufreq_resolve_freq(struct cpufreq_policy *policy,
> > +                                       unsigned int target_freq)
> 
> Should be defined as static?

Yes.

-- 
viresh

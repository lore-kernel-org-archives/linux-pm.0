From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Fix requested_freq handling
Date: Mon, 15 Oct 2018 11:34:33 +0200
Message-ID: <CAHKzcEPuD7nnmvBjnUNn=wb-5LfN1nHoTYBekAiBFG8Je+oPwA@mail.gmail.com>
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
 <CAJZ5v0j0GLHgKS9+mafm3eoFMuNEo6VPa3LhRthg+H5OKHhFqA@mail.gmail.com>
 <CAHKzcEMx2V-uvkM7_gUXiL1jEiYDwNn3KoGHqneqXAwmUQJ+0w@mail.gmail.com> <2671493.AgiGORq3CZ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2671493.AgiGORq3CZ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Bartholomae, Thomas" <t.bartholomae@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Oct 2018 at 23:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, October 9, 2018 6:06:08 PM CEST Waldemar Rymarkiewicz wrote:
> > On Tue, 9 Oct 2018 at 09:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Oct 8, 2018 at 5:11 PM Waldemar Rymarkiewicz
> > > <waldemar.rymarkiewicz@gmail.com> wrote:
> > > >
> > > > From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> > > >
> > > > The governor updates dbs_info->requested_freq only after increasing or
> > > > decreasing frequency. There is, however, an use case when this is not
> > > > sufficient.
> > > >
> > > > Imagine, external module constraining cpufreq policy in a way that policy->max
> > >
> > > Is the "external module" here a utility or a demon running in user space?
> >
> > No, this is a driver that communicates with a firmware and makes sure
> > CPU is running at the highest rate in specific time.
> > It uses verify_within_limits  and update_policy, a standard way to
> > constraint cpufreq policy limits.
> >
> > > > @@ -136,10 +135,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> > > >                         requested_freq = policy->min;
> > > >
> > > >                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
> > > > -               dbs_info->requested_freq = requested_freq;
> > > >         }
> > > >
> > > >   out:
> > > > +       dbs_info->requested_freq = requested_freq;
> > >
> > > This will have a side effect when requested_freq is updated before the
> > > thresholds checks due to the policy_dbs->idle_periods < UINT_MAX
> > > check.
> > >
> > > Shouldn't that be avoided?
> >
> > I would say we should.
> >
> > A hardware design I use is running 4.9 kernel where the check does not
> > exist yet, so there is not a problem.
> > Anyway, the check policy_dbs->idle_periods < UINT_MAX  can change
> > requested_freq  either to requested_freq = policy->min or
> > requested_freq -= freq_steps;. The first case will not change anything
> > for us as policy->max=min=cur. The second, however, will force to
> > update freq which is definitely not expected when limits are set to
> > min=max. Simply it will not go out  here:
> >
> > if (load < cs_tuners->down_threshold) {
> >       if (requested_freq == policy->min)
> >            goto out;   <---
> > ...
> > }
> >
> > Am I right here? If so, shouldn't we check explicitly
> >
> > /*
> > * If requested_freq is out of range, it is likely that the limits
> > * changed in the meantime, so fall back to current frequency in that
> > * case.
> > */
> > if (requested_freq > policy->max || requested_freq < policy->min)
> >        requested_freq = policy->cur;
> >
> > +/*
> > +* If the the new limits min,max are equal, there is no point to process further
> > +*/
> > +
> > +if (requested_freq == policy->max  &&  requested_freq == policy->min)
> > +     goto out;
>
> If my understanding of the problem is correct, it would be better to simply
> update dbs_info->requested_freq along with requested_freq when that is found
> to be out of range.  IOW, something like the appended patch (untested).

Yes, this will solve the original problem as well.

I think there could also be a  problem with policy_dbs->idle_periods <
UINT_MAX  check. It it's true it  can modify requested_freq (
requested_freq -= freq_steps) and further it can result in a change of
the freq,  requested_freq == policy->max is not anymore true. I would
expect governor not to change freq (requested_freq) when
policy->max=policy->min=policy->cur.

Thanks,
/Waldek

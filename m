From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Date: Fri, 6 Jul 2018 11:05:20 +0100
Message-ID: <20180706100520.GA11862@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <CAKfTPtCxt-O8uMOYgAjY7daujXwXyZQ-3BYe=DONL7R95T7nmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtCxt-O8uMOYgAjY7daujXwXyZQ-3BYe=DONL7R95T7nmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hi Vincent,

On Friday 06 Jul 2018 at 11:57:37 (+0200), Vincent Guittot wrote:
> On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> wrote:
> > +static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
> > +                               unsigned long max_util, unsigned long sum_util)
> > +{
> > +       struct em_cs_table *cs_table;
> > +       struct em_cap_state *cs;
> > +       unsigned long freq;
> > +       int i;
> > +
> > +       cs_table = rcu_dereference(fd->cs_table);
> > +       if (!cs_table)
> > +               return 0;
> > +
> > +       /* Map the utilization value to a frequency */
> > +       cs = &cs_table->state[cs_table->nr_cap_states - 1];
> > +       freq = map_util_freq(max_util, cs->frequency, cs->capacity);
> 
> The 2 lines above deserve more explanation:
> 1st, you get the max capacity of the freq domain
> Then, you estimate what will be the selected frequency according to
> the max_utilization.
> Might worth to mention that we must keep sync how sched_util and EM
> select a freq for a given capacity which is the reason of patch 02

Agreed, this could benefit from more explanations. I'll comment that
better in the next version.

> 
> > +
> > +       /* Find the lowest capacity state above this frequency */
> > +       for (i = 0; i < cs_table->nr_cap_states; i++) {
> > +               cs = &cs_table->state[i];
> > +               if (cs->frequency >= freq)
> > +                       break;
> > +       }
> > +
> > +       return cs->power * sum_util / cs->capacity;
> 
> IIUC the formula above, you consider that all CPUs in a frequency
> domain has the same capacity. This sounds a reasonable assumption but
> it would be good to write that somewhere

That's correct, we agreed on the assumption that CPUs in the same freq
domain must have the same micro-arch, and consequently the same capacity.

But you're right, that needs at the very least to be documented. Or even
better, I should check that when the EM is created and bail out with an
error message if that's not the case. That shouldn't be too hard to
implement, I think.

Thanks,
Quentin

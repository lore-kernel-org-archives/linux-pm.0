From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from
 menu_select()
Date: Thu, 4 Oct 2018 10:00:06 +0200
Message-ID: <20181004080006.GH19272@hirez.programming.kicks-ass.net>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <4130376.2FFt7p4687@aspire.rjw.lan>
 <20181004074627.GE19272@hirez.programming.kicks-ass.net>
 <CAJZ5v0gvAOz7R8uwXy=37ni=+dz9-gb69S2M2PtZSXc+tUhxrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gvAOz7R8uwXy=37ni=+dz9-gb69S2M2PtZSXc+tUhxrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 04, 2018 at 09:53:39AM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 4, 2018 at 9:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
> > >       idx = -1;
> > > -     for (i = first_idx; i < drv->state_count; i++) {
> > > +     for (i = 0; i < drv->state_count; i++) {
> > >               struct cpuidle_state *s = &drv->states[i];
> > >               struct cpuidle_state_usage *su = &dev->states_usage[i];
> > >
> > >               if (s->disabled || su->disable)
> > >                       continue;
> > > +
> > >               if (idx == -1)
> > >                       idx = i; /* first enabled state */
> > > +
> > >               if (s->target_residency > predicted_us) {
> > > +                     /*
> > > +                      * Use a physical idle state, not busy polling, unless
> > > +                      * a timer is going to trigger really really soon.
> > > +                      */
> > > +                     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> > > +                         i == idx + 1 && latency_req > s->exit_latency &&
> > > +                         data->next_timer_us > max_t(unsigned int, 20,
> > > +                                                     s->target_residency)) {
> >
> > Not new in this patch, but this is where I really noticed it; that 20,
> > should that not be something like: POLL_IDLE_TIME_LIMIT / NSEC_PER_USEC
> > ?
> 
> The POLL_IDLE_TIME_LIMIT is how much time we allow it to spin in
> idle_poll() and I'm not sure it is related.  Besides, I want it to go
> away actually (https://patchwork.kernel.org/patch/10624117/).

Ah, ok. Making it go away is better still!

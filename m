From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 5/5] PM / Domains: Propagate performance state updates
Date: Wed, 5 Dec 2018 18:29:14 +0100
Message-ID: <CAPDyKFoW=WnOu-0twwcaMprWiV8UzAOP8vQN5Pase_km58VXMA@mail.gmail.com>
References: <cover.1543219386.git.viresh.kumar@linaro.org> <5a29ceb2704239a8efb4db2e47ca155a422a6e57.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFpp1iPQ08QQjoi9b4RGUo2Zw_L_vjy8xtnSpg34gn--eA@mail.gmail.com>
 <20181130095912.7hutbsrihpg4gez4@vireshk-i7> <CAPDyKFocp63hUOYOJ3HUXBj2CcHZGXMQ6n873SmMSfpDhRjB7g@mail.gmail.com>
 <20181130110650.6ni2ft3wud7gn6jz@vireshk-i7> <CAPDyKFr_cG1if1Aozo+4hpQ6jY8sHD1wx91QCTwsnKcF5TwUhw@mail.gmail.com>
 <154399214662.88331.9095652690165763995@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154399214662.88331.9095652690165763995@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, grahamr@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Wed, 5 Dec 2018 at 07:42, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Ulf Hansson (2018-12-03 05:38:35)
> > + Stephen, Mike, Graham
> >
> > On Fri, 30 Nov 2018 at 12:06, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 30-11-18, 11:18, Ulf Hansson wrote:
> > There is one a big difference while comparing with clocks, which make
> > this more difficult.
> >
> > That is, in dev_pm_genpd_set_performance_state(), we are *not* calling
> > ->the set_performance_state() callback of the genpd, unless the genpd
> > is already powered on. Instead, for that case, we are only aggregating
> > the performance states votes, to defer to invoke
> > ->set_performance_state() until the genpd becomes powered on. In some
> > way this makes sense, but for clock_set_rate(), the clock's rate can
> > be changed, no matter if the clock has been prepared/enabled or not.
> >
> > I recall we discussed this behavior of genpd, while introducing the
> > performance states support to it. Reaching this point, introducing the
> > master-domain propagation of performance states votes, we may need to
> > re-consider the behavior, as there is evidently an overhead that grows
> > along with the hierarchy.
> >
> > As a matter of fact, what I think this boils to, is to consider if we
> > want to temporary drop the performance state vote for a device from
> > genpd's ->runtime_suspend() callback. Thus, also restore the vote from
> > genpd's ->runtime_resume() callback. That's because, this is directly
> > related to whether genpd should care about whether it's powered on or
> > off, when calling the ->set_performance_state(). We have had
> > discussions at LKML already around this topic. It seems like we need
> > to pick them up to reach a consensus, before we can move forward with
> > this.
>
> What are we trying to gain consensus on exactly?

Apologize for not being more clear. Let me re-phrase the question.

Should genpd (via genpd's internal runtime suspend callback) reset the
performance state for a device to zero, when that device becomes
runtime suspended?

Of course, if such reset is done, then genpd should also re-compute
the aggregation of the performance states for the corresponding PM
domain (and its master domains). Consequentially, these operations
then needs to be reversed, when the device in question becomes runtime
resumed.

>
> I've been thinking that we would want there to be a performance state
> 'target' for the 'devices are runtime suspended' state that we apply
> when the genpd is powered down from runtime PM suspend of all devices in
> the domain. This would then be overwritten with whatever the aggregated
> performance state is when the genpd is powered back on due to some
> device runtime resuming.

>From the above, I assume "target" to not always be zero. That confirms
my understanding from earlier discussions.

That is sort of what we already have today. The consumer driver are
free to change the performance state, via
dev_pm_genpd_set_performance_state() (or indirectly via
dev_pm_opp_set_rate()), for its device at any time. For example, it
may want to set a new performance state at runtime suspend.

> Don't we already sort of have support for this
> right now in genpd with commit fc5cbf0c94b6 ("PM / Domains: Support for
> multiple states")? So I would think that we either let that state_idx
> member be 0 or some implementation defined 'off' state index of the
> genpd that can be achieved.

Well, implementation details, but thanks for sharing your ideas.

> I was also thinking that the genpd_power_state was more than just a
> bunch of idle states of a device so that we could combine
> on/off/idle/active(performance states?) into one genpd_power_state
> space that is affected by idle and on/off runtime PM status.
>
> In the Qualcomm use-case, the state of the clk, either on or off, is
> factored into the decision to consider the voltage constraint that the
> clk has on the CX domain. So when the clk is disabled, the voltage
> constraint on CX can be removed/ignored in the aggregation equation
> because the hardware isn't clocking. This needs to work properly so that
> devices can disable their clks and save power.
>
> I hope that we can move clk on/off/rate control to be implemented with
> clk domains based upon genpds so that we can generically reason about
> genpds being on/off and at some performance state (i.e. a frequency)
> instead of making something clk specific in the genpd code. If we can do
> that, then this can be stated as a slave genpd (the clk domain) that's
> linked to a master genpd (the voltage/corner domain) can only affect the
> performance state requirement of the master genpd when the slave genpd
> is on. When the slave genpd is off, the performance state requirement is
> dropped and the master domain settles to a lower requirement based on
> the other domains linked to it that are on. The clk domain would turn on
> and off when the set of devices it is attached to are all suspended and
> that would "do the right thing" by bubbling up the requirements to the
> master domain this way.

This sounds to me, like there are reasons to keep the existing
behavior of genpd, thus leaving the performance state as is during
runtime suspend/resume.

But, on the other hand it also seems like a common case to reset the
performance state of a device to zero at runtime suspend. This leads
to that lots of boilerplate code needs to be added to driver's
->runtime_suspend|resume() callbacks, calling
dev_pm_genpd_set_performance_state() or dev_pm_opp_set_rate().

Maybe we should just wait and see what happens to consumer drivers, as
they starts deploying support for this.

Kind regards
Uffe

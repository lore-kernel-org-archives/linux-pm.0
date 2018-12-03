From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 5/5] PM / Domains: Propagate performance state updates
Date: Mon, 3 Dec 2018 14:38:35 +0100
Message-ID: <CAPDyKFr_cG1if1Aozo+4hpQ6jY8sHD1wx91QCTwsnKcF5TwUhw@mail.gmail.com>
References: <cover.1543219386.git.viresh.kumar@linaro.org> <5a29ceb2704239a8efb4db2e47ca155a422a6e57.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFpp1iPQ08QQjoi9b4RGUo2Zw_L_vjy8xtnSpg34gn--eA@mail.gmail.com>
 <20181130095912.7hutbsrihpg4gez4@vireshk-i7> <CAPDyKFocp63hUOYOJ3HUXBj2CcHZGXMQ6n873SmMSfpDhRjB7g@mail.gmail.com>
 <20181130110650.6ni2ft3wud7gn6jz@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130110650.6ni2ft3wud7gn6jz@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Mike Turquette <mturquette@baylibre.com>, grahamr@codeaurora.org
List-Id: linux-pm@vger.kernel.org

+ Stephen, Mike, Graham

On Fri, 30 Nov 2018 at 12:06, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-11-18, 11:18, Ulf Hansson wrote:
> > On Fri, 30 Nov 2018 at 10:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > Sure, but the ordering of locks is always subdomain first and then master.
> > > Considering the case of Qcom, we have two domains Cx (sub-domain) and Mx (master).
> > >
> > > On first genpd_power_on(Cx) call, we will first call genpd_power_on(Mx) which
> > > will just power it on as none of its master will have perf-state support. We
> > > then call _genpd_power_on(Cx) which will also not do anything with Mx as its own
> > > (Cx's) pstate would be 0 at that time. But even if it had a valid value, it will
> > > propagate just fine with all proper locking in place.
> >
> > Can you explain that, it's not super easy to follow the flow.
>
> Sorry, I somehow assumed you would know it already :)
>
> > So what will happen if Cx has a value that needs to be propagated?
> > What locks will be taken, and in what order?
> >
> > Following, what if we had a Bx domain, being the subdomain of Cx, and
> > it too had a value that needs to be propagated.
>
> Lets take the worst example, we have Bx (sub-domain of Cx), Cx (sub-domain of
> Mx) and Dx (master). Normal power-on/off will always have the values 0, so lets
> consider resume sequence where all the domains will have a value pstate value.
> And please forgive me for any bugs I have introduced in the following
> super-complex sequence :)
>
> genpd_runtime_resume(dev) //domain Bx
>     -> genpd_lock(Bx)
>     -> genpd_power_on(Bx)
>
>         -> genpd_lock(Cx)
>         -> genpd_power_on(Cx)
>
>             -> genpd_lock(Dx)
>             -> genpd_power_on(Dx)
>
>                 -> _genpd_power_on(Dx)
>                     -> _genpd_set_performance_state(Dx, Dxstate) {
>                         //Doesn't have any masters
>                         -> genpd->set_performance_state(Dx, Dxstate);
>                     }
>
>             -> genpd_unlock(Dx)
>
>             -> _genpd_power_on(Cx)
>                 -> _genpd_set_performance_state(Cx, Cxstate) {
>                     //have one master, Dx
>                     -> genpd_lock(Dx)
>                         -> _genpd_set_performance_state(Dx, Dxstate) {
>                             //Doesn't have any masters
>                             -> genpd->set_performance_state(Dx, Dxstate);
>                         }
>
>                     -> genpd_unlock(Dx)
>
>                     // Change Cx state
>                     -> genpd->set_performance_state(Cx, Cxstate);
>                 }
>
>         -> genpd_unlock(Cx)
>
>         -> _genpd_power_on(Bx)
>             -> _genpd_set_performance_state(Bx, Bxstate) {
>                 //have one master, Cx
>                 -> genpd_lock(Cx)
>                 -> _genpd_set_performance_state(Cx, Cxstate) {
>                     //have one master, Dx
>                     -> genpd_lock(Dx)
>                         -> _genpd_set_performance_state(Dx, Dxstate) {
>                             //Doesn't have any masters
>                             -> genpd->set_performance_state(Dx, Dxstate);
>                         }
>
>                     -> genpd_unlock(Dx)
>
>                     // Change Cx state
>                     -> genpd->set_performance_state(Cx, Cxstate);
>                 }
>                 -> genpd_unlock(Cx)
>
>                 -> genpd->set_performance_state(Bx, Bxstate);
>             }
>
>     -> genpd_unlock(Bx)
>
>

Thanks for clarifying. This confirms my worries about the locking overhead.

>
> > It sounds like we will
> > do the propagation one time per level. Is that really necessary,
> > couldn't we just do it once, after the power on sequence have been
> > completed?
>
> It will be a BIG hack somewhere, isn't it ? How will we know when has the time
> come to shoot the final sequence of set_performance_state() ? And where will we
> do it? genpd_runtime_resume() ? And then we will have more problems, for example
> Rajendra earlier compared this stuff to clk framework where it is possible to do
> clk_set_rate() first and then only call clk_enable() and the same should be
> possible with genpd as well, i.e. set performance state first and then only
> enable the device/domain. And so we need this right within genpd_power_on().

There is one a big difference while comparing with clocks, which make
this more difficult.

That is, in dev_pm_genpd_set_performance_state(), we are *not* calling
->the set_performance_state() callback of the genpd, unless the genpd
is already powered on. Instead, for that case, we are only aggregating
the performance states votes, to defer to invoke
->set_performance_state() until the genpd becomes powered on. In some
way this makes sense, but for clock_set_rate(), the clock's rate can
be changed, no matter if the clock has been prepared/enabled or not.

I recall we discussed this behavior of genpd, while introducing the
performance states support to it. Reaching this point, introducing the
master-domain propagation of performance states votes, we may need to
re-consider the behavior, as there is evidently an overhead that grows
along with the hierarchy.

As a matter of fact, what I think this boils to, is to consider if we
want to temporary drop the performance state vote for a device from
genpd's ->runtime_suspend() callback. Thus, also restore the vote from
genpd's ->runtime_resume() callback. That's because, this is directly
related to whether genpd should care about whether it's powered on or
off, when calling the ->set_performance_state(). We have had
discussions at LKML already around this topic. It seems like we need
to pick them up to reach a consensus, before we can move forward with
this.

>
> I know things are repetitive here, but that's the right way of doing it IMHO.
> What do you say ?

As this point, honestly I don't know yet.

I have looped in Stephen, Mike and Graham, let's see if they have some
thoughts on the topic.

Kind regards
Uffe

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Date: Fri, 4 Jan 2019 15:46:01 +0530
Message-ID: <20190104101601.mpo4vpfcvsfauk2u@vireshk-i7>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
 <CAJZ5v0g4ABiPGGeLuzLN=1cT+7ejUP5hCgoN3_nhvr=Foaxa6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4ABiPGGeLuzLN=1cT+7ejUP5hCgoN3_nhvr=Foaxa6Q@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Douglas.Raillard@arm.com, "4 . 20" <stable@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04-01-19, 11:10, Rafael J. Wysocki wrote:
> On Fri, Jan 4, 2019 at 10:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> > _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> > automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
> > affects the scpi and scmi cpufreq drivers which no longer free OPPs on
> > failures or on invocations of the policy->exit() callback.
> >
> > Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
> > called from these drivers instead of dev_pm_opp_cpumask_remove_table().
> >
> > In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
> > opp_list isn't getting accessed simultaneously from other parts of the
> > OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
> > the opp_table->lock while traversing through the OPP list. And to
> > accomplish that, this patch also creates _opp_kref_release_unlocked()
> > which can be called from this new helper with the opp_table lock already
> > held.
> >
> > Cc: 4.20 <stable@vger.kernel.org> # v4.20
> > Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> > Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I guess I'll pick it up by hand.

Sure.

> I'm assuming that you have tested it, have you?

Yes, but I had to fake few dynamic OPPs and ignore the static ones
coming from DT. Lets wait for Sudeep or Valentin to test this, who
have real hardware to fix with this patch.

-- 
viresh

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Date: Fri, 11 Jan 2019 11:37:57 +0100
Message-ID: <13587320.TAQQ9Zc4eI@aspire.rjw.lan>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com> <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org> <20190104110142.GA28483@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190104110142.GA28483@e107155-lin>
Sender: stable-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, quentin.perret@arm.com, dietmar.eggemann@arm.com, Douglas.Raillard@arm.com, "4 . 20" <stable@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, January 4, 2019 12:01:42 PM CET Sudeep Holla wrote:
> On Fri, Jan 04, 2019 at 03:14:33PM +0530, Viresh Kumar wrote:
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
> 
> I did test it but since I couldn't reproduce the original issue, my
> tested-by is not that worth. Anyways the changes look fine to me.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied and pushed to Linus, thanks!

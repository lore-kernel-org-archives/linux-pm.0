From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Date: Fri, 4 Jan 2019 10:40:07 +0000
Message-ID: <96b57b5b-7c6f-2118-05a0-8a568d7cb245@arm.com>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, quentin.perret@arm.com, dietmar.eggemann@arm.com, Douglas.Raillard@arm.com, "4 . 20" <stable@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 04/01/2019 09:44, Viresh Kumar wrote:
> Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
> affects the scpi and scmi cpufreq drivers which no longer free OPPs on
> failures or on invocations of the policy->exit() callback.
> 
> Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
> called from these drivers instead of dev_pm_opp_cpumask_remove_table().
> 
> In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
> opp_list isn't getting accessed simultaneously from other parts of the
> OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
> the opp_table->lock while traversing through the OPP list. And to
> accomplish that, this patch also creates _opp_kref_release_unlocked()
> which can be called from this new helper with the opp_table lock already
> held.
> 
> Cc: 4.20 <stable@vger.kernel.org> # v4.20
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Gave it a spin on my Juno, and I don't see the refcount warning anymore so:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks for having a look at this.

[...]

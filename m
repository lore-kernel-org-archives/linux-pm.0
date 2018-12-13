From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH V3 0/6] PM / Domains: Allow performance state propagation
Date: Thu, 13 Dec 2018 10:13:57 +0530
Message-ID: <98df6bc6-4455-87d3-a8b6-493b1c4d7960@codeaurora.org>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 12/12/2018 4:27 PM, Viresh Kumar wrote:
> Hi,
> 
> This series adds performance state propagation support in genpd core.
> The propagation happens from the sub-domains to their masters. More
> details can be found in the individual commit logs.
> 
> This is tested on hikey960 by faking power domains in such a way that
> the CPU devices have two power domains and both of them have the same
> master domain. The CPU device, as well as its power domains have
> "required-opps" property set and the performance requirement from the
> CPU eventually configures all the domains (2 sub-domains and 1 master).
> 
> Based on opp/linux-next branch (which is 4.20-rc1 +
> multiple-power-domain-support-in-opp-core + some OPP fixes).
> 
> Rajendra has already tested the previous version of this series and so I
> have included his Tested-by for all patches.

I also tested this on top of my v7 [1] of rpm power domain series and things
continue to work as expected for the cx/mx propagation so I am fine with my
Tested-by on all the patches.

[1] https://lkml.org/lkml/2018/12/12/174

> 
> V2->V3:
> - Include Ulf's patch (sent separately earlier) with this series.
> - The performance state update code doesn't rely anymore on the power
>    on/off state of the genpd, it sets and propagates rate in all cases.
> - That simplified a lot of code from V2 in _genpd_power_on().
> - commit logs improved for few commits.
> - s/mstate/master_state/
> - and few more minor changes.
> 
> v1->V2:
> - First patch (1/5) is new and an improvement to earlier stuff.
> - Move genpd_status_on() check to _genpd_reeval_performance_state() from
>    _genpd_set_performance_state().
> - Improve dev_pm_opp_xlate_performance_state() to handle 1:1 pstate
>    mapping between genpd and its master and also to fix a problem while
>    finding the dst_table.
> - Handle pstate=0 case properly.
> 
> --
> viresh
> 
> Ulf Hansson (1):
>    PM / Domains: Make genpd performance states orthogonal to the
>      idlestates
> 
> Viresh Kumar (5):
>    OPP: Improve _find_table_of_opp_np()
>    OPP: Add dev_pm_opp_xlate_performance_state() helper
>    PM / Domains: Save OPP table pointer in genpd
>    PM / Domains: Factorize dev_pm_genpd_set_performance_state()
>    PM / Domains: Propagate performance state updates
> 
>   drivers/base/power/domain.c | 207 ++++++++++++++++++++++++++----------
>   drivers/opp/core.c          |  59 ++++++++++
>   drivers/opp/of.c            |  14 ++-
>   include/linux/pm_domain.h   |   6 ++
>   include/linux/pm_opp.h      |   7 ++
>   5 files changed, 235 insertions(+), 58 deletions(-)
> 

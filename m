From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH V2 0/5] PM / Domains: Allow performance state propagation
Date: Tue, 27 Nov 2018 10:20:43 +0530
Message-ID: <65f1e1c8-8227-33f2-6938-8da5c7f0e250@codeaurora.org>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 11/26/2018 1:39 PM, Viresh Kumar wrote:
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

I validated this using the rpmh powerdomain driver [1] where I had to model
a relationship across cx and mx powerdomains, so that mx is always >= cx.
Seems to work as expected, I will respin the rpmh powerdomain patches soon
(Though its awaiting Rob's review/ack for the corner bindings)

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>

[1] https://patchwork.ozlabs.org/cover/935289/

> 
> Based on opp/linux-next branch (which is 4.20-rc1 +
> multiple-power-domain-support-in-opp-core + some OPP fixes).
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
> Viresh Kumar (5):
>    OPP: Improve _find_table_of_opp_np()
>    OPP: Add dev_pm_opp_xlate_performance_state() helper
>    PM / Domains: Save OPP table pointer in genpd
>    PM / Domains: Factorize dev_pm_genpd_set_performance_state()
>    PM / Domains: Propagate performance state updates
> 
>   drivers/base/power/domain.c | 211 +++++++++++++++++++++++++++---------
>   drivers/opp/core.c          |  59 ++++++++++
>   drivers/opp/of.c            |  14 ++-
>   include/linux/pm_domain.h   |   6 +
>   include/linux/pm_opp.h      |   7 ++
>   5 files changed, 244 insertions(+), 53 deletions(-)
> 

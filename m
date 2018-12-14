From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/7] PM / Domains: Allow performance state propagation
Date: Fri, 14 Dec 2018 15:45:26 +0530
Message-ID: <cover.1544782279.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, rnayak@codeaurora.org, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

This series adds performance state propagation support in genpd core.
The propagation happens from the sub-domains to their masters. More
details can be found in the individual commit logs.

This is tested on hikey960 by faking power domains in such a way that
the CPU devices have two power domains and both of them have the same
master domain. The CPU device, as well as its power domains have
"required-opps" property set and the performance requirement from the
CPU eventually configures all the domains (2 sub-domains and 1 master).

Based on opp/linux-next branch (which is 4.20-rc1 +
multiple-power-domain-support-in-opp-core + some OPP fixes).

Rajendra has already tested the previous version of this series and so I
have included his Tested-by for all patches.

V3->V4:
- dev_pm_opp_xlate_performance_state() returns negative values on error
  now.
- of_get_required_opp_performance_state() is also updated to do the
  same.
- _genpd_set_performance_state() is not called anymore from
  _genpd_reeval_performance_state() and we get rid of the extra
  declaration.
- Improved commit log in the last patch.
- dropped an unlikely.

V2->V3:
- Include Ulf's patch (sent separately earlier) with this series.
- The performance state update code doesn't rely anymore on the power
  on/off state of the genpd, it sets and propagates rate in all cases.
- That simplified a lot of code from V2 in _genpd_power_on().
- commit logs improved for few commits.
- s/mstate/master_state/
- and few more minor changes.

v1->V2:
- First patch (1/5) is new and an improvement to earlier stuff.
- Move genpd_status_on() check to _genpd_reeval_performance_state() from
  _genpd_set_performance_state().
- Improve dev_pm_opp_xlate_performance_state() to handle 1:1 pstate
  mapping between genpd and its master and also to fix a problem while
  finding the dst_table.
- Handle pstate=0 case properly.

--
viresh

Ulf Hansson (1):
  PM / Domains: Make genpd performance states orthogonal to the
    idlestates

Viresh Kumar (6):
  OPP: Improve _find_table_of_opp_np()
  OPP: Add dev_pm_opp_xlate_performance_state() helper
  OPP: Don't return 0 on error from
    of_get_required_opp_performance_state()
  PM / Domains: Save OPP table pointer in genpd
  PM / Domains: Factorize dev_pm_genpd_set_performance_state()
  PM / Domains: Propagate performance state updates

 drivers/base/power/domain.c | 202 ++++++++++++++++++++++++++----------
 drivers/opp/core.c          |  63 +++++++++++
 drivers/opp/of.c            |  24 +++--
 include/linux/pm_domain.h   |   6 ++
 include/linux/pm_opp.h      |  13 ++-
 5 files changed, 242 insertions(+), 66 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

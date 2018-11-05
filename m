From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/4] PM / Domains: Allow performance state propagation
Date: Mon,  5 Nov 2018 12:06:42 +0530
Message-ID: <cover.1541399301.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, rnayak@codeaurora.org, linux-kernel@vger.kernel.org
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

@Rajendra: Will it be possible for you to run some tests and tell me if
some stuff is still missing as per Qcom requirements ?

Based on opp/linux-next branch (which is 4.20-rc1 +
multiple-power-domain-support-in-opp-core).

--
viresh

Viresh Kumar (4):
  OPP: Add dev_pm_opp_xlate_performance_state() helper
  PM / Domains: Save OPP table pointer in genpd
  PM / Domains: Factorize dev_pm_genpd_set_performance_state()
  PM / Domains: Propagate performance state updates

 drivers/base/power/domain.c | 204 +++++++++++++++++++++++++++---------
 drivers/opp/core.c          |  49 +++++++++
 include/linux/pm_domain.h   |   6 ++
 include/linux/pm_opp.h      |   7 ++
 4 files changed, 217 insertions(+), 49 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

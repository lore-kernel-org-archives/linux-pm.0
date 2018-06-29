From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/10] OPP: Support multiple power-domains per device
Date: Fri, 29 Jun 2018 11:49:30 +0530
Message-ID: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

This series improves the OPP core (and a bit of genpd core as well) to
support multiple phandles in the "required-opps" property, which are
only used for multiple power-domains per device for now.

We still don't propagate the changes to master domains for the
sub-domains, but this patchset is an important stepping stone for that
to happen.

Tested on Hikey960 after faking some power domains for CPUs.

--
viresh

Viresh Kumar (10):
  OPP: Parse OPP table's DT properties from _of_init_opp_table()
  OPP: Identify and mark genpd OPP tables
  OPP: Separate out custom OPP handler specific code
  OPP: Populate required opp tables from "required-opps" property
  OPP: Populate OPPs from "required-opps" property
  OPP: Add dev_pm_opp_{set|put}_required_device() helper
  PM / Domains: Add genpd_opp_to_performance_state()
  OPP: Configure all required OPPs
  OPP: Rename and relocate of_genpd_opp_to_performance_state()
  OPP: Remove of_dev_pm_opp_find_required_opp()

 drivers/base/power/domain.c |  82 ++++----
 drivers/opp/core.c          | 228 ++++++++++++++-------
 drivers/opp/of.c            | 382 ++++++++++++++++++++++++++++++------
 drivers/opp/opp.h           |  18 ++
 include/linux/pm_domain.h   |   7 +-
 include/linux/pm_opp.h      |  16 +-
 6 files changed, 557 insertions(+), 176 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c

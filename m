From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/9] OPP: Support multiple power-domains per device
Date: Fri, 12 Oct 2018 16:41:08 +0530
Message-ID: <cover.1539341929.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, rnayak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

We are already at 4.19-rc7 and there may not enough time to get this
reviewed/tested/ready for the upcoming merge window and so there is no
hurry in getting this merged. The purpose to send now is to get this
reviewed/tested, which would allow more more development to happen on
top of this.

This series improves the OPP core (and a bit of genpd core as well) to
support multiple phandles in the "required-opps" property, which are
only used for multiple power-domains per device for now.

We still don't propagate the changes to master domains for the
sub-domains, but this patchset is an important stepping stone for that
to happen.

Tested on Hikey960 after faking some power domains for CPUs.

V1->V2:
- Had a discussion at Linaro connect with Ulf regarding the changes V1
  did in the genpd core and what his objections are to them. Based on
  his suggestions many changes are made.
- The OPP core still needs the virtual device pointers to set the
  performance state for multiple domains, but the genpd core doesn't
  provide them automatically to the OPP core. One of the reasons behind
  this is to give more power to the consumer drivers which may not want
  to enable all the genpds at once.
- The consumer drivers would now need to call the APIs
  dev_pm_opp_{set|put}_genpd_device() in order to set/reset these
  virtual device pointers.
- More locking is put in place to protect the genpd device pointers in
  OPP core.
- Reorg of the code at many places to make code less redundant.

--
viresh
 
Viresh Kumar (9):
  OPP: Identify and mark genpd OPP tables
  OPP: Separate out custom OPP handler specific code
  OPP: Populate required opp tables from "required-opps" property
  OPP: Populate OPPs from "required-opps" property
  PM / Domains: Add genpd_opp_to_performance_state()
  OPP: Add dev_pm_opp_{set|put}_genpd_device() helper
  OPP: Configure all required OPPs
  OPP: Rename and relocate of_genpd_opp_to_performance_state()
  OPP: Remove of_dev_pm_opp_find_required_opp()

 drivers/base/power/domain.c |  51 +++---
 drivers/opp/core.c          | 261 ++++++++++++++++++++++--------
 drivers/opp/of.c            | 313 +++++++++++++++++++++++++++++++-----
 drivers/opp/opp.h           |  20 +++
 include/linux/pm_domain.h   |   7 +-
 include/linux/pm_opp.h      |  16 +-
 6 files changed, 519 insertions(+), 149 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c

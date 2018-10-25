From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 00/10] OPP: Support multiple power-domains per device
Date: Thu, 25 Oct 2018 11:22:37 +0530
Message-ID: <cover.1540446493.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, rnayak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

This series improves the OPP core (and a bit of genpd core as well) to
support multiple phandles in the "required-opps" property, which are
only used for multiple power-domains per device for now.

We still don't propagate the changes to master domains for the
sub-domains, but this patchset is an important stepping stone for that
to happen.

Tested on Hikey960 after faking some power domains for CPUs.

V2->V3:
- Gained an additional patch to properly name the virtual device (1/10)
- Renamed the virtual device as virt_dev instead of genpd_dev.
- Few helpers renamed as well accordingly.
- Use container_of() instead of traversing list of genpd.
- Included tags received from Ulf.

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

Viresh Kumar (10):
  PM / Domains: Rename genpd virtual devices as virt_dev
  OPP: Identify and mark genpd OPP tables
  OPP: Separate out custom OPP handler specific code
  OPP: Populate required opp tables from "required-opps" property
  OPP: Populate OPPs from "required-opps" property
  PM / Domains: Add genpd_opp_to_performance_state()
  OPP: Add dev_pm_opp_{set|put}_genpd_virt_dev() helper
  OPP: Configure all required OPPs
  OPP: Rename and relocate of_genpd_opp_to_performance_state()
  OPP: Remove of_dev_pm_opp_find_required_opp()

 drivers/base/power/domain.c |  70 ++++----
 drivers/opp/core.c          | 261 ++++++++++++++++++++++--------
 drivers/opp/of.c            | 313 +++++++++++++++++++++++++++++++-----
 drivers/opp/opp.h           |  20 +++
 include/linux/pm_domain.h   |   8 +-
 include/linux/pm_opp.h      |  16 +-
 6 files changed, 526 insertions(+), 162 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

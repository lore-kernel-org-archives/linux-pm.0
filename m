From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/7] PM /Domain/OPP: Add support to get performance state from DT
Date: Fri, 22 Dec 2017 12:56:24 +0530
Message-ID: <cover.1513926033.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34813 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLVHaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 02:30:11 -0500
Received: by mail-pf0-f194.google.com with SMTP id a90so15010278pfk.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2017 23:30:10 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org

Hi,

Now that the DT bindings [1] are already Reviewed/Acked by respective
maintainers, here is the code to start using them.

The first two patches provide helpers in the OPP core, [3-5]/7 update
the PM domain core to start supporting domain OPP tables, etc, 6/7
updates the OPP core to use the new callback provided by the PM domains
to get performance state and the last one removes the unused helpers
now.

This is tested on Hikey620 and works just fine.

--
viresh

[1] https://lkml.kernel.org/r/cover.1513591822.git.viresh.kumar@linaro.org

Viresh Kumar (7):
  PM / OPP: Implement dev_pm_opp_of_add_table_indexed()
  PM / OPP: Implement of_dev_pm_opp_find_required_opp()
  PM / Domain: Add struct device to genpd
  PM / Domain: Add support to parse domain's OPP table
  PM / Domain: Implement of_dev_pm_genpd_get_performance_state()
  PM / OPP: Get performance state using genpd helper
  PM / OPP: Remove dev_pm_opp_{un}register_get_pstate_helper()

 drivers/base/power/domain.c | 159 ++++++++++++++++++++++++++++++++++++++++----
 drivers/opp/core.c          |  82 +----------------------
 drivers/opp/of.c            | 123 +++++++++++++++++++++++++++++++---
 drivers/opp/opp.h           |   3 +-
 include/linux/pm_domain.h   |  12 ++++
 include/linux/pm_opp.h      |  22 +++---
 6 files changed, 284 insertions(+), 117 deletions(-)

-- 
2.15.0.194.g9af6a3dea062

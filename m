From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH 0/2] thermal, OPP: move the CPU power estimation to the OPP library
Date: Tue,  9 Jan 2018 11:02:50 +0000
Message-ID: <20180109110252.13557-1-quentin.perret@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755444AbeAILDA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jan 2018 06:03:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

Currently, IPA estimates the power dissipated by a CPU at each available OPP
using its capacitance (the dynamic-power-coefficient DT binding). This series
relocates this feature into the OPP library as a preparation for future
changes. More specifically:

   1. The current DT-based approach for power estimation will need deep
      changes to support SCMI-provided power values. While the thermal
      subsystem is not necessarily the best place to hide multiple power
      estimation methods, the OPP library appears to be a good candidate to
      implement the required platform abstraction.
   2. The energy models of CPUs will be needed by other clients in the future
      (such as the task scheduler or CPUFreq governors for example) in order
      to make energy-aware decisions. The relocation to the OPP library will
      enable code re-use and all clients will benefit form the platform
      abstraction mentioned previously.

Quentin Perret (2):
  PM / OPP: introduce an OPP power estimation helper
  thermal: cpu_cooling: use power models from the OPP library

 drivers/cpufreq/arm_big_little.c   |  2 ++
 drivers/cpufreq/cpufreq-dt.c       |  2 ++
 drivers/cpufreq/mediatek-cpufreq.c |  2 ++
 drivers/opp/core.c                 | 40 +++++++++++++++++++++++++
 drivers/opp/of.c                   | 61 ++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h                  |  4 +++
 drivers/thermal/cpu_cooling.c      | 33 ++++++---------------
 include/linux/pm_opp.h             | 20 +++++++++++++
 8 files changed, 140 insertions(+), 24 deletions(-)

-- 
2.15.1

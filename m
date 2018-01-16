From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2 0/2] thermal, OPP: move the CPU power estimation to the OPP library
Date: Tue, 16 Jan 2018 16:51:17 +0000
Message-ID: <20180116165119.15168-1-quentin.perret@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbeAPQvl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jan 2018 11:51:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com, joelaf@google.com, tkjos@google.com, Quentin Perret <quentin.perret@arm.com>

Hi,

Currently, IPA estimates the power dissipated by a CPU at each available OPP
using its capacitance (the dynamic-power-coefficient DT binding). This series
relocates this per-OPP power model in the OPP core as a preparation for
future changes. More specifically:

   1. The current DT-based approach for power estimation will need deep
      changes to support SCMI-provided power values. While the thermal
      subsystem is not necessarily the best place to hide multiple power
      estimation methods, the OPP library appears to be a good candidate to
      implement the required platform abstraction and respect the existing
      design (the thermal subsystem already relies on the OPP library to
      provide voltages no matter where they come from -- DT or SCPI).

   2. The energy models of CPUs will be needed by other clients in the future
      (such as the task scheduler or CPUFreq governors for example) in order
      to make energy-aware decisions. The relocation to the OPP library will
      enable code re-use and all clients will benefit form the platform
      abstraction mentioned previously.

As mentionned during the review of V1, this series will have a chance to get
merged only when the clients (the scheduler, or the SCMI driver) depending
on it are ready to be merged as well. This V2 is here for reference and
addresses the main changes requested on the V1.

Changes in v2:
 - Changed the OPP power estimation to be done upon OPP creation (V. Kumar)
 - Updated the cover letter to motivate the choice of PM OPP (E. Valentin)

Quentin Perret (2):
  PM / OPP: introduce an OPP power estimation helper
  thermal: cpu_cooling: use power models from the OPP library

 drivers/opp/core.c            | 63 +++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/of.c              | 13 ++++++---
 drivers/opp/opp.h             |  5 ++++
 drivers/thermal/cpu_cooling.c | 33 +++++++----------------
 include/linux/pm_opp.h        | 14 ++++++++++
 5 files changed, 100 insertions(+), 28 deletions(-)

-- 
2.15.1

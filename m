From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3][v3] Fix thermal problems during suspend/bootup
Date: Fri, 30 Oct 2015 16:31:31 +0800
Message-ID: <cover.1446192980.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: javi.merino@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

This patch set fixes two problems when system is trying to
suspend and boot up:
1.After system is woken up from suspend, the thermal framework uses
  the dirty 'cached' thermal variables before suspend, which might
  cause expected behavior.
2.If a cooling device is registered after the thermal zone's registration,
  current thermal framework forgets to update the thermal_zone's status,
  which might bring expected behavior under special cases.

Chen Yu (3):
  Thermal: initialize thermal zone device correctly
  Thermal: handle thermal zone device properly during system sleep
  Thermal: do thermal zone update after a cooling device registered

 drivers/thermal/step_wise.c    | 17 ++++++++--
 drivers/thermal/thermal_core.c | 75 ++++++++++++++++++++++++++++++++++++++++--
 drivers/thermal/thermal_core.h |  1 +
 include/linux/thermal.h        |  5 +++
 4 files changed, 93 insertions(+), 5 deletions(-)

-- 
1.8.4.2

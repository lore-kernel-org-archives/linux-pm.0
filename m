From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3] Thermal: Fix thermal zone update problems during bootup/suspend
Date: Sun, 27 Sep 2015 13:48:18 +0800
Message-ID: <1443332898-13908-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38623 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbbI0FpU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 27 Sep 2015 01:45:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com, javi.merino@arm.com
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org

This patch set is to fix a series of thermal issues during system
bootup and suspend/resume. Two major reasons for these bugs are:
1.thermal core is unaware of suspending process, and uses the invalid
  value cached after resuming, which brings the problems.
  (PATCH 1/3 and 2/3]
2.thermal core forgets to update the device's status in some situations,
  this may lead to unexpected behavior after system bootup.
  [PATCH 3/3]

Please refer to:
https://bugzilla.kernel.org/show_bug.cgi?id=78201
for why these patches are proposed.

Chen Yu (3):
  Thermal: initialize thermal zone device correctly
  Thermal: handle thermal zone device properly during system sleep
  Thermal: do thermal zone update after a cooling device registered

 drivers/thermal/step_wise.c    | 18 +++++++++--
 drivers/thermal/thermal_core.c | 68 ++++++++++++++++++++++++++++++++++++++++--
 drivers/thermal/thermal_core.h |  1 +
 include/linux/thermal.h        |  3 ++
 4 files changed, 86 insertions(+), 4 deletions(-)

-- 
1.8.4.2


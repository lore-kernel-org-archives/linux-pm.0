From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3][v2] Fix thermal problems during suspend/bootup
Date: Mon, 26 Oct 2015 11:12:29 +0800
Message-ID: <cover.1445828170.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19392 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbbJZDLU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 25 Oct 2015 23:11:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, javi.merino@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

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

 drivers/thermal/step_wise.c    | 17 +++++++--
 drivers/thermal/thermal_core.c | 78 +++++++++++++++++++++++++++++++++++++++---
 drivers/thermal/thermal_core.h |  1 +
 include/linux/thermal.h        |  4 +++
 4 files changed, 94 insertions(+), 6 deletions(-)

-- 
1.8.4.2


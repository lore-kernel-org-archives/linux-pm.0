From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [UPDATE v7 3/3] pm/powerclamp: fix type check warnings
Date: Fri, 18 Jan 2013 01:30:05 -0800
Message-ID: <1358501405-3718-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30879 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab3ARRa2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Jan 2013 12:30:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Sparse reports the following warning due to incorrect types.

drivers/thermal/intel_powerclamp.c:516:25: warning: incorrect type in initializer (different address spaces)
drivers/thermal/intel_powerclamp.c:516:25:    expected void const [noderef] <asn:3>*__vpp_verify
drivers/thermal/intel_powerclamp.c:516:25:    got struct task_struct [noderef] <asn:3>**<noident>
drivers/thermal/intel_powerclamp.c:516:25: warning: incorrect type in initializer (different address spaces)
drivers/thermal/intel_powerclamp.c:516:25:    expected struct task_struct **p
drivers/thermal/intel_powerclamp.c:516:25:    got struct task_struct [noderef] <asn:3>**<noident>

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 81ebf87..33edf5d 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -86,7 +86,7 @@ static unsigned int control_cpu; /* The cpu assigned to collect stat and update
 static bool clamping;
 
 
-static struct task_struct __percpu **powerclamp_thread;
+static struct task_struct * __percpu *powerclamp_thread;
 static struct thermal_cooling_device *cooling_dev;
 static unsigned long *cpu_clamping_mask;  /* bit map for tracking per cpu
 					   * clamping thread
-- 
1.7.9.5


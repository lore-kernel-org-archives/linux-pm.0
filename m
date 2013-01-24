From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] PM: intel_powerclamp: off by one in start_power_clamp()
Date: Thu, 24 Jan 2013 11:51:22 +0300
Message-ID: <20130124085122.GA3547@elgon.mountain>
References: <5100ee96.xoiaCavCYxXgoSIK%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26493 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab3AXIvg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jan 2013 03:51:36 -0500
Content-Disposition: inline
In-Reply-To: <5100ee96.xoiaCavCYxXgoSIK%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>, kernel-janitors@vger.kernel.org

This value has already been clamped correctly to 0 through 49 in
powerclamp_set_cur_state() so this patch doesn't actually change
anything.  But we should fix it anyway for consistency.

set_target_ratio is used as an offset into an array with
MAX_TARGET_RATIO (50) elements.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index a85ff38..ab3ed90 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -504,7 +504,7 @@ static int start_power_clamp(void)
 		return -EINVAL;
 	}
 
-	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO);
+	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
 	/* prevent cpu hotplug */
 	get_online_cpus();
 

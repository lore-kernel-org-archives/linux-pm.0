From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH] thermal: pch_dev_ops_wpt can be static
Date: Tue, 4 Aug 2015 08:09:47 +0800
Message-ID: <20150804000947.GA22892@wfg-t540p.sh.intel.com>
References: <201508040110.6YvwEgCw%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19247 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbbHDAK2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 20:10:28 -0400
Content-Disposition: inline
In-Reply-To: <201508040110.6YvwEgCw%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Tushar Dave <tushar.n.dave@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 intel_pch_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index d9e07fd..a1393e1 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -137,7 +137,7 @@ struct pch_dev_ops {
 
 
 /* dev ops for Wildcat Point */
-struct pch_dev_ops pch_dev_ops_wpt = {
+static struct pch_dev_ops pch_dev_ops_wpt = {
 	.hw_init = pch_wpt_init,
 	.get_temp = pch_wpt_get_temp,
 };

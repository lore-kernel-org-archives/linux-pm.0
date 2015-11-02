From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 2/2] thermal: devfreq_cooling: Make power a u64
Date: Mon,  2 Nov 2015 19:03:04 +0000
Message-ID: <1446490984-18438-3-git-send-email-javi.merino@arm.com>
References: <1446490984-18438-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52385 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbbKBTEV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Nov 2015 14:04:21 -0500
In-Reply-To: <1446490984-18438-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, orjan.eide@arm.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>

The prototype of do_div() is:

uint32_t do_div(uint64_t *n, uint32_t base);

Make power u64 to avoid the following warning:

   drivers/thermal/devfreq_cooling.c: In function 'get_dynamic_power':
   drivers/thermal/devfreq_cooling.c:267:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]
   drivers/thermal/devfreq_cooling.c:267:2: warning: right shift count >= width of type [enabled by default]
   drivers/thermal/devfreq_cooling.c:267:2: warning: passing argument 1 of '__div64_32' from incompatible pointer type [enabled by default]
   include/asm-generic/div64.h:35:17: note: expected 'uint64_t *' but argument is of type 'long unsigned int *'

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 31e40a9a9fd0..d1b7c32e7406 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -257,7 +257,7 @@ static unsigned long
 get_dynamic_power(struct devfreq_cooling_device *dfc, unsigned long freq,
 		  unsigned long voltage)
 {
-	unsigned long power;
+	u64 power;
 	u32 freq_mhz;
 	struct devfreq_cooling_power *dfc_power = dfc->power_ops;
 
-- 
1.9.1


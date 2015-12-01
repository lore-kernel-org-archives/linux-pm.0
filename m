From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH RESEND] thermal: power_allocator: req_range multiplication should be a 64 bit type
Date: Tue,  1 Dec 2015 15:15:23 +0000
Message-ID: <1448982923-19416-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36347 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbbLAPP4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Dec 2015 10:15:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dan.carpenter@oracle.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>

req_range is declared as a u64 to cope with overflows in the
multiplication of two u32.  As both req_power and power_range are u32,
we need to make sure the multiplication is done with u64 types.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/power_allocator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 1246aa6fcab0..2f1a863a8e15 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -301,7 +301,7 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	capped_extra_power = 0;
 	extra_power = 0;
 	for (i = 0; i < num_actors; i++) {
-		u64 req_range = req_power[i] * power_range;
+		u64 req_range = (u64)req_power[i] * power_range;
 
 		granted_power[i] = DIV_ROUND_CLOSEST_ULL(req_range,
 							 total_req_power);
-- 
1.9.1


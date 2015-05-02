From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: power_allocator: round the division when divvying up power
Date: Sat,  2 May 2015 10:15:24 +0100
Message-ID: <1430558124-5783-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39819 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbbEBJPq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 2 May 2015 05:15:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

In situations where there is an uneven number of cooling devices, the
division of power among them can lead to a milliwatt being dropped on
the floor due to rounding errors.  This doesn't sound like a lot, but
some devices only grant the lowest cooling device state for their
maximum power.  So for instance, if the granted_power is the maximum
power and all devices are getting their maximum power, one would get
max_power - 1, making it choose cooling device state 1, instead of 0.

Round the division to make the calculation more accurate.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
Hi,

This patch should apply on top of the linus branch in Eduardo's repository.

 drivers/thermal/power_allocator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 3ca7530deac6..4672250b329f 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -196,7 +196,8 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	for (i = 0; i < num_actors; i++) {
 		u64 req_range = req_power[i] * power_range;
 
-		granted_power[i] = div_u64(req_range, total_req_power);
+		granted_power[i] = DIV_ROUND_CLOSEST_ULL(req_range,
+							 total_req_power);
 
 		if (granted_power[i] > max_power[i]) {
 			extra_power += granted_power[i] - max_power[i];
-- 
1.9.1


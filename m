From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: power_allocator: allocate with kcalloc what you free with kfree
Date: Tue, 25 Aug 2015 19:22:35 +0100
Message-ID: <1440526955-9860-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42241 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755799AbbHYSWw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Aug 2015 14:22:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>

Commit cf736ea6f902 ("thermal: power_allocator: do not use devm*
interfaces") forgot to change a devm_kcalloc() to just kcalloc(), but
it's corresponding devm_kfree() was changed to kfree().  Allocate with
kcalloc() to match the kfree().

Fixes: cf736ea6f902 ("thermal: power_allocator: do not use devm* interfaces")
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---

Can this be merged for 4.2, please?  I'm having memory problems with
4.2-rc8 because of this.

 drivers/thermal/power_allocator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 7006860f2f36..251676902869 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -258,8 +258,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*granted_power));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*extra_actor_power));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*weighted_req_power));
-	req_power = devm_kcalloc(&tz->device, num_actors * 5,
-				 sizeof(*req_power), GFP_KERNEL);
+	req_power = kcalloc(num_actors * 5, sizeof(*req_power), GFP_KERNEL);
 	if (!req_power) {
 		ret = -ENOMEM;
 		goto unlock;
-- 
1.9.1


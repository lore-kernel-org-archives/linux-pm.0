From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] power: vexpress: make dev_attr_active static
Date: Wed,  8 Jun 2016 19:26:31 +0100
Message-ID: <1465410391-29475-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:53764 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161461AbcFHS0l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 14:26:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The dev_attr_active is not exported or defined to be used
outside the driver, so make it static to avoid the following
warning:

drivers/power/reset/vexpress-poweroff.c:77:1: warning: symbol 'dev_attr_active' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/power/reset/vexpress-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 6a9bf70..102f95a 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -74,8 +74,8 @@ static ssize_t vexpress_reset_active_store(struct device *dev,
 	return err ? err : count;
 }
 
-DEVICE_ATTR(active, S_IRUGO | S_IWUSR, vexpress_reset_active_show,
-		vexpress_reset_active_store);
+static DEVICE_ATTR(active, S_IRUGO | S_IWUSR, vexpress_reset_active_show,
+		   vexpress_reset_active_store);
 
 
 enum vexpress_reset_func { FUNC_RESET, FUNC_SHUTDOWN, FUNC_REBOOT };
-- 
2.8.1


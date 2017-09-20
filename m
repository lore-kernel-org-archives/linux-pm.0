From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] PM / OPP: Handle return value of kasprintf
Date: Wed, 20 Sep 2017 12:29:13 +0530
Message-ID: <15cec6eac63ffc9f12f1d16aff913eccad670f77.1505817563.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38515 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdITHAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 03:00:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/base/power/opp/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index 81cf120..226d6ae 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -45,7 +45,8 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 
 	for (i = 0; i < opp_table->regulator_count; i++) {
 		name = kasprintf(GFP_KERNEL, "supply-%d", i);
-
+		if (!name)
+			return false;
 		/* Create per-opp directory */
 		d = debugfs_create_dir(name, pdentry);
 
-- 
1.9.1

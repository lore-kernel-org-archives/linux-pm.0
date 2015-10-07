From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] PM / OPP: fix build warning
Date: Wed,  7 Oct 2015 16:49:25 +0530
Message-ID: <1444216765-9189-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-pm@vger.kernel.org

We were getting build warning that:
expected 'bool *' but argument is of type 'u32 *'

debugfs_create_bool() used to take the argument as (u32 *), but commit
621a5f7ad9cd ("debugfs: Pass bool pointer to debugfs_create_bool()")
has modified it and now it accepts bool, so no need to typecast a bool
to (u32 *).

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/base/power/opp/debugfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index 865cbfa..251966b 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -45,14 +45,13 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp)
 	if (!d)
 		return -ENOMEM;
 
-	if (!debugfs_create_bool("available", S_IRUGO, d,
-				 (u32 *)&opp->available))
+	if (!debugfs_create_bool("available", S_IRUGO, d, &opp->available))
 		return -ENOMEM;
 
-	if (!debugfs_create_bool("dynamic", S_IRUGO, d, (u32 *)&opp->dynamic))
+	if (!debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic))
 		return -ENOMEM;
 
-	if (!debugfs_create_bool("turbo", S_IRUGO, d, (u32 *)&opp->turbo))
+	if (!debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo))
 		return -ENOMEM;
 
 	if (!debugfs_create_u32("rate_hz", S_IRUGO, d, (u32 *)&opp->rate))
-- 
1.9.1

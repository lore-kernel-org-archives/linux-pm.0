From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] PM / Domains: Ensure genpd name is set before creating debugfs entry
Date: Fri, 28 Jul 2017 13:48:18 -0500
Message-ID: <20170728184818.1306-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:12751 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbdG1Ssh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 14:48:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thara Gopinath <thara.gopinath@linaro.org>, Dave Gerlach <d-gerlach@ti.com>

Commit b6a1d093f96b ("PM / Domains: Extend generic power domain
debugfs") extends the existing generic power domain debugfs to provide
more information about each genpd, however it creates a debugfs
directory for each based on the name of the genpd. While it is a good
idea to populate the name field of each genpd, up until this commit it
was not required. However, attempting to call debugfs_create_dir with a
null name value causes a NULL pointer dereference panic.

In order to keep things working as they did before the aforementioned
patch, check to see if name has been populated and if not, skip creating
the extended debugfs info path and warn that name is needed to get this
extended info.

Fixes: b6a1d093f96b ("PM / Domains: Extend generic power domain debugfs")
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/base/power/domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 43fd08e50ae9..77f7ea6f7fc3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2575,6 +2575,12 @@ static int __init pm_genpd_debug_init(void)
 		return -ENOMEM;
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		if (!genpd->name) {
+			pr_warn("%s: Must populate name of genpd for extended debugfs info.",
+				__func__);
+			continue;
+		}
+
 		d = debugfs_create_dir(genpd->name, pm_genpd_debugfs_dir);
 		if (!d)
 			return -ENOMEM;
-- 
2.13.0

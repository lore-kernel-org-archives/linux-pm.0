From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] power: domain: no need to check return value of debugfs_create functions
Date: Tue, 22 Jan 2019 16:21:05 +0100
Message-ID: <20190122152151.16139-6-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/domain.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 500de1dee967..45eafe8cf7dd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2948,18 +2948,11 @@ static int __init genpd_debug_init(void)
 
 	genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
 
-	if (!genpd_debugfs_dir)
-		return -ENOMEM;
-
-	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			genpd_debugfs_dir, NULL, &summary_fops);
-	if (!d)
-		return -ENOMEM;
+	debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
+			    NULL, &summary_fops);
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
 		d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
-		if (!d)
-			return -ENOMEM;
 
 		debugfs_create_file("current_state", 0444,
 				d, genpd, &status_fops);
-- 
2.20.1

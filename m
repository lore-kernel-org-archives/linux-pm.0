From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 3/3 v3] powercap, intel_rapl, Add ignore_max_time_window_check module parameter for broken BIOSes
Date: Mon, 21 Mar 2016 08:27:16 -0400
Message-ID: <1458563236-19269-4-git-send-email-prarit@redhat.com>
References: <1458563236-19269-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755811AbcCUM1Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Mar 2016 08:27:24 -0400
In-Reply-To: <1458563236-19269-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>, Mathias Krause <minipli@googlemail.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>

Some systems erroneously set the maximum time window field of
MSR_PKG_POWER_INFO register to 0.  This results in a user not being able
to set the time windows for the package.  In some cases, however, RAPL
will still continue to work with a small window (albeit through some
trial and error).  This patch adds a ignore_max_time_window_check module
parameter to avoid the maximum time window check in set_time_window().

[v2]: change name to max_time_window_check, fix (val == 0) check
[v3]: fix typo in debug message

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
Cc: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/powercap/intel_rapl.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index cf89b3d..87dac13 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -505,13 +505,24 @@ static int get_max_time_window(struct powercap_zone *power_zone, int id,
 
 	if (rapl_read_data_raw(rd, MAX_TIME_WINDOW, true, &val))
 		ret = -EIO;
-	else
+	else {
 		*data = val;
-
+		if (val == 0)
+			pr_warn_once(FW_BUG "intel_rapl: Maximum Time Window is zero.  This is a BIOS bug that should be reported to your hardware or BIOS vendor.  The value of zero may prevent Intel RAPL from functioning properly.  Most bugs can be avoided by setting the ignore_max_time_window_check module parameter.\n");
+	}
 	put_online_cpus();
 	return ret;
 }
 
+/* Some BIOSes incorrectly program the maximum time window in the
+ * MSR_PKG_POWER_INFO register.  Some of these systems still have functional
+ * RAPL registers, etc., so give the user the option of disabling the maximum
+ * time window check.
+ */
+static int ignore_max_time_window_check;
+module_param(ignore_max_time_window_check, int, 0444);
+MODULE_PARM_DESC(ignore_max_time_window_check, "Ignore maximum time window check.  A bug should be reported to your hardware or BIOS vendor if this parameter is used.");
+
 static int set_time_window(struct powercap_zone *power_zone, int id,
 								u64 window)
 {
@@ -532,7 +543,8 @@ static int set_time_window(struct powercap_zone *power_zone, int id,
 	 * The MSR_RAPL_POWER_UNIT register, read during initialization,
 	 * does contain the smallest unit of time that can be measured.
 	 */
-	if ((window > max_window) || (window < rp->time_unit)) {
+	if ((!ignore_max_time_window_check && (window > max_window)) ||
+	    (window < rp->time_unit)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
1.7.9.3


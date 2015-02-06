From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: [PATCH 1/1] drivers/base: Remove unnecessary OOM message
Date: Fri, 6 Feb 2015 16:39:12 +0100
Message-ID: <20150206153912.GA8486@sloth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:64711 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbbBFPjF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Feb 2015 10:39:05 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This patch fix checkpatch warnings concerning the possible
duplication of an "out of memory" message.

A simplified version of the semantic patch that finds this problem is as
follows: (http://coccinelle.lip6.fr)

@@
identifier f,print,l;
expression e;
constant char[] c;
@@

e = \(kzalloc\|kmalloc\|devm_kzalloc\|devm_kmalloc\)(...);
if (e == NULL) {
  <+...
-  print(...,c,...);
  ... when any
(
  goto l;
|
  return ...;
)
  ...+> }

Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
---
 drivers/base/firmware_class.c  | 1 -
 drivers/base/power/clock_ops.c | 4 +---
 drivers/base/power/opp.c       | 8 ++------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 58470c3..c3293f0 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -855,7 +855,6 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
 
 	fw_priv = kzalloc(sizeof(*fw_priv), GFP_KERNEL);
 	if (!fw_priv) {
-		dev_err(device, "%s: kmalloc failed\n", __func__);
 		fw_priv = ERR_PTR(-ENOMEM);
 		goto exit;
 	}
diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index d626576..7fdd017 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -81,10 +81,8 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
 		return -EINVAL;
 
 	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
-	if (!ce) {
-		dev_err(dev, "Not enough memory for clock entry.\n");
+	if (!ce)
 		return -ENOMEM;
-	}
 
 	if (con_id) {
 		ce->con_id = kstrdup(con_id, GFP_KERNEL);
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 15bf299..677fb28 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -474,10 +474,8 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 
 	/* allocate new OPP node */
 	new_opp = kzalloc(sizeof(*new_opp), GFP_KERNEL);
-	if (!new_opp) {
-		dev_warn(dev, "%s: Unable to create new OPP node\n", __func__);
+	if (!new_opp)
 		return -ENOMEM;
-	}
 
 	/* Hold our list modification lock here */
 	mutex_lock(&dev_opp_list_lock);
@@ -695,10 +693,8 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 
 	/* keep the node allocated */
 	new_opp = kmalloc(sizeof(*new_opp), GFP_KERNEL);
-	if (!new_opp) {
-		dev_warn(dev, "%s: Unable to create OPP\n", __func__);
+	if (!new_opp)
 		return -ENOMEM;
-	}
 
 	mutex_lock(&dev_opp_list_lock);
 
-- 
1.9.1


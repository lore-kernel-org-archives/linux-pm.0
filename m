From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] Thermal/int340x/int3403: Fix memory leak
Date: Tue, 23 Dec 2014 15:23:34 -0800
Message-ID: <1419377016-13688-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44063 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbaLWXYN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Dec 2014 18:24:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Address memory leak for buffer allocated with ACPI_ALLOCATE_BUFFER.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3403_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
index 6e9fb62..2ee7fd8 100644
--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -370,6 +370,7 @@ static int int3403_cdev_add(struct int3403_priv *priv)
 	p = buf.pointer;
 	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
 		printk(KERN_WARNING "Invalid PPSS data\n");
+		kfree(buf.pointer);
 		return -EFAULT;
 	}
 
@@ -382,6 +383,7 @@ static int int3403_cdev_add(struct int3403_priv *priv)
 
 	priv->priv = obj;
 
+	kfree(buf.pointer);
 	/* TODO: add ACPI notification support */
 
 	return result;
-- 
1.9.3


From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] thermal: constify pch_dev_ops structure
Date: Sun, 22 Nov 2015 10:03:49 +0100
Message-ID: <1448183029-28929-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The pch_dev_ops structure is never modified, so declare it as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/thermal/intel_pch_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 50c7da7..00d81af 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -136,7 +136,7 @@ struct pch_dev_ops {
 
 
 /* dev ops for Wildcat Point */
-static struct pch_dev_ops pch_dev_ops_wpt = {
+static const struct pch_dev_ops pch_dev_ops_wpt = {
 	.hw_init = pch_wpt_init,
 	.get_temp = pch_wpt_get_temp,
 };


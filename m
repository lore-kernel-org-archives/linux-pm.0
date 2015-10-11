From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] thermal: constify pch_dev_ops structure
Date: Sun, 11 Oct 2015 13:01:28 +0200
Message-ID: <1444561288-29764-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:7442 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751733AbbJKLMZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Oct 2015 07:12:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The pch_dev_ops structure is never modified.  It is only stored in a field
that is already declared as const.

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


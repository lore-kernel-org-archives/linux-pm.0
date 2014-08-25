From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] power/reset: xgene-reset: Fix prototype of xgene_restart()
Date: Sun, 24 Aug 2014 19:36:29 -0500
Message-ID: <1408926989-12501-1-git-send-email-broonie@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60191 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaHYKCb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Aug 2014 06:02:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

The xgene-reset driver uses xgene_restart() as arm_pm_restart() but that
function should take an enum reset_type as the first argument rather than
a char. Fix this; the paramter is not referenced in the implementation.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/power/reset/xgene-reboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index ecd55f8..6b49be6 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -40,7 +40,7 @@ struct xgene_reboot_context {
 
 static struct xgene_reboot_context *xgene_restart_ctx;
 
-static void xgene_restart(char str, const char *cmd)
+static void xgene_restart(enum reboot_mode mode, const char *cmd)
 {
 	struct xgene_reboot_context *ctx = xgene_restart_ctx;
 	unsigned long timeout;
-- 
2.1.0.rc1


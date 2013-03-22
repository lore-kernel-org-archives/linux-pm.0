From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 04/14] thermal: mvebu: Remove unneeded variable initialization
Date: Fri, 22 Mar 2013 19:25:04 -0300
Message-ID: <1363991114-4225-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33421 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423359Ab3CVWZi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 18:25:38 -0400
In-Reply-To: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This variable is used only after it's properly initialized,
so there's no need to set it to NULL in its declaration.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index 031f94d..1f502ed 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -72,7 +72,7 @@ MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
 
 static int mvebu_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *thermal = NULL;
+	struct thermal_zone_device *thermal;
 	struct mvebu_thermal_priv *priv;
 	struct resource *res;
 
-- 
1.7.8.6


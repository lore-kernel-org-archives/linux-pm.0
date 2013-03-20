From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 03/16] thermal: mvebu: Move MODULE_DEVICE_TABLE upwards
Date: Wed, 20 Mar 2013 19:36:24 -0300
Message-ID: <1363818997-23137-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50561 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab3CTWgz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 18:36:55 -0400
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This table will be needed by mvebu_thermal_probe() so we move
it just below the declaration of the compatible device table.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index d61a750..77c488c 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -68,6 +68,7 @@ static const struct of_device_id mvebu_thermal_id_table[] = {
 	{ .compatible = "marvell,kirkwood-thermal" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
 
 static int mvebu_thermal_probe(struct platform_device *pdev)
 {
@@ -115,8 +116,6 @@ static int mvebu_thermal_exit(struct platform_device *pdev)
 	return 0;
 }
 
-MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
-
 static struct platform_driver mvebu_thermal_driver = {
 	.probe = mvebu_thermal_probe,
 	.remove = mvebu_thermal_exit,
-- 
1.7.8.6


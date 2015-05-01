From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 1/2] power: axp288_fuel_gauge: Constify platform_device_id
Date: Sat,  2 May 2015 00:46:43 +0900
Message-ID: <1430495204-31363-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34711 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbbEAPrD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 11:47:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/power/axp288_fuel_gauge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/axp288_fuel_gauge.c b/drivers/power/axp288_fuel_gauge.c
index ca1cc5a47eb1..35932c768aa4 100644
--- a/drivers/power/axp288_fuel_gauge.c
+++ b/drivers/power/axp288_fuel_gauge.c
@@ -1117,7 +1117,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_device_id axp288_fg_id_table[] = {
+static const struct platform_device_id axp288_fg_id_table[] = {
 	{ .name = DEV_NAME },
 	{},
 };
-- 
2.1.4


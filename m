From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/2] power: Build power/avs when POWER_AVS is selected but
 POWER_SUPPLY is not
Date: Wed, 02 Dec 2015 14:59:07 +0900
Message-ID: <1449035947-16758-2-git-send-email-k.kozlowski@samsung.com>
References: <1449035947-16758-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:8257 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbLBF7S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 00:59:18 -0500
In-reply-to: <1449035947-16758-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Pavel Fedin <p.fedin@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

POWER_AVS can be selected from top-drivers menu and it does not depend
on POWER_SUPPLY. However in such case (POWER_SUPPLY is not enabled) all
objects will be skipped by make.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/Makefile       | 1 +
 drivers/power/Makefile | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 0ebb49d0e57e..a3717decf3e7 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -106,6 +106,7 @@ obj-y				+= i2c/ media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-$(CONFIG_PTP_1588_CLOCK)	+= ptp/
 obj-$(CONFIG_W1)		+= w1/
+obj-$(CONFIG_POWER_AVS)		+= power/avs/
 obj-$(CONFIG_POWER_RESET)	+= power/reset/
 obj-$(CONFIG_POWER_SUPPLY)	+= power/
 obj-$(CONFIG_HWMON)		+= hwmon/
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index ac430b373f84..d6a1ddb20fec 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -65,7 +65,6 @@ obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
 obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
 obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
 obj-$(CONFIG_CHARGER_BQ25890)	+= bq25890_charger.o
-obj-$(CONFIG_POWER_AVS)		+= avs/
 obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
 obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
 obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
-- 
1.9.1


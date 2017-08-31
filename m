From: Allen Wild <allenwild93@gmail.com>
Subject: [PATCH 2/2] arm64: defconfig: enable BCM2835_THERMAL
Date: Wed, 30 Aug 2017 23:43:06 -0400
Message-ID: <20170831034306.13413-2-allenwild93@gmail.com>
References: <20170831034306.13413-1-allenwild93@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36456 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdHaDnj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2017 23:43:39 -0400
Received: by mail-oi0-f68.google.com with SMTP id x184so7231502oia.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2017 20:43:39 -0700 (PDT)
In-Reply-To: <20170831034306.13413-1-allenwild93@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Allen Wild <allenwild93@gmail.com>

After fixing the thermal Kconfig to allow enabling the bcm2835 thermal
driver for arm64, turn it back on in the defconfig.

Signed-off-by: Allen Wild <allenwild93@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b4ca115b3be1..d3d3f427755d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -304,6 +304,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_BCM2835_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_WATCHDOG=y
-- 
2.14.1

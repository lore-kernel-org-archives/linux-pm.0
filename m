From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] PM / devfreq: rockchip: add PM_DEVFREQ_EVENT dependency
Date: Thu, 15 Sep 2016 17:44:58 +0200
Message-ID: <20160915154513.3006199-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:54160 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbcIOPps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 11:45:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Lin Huang <hl@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The newly added ARM_RK3399_DMC_DEVFREQ driver requires the
DEVFREQ_EVENT_ROCKCHIP_DFI driver and tries to turn that on through
a 'select' statement, and that in turn has a dependency on
PM_DEVFREQ_EVENT, which may be disabled here:

warning: (ARM_RK3399_DMC_DEVFREQ) selects DEVFREQ_EVENT_ROCKCHIP_DFI which has unmet direct dependencies (PM_DEVFREQ && PM_DEVFREQ_EVENT && ARCH_ROCKCHIP)

We probably want a 'depends on' here, but other drivers use 'select'
too, so for consistency I'm doing the same.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5a893e31a636 ("PM / devfreq: rockchip: add devfreq driver for rk3399 dmc")
---
 drivers/devfreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 93b6ada06676..41254e702f1e 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -105,6 +105,7 @@ config ARM_RK3399_DMC_DEVFREQ
 	depends on ARCH_ROCKCHIP
 	select DEVFREQ_EVENT_ROCKCHIP_DFI
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select PM_DEVFREQ_EVENT
 	select PM_OPP
 	help
           This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
-- 
2.9.0


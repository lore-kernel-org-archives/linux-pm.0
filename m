From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] ARM: ux500: u8500_defconfig: add missing cpuidle option
Date: Mon, 30 Sep 2013 13:36:36 +0200
Message-ID: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:34573 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab3I3Lgr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 07:36:47 -0400
Received: by mail-we0-f173.google.com with SMTP id w62so5366606wes.18
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2013 04:36:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linus.walleij@linaro.org, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, patches@linao.org

With the commit d3f2950f2adeea3da0317e952914b59adaa4cdb3, the option
ARM_U8500_CPUIDLE was added to the Kconfig but not reflected in the
default config file, hence the cpuidle driver is no longer enabled
since this commit.

Enable it again by adding the missing option in the default config file.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index a0025dc..4bd93bf 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -20,6 +20,7 @@ CONFIG_CMDLINE="root=/dev/ram0 console=ttyAMA2,115200n8"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_U8500_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_PM_RUNTIME=y
-- 
1.7.9.5


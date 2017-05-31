From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] power: reset: Allow selecting POWER_RESET_BRCMSTB on ARM64
Date: Wed, 31 May 2017 13:39:45 -0700
Message-ID: <20170531203946.32644-2-f.fainelli@gmail.com>
References: <20170531203946.32644-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531203946.32644-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: sre@kernel.org, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

Since commit 37eb56dc79a8 ("arm64: Add Broadcom Set Top Box Kconfig
entry point") we have ARCH_BRCMSTB also visible on ARM64 platform, yet
this reboot driver was not selectable, so fix that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 13f1714cf6f7..fdad987bed89 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -58,7 +58,7 @@ config POWER_RESET_BRCMKONA
 
 config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver"
-	depends on ARM || MIPS || COMPILE_TEST
+	depends on ARM || ARM64 || MIPS || COMPILE_TEST
 	depends on MFD_SYSCON
 	default ARCH_BRCMSTB
 	help
-- 
2.9.3

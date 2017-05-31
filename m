From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] power: reset: Default POWER_RESET_BRCMSTB to BMIPS_GENERIC
Date: Wed, 31 May 2017 13:39:46 -0700
Message-ID: <20170531203946.32644-3-f.fainelli@gmail.com>
References: <20170531203946.32644-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531203946.32644-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: sre@kernel.org, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Broadcom MIPS STB platforms, BMIPS_GENERIC is the Kconfig symbol that
is used, make this reboot driver default to that value to make sure we
can reboot a system properly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fdad987bed89..ca0de1a78e85 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -60,7 +60,7 @@ config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver"
 	depends on ARM || ARM64 || MIPS || COMPILE_TEST
 	depends on MFD_SYSCON
-	default ARCH_BRCMSTB
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  This driver provides restart support for Broadcom STB boards.
 
-- 
2.9.3

From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v2 12/12] arm64: Kconfig: Enable PM_GENERIC_DOMAINS for
 exynos7
Date: Mon, 24 Nov 2014 18:34:16 +0530
Message-ID: <1416834256-11225-12-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, pankaj.dubey@samsung.com, ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

Use power domain driver for Exynos7 SOC's

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 30bd4d5..b102d0b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -154,6 +154,7 @@ config ARCH_EXYNOS7
 	bool "ARMv8 based Samsung Exynos7"
 	select ARCH_EXYNOS
 	select COMMON_CLK_SAMSUNG
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for Samsung Exynos7 SoC family
 
-- 
1.7.9.5

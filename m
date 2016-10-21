From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / Domains: Restrict "samsung,power-domain" checks to ARCH_EXYNOS
Date: Fri, 21 Oct 2016 13:34:16 +0200
Message-ID: <1477049656-27535-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Currently the generic PM Domain code code checks for the presence of
both (generic) "power-domains" and (Samsung Exynos legacy)
"samsung,power-domain" properties in all device tree nodes representing
devices.

There are two issues with this:
  1. This imposes a small boot-time penalty on all platforms using DT,
  2. Platform-specific checks do not really belong in core framework
     code.

While moving the check from platform-agnostic code to Samsung-specific
code is non-trivial, the runtime overhead can be restricted to kernels
including support for 32-bit Samsung Exynos platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
"samsung,power-domain" was only ever used in:
  - arch/arm/boot/dts/exynos4415.dtsi: Unused?
  - arch/arm/boot/dts/exynos3250.dtsi: CONFIG_ARCH_EXYNOS3
  - arch/arm/boot/dts/exynos4.dtsi:    CONFIG_ARCH_EXYNOS4
  - arch/arm/boot/dts/exynos4x12.dtsi: CONFIG_ARCH_EXYNOS4
				       exynos4212.dtsi is unused?
  - arch/arm/boot/dts/exynos5250.dtsi: CONFIG_ARCH_EXYNOS5
  - arch/arm/boot/dts/exynos5420.dtsi: CONFIG_ARCH_EXYNOS5
---
 drivers/base/power/domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e023066e421547c5..d94d6a4b9b527108 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1853,7 +1853,8 @@ int genpd_dev_pm_attach(struct device *dev)
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 					"#power-domain-cells", 0, &pd_args);
 	if (ret < 0) {
-		if (ret != -ENOENT)
+		if (ret != -ENOENT || !IS_ENABLED(CONFIG_ARCH_EXYNOS) ||
+		    IS_ENABLED(CONFIG_64BIT))
 			return ret;
 
 		/*
-- 
1.9.1

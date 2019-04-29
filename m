From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH 1/1] thermal: Fix build error of missing devm_ioremap_resource on UM
Date: Mon, 29 Apr 2019 12:47:36 +0300
Message-ID: <1556531256-26321-1-git-send-email-talel@amazon.com>
References: <201904261215.nJZXSFjx%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201904261215.nJZXSFjx%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: talel@amazon.com, robh@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, dwmw@amazon.co.uk, jonnyc@amazon.com, rui.zhang@intel.com, hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The devres.o gets linked if HAS_IOMEM is present so on ARCH=um
allyesconfig (COMPILE_TEST) failed on many files with:

drivers/thermal/thermal_mmio.o:
In function 'thermal_mmio_probe':thermal_mmio.c:(.text+0xe1):
undefined reference to `devm_ioremap_resource'

The users of devm_ioremap_resource() which are compile-testable
should depend on HAS_IOMEM.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 41f3943..66a709d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -203,6 +203,7 @@ config THERMAL_EMULATION
 config THERMAL_MMIO
 	tristate "Generic Thermal MMIO driver"
 	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This option enables the generic thermal MMIO driver that will use
 	  memory-mapped reads to get the temperature.  Any HW/System that
-- 
2.7.4

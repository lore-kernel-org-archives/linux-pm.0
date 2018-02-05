From: Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH v2 03/20] kconfig: Remove leftover references to AVR32 symbol
Date: Mon,  5 Feb 2018 05:44:41 +0100
Message-ID: <20180205044441.4440-1-ulfalizer@gmail.com>
References: <20180205040515.GC28462@vireshk-i7>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20180205040515.GC28462@vireshk-i7>
Sender: linux-pwm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com, egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com, yamada.masahiro@socionext.com, ulfalizer@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, thierry.reding@gmail.com, broonie@kernel.org, b.zolnierkie@samsung.com, seanpaul@chromium.org, daniel.vetter@ffwll.ch, christophe.leroy@c-s.fr, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
support for AVR32 architecture"). Remove the remaining references to it
from the Kconfig files.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
Changes in v2:
Removal of AVR32_AT32AP_CPUFREQ is already pending in
https://marc.info/?i=20180118200202.11883-1-clabbe.montjoie%40gmail.com (which
also does it properly -- I forgot to search for related files here). Just
remove the other references.

 drivers/pwm/Kconfig           | 2 +-
 drivers/spi/Kconfig           | 2 +-
 drivers/video/console/Kconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50ea57d..f16aad3bf5d6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -43,7 +43,7 @@ config PWM_AB8500
 
 config PWM_ATMEL
 	tristate "Atmel PWM support"
-	depends on ARCH_AT91 || AVR32
+	depends on ARCH_AT91
 	help
 	  Generic PWM framework driver for Atmel SoC.
 
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 603783976b81..c1e455d46c7f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -72,7 +72,7 @@ config SPI_ARMADA_3700
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on HAS_DMA
-	depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
+	depends on (ARCH_AT91 || COMPILE_TEST)
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT32 (AVR32) and AT91 (ARM) chips.
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..be63759b6027 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,7 +7,7 @@ menu "Console display driver support"
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
-		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
+		!SUPERH && !BLACKFIN && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
 	default y
-- 
2.14.1

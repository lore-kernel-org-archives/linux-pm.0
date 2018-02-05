From: Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 03/20] kconfig: Remove leftover references to AVR32 symbol
Date: Mon,  5 Feb 2018 02:21:15 +0100
Message-ID: <20180205012146.23981-4-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com, egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com, yamada.masahiro@socionext.com, Ulf Magnusson <ulfalizer@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-pm@vger.kernel.orgl
List-Id: linux-pm@vger.kernel.org

The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
support for AVR32 architecture"). Remove the remaining references to it
from the Kconfig files.

No references remain to the removed AVR32_AT32AP_CPUFREQ symbol either,
so remove that one too.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/cpufreq/Kconfig       | 10 ----------
 drivers/pwm/Kconfig           |  2 +-
 drivers/spi/Kconfig           |  2 +-
 drivers/video/console/Kconfig |  2 +-
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index d8addbce40bc..608af20a3494 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -239,16 +239,6 @@ if PPC32 || PPC64
 source "drivers/cpufreq/Kconfig.powerpc"
 endif
 
-if AVR32
-config AVR32_AT32AP_CPUFREQ
-	bool "CPU frequency driver for AT32AP"
-	depends on PLATFORM_AT32AP
-	default n
-	help
-	  This enables the CPU frequency driver for AT32AP processors.
-	  If in doubt, say N.
-endif
-
 if IA64
 config IA64_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
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

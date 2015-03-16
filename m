From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/6] iio/adc/cc10001_adc.c: Fix !HAS_IOMEM build
Date: Mon, 16 Mar 2015 22:27:10 +0100
Message-ID: <1426541230-928-6-git-send-email-richard@nod.at>
References: <1426541230-928-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426541230-928-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, Richard Weinberger <richard@nod.at>
List-Id: linux-pm@vger.kernel.org

Fixes:
drivers/built-in.o: In function `cc10001_adc_probe':
cc10001_adc.c:(.text+0x412e92): undefined reference to `devm_ioremap_resource'

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/iio/adc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 202daf8..46379b1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -137,7 +137,8 @@ config AXP288_ADC
 
 config CC10001_ADC
 	tristate "Cosmic Circuits 10001 ADC driver"
-	depends on HAS_IOMEM || HAVE_CLK || REGULATOR
+	depends on HAVE_CLK || REGULATOR
+	depends on HAS_IOMEM
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
1.8.4.5

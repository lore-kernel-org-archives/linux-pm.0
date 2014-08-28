From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 7/7] MAINTAINERS: Include DA9150 files in Dialog Semiconductor
 support list.
Date: Thu, 28 Aug 2014 11:49:19 +0100
Message-ID: <09b13677b1e2d1cf02e4eb43e2777f8081ec9597.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa948..6dc0aee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2883,12 +2883,15 @@ S:	Supported
 F:	Documentation/hwmon/da90??
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
+F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
 F:	drivers/mfd/da90??-*.c
+F:	drivers/mfd/da91??-*.c
 F:	drivers/power/da9052-battery.c
+F:	drivers/power/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
 F:	drivers/rtc/rtc-da90??.c
@@ -2898,6 +2901,7 @@ F:	include/linux/mfd/da903x.h
 F:	include/linux/mfd/da9052/
 F:	include/linux/mfd/da9055/
 F:	include/linux/mfd/da9063/
+F:	include/linux/mfd/da9150/
 F:	include/sound/da[79]*.h
 F:	sound/soc/codecs/da[79]*.[ch]

--
1.9.3

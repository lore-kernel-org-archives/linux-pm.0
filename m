From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 19/22] power-supply: Probe power supplies on demand
Date: Mon,  7 Sep 2015 14:23:44 +0200
Message-ID: <1441628627-5143-20-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When looking up a power supply through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/power/power_supply_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 456987c88baa..80bc89f4ae89 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/power_supply.h>
 #include <linux/thermal.h>
+#include <linux/of_device.h>
 #include "power_supply.h"
 
 /* exported for the APM Power driver, APM emulation */
@@ -206,6 +207,8 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 {
 	int error;
 
+	of_device_probe(supply_node);
+
 	/*
 	 * class_for_each_device() either returns its own errors or values
 	 * returned by __power_supply_find_supply_from_node().
-- 
2.4.3

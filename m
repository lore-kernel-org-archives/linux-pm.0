From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/3] regulator: core: add helper to check if regulator is
 disabled in suspend
Date: Tue, 8 Jan 2019 09:52:57 +0000
Message-ID: <1546941147-18410-3-git-send-email-claudiu.beznea@microchip.com>
References: <1546941147-18410-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546941147-18410-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add helper to check if regulator will be disabled in suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/core.c           | 17 +++++++++++++++++
 include/linux/regulator/consumer.h |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b9d7b45c7295..a876ec369450 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3786,6 +3786,23 @@ int regulator_suspend_disable(struct regulator_dev *=
rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_suspend_disable);
=20
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state)
+{
+	struct regulator_state *rstate;
+
+	if (!regulator->rdev->constraints)
+		return false;
+
+	rstate =3D regulator_get_suspend_state(regulator->rdev, state);
+	if (!rstate)
+		return false;
+
+	return !!(regulator->rdev->desc->ops->set_suspend_disable &&
+		  rstate->enabled =3D=3D DISABLE_IN_SUSPEND);
+}
+EXPORT_SYMBOL_GPL(regulator_is_disabled_in_suspend);
+
 static int _regulator_set_suspend_voltage(struct regulator *regulator,
 					  int min_uV, int max_uV,
 					  suspend_state_t state)
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/c=
onsumer.h
index f3f76051e8b0..cf5e71dc63ce 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -36,6 +36,7 @@
 #define __LINUX_REGULATOR_CONSUMER_H_
=20
 #include <linux/err.h>
+#include <linux/suspend.h>
=20
 struct device;
 struct notifier_block;
@@ -285,6 +286,9 @@ void devm_regulator_unregister_notifier(struct regulato=
r *regulator,
 void *regulator_get_drvdata(struct regulator *regulator);
 void regulator_set_drvdata(struct regulator *regulator, void *data);
=20
+/* regulator suspend/resume state */
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state);
 #else
=20
 /*
@@ -579,6 +583,9 @@ static inline int regulator_list_voltage(struct regulat=
or *regulator, unsigned s
 	return -EINVAL;
 }
=20
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state);
+
 #endif
=20
 static inline int regulator_set_voltage_triplet(struct regulator *regulato=
r,
--=20
2.7.4

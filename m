From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [RFC 4/8] regulator: core: Check enabling bypass respects constraints
Date: Wed, 22 Mar 2017 18:53:06 +0200
Message-ID: <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1490199005.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Enabling bypass mode makes a regulator passthrough the supply voltage
directly. It is possible that the supply voltage is set high enough that
it violates machine constraints so let's check for that.

The supply voltage might be higher because of min_dropout_uV or maybe
there is just an unrelated consumer who requested a higher voltage.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/regulator/core.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 53d4fc7..9d893aa 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3453,6 +3453,54 @@ int regulator_set_load(struct regulator *regulator, int uA_load)
 }
 EXPORT_SYMBOL_GPL(regulator_set_load);
 
+static int _regulator_set_bypass(struct regulator *regulator, bool bypass)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	int output_voltage;
+	int supply_voltage;
+
+	if (bypass && !rdev->supply) {
+		rdev_err(rdev, "Refuse to set bypass on regulator with no supply!\n");
+		return -EINVAL;
+	}
+
+	/* Check that enabling bypass won't break constraints */
+	if (bypass && _regulator_is_enabled(rdev)) {
+		output_voltage = _regulator_get_voltage(rdev);
+		if (output_voltage < 0) {
+			rdev_err(rdev, "Failed to get old output voltage before"
+					" enabling bypass: %d\n", output_voltage);
+			return output_voltage;
+		}
+		supply_voltage = _regulator_get_voltage(rdev->supply->rdev);
+		if (supply_voltage < 0) {
+			rdev_err(rdev, "Failed to get supply voltage before"
+					" enabling bypass: %d\n", supply_voltage);
+			return supply_voltage;
+		}
+		if (supply_voltage < rdev->constraints->min_uV ||
+				supply_voltage > rdev->constraints->max_uV) {
+			rdev_err(rdev, "Enabling bypass would change voltage"
+					" from %duV to %duV violating"
+					" constraint range %duV to %duV\n",
+				output_voltage,
+				supply_voltage,
+				rdev->constraints->min_uV,
+				rdev->constraints->max_uV);
+			return -EINVAL;
+		}
+		rdev_dbg(rdev, "Enabling bypass would change voltage"
+				" from %duV to %duV respecting"
+				" constraint range %duV to %duV\n",
+			output_voltage,
+			supply_voltage,
+			rdev->constraints->min_uV,
+			rdev->constraints->max_uV);
+	}
+
+	return rdev->desc->ops->set_bypass(rdev, bypass);
+}
+
 /**
  * regulator_allow_bypass - allow the regulator to go into bypass mode
  *
@@ -3481,7 +3529,7 @@ int regulator_allow_bypass(struct regulator *regulator, bool enable)
 		rdev->bypass_count++;
 
 		if (rdev->bypass_count == rdev->open_count) {
-			ret = rdev->desc->ops->set_bypass(rdev, enable);
+			ret = _regulator_set_bypass(regulator, enable);
 			if (ret != 0)
 				rdev->bypass_count--;
 		}
@@ -3490,7 +3538,7 @@ int regulator_allow_bypass(struct regulator *regulator, bool enable)
 		rdev->bypass_count--;
 
 		if (rdev->bypass_count != rdev->open_count) {
-			ret = rdev->desc->ops->set_bypass(rdev, enable);
+			ret = _regulator_set_bypass(regulator, enable);
 			if (ret != 0)
 				rdev->bypass_count++;
 		}
-- 
2.7.4

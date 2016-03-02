From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/14] power: pm2301-charger: use __maybe_unused to hide pm
 functions
Date: Wed,  2 Mar 2016 16:58:56 +0100
Message-ID: <1456934350-1389172-5-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The pm2301 charger driver uses nested #ifdefs to check for both
CONFIG_PM and CONFIG_PM_SLEEP in an attempt to hide its
suspend and runtime-pm operations when they are unused, but
it does not hide the clear_lpn_pin() function in the same
way, so we get a build warning when everything is
disabled:

drivers/power/pm2301_charger.c:123:13: error: 'clear_lpn_pin' defined but not used [-Werror=unused-function]

This removes all the #ifdef and instead uses __maybe_unused
annotations to let the compiler know it can silently drop
the function definition.

For the PM2XXX_PM_OPS, we can use an IS_ENABLED() check
to avoid defining the structure when CONFIG_PM is not set without
the #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/pm2301_charger.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index 8f9bd1d0eeb6..fb62ed3fc38c 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -911,11 +911,7 @@ static struct pm2xxx_irq pm2xxx_charger_irq[] = {
 	{"PM2XXX_IRQ_INT", pm2xxx_irq_int},
 };
 
-#ifdef CONFIG_PM
-
-#ifdef CONFIG_PM_SLEEP
-
-static int pm2xxx_wall_charger_resume(struct device *dev)
+static int __maybe_unused pm2xxx_wall_charger_resume(struct device *dev)
 {
 	struct i2c_client *i2c_client = to_i2c_client(dev);
 	struct pm2xxx_charger *pm2;
@@ -931,7 +927,7 @@ static int pm2xxx_wall_charger_resume(struct device *dev)
 	return 0;
 }
 
-static int pm2xxx_wall_charger_suspend(struct device *dev)
+static int __maybe_unused pm2xxx_wall_charger_suspend(struct device *dev)
 {
 	struct i2c_client *i2c_client = to_i2c_client(dev);
 	struct pm2xxx_charger *pm2;
@@ -949,9 +945,7 @@ static int pm2xxx_wall_charger_suspend(struct device *dev)
 	return 0;
 }
 
-#endif
-
-static int  pm2xxx_runtime_suspend(struct device *dev)
+static int __maybe_unused pm2xxx_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *pm2xxx_i2c_client = to_i2c_client(dev);
 	struct pm2xxx_charger *pm2;
@@ -962,7 +956,7 @@ static int  pm2xxx_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int  pm2xxx_runtime_resume(struct device *dev)
+static int __maybe_unused pm2xxx_runtime_resume(struct device *dev)
 {
 	struct i2c_client *pm2xxx_i2c_client = to_i2c_client(dev);
 	struct pm2xxx_charger *pm2;
@@ -975,15 +969,11 @@ static int  pm2xxx_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops pm2xxx_pm_ops = {
+static const struct dev_pm_ops pm2xxx_pm_ops __maybe_unused = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm2xxx_wall_charger_suspend,
 		pm2xxx_wall_charger_resume)
 	SET_RUNTIME_PM_OPS(pm2xxx_runtime_suspend, pm2xxx_runtime_resume, NULL)
 };
-#define  PM2XXX_PM_OPS (&pm2xxx_pm_ops)
-#else
-#define  PM2XXX_PM_OPS  NULL
-#endif
 
 static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 		const struct i2c_device_id *id)
@@ -1244,7 +1234,7 @@ static struct i2c_driver pm2xxx_charger_driver = {
 	.remove = pm2xxx_wall_charger_remove,
 	.driver = {
 		.name = "pm2xxx-wall_charger",
-		.pm = PM2XXX_PM_OPS,
+		.pm = IS_ENABLED(CONFIG_PM) ? &pm2xxx_pm_ops : NULL,
 	},
 	.id_table = pm2xxx_id,
 };
-- 
2.7.0

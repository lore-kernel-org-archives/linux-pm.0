From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 7/8] PM / devfreq: Define the constant governor name
Date: Fri, 13 Oct 2017 16:48:23 +0900
Message-ID: <1507880904-31956-8-git-send-email-cw00.choi@samsung.com>
References: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
 <CGME20171013074836epcas2p4e70bca2ebe9446353abf5c14a9d16460@epcas2p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, inki.dae@samsung.com, Kukjin Kim <kgene@kernel.org>, chanwoo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Prior to that, the devfreq device uses the governor name when adding
the itself. In order to prevent the mistake used the wrong governor name,
this patch defines the governor name as a constant and then uses them
instead of using the string directly.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/devfreq/exynos-bus.c              | 5 +++--
 drivers/devfreq/governor_passive.c        | 2 +-
 drivers/devfreq/governor_performance.c    | 2 +-
 drivers/devfreq/governor_powersave.c      | 2 +-
 drivers/devfreq/governor_simpleondemand.c | 2 +-
 drivers/devfreq/governor_userspace.c      | 2 +-
 drivers/devfreq/rk3399_dmc.c              | 2 +-
 include/linux/devfreq.h                   | 7 +++++++
 8 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 49f68929e024..c25658b26598 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -436,7 +436,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	ondemand_data->downdifferential = 5;
 
 	/* Add devfreq device to monitor and handle the exynos bus */
-	bus->devfreq = devm_devfreq_add_device(dev, profile, "simple_ondemand",
+	bus->devfreq = devm_devfreq_add_device(dev, profile,
+						DEVFREQ_GOV_SIMPLE_ONDEMAND,
 						ondemand_data);
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev, "failed to add devfreq device\n");
@@ -488,7 +489,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	passive_data->parent = parent_devfreq;
 
 	/* Add devfreq device for exynos bus with passive governor */
-	bus->devfreq = devm_devfreq_add_device(dev, profile, "passive",
+	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
 						passive_data);
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev,
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 673ad8cc9a1d..3bc29acbd54e 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -183,7 +183,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 }
 
 static struct devfreq_governor devfreq_passive = {
-	.name = "passive",
+	.name = DEVFREQ_GOV_PASSIVE,
 	.immutable = 1,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index c72f942f30a8..4d23ecfbd948 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -42,7 +42,7 @@ static int devfreq_performance_handler(struct devfreq *devfreq,
 }
 
 static struct devfreq_governor devfreq_performance = {
-	.name = "performance",
+	.name = DEVFREQ_GOV_PERFORMANCE,
 	.get_target_freq = devfreq_performance_func,
 	.event_handler = devfreq_performance_handler,
 };
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 0c6bed567e6d..0c42f23249ef 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -39,7 +39,7 @@ static int devfreq_powersave_handler(struct devfreq *devfreq,
 }
 
 static struct devfreq_governor devfreq_powersave = {
-	.name = "powersave",
+	.name = DEVFREQ_GOV_POWERSAVE,
 	.get_target_freq = devfreq_powersave_func,
 	.event_handler = devfreq_powersave_handler,
 };
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ae72ba5e78df..28e0f2de7100 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -125,7 +125,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 }
 
 static struct devfreq_governor devfreq_simple_ondemand = {
-	.name = "simple_ondemand",
+	.name = DEVFREQ_GOV_SIMPLE_ONDEMAND,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
 };
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 77028c27593c..080607c3f34d 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -87,7 +87,7 @@ static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
 	NULL,
 };
 static const struct attribute_group dev_attr_group = {
-	.name	= "userspace",
+	.name	= DEVFREQ_GOV_USERSPACE,
 	.attrs	= dev_entries,
 };
 
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 1b89ebbad02c..5dfbfa3cc878 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -431,7 +431,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	data->devfreq = devm_devfreq_add_device(dev,
 					   &rk3399_devfreq_dmc_profile,
-					   "simple_ondemand",
+					   DEVFREQ_GOV_SIMPLE_ONDEMAND,
 					   &data->ondemand_data);
 	if (IS_ERR(data->devfreq))
 		return PTR_ERR(data->devfreq);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 5dc6190e479c..682419a32aa3 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -19,6 +19,13 @@
 
 #define DEVFREQ_NAME_LEN 16
 
+/* DEVFREQ governor name */
+#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
+#define DEVFREQ_GOV_PERFORMANCE		"performance"
+#define DEVFREQ_GOV_POWERSAVE		"powersave"
+#define DEVFREQ_GOV_USERSPACE		"userspace"
+#define DEVFREQ_GOV_PASSIVE		"passive"
+
 /* DEVFREQ notifier interface */
 #define DEVFREQ_TRANSITION_NOTIFIER	(0)
 
-- 
1.9.1

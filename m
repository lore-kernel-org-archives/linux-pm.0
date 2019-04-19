From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 2/4] drivers: devfreq: events: extend events by type of
 counted data
Date: Fri, 19 Apr 2019 15:48:06 +0200
Message-ID: <1555681688-19643-3-git-send-email-l.luba@partner.samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, willy.mh.wolff.ml@gmail.com, kgene@kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, l.luba@partner.samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org, myungjoo.ham@samsung.com, s.nawrocki@samsung.com, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch adds posibility to choose what type of data should be counted
by the PPMU counter. Now the type comes from DT where the event has been
defined. When there is no 'event-data-type' the default value is used,
which is 'read data in bytes'.
It is needed when you want to know not only read+write data bytes but
i.e. only write data in byte, or number of read requests, etc.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 61 +++++++++++++++++++++++++------------
 include/linux/devfreq-event.h       |  6 ++++
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0b..073bf2c 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -154,9 +154,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		return ret;
 
-	/* Set the event of Read/Write data count  */
+	/* Set the event of proper data type monitoring */
 	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
-				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
+			   edev->desc->data_type);
 	if (ret < 0)
 		return ret;
 
@@ -368,23 +368,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		return ret;
 
-	/* Set the event of Read/Write data count  */
-	switch (id) {
-	case PPMU_PMNCNT0:
-	case PPMU_PMNCNT1:
-	case PPMU_PMNCNT2:
-		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
-				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
-		if (ret < 0)
-			return ret;
-		break;
-	case PPMU_PMNCNT3:
-		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
-				PPMU_V2_EVT3_RW_DATA_CNT);
-		if (ret < 0)
-			return ret;
-		break;
-	}
+	/* Set the event of proper data type monitoring */
+	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
+			   edev->desc->data_type);
+	if (ret < 0)
+		return ret;
 
 	/* Reset cycle counter/performance counter and enable PPMU */
 	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
@@ -508,6 +496,7 @@ static int of_get_devfreq_events(struct device_node *np,
 	struct device *dev = info->dev;
 	struct device_node *events_np, *node;
 	int i, j, count;
+	int ret;
 
 	events_np = of_get_child_by_name(np, "events");
 	if (!events_np) {
@@ -544,6 +533,40 @@ static int of_get_devfreq_events(struct device_node *np,
 		desc[j].driver_data = info;
 
 		of_property_read_string(node, "event-name", &desc[j].name);
+		ret = of_property_read_u32(node, "event-data-type",
+					   &desc[j].data_type);
+		if (ret) {
+			/* Set the event of proper data type counting.
+			 * Check if the data type has been defined in DT,
+			 * use default if not.
+			 */
+			if (of_device_is_compatible(np,
+					"samsung,exynos-ppmu-v2")) {
+				struct devfreq_event_dev edev;
+				int id;
+				/* Not all registers take the same value for
+				 * read+write data count.
+				 */
+				edev.desc = &desc[j];
+				id = exynos_ppmu_find_ppmu_id(&edev);
+
+				switch (id) {
+				case PPMU_PMNCNT0:
+				case PPMU_PMNCNT1:
+				case PPMU_PMNCNT2:
+					desc[j].data_type = PPMU_V2_RO_DATA_CNT
+						| PPMU_V2_WO_DATA_CNT;
+					break;
+				case PPMU_PMNCNT3:
+					desc[j].data_type =
+						PPMU_V2_EVT3_RW_DATA_CNT;
+					break;
+				}
+			} else {
+				desc[j].data_type = PPMU_RO_DATA_CNT |
+					PPMU_WO_DATA_CNT;
+			}
+		}
 
 		j++;
 	}
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 4db00b0..cc160b1 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -81,14 +81,20 @@ struct devfreq_event_ops {
  * struct devfreq_event_desc - the descriptor of devfreq-event device
  *
  * @name	: the name of devfreq-event device.
+ * @data_type	: the data type which is going to be counted in the register.
  * @driver_data	: the private data for devfreq-event driver.
  * @ops		: the operation to control devfreq-event device.
  *
  * Each devfreq-event device is described with a this structure.
  * This structure contains the various data for devfreq-event device.
+ * The data_type describes what is going to be counted in the register.
+ * It might choose to count e.g. read requests, write data in bytes, etc.
+ * The full supported list of types is present in specyfic header in:
+ * include/dt-bindings/pmu/.
  */
 struct devfreq_event_desc {
 	const char *name;
+	u32 data_type;
 	void *driver_data;
 
 	const struct devfreq_event_ops *ops;
-- 
2.7.4

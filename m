From: Andrew-sh.Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/4] opp: add API which get max freq by voltage
Date: Fri, 29 Mar 2019 14:46:10 +0800
Message-ID: <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1553841972-19737-1-git-send-email-andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob
 Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias
 Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew-sh.Cheng" <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This API will get voltage as input parameter.
Search all opp items for the item which with max frequency,
and the voltae is smaller than provided voltage.

Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0420f7e..7323cd9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -526,6 +526,61 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/**
+ * dev_pm_opp_find_max_freq_by_volt() - Search for a opp with max freq
+ * under provided voltage
+ * @dev:	device for which we do this operation
+ * @u_volt:	provided voltage
+ *
+ * Search for the matching available OPP which provide voltage can support.
+ *
+ * Return: matching *opp, else returns ERR_PTR in case of error
+ * and should be handled using IS_ERR.
+ * Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
+					      unsigned long u_volt)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	if (!dev || !u_volt) {
+		dev_err(dev, "%s: Invalid argument volt=%d\n", __func__,
+			u_volt);
+		return ERR_PTR(-EINVAL);
+	}
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available) {
+			/* go to the next node, before choosing prev */
+			if (temp_opp->supplies[0].u_volt > u_volt)
+				break;
+			opp = temp_opp;
+		}
+	}
+
+	/* Increment the reference count of OPP */
+	if (!IS_ERR(opp))
+		dev_pm_opp_get(opp);
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_max_freq_by_volt);
+
 static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 			    struct dev_pm_opp_supply *supply)
 {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 24c757a..57deef9 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -102,6 +102,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
+struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
+					      unsigned long u_volt);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
@@ -207,6 +209,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
+					      unsigned long u_volt)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					unsigned long *freq)
 {
-- 
1.8.1.1.dirty

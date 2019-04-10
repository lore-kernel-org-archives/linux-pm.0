From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/4] opp: add API which get max freq by voltage
Date: Wed, 10 Apr 2019 11:59:09 +0530
Message-ID: <20190410062909.6nkl4m4j5evrmqrl@vireshk-i7>
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, fan.chen@mediatek.com
List-Id: linux-pm@vger.kernel.org

On 29-03-19, 14:46, Andrew-sh.Cheng wrote:
> This API will get voltage as input parameter.
> Search all opp items for the item which with max frequency,
> and the voltae is smaller than provided voltage.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 ++++++++
>  2 files changed, 63 insertions(+)

I have applied this patch with some modifications, here is the diff:

---
 drivers/opp/core.c     | 29 ++++++++++++++---------------
 include/linux/pm_opp.h |  8 ++++----
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7323cd9aabf9..0e7703fe733f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -527,31 +527,30 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
 /**
- * dev_pm_opp_find_max_freq_by_volt() - Search for a opp with max freq
- * under provided voltage
- * @dev:	device for which we do this operation
- * @u_volt:	provided voltage
+ * dev_pm_opp_find_freq_ceil_by_volt() - Find OPP with highest frequency for
+ *					 target voltage.
+ * @dev:	Device for which we do this operation.
+ * @u_volt:	Target voltage.
+ *
+ * Search for OPP with highest (ceil) frequency and has voltage <= u_volt.
  *
- * Search for the matching available OPP which provide voltage can support.
+ * Return: matching *opp, else returns ERR_PTR in case of error which should be
+ * handled using IS_ERR.
  *
- * Return: matching *opp, else returns ERR_PTR in case of error
- * and should be handled using IS_ERR.
  * Error return values can be:
- * EINVAL:	for bad pointer
- * ERANGE:	no match found for search
- * ENODEV:	if device not found in list of registered devices
+ * EINVAL:	bad parameters
  *
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
-					      unsigned long u_volt)
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
+						     unsigned long u_volt)
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	if (!dev || !u_volt) {
-		dev_err(dev, "%s: Invalid argument volt=%d\n", __func__,
+		dev_err(dev, "%s: Invalid argument volt=%lu\n", __func__,
 			u_volt);
 		return ERR_PTR(-EINVAL);
 	}
@@ -564,7 +563,6 @@ struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
 
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available) {
-			/* go to the next node, before choosing prev */
 			if (temp_opp->supplies[0].u_volt > u_volt)
 				break;
 			opp = temp_opp;
@@ -574,12 +572,13 @@ struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
 	/* Increment the reference count of OPP */
 	if (!IS_ERR(opp))
 		dev_pm_opp_get(opp);
+
 	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return opp;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_find_max_freq_by_volt);
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_by_volt);
 
 static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 			    struct dev_pm_opp_supply *supply)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 57deef9cf5d3..b150fe97ce5a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -102,8 +102,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
-struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
-					      unsigned long u_volt);
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
+						     unsigned long u_volt);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
@@ -209,8 +209,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
-					      unsigned long u_volt)
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
+					unsigned long u_volt)
 {
 	return ERR_PTR(-ENOTSUPP);
 }

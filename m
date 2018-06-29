From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] PM / Domains: Introduce dev_pm_domain_attach_by_name()
Date: Fri, 29 Jun 2018 13:04:32 +0200
Message-ID: <20180629110432.5179-4-ulf.hansson@linaro.org>
References: <20180629110432.5179-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180629110432.5179-1-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <dev@lynxeye.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Todor Tomov <todor.tomov@linaro.org>, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

For the multiple PM domain case, let's introduce a new API called
dev_pm_domain_attach_by_name(). This allows a consumer driver to associate
its device with one of its PM domains, by using a name based lookup.

Do note that, currently it's only genpd that supports multiple PM domains
per device, but dev_pm_domain_attach_by_name() can easily by extended to
cover other PM domain types, if/when needed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 17 +++++++++++++++++
 include/linux/pm_domain.h   |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index df41b4780b3b..b413951c6abc 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -152,6 +152,23 @@ struct device *dev_pm_domain_attach_by_id(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_id);
 
+/**
+ * dev_pm_domain_attach_by_name - Associate a device with one of its PM domains.
+ * @dev: The device used to lookup the PM domain.
+ * @name: The name of the PM domain.
+ *
+ * For a detailed function description, see dev_pm_domain_attach_by_id().
+ */
+struct device *dev_pm_domain_attach_by_name(struct device *dev,
+					    char *name)
+{
+	if (dev->pm_domain)
+		return ERR_PTR(-EEXIST);
+
+	return genpd_dev_pm_attach_by_name(dev, name);
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
+
 /**
  * dev_pm_domain_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 03e14a38462d..776c546d581a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -309,6 +309,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 int dev_pm_domain_attach(struct device *dev, bool power_on);
 struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
+struct device *dev_pm_domain_attach_by_name(struct device *dev,
+					    char *name);
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 #else
@@ -321,6 +323,11 @@ static inline struct device *dev_pm_domain_attach_by_id(struct device *dev,
 {
 	return NULL;
 }
+static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
+							  char *name)
+{
+	return NULL;
+}
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
-- 
2.17.1

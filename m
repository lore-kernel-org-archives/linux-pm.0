From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] PM / Domains: Introduce option to attach a device by name
 to genpd
Date: Fri, 29 Jun 2018 13:04:31 +0200
Message-ID: <20180629110432.5179-3-ulf.hansson@linaro.org>
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

For the multiple PM domain case, let's introduce a new function called
genpd_dev_pm_attach_by_name(). This allows a device to be associated with
its PM domain through genpd, by using a name based lookup.

Note that, genpd_dev_pm_attach_by_name() shall only be called by the driver
core / PM core, similar to how the existing dev_pm_domain_attach_by_id()
makes use of genpd_dev_pm_attach_by_id(). However, this is implemented by
following changes on top.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c298de8a8308..a70e4b7a3b14 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2372,6 +2372,30 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
 
+/**
+ * genpd_dev_pm_attach_by_name - Associate a device with one of its PM domains.
+ * @dev: The device used to lookup the PM domain.
+ * @name: The name of the PM domain.
+ *
+ * Parse device's OF node to find a PM domain specifier using the
+ * power-domain-names DT property. For further description see
+ * genpd_dev_pm_attach_by_id().
+ */
+struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
+{
+	int index;
+
+	if (!dev->of_node)
+		return NULL;
+
+	index = of_property_match_string(dev->of_node, "power-domain-names",
+					 name);
+	if (index < 0)
+		return NULL;
+
+	return genpd_dev_pm_attach_by_id(dev, index);
+}
+
 static const struct of_device_id idle_state_match[] = {
 	{ .compatible = "domain-idle-state", },
 	{ }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index cb8d84090cfb..03e14a38462d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -239,6 +239,8 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
+struct device *genpd_dev_pm_attach_by_name(struct device *dev,
+					   char *name);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -290,6 +292,12 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	return NULL;
 }
 
+static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
+							 char *name)
+{
+	return NULL;
+}
+
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
-- 
2.17.1

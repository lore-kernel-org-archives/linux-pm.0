From: Dmitry Osipenko <digetx@gmail.com>
Subject: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage regulators
Date: Sun, 21 Oct 2018 23:54:45 +0300
Message-ID: <20181021205501.23943-2-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Voltage regulators may be not available on some variations of HW, allow to
request stub voltage regulators by OPP core in a such case to reduce code
churning within drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/cpufreq-dt.c | 2 +-
 drivers/cpufreq/ti-cpufreq.c | 3 ++-
 drivers/opp/core.c           | 9 +++++++--
 include/linux/pm_opp.h       | 4 ++--
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..6ebca472ec76 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -196,7 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 */
 	name = find_supply_name(cpu_dev);
 	if (name) {
-		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
+		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1, false);
 		if (IS_ERR(opp_table)) {
 			ret = PTR_ERR(opp_table);
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3f0e2a14895a..9099c8cdf447 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -268,7 +268,8 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (opp_data->soc_data->multi_regulator) {
 		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
 							 reg_names,
-							 ARRAY_SIZE(reg_names));
+							 ARRAY_SIZE(reg_names),
+							 false);
 		if (IS_ERR(ti_opp_table)) {
 			dev_pm_opp_put_supported_hw(opp_data->opp_table);
 			ret =  PTR_ERR(ti_opp_table);
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e4fc14..fba1d7a1eb7c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1365,6 +1365,7 @@ static void _free_set_opp_data(struct opp_table *opp_table)
  * @dev: Device for which regulator name is being set.
  * @names: Array of pointers to the names of the regulator.
  * @count: Number of regulators.
+ * @allow_stub_regulator: Some or all regulators can be missed.
  *
  * In order to support OPP switching, OPP layer needs to know the name of the
  * device's regulators, as the core would be required to switch voltages as
@@ -1374,7 +1375,8 @@ static void _free_set_opp_data(struct opp_table *opp_table)
  */
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 					    const char * const names[],
-					    unsigned int count)
+					    unsigned int count,
+					    bool allow_stub_regulator)
 {
 	struct opp_table *opp_table;
 	struct regulator *reg;
@@ -1403,7 +1405,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	}
 
 	for (i = 0; i < count; i++) {
-		reg = regulator_get_optional(dev, names[i]);
+		if (allow_stub_regulator)
+			reg = regulator_get(dev, names[i]);
+		else
+			reg = regulator_get_optional(dev, names[i]);
 		if (IS_ERR(reg)) {
 			ret = PTR_ERR(reg);
 			if (ret != -EPROBE_DEFER)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5d399eeef172..480666b0a008 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -120,7 +120,7 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *ver
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
+struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count, bool allow_stub_regulator);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
@@ -258,7 +258,7 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count)
+static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count, bool allow_stub_regulator)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-- 
2.19.0

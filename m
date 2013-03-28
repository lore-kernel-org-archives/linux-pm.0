From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 04/12] PM / Domains: Lookup domain by name
Date: Thu, 28 Mar 2013 17:11:30 +0100
Message-ID: <1364487098-10319-5-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hongbo.zhang@linaro.org, ulf.hansson@linaro.org, khilman@linaro.org, linus.walleij@stericsson.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com
List-Id: linux-pm@vger.kernel.org

Make the function pm_genpd_lookup_name(..) non
static. This is done to limit the need for "name
functions" as e.g. pm_genpd_name_attach_cpuidle.
Also the name lookup takes a mutex and should not
be called when IRQ's are off. So by exporting this
function the name lookup can be done before IRQ's
are off.
Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/base/power/domain.c | 2 +-
 include/linux/pm_domain.h   | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 91e3b7d..a8755cb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -53,7 +53,7 @@
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
-static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
+struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
 {
 	struct generic_pm_domain *genpd = NULL, *gpd;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bf5e7d514..0fa2d5e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -129,7 +129,7 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 }
 
 extern struct dev_power_governor simple_qos_governor;
-
+extern struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name);
 extern struct generic_pm_domain *dev_to_genpd(struct device *dev);
 extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
@@ -181,6 +181,10 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 {
 	return ERR_PTR(-ENOSYS);
 }
+static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
+{
+	return ERR_PTR(-ENOSYS);
+}
 static inline struct generic_pm_domain *dev_to_genpd(struct device *dev)
 {
 	return ERR_PTR(-ENOSYS);
-- 
1.8.2

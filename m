From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/5] power: domain: add pm_genpd_exit
Date: Fri,  4 Dec 2015 09:45:44 -0800
Message-ID: <1449251148-19344-2-git-send-email-eric@anholt.net>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449251148-19344-1-git-send-email-eric@anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Eric Anholt <eric@anholt.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Alexander Aring <alex.aring@gmail.com>

This patch adds function pm_genpd_exit for undo a pm_genpd_init. This
is useful for multiple power domains while probing. If the probing fails
after one pm_genpd_init was called we need to undo all previous
registrations of generic pm domains inside the gpd_list list.

There is a check on IS_ERR_OR_NULL(genpd) which is useful to check again
registered power domains and not registered domains, the driver can use
this mechanism to have an array with registered and non-registered power
domains, where non-registered power domains are NULL.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 22 ++++++++++++++++++++++
 include/linux/pm_domain.h   |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 167418e..e7aca27 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1509,6 +1509,28 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
+/**
+ * pm_genpd_exit - Uninitialize a generic I/O PM domain object.
+ * @genpd: PM domain object to uninitialize.
+ */
+void pm_genpd_exit(struct generic_pm_domain *genpd)
+{
+	if (IS_ERR_OR_NULL(genpd))
+		return;
+
+	/* check if domain is still in registered inside the pm subsystem */
+	WARN_ON_ONCE(!list_empty(&genpd->master_links) ||
+		     !list_empty(&genpd->slave_links) ||
+		     !list_empty(&genpd->dev_list));
+
+	mutex_lock(&gpd_list_lock);
+	list_del(&genpd->gpd_list_node);
+	mutex_unlock(&gpd_list_lock);
+
+	mutex_destroy(&genpd->lock);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_exit);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 /*
  * Device Tree based PM domain providers.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ba4ced3..5020b36 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -123,6 +123,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
+extern void pm_genpd_exit(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -161,6 +162,9 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off)
 {
 }
+static inline void pm_genpd_exit(struct generic_pm_domain *genpd)
+{
+}
 #endif
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-- 
2.6.2

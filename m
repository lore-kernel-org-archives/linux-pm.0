From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 9/9] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Mon, 13 Oct 2014 16:02:10 +0200
Message-ID: <1413208930-26019-10-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

There are currently no users of this API, let's remove it.

Additionally, if such feature would be needed future wise, a better
option is likely use pm_runtime_set_active|suspended() in some form.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/base/power/domain.c | 20 --------------------
 include/linux/pm_domain.h   |  2 --
 2 files changed, 22 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 96fe72e..a717132 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1554,26 +1554,6 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 }
 
 /**
- * pm_genpd_dev_need_restore - Set/unset the device's "need restore" flag.
- * @dev: Device to set/unset the flag for.
- * @val: The new value of the device's "need restore" flag.
- */
-void pm_genpd_dev_need_restore(struct device *dev, bool val)
-{
-	struct pm_subsys_data *psd;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev->power.lock, flags);
-
-	psd = dev_to_psd(dev);
-	if (psd && psd->domain_data)
-		to_gpd_data(psd->domain_data)->need_restore = val;
-
-	spin_unlock_irqrestore(&dev->power.lock, flags);
-}
-EXPORT_SYMBOL_GPL(pm_genpd_dev_need_restore);
-
-/**
  * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
  * @genpd: Master PM domain to add the subdomain to.
  * @subdomain: Subdomain to be added.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 7b3cba2..d5df64e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -130,7 +130,6 @@ extern int __pm_genpd_name_add_device(const char *domain_name,
 
 extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 				  struct device *dev);
-extern void pm_genpd_dev_need_restore(struct device *dev, bool val);
 extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 				  struct generic_pm_domain *new_subdomain);
 extern int pm_genpd_add_subdomain_names(const char *master_name,
@@ -176,7 +175,6 @@ static inline int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
-static inline void pm_genpd_dev_need_restore(struct device *dev, bool val) {}
 static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 					 struct generic_pm_domain *new_sd)
 {
-- 
1.9.1

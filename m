From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
Date: Thu, 14 Feb 2019 10:12:48 -0800
Message-ID: <20190214181249.2749-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

The genpd_dev_pm_attach_by_name() simply takes the name and passes it
to of_property_match_string() where the argument is "const char *".
Adding a const here allows a later patch to add a const to
dev_pm_domain_attach_by_name() which allows drivers to pass in a name
that was declared "const" in a driver.

Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/power/domain.c | 2 +-
 include/linux/pm_domain.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 45eafe8cf7dd..2c334c01fc43 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2483,7 +2483,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
  * power-domain-names DT property. For further description see
  * genpd_dev_pm_attach_by_id().
  */
-struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
+struct device *genpd_dev_pm_attach_by_name(struct device *dev, const char *name)
 {
 	int index;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index dd364abb649a..203be5082f33 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -271,7 +271,7 @@ int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
-					   char *name);
+					   const char *name);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -324,7 +324,7 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 }
 
 static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
-							 char *name)
+							 const char *name)
 {
 	return NULL;
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/05] PM: export pm_genpd_poweron() in header
Date: Thu, 07 Jul 2011 22:32:45 +0900
Message-ID: <20110707133245.22347.42754.sendpatchset__38218.7584219084$1310045247$gmane$org@t400s>
References: <20110707133212.22347.68775.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110707133212.22347.68775.sendpatchset@t400s>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-sh@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Allow SoC-specific code to call pm_genpd_poweron().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Perhaps there are better ways to deal with this?

 drivers/base/power/domain.c |    2 +-
 include/linux/pm_domain.h   |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- 0001/drivers/base/power/domain.c
+++ work/drivers/base/power/domain.c	2011-07-07 21:37:49.000000000 +0900
@@ -37,7 +37,7 @@ static void genpd_sd_counter_dec(struct
  * Restore power to @genpd and all of its parents so that it is possible to
  * resume a device belonging to it.
  */
-static int pm_genpd_poweron(struct generic_pm_domain *genpd)
+int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
 	int ret = 0;
 
--- 0001/include/linux/pm_domain.h
+++ work/include/linux/pm_domain.h	2011-07-07 21:37:49.000000000 +0900
@@ -63,6 +63,7 @@ extern int pm_genpd_remove_subdomain(str
 				     struct generic_pm_domain *target);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
+extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 #else
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 				      struct device *dev)
@@ -86,6 +87,10 @@ static inline int pm_genpd_remove_subdom
 }
 static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off) {}
+static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
+{
+	return -ENOSYS;
+}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */

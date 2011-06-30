From: jean.pihet@newoldbits.com
Subject: [PATCH 09/11] OMAP2+: omap_hwmod: manage the wake-up
	latency constraints
Date: Thu, 30 Jun 2011 17:11:23 +0200
Message-ID: <1309446685-17502-10-git-send-email-j-pihet__43045.1150903993$1309447205$gmane$org@ti.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lis>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Hwmod is queried from the OMAP_PM layer to manage the power domains
wake-up latency constraints. Hwmod retrieves the correct power domain
and if it exists it calls the corresponding power domain function.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   26 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..69fa946 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -142,6 +142,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -2322,11 +2323,34 @@ ohsps_unlock:
 	return ret;
 }
 
+/*
+ * omap_hwmod_set_wkup_constraint- set/release a wake-up latency constraint
+ *
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ * @min_latency: the minimum allowed wake-up latency for @oh.
+ *
+ * Returns 0 upon success.
+ */
+int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh,
+				       void *cookie, long min_latency)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!pwrdm) {
+		pr_err("%s: Error: could not find powerdomain "
+		       "for %s\n", __func__, oh->name);
+		return -EINVAL;
+	}
+
+	return pwrdm_set_wkup_lat_constraint(pwrdm, cookie, min_latency);
+}
+
 /**
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
- * Query the powerdomain of of @oh to get the context loss
+ * Query the powerdomain of @oh to get the context loss
  * count for this device.
  *
  * Returns the context loss count of the powerdomain assocated with @oh
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..bf9e81d 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -598,6 +598,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh, void *cookie,
+				       long min_latency);
 u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
-- 
1.7.4.1

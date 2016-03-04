From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/2] PM / clk: Add stubs for pm_clk_suspend/resume
Date: Fri, 4 Mar 2016 15:33:04 +0000
Message-ID: <1457105585-25157-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The functions pm_clk_suspend() and pm_clk_resume() cannot be used
directly within the main body of a function, because when CONFIG_PM_CLK
is not defined the functions are defined as NULL and this will lead to
a compilation error.

Add stubs functions for pm_clk_suspend() and pm_clk_resume() so that
these functions may be called directly.

Please note that these functions are currently assigned to function
pointers in the PM domain core and so to avoid have a valid function
pointer defined when CONFIG_PM_CLK is not defined, define
GENPD_FLAG_PM_CLK as 0 when CONFIG_PM_CLK is not defined to ensure
the stubs are not populated as valid function pointers.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 include/linux/pm_clock.h  | 10 ++++++++--
 include/linux/pm_domain.h |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 25266c600021..ffefbf2df1aa 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -72,8 +72,14 @@ static inline int pm_clk_add_clk(struct device *dev, struct clk *clk)
 static inline void pm_clk_remove(struct device *dev, const char *con_id)
 {
 }
-#define pm_clk_suspend	NULL
-#define pm_clk_resume	NULL
+static inline int pm_clk_suspend(struct device *dev)
+{
+	return -EINVAL;
+}
+static inline int pm_clk_resume(struct device *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #ifdef CONFIG_HAVE_CLK
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 49cd8890b873..1074c2073df8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,7 +17,11 @@
 #include <linux/notifier.h>
 
 /* Defines used for the flags field in the struct generic_pm_domain */
+#ifdef CONFIG_PM_CLK
 #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
+#else
+#define GENPD_FLAG_PM_CLK	0
+#endif
 
 #define GENPD_MAX_NUM_STATES	8 /* Number of possible low power states */
 
-- 
2.1.4

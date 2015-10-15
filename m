From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/4] PM / OPP: Improve debug print messages with pr_fmt
Date: Thu, 15 Oct 2015 21:42:43 +0530
Message-ID: <d3072ab1f6665e63d2e26db75a3d598b241d423e.1444925400.git.viresh.kumar@linaro.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

With debug options on, it is difficult to locate OPP core's debug
prints. Fix this by prefixing OPP debug prints with KBUILD_MODNAME.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 2 ++
 drivers/base/power/opp/cpu.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d5c1149ff123..a422ebf2501f 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -11,6 +11,8 @@
  * published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 7654c5606307..c27a1cdffec9 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -10,6 +10,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/err.h>
-- 
2.4.0

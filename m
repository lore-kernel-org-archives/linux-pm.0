From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/16] PM / OPP: Improve debug print messages with pr_fmt
Date: Fri, 11 Sep 2015 17:31:59 +0530
Message-ID: <33f4074a73101dd58587fa68422db26308f96062.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

With debug options on, it is difficult to locate OPP core's debug
prints. Fix this by prefixing OPP debug prints with KBUILD_MODNAME.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 2 ++
 drivers/base/power/opp/cpu.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 8a72f0e586e8..113fdd0ce6d9 100644
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
index 3d946b508a13..9ac691341fb0 100644
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

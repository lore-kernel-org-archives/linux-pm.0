From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/4] PM / OPP: Improve print messages with pr_fmt
Date: Sat, 17 Oct 2015 09:45:18 +0530
Message-ID: <d3072ab1f6665e63d2e26db75a3d598b241d423e.1445055113.git.viresh.kumar@linaro.org>
References: <20151016192031.GB16437@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33863 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbbJQEQh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2015 00:16:37 -0400
Received: by pabws5 with SMTP id ws5so7614246pab.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 21:16:36 -0700 (PDT)
In-Reply-To: <20151016192031.GB16437@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

To identify OPP core's print messages easily, prefix them with
KBUILD_MODNAME.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Improved commit-log.

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


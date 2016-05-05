From: Eric Engestrom <eric.engestrom@imgtec.com>
Subject: [PATCH v2] Fix CONFIG_PM_OPP without CONFIG_OF build failure
Date: Thu, 5 May 2016 10:14:18 +0100
Message-ID: <1462439658-4523-1-git-send-email-eric.engestrom@imgtec.com>
References: <20160505030109.GG2573@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:18181 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbcEEJOY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 05:14:24 -0400
In-Reply-To: <20160505030109.GG2573@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rufus Hamade <rufus.hamade@imgtec.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rufus Hamade <rufus.hamade@imgtec.com>

A few `#ifdef CONFIG_OF` were missing, resulting in "unused function"
warnings in core.c.

Signed-off-by: Rufus Hamade <rufus.hamade@imgtec.com>
Reviewed-by: Eric Engestrom <eric.engestrom@imgtec.com>
Tested-by: Eric Engestrom <eric.engestrom@imgtec.com>
---
v2: drop incorrect change in cpu.c (Viresh Kumar)

On Thu, May 05, 2016 at 08:31:09AM +0530, Viresh Kumar wrote:
> Some things have already changed, can you please rebase on linux-next
> and resend this patch?

I rebased on top of linux-next (30d0993ec9f6) from the repo
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
but there were no change (the patch is identical, save for the
removed change in cpu.c; not even a line number changed).
Which repo did you want me to rebase on?

---
 drivers/base/power/opp/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 433b600..bc5448c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -53,6 +53,7 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
 	return NULL;
 }
 
+#ifdef CONFIG_OF
 static struct opp_table *_managed_opp(const struct device_node *np)
 {
 	struct opp_table *opp_table;
@@ -72,6 +73,7 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 
 	return NULL;
 }
+#endif
 
 /**
  * _find_opp_table() - find opp_table struct using device pointer
@@ -1115,6 +1117,7 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	return ret;
 }
 
+#ifdef CONFIG_OF
 /* TODO: Support multiple regulators */
 static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			      struct opp_table *opp_table)
@@ -1191,6 +1194,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 
 	return 0;
 }
+#endif
 
 /**
  * dev_pm_opp_set_supported_hw() - Set supported platforms
@@ -1520,6 +1524,7 @@ void dev_pm_opp_put_regulator(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulator);
 
+#ifdef CONFIG_OF
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
@@ -1657,6 +1662,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	mutex_unlock(&opp_table_lock);
 	return ret;
 }
+#endif
 
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
-- 
2.8.2


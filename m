From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] cpufreq: arm_big_little: fix module license spec
Date: Fri,  8 Aug 2014 08:56:30 +0200
Message-ID: <1407480990-4767-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41744 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaHHG4w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Aug 2014 02:56:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-pm@vger.kernel.org

Having no license specification in a module taints the kernel during lo=
ad
with:

	arm_big_little: module license 'unspecified' taints kernel.

and also the linker doesn't allow it to make use of GPL-exported symbol=
s
which in this case also results in errors like:

	arm_big_little: Unknown symbol cpufreq_register_driver (err 0)

=2E The header of the driver specifies a GPL v2 license, so note that
accordingly. While at it also add a description and an author and fix
the license in a companion file to explicit v2.

Reported-by: Andreas Schwab <schwab@suse.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1, sent with Message-Id:
1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de:

 - Add #include <linux/module.h> to fix build failure
 - Add ack by Viresh Kumar

 drivers/cpufreq/arm_big_little.c    | 5 +++++
 drivers/cpufreq/arm_big_little_dt.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big=
_little.c
index 1f4d4e315057..a46c223c2506 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -24,6 +24,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
@@ -593,3 +594,7 @@ void bL_cpufreq_unregister(struct cpufreq_arm_bL_op=
s *ops)
 	arm_bL_ops =3D NULL;
 }
 EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
+
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_=
big_little_dt.c
index 8d9d59108906..4550f6976768 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -114,4 +114,4 @@ module_platform_driver(generic_bL_platdrv);
=20
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver via DT");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
--=20
2.0.1


From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] PM / OPP: fix condition for empty of_init_opp_table()
Date: Thu, 21 Feb 2013 19:04:45 +0800
Message-ID: <1361444685-1034-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:16698
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753318Ab3BULEh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Feb 2013 06:04:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

randconfig build reports the following error which is caused by that
CONFIG_PM_OPP is unset.

  CC      arch/arm/mach-imx/mach-imx6q.o
arch/arm/mach-imx/mach-imx6q.c: In function =E2=80=98imx6q_opp_init=E2=80=
=99:
arch/arm/mach-imx/mach-imx6q.c:248:2: error: implicit declaration of fu=
nction =E2=80=98of_init_opp_table=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]

=46ix the error by giving a more correct condition for empty
of_init_opp_table() implementation.

Reported-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/linux/opp.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/opp.h b/include/linux/opp.h
index 214e0eb..3aca2b8 100644
--- a/include/linux/opp.h
+++ b/include/linux/opp.h
@@ -47,15 +47,6 @@ int opp_enable(struct device *dev, unsigned long fre=
q);
 int opp_disable(struct device *dev, unsigned long freq);
=20
 struct srcu_notifier_head *opp_get_notifier(struct device *dev);
-
-#ifdef CONFIG_OF
-int of_init_opp_table(struct device *dev);
-#else
-static inline int of_init_opp_table(struct device *dev)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_OF */
 #else
 static inline unsigned long opp_get_voltage(struct opp *opp)
 {
@@ -112,6 +103,15 @@ static inline struct srcu_notifier_head *opp_get_n=
otifier(struct device *dev)
 }
 #endif		/* CONFIG_PM_OPP */
=20
+#if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
+int of_init_opp_table(struct device *dev);
+#else
+static inline int of_init_opp_table(struct device *dev)
+{
+	return -EINVAL;
+}
+#endif
+
 #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
 int opp_init_cpufreq_table(struct device *dev,
 			    struct cpufreq_frequency_table **table);
--=20
1.7.9.5



From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V2 PATCH] cpuidle: add maintainer entry
Date: Fri, 26 Apr 2013 13:05:44 +0200
Message-ID: <1366974344-26064-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:50497 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab3DZLFs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2013 07:05:48 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so2083678wgh.12
        for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2013 04:05:47 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, khilman@deeprootsystems.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, kernel@pengutronix.de, swarren@wwwdotorg.org, horms+renesas@verge.net.au, josephl@nvidia.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, horms@verge.net.au, magnus.damm@gmail.com, benh@kernel.crashing.org, paulus@samba.org, kgene.kim@samsung.com, linus.walleij@linaro.org, viresh.kumar@linaro.org, lenb@kernel.org, nsekhar@ti.com, ben-linux@fluff.org

Currently the cpuidle drivers are spread across the different archs.

The patch submission for cpuidle are following different path: the cpuidle core
code goes to linux-pm, the ARM drivers goes to arm-soc or the SoC specific
tree, sh goes through sh arch tree, pseries goes through PowerPC and
finally intel goes through Len's tree while acpi_idle goes under linux-pm.

That makes difficult to consolidate the code and to propagate modifications
from the cpuidle core to the different drivers.

Hopefully, a movement has initiated to put the cpuidle drivers into the
drivers/cpuidle directory like cpuidle-calxeda.c and cpuidle-kirkwood.c

Add an explicit maintainer entry in the MAINTAINER to clarify the situation
and prevent new cpuidle drivers to goes to an arch directory.

The upstreaming process is unchanged: Rafael takes the patches to merge them
into its tree but with the acked-by from the driver's maintainer. So the header
must contains the name of the maintainer.

This organization will be the same than cpufreq.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Andrew Lunn <andrew@lunn.ch>  #for kirkwood
Acked-by: Jason Cooper <jason@lakedaemon.net> #for kirkwood
---
 MAINTAINERS                        |    9 +++++++++
 drivers/cpuidle/cpuidle-calxeda.c  |    4 +++-
 drivers/cpuidle/cpuidle-kirkwood.c |    5 +++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61677c3..45ee6dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2217,6 +2217,15 @@ F:	drivers/cpufreq/arm_big_little.h
 F:	drivers/cpufreq/arm_big_little.c
 F:	drivers/cpufreq/arm_big_little_dt.c
 
+CPUIDLE DRIVERS
+M:	Rafael J. Wysocki <rjw@sisk.pl>
+M:	Daniel Lezcano <daniel.lezcano@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+T:	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
+F:	drivers/cpuidle/*
+F:	include/linux/cpuidle.h
+
 CPUID/MSR DRIVER
 M:	"H. Peter Anvin" <hpa@zytor.com>
 S:	Maintained
diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index e344b56..2233791 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -1,7 +1,7 @@
 /*
  * Copyright 2012 Calxeda, Inc.
  *
- * Based on arch/arm/plat-mxc/cpuidle.c:
+ * Based on arch/arm/plat-mxc/cpuidle.c: #v3.7
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2012 Linaro Ltd.
  *
@@ -16,6 +16,8 @@
  *
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Maintainer: Rob Herring <rob.herring@calxeda.com>
  */
 
 #include <linux/cpuidle.h>
diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index 53290e1..521b0a7 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-kirkwood/cpuidle.c
- *
  * CPU idle Marvell Kirkwood SoCs
  *
  * This file is licensed under the terms of the GNU General Public
@@ -11,6 +9,9 @@
  * to implement two idle states -
  * #1 wait-for-interrupt
  * #2 wait-for-interrupt and DDR self refresh
+ *
+ * Maintainer: Jason Cooper <jason@lakedaemon.net>
+ * Maintainer: Andrew Lunn <andrew@lunn.ch>
  */
 
 #include <linux/kernel.h>
-- 
1.7.9.5


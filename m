From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] drivers/cpufreq: delete non-required instances of include <linux/init.h>
Date: Thu, 9 Jan 2014 10:10:07 -0500
Message-ID: <1389280207-11846-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-pm@vger.kernel.org

None of these files are actually using any __init type directives
and hence don't need to include <linux/init.h>.  Most are just a
left over from __devinit and __cpuinit removal, or simply due to
code getting copied from one driver to the next.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/cpufreq/omap-cpufreq.c    | 1 -
 drivers/cpufreq/powernow-k8.c     | 1 -
 drivers/cpufreq/s3c2412-cpufreq.c | 1 -
 drivers/cpufreq/s3c2440-cpufreq.c | 1 -
 drivers/cpufreq/spear-cpufreq.c   | 1 -
 drivers/cpufreq/speedstep-lib.c   | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index a0acd0bfba40..ba2fcad17941 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -18,7 +18,6 @@
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 0023c7d40a51..4b85ecbc81b1 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -30,7 +30,6 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
index 4645b4898996..8f42bacbe21b 100644
--- a/drivers/cpufreq/s3c2412-cpufreq.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index 72b2cc8a5a85..91d6efb92feb 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -11,7 +11,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index d02ccd19c9c4..8bdd46905c4c 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -16,7 +16,6 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/err.h>
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 7047821a7f8a..1ef6fb65281b 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/init.h>
 #include <linux/cpufreq.h>
 
 #include <asm/msr.h>
-- 
1.8.5.2


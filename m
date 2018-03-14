From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 23/47] cpufreq: remove cris specific drivers
Date: Wed, 14 Mar 2018 16:35:36 +0100
Message-ID: <20180314153603.3127932-24-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cris architecture is getting removed, including the artpec3
and etraxfs SoCs, so these cpufreq drivers are now unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Makefile               |  2 -
 drivers/cpufreq/cris-artpec3-cpufreq.c | 93 ----------------------------------
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 92 ---------------------------------
 3 files changed, 187 deletions(-)
 delete mode 100644 drivers/cpufreq/cris-artpec3-cpufreq.c
 delete mode 100644 drivers/cpufreq/cris-etraxfs-cpufreq.c

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 2e4495cf9aa8..8d24ade3bd02 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -102,8 +102,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 ##################################################################################
 # Other platform drivers
 obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
-obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
-obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
 obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
deleted file mode 100644
index 455b4fb78cba..000000000000
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
deleted file mode 100644
index 4c4b5dd685e3..000000000000
-- 
2.9.0

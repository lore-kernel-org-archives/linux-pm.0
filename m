From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] cpufreq: Do not default-yes CPU_FREQ_STAT
Date: Mon,  1 Aug 2016 11:34:55 +0200
Message-ID: <20160801093455.12676-1-bp@alien8.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

CPU frequency transition statistics are not absolutely required for
proper cpufreq operation on the system AFAICT so remove the default-yes
setting in Kconfig.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index c822d72629d5..74919aa81dcb 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -32,7 +32,6 @@ config CPU_FREQ_BOOST_SW
 
 config CPU_FREQ_STAT
 	bool "CPU frequency transition statistics"
-	default y
 	help
 	  Export CPU frequency statistics information through sysfs.
 
-- 
2.8.4

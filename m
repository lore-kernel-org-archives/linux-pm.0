From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] cpufreq: rename references to CPU_FREQ_SA11x0
Date: Mon, 13 May 2013 11:23:45 +0200
Message-ID: <1368437025.1350.35.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Kconfig symbols CPU_FREQ_SA1100 and CPU_FREQ_SA1110 were renamed in
commit 59a2e613d0 ("cpufreq: sa11x0: move cpufreq driver to
drivers/cpufreq"). Rename the last references to those symbols too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index a1488f5..534fcb8 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -47,7 +47,7 @@ config CPU_FREQ_STAT_DETAILS
 
 choice
 	prompt "Default CPUFreq governor"
-	default CPU_FREQ_DEFAULT_GOV_USERSPACE if CPU_FREQ_SA1100 || CPU_FREQ_SA1110
+	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
 	  This option sets which CPUFreq governor shall be loaded at
-- 
1.7.11.7

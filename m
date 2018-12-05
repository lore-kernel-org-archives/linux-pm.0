From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpufreq: nforce2: Remove meaningless return
Date: Wed,  5 Dec 2018 10:57:51 -0500
Message-ID: <20181205155751.15945-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Delete a line of meaningless return and some useless blank lines. In a function
whose return type is void, returning on the last line is not required.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-revert modify of MODULE_
-delete some blank lines
---
 drivers/cpufreq/cpufreq-nforce2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index dbf82f36d270..33c309a08c64 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -123,8 +123,6 @@ static void nforce2_write_pll(int pll)
 	/* Now write the value in all 64 registers */
 	for (temp = 0; temp <= 0x3f; temp++)
 		pci_write_config_dword(nforce2_dev, NFORCE2_PLLREG, pll);
-
-	return;
 }
 
 /**
@@ -438,4 +436,3 @@ static void __exit nforce2_exit(void)
 
 module_init(nforce2_init);
 module_exit(nforce2_exit);
-
-- 
2.17.0

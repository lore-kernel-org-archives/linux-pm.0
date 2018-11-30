From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: nforce2: Remove meaningless return
Date: Fri, 30 Nov 2018 09:25:57 -0500
Message-ID: <20181130142557.2623-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

In a function whose return type is void, returning on the last line is
not required.So remove it.Also move the module declaration to the end.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/cpufreq-nforce2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index dbf82f36d270..ccff1f2a7c25 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -47,10 +47,6 @@ static int fid;
 static int min_fsb;
 static int max_fsb;
 
-MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
-MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
-MODULE_LICENSE("GPL");
-
 module_param(fid, int, 0444);
 module_param(min_fsb, int, 0444);
 
@@ -123,8 +119,6 @@ static void nforce2_write_pll(int pll)
 	/* Now write the value in all 64 registers */
 	for (temp = 0; temp <= 0x3f; temp++)
 		pci_write_config_dword(nforce2_dev, NFORCE2_PLLREG, pll);
-
-	return;
 }
 
 /**
@@ -436,6 +430,9 @@ static void __exit nforce2_exit(void)
 	cpufreq_unregister_driver(&nforce2_driver);
 }
 
+MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
+MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
+MODULE_LICENSE("GPL");
+
 module_init(nforce2_init);
 module_exit(nforce2_exit);
-
-- 
2.17.0

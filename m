From: Jesse Chan <jc@linux.com>
Subject: [PATCH] cpufreq: mediatek: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon, 20 Nov 2017 13:32:01 -0800
Message-ID: <20171120213201.52606-1-jc@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jesse Chan <jc@linux.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/cpufreq/mediatek-cpufreq.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 18c4bd9a5c65..e0d5090b303d 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -620,3 +620,7 @@ static int __init mtk_cpufreq_driver_init(void)
 	return 0;
 }
 device_initcall(mtk_cpufreq_driver_init);
+
+MODULE_DESCRIPTION("MediaTek CPUFreq driver");
+MODULE_AUTHOR("Pi-Cheng Chen <pi-cheng.chen@linaro.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1

From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 250/493] cpufreq: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:19 -0500
Message-ID: <1353349642-3677-250-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: cpufreq-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl> 
Cc: cpufreq@vger.kernel.org 
Cc: linux-pm@vger.kernel.org 
---
 drivers/cpufreq/cpufreq-cpu0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index e915827..52bf36d 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -174,7 +174,7 @@ static struct cpufreq_driver cpu0_cpufreq_driver = {
 	.attr = cpu0_cpufreq_attr,
 };
 
-static int __devinit cpu0_cpufreq_driver_init(void)
+static int cpu0_cpufreq_driver_init(void)
 {
 	struct device_node *np;
 	int ret;
-- 
1.8.0


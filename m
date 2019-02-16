From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] cpufreq: pcc-cpufreq: remove unneeded semicolon
Date: Sat, 16 Feb 2019 10:55:26 -0500
Message-ID: <20190216155527.11839-2-tiny.windzz@gmail.com>
References: <20190216155527.11839-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190216155527.11839-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The semicolon is unneeded, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 099a849396f6..1e5e64643c3a 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -268,7 +268,7 @@ static int pcc_get_offset(int cpu)
 	if (!pccp || pccp->type != ACPI_TYPE_PACKAGE) {
 		ret = -ENODEV;
 		goto out_free;
-	};
+	}
 
 	offset = &(pccp->package.elements[0]);
 	if (!offset || offset->type != ACPI_TYPE_INTEGER) {
-- 
2.17.0

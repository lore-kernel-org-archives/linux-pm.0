From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] blackfin-cpufreq: Change return type of cpu_set_cclk() to
 that of clk_set_rate()
Date: Fri, 18 Dec 2015 20:07:55 +0100
Message-ID: <5674598B.6020000@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:51867 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554AbbLRTIE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Dec 2015 14:08:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 18 Dec 2015 19:43:27 +0100

The return type "unsigned long" was used by the cpu_set_cclk() function
while the type "int" is provided by the clk_set_rate() function.
Let us make this usage consistent.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpufreq/blackfin-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index a9f8e5b..2a6f3ac 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -112,7 +112,7 @@ static unsigned int bfin_getfreq_khz(unsigned int cpu)
 }
 
 #ifdef CONFIG_BF60x
-unsigned long cpu_set_cclk(int cpu, unsigned long new)
+int cpu_set_cclk(int cpu, unsigned long new)
 {
 	struct clk *clk;
 	int ret;
-- 
2.6.3


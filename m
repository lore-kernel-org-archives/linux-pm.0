From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] blackfin-cpufreq: Change return type of cpu_set_cclk() to
 that of clk_set_rate()
Date: Mon, 21 Dec 2015 22:30:31 +0100
Message-ID: <56786F77.4000305@users.sourceforge.net>
References: <5674598B.6020000@users.sourceforge.net>
 <56786EF3.3070203@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:50152 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbbLUVap (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Dec 2015 16:30:45 -0500
In-Reply-To: <56786EF3.3070203@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 21 Dec 2015 21:56:27 +0100

The return type "unsigned long" was used by the cpu_set_cclk() function
while the type "int" is provided by the clk_set_rate() function.
Let us make this usage consistent.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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


From: Jonghwan Choi <jhbird.choi@samsung.com>
Subject: [PATCH] cpufreq: Fix unsigned variable being checked for negative value
Date: Mon, 18 Mar 2013 17:09:42 +0900
Message-ID: <000001ce23af$f51b0240$df5106c0$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62868 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab3CRIJt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Mar 2013 04:09:49 -0400
References: 
In-reply-to: 
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Shawn Guo' <shawn.guo@linaro.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>

clk_round_rate() returns singed value which was assigned to an unsigned
variable.
So it can't be checked for negative.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/cpufreq/cpufreq-cpu0.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 4e5b7fb..6bb88af 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -44,7 +44,8 @@ static int cpu0_set_target(struct cpufreq_policy *policy,
 {
 	struct cpufreq_freqs freqs;
 	struct opp *opp;
-	unsigned long freq_Hz, volt = 0, volt_old = 0, tol = 0;
+	unsigned long volt = 0, volt_old = 0, tol = 0;
+	long freq_Hz;
 	unsigned int index, cpu;
 	int ret;
 
-- 
1.7.4.1


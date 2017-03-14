From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Fix and clean up show_cpuinfo_cur_freq()
Date: Wed, 15 Mar 2017 00:12:16 +0100
Message-ID: <2254422.RMefVc1hHr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61056 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751073AbdCNXRn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 19:17:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a missing newline in show_cpuinfo_cur_freq(), so add it,
but while at it clean it up somewhat too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -680,9 +680,11 @@ static ssize_t show_cpuinfo_cur_freq(str
 					char *buf)
 {
 	unsigned int cur_freq = __cpufreq_get(policy);
-	if (!cur_freq)
-		return sprintf(buf, "<unknown>");
-	return sprintf(buf, "%u\n", cur_freq);
+
+	if (cur_freq)
+		return sprintf(buf, "%u\n", cur_freq);
+
+	return sprintf(buf, "<unknown>\n");
 }
 
 /**

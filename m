From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] cpufreq: Drop pointless return statement
Date: Thu, 23 Nov 2017 01:30:16 +0100
Message-ID: <8136755.4DucdONPzh@aspire.rjw.lan>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57726 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751507AbdKWAbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Nov 2017 19:31:16 -0500
In-Reply-To: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop a pointless return statement from cpufreq_unregister_governor().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2168,7 +2168,6 @@ void cpufreq_unregister_governor(struct
 	mutex_lock(&cpufreq_governor_mutex);
 	list_del(&governor->governor_list);
 	mutex_unlock(&cpufreq_governor_mutex);
-	return;
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
 

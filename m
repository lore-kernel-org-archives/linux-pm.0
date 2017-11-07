From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH] cpufreq:stats: Handle the case when trans_table goes beyond PAGE_SIZE
Date: Tue,  7 Nov 2017 13:39:29 +0530
Message-ID: <1510042169-16664-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932418AbdKGIJj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 03:09:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA784WWQ112221
        for <linux-pm@vger.kernel.org>; Tue, 7 Nov 2017 03:09:39 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e38r80ufu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2017 03:09:39 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 7 Nov 2017 01:09:37 -0700
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, shilpa.bhat@linux.vnet.ibm.com, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On platforms with large number of Pstates, the transition table, which
is a NxN matrix, can overflow beyond the PAGE_SIZE boundary.

This can be seen on POWER9 which has 100+ Pstates.

As a result, each time the trans_table is read for any of the CPUs, we
will get the following error.

---------------------------------------------------
fill_read_buffer: show+0x0/0xa0 returned bad count
---------------------------------------------------

This patch ensures that in case of an overflow, we print a warning
once in the dmesg and return FILE TOO LARGE error for this and all
subsequent accesses of trans_table.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/cpu-freq/cpufreq-stats.txt | 3 +++
 drivers/cpufreq/cpufreq_stats.c          | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
index 2bbe207..a873855 100644
--- a/Documentation/cpu-freq/cpufreq-stats.txt
+++ b/Documentation/cpu-freq/cpufreq-stats.txt
@@ -90,6 +90,9 @@ Freq_i to Freq_j. Freq_i is in descending order with increasing rows and
 Freq_j is in descending order with increasing columns. The output here also 
 contains the actual freq values for each row and column for better readability.
 
+If the transition table is bigger than PAGE_SIZE, reading this will
+return an -EFBIG error.
+
 --------------------------------------------------------------------------------
 <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat trans_table
    From  :    To
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index e75880e..1e55b57 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -118,8 +118,11 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 			break;
 		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
+
+	if (len >= PAGE_SIZE) {
+		pr_warn_once("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
+		return -EFBIG;
+	}
 	return len;
 }
 cpufreq_freq_attr_ro(trans_table);
-- 
1.9.4

From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH -next] powernv: cpufreq: Fix uninitialized lpstate_idx in gpstates_timer_handler
Date: Mon, 14 Nov 2016 17:29:27 +0530
Message-ID: <1479124767-20165-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932449AbcKNMA3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 07:00:29 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAEC0HM8093014
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2016 07:00:29 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26qb6svre2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2016 07:00:22 -0500
Received: from localhost
        by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Mon, 14 Nov 2016 21:59:46 +1000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

lpstate_idx remains uninitialized in the case when elapsed_time
is greater than MAX_RAMP_DOWN_TIME. At the end of rampdown
global pstate should be equal to local pstate.

Fixes: 20b15b766354 ("cpufreq: powernv: Use PMCR to verify global and
localpstate")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index c82304b..c5c5bc3 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -624,6 +624,7 @@ void gpstate_timer_handler(unsigned long data)
 
 	if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
 		gpstate_idx = pstate_to_idx(freq_data.pstate_id);
+		lpstate_idx = gpstate_idx;
 		reset_gpstates(policy);
 		gpstates->highest_lpstate_idx = gpstate_idx;
 	} else {
-- 
2.5.5


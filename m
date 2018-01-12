From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Dont assume distinct pstate values for nominal and pmin
Date: Fri, 12 Jan 2018 12:43:53 +0530
Message-ID: <1515741233-1442-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754530AbeALHOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 02:14:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0C7EJNR024598
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2018 02:14:23 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2femg99y9f-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2018 02:14:21 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Fri, 12 Jan 2018 07:14:11 -0000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Some OpenPOWER boxes can have same pstate values for nominal and
pmin pstates. In these boxes the current code will not initialize
'powernv_pstate_info.min' variable and result in erroneous CPU
frequency reporting. This patch fixes this problem.

Fixes: 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with frequency table index")
Reported-by: Alvin Wang <wangat@tw.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index b6d7c4c..da7fdb4 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -288,9 +288,9 @@ static int init_powernv_pstates(void)
 
 		if (id == pstate_max)
 			powernv_pstate_info.max = i;
-		else if (id == pstate_nominal)
+		if (id == pstate_nominal)
 			powernv_pstate_info.nominal = i;
-		else if (id == pstate_min)
+		if (id == pstate_min)
 			powernv_pstate_info.min = i;
 
 		if (powernv_pstate_info.wof_enabled && id == pstate_turbo) {
-- 
1.8.3.1

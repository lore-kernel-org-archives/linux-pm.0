From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH] cpuidle/powernv: staticise powernv_idle_driver
Date: Tue, 22 Nov 2016 16:08:06 +1100
Message-ID: <20161122050806.29564-1-andrew.donnellan@au1.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbcKVFIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 00:08:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAM54Cws021001
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 00:08:20 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26v7h1hrke-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 00:08:20 -0500
Received: from localhost
        by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Tue, 22 Nov 2016 15:08:17 +1000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org

powernv_idle_driver isn't exported, it can be made static. Found by sparse.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 7fe442c..0835a37 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -22,7 +22,7 @@
 
 #define POWERNV_THRESHOLD_LATENCY_NS 200000
 
-struct cpuidle_driver powernv_idle_driver = {
+static struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
 	.owner            = THIS_MODULE,
 };
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited


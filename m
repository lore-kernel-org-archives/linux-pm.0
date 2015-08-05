From: Ethan Zhao <ethan.zhao@oracle.com>
Subject: [PATCH] intel_pstate: append more Oracle OEM table id to vendor bypass list
Date: Wed,  5 Aug 2015 09:28:50 +0900
Message-ID: <1438734530-5855-1-git-send-email-ethan.zhao@oracle.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44541 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbHEAax (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 20:30:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ethan Zhao <ethan.zhao@oracle.com>

Append more Oracle X86 servers that have their own power management,

SUN FIRE X4275 M3
SUN FIRE X4170 M3
and
SUN FIRE X6-2

Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c45d274..c57b011 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1156,6 +1156,10 @@ static struct hw_vendor_info vendor_info[] = {
 	{1, "ORACLE", "X4270M3 ", PPC},
 	{1, "ORACLE", "X4270M2 ", PPC},
 	{1, "ORACLE", "X4170M2 ", PPC},
+	{1, "ORACLE", "X4170 M3", PPC},
+	{1, "ORACLE", "X4275 M3", PPC},
+	{1, "ORACLE", "X6-2    ", PPC},
+	{1, "ORACLE", "Sudbury ", PPC},
 	{0, "", ""},
 };
 
-- 
1.8.3.1


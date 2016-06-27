From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 1/3] intel_pstate: Fix incorrect placement of __initdata
Date: Mon, 27 Jun 2016 17:26:13 +0800
Message-ID: <1467019575-664-2-git-send-email-jszhang@marvell.com>
References: <1467019575-664-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:48112 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751828AbcF0JaQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 05:30:16 -0400
In-Reply-To: <1467019575-664-1-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

__initdata should be placed between the variable name and equal sign
(if there is) for the variable to be placed in the intended section.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fe9dc17..44099e9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1574,9 +1574,9 @@ static struct cpufreq_driver intel_pstate_driver = {
 	.name		= "intel_pstate",
 };
 
-static int __initdata no_load;
-static int __initdata no_hwp;
-static int __initdata hwp_only;
+static int no_load __initdata;
+static int no_hwp __initdata;
+static int hwp_only __initdata;
 static unsigned int force_load;
 
 static int intel_pstate_msrs_not_valid(void)
-- 
2.8.1


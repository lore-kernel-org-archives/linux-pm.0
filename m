Return-Path: <SRS0=GSIr=SQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD7C10F14
	for <linux-pm@archiver.kernel.org>; Sun, 14 Apr 2019 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7A520850
	for <linux-pm@archiver.kernel.org>; Sun, 14 Apr 2019 20:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RmEcetgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfDNUuS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:50:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46408 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDNUuS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Apr 2019 16:50:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3EKn5cF163407;
        Sun, 14 Apr 2019 20:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=aOGniLq5JlxCxmSw1GEGl3FmIhp2SUSpIlfz/tXx4W0=;
 b=RmEcetgTnUY5ekob8GuUTxUkjEfYlOmm7mc+a4r4egLOmCwyt8kjDwm/J33rsE+rxNQS
 kkW3t5p73q4zBsj5Zi1pmGmxlTX4pZyHVwHH6oSl2YU+qUTIBVWaYlGG8SRRwq4ZUnq0
 0sYXDIDIt4qyvN8Lr0JuJLuL7HMXayqGpZ60bHj8KfiiE9RmaF2Vz69MEkW/XIzvePbB
 9pFLkBZpGE5v/SkIuRyISD6eIBrbdswKGcxaG32j5ZdhiLcf/a2FU59OIaCjHNoTnBPv
 BfU3EGb5KsD/Klqn+lUpCEBIGCbXhgQ1to7dRsDwZf0AaQtwp9q2VlSVIL70pNXaw8mI nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2ru59curcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 20:50:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3EKo4Wg053442;
        Sun, 14 Apr 2019 20:50:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2rv2ttuchx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 20:50:06 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3EKo5om022505;
        Sun, 14 Apr 2019 20:50:05 GMT
Received: from spark.ravello.local (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 13:50:05 -0700
From:   Liran Alon <liran.alon@oracle.com>
To:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 2/2] x86: intel: Define MSR_POWER_CTL bits with symbolic constants
Date:   Sun, 14 Apr 2019 23:48:31 +0300
Message-Id: <20190414204831.93705-2-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414204831.93705-1-liran.alon@oracle.com>
References: <20190414204831.93705-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904140158
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904140159
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/include/asm/msr-index.h      | 7 +++++++
 drivers/cpufreq/intel_pstate.c        | 6 ++----
 drivers/idle/intel_idle.c             | 2 +-
 tools/power/x86/turbostat/turbostat.c | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8e40c2446fd1..436f3c5aa358 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -209,6 +209,13 @@
 
 #define MSR_IA32_POWER_CTL		0x000001fc
 
+/* POWERCTLMSR bits: */
+#define POWERCTLMSR_BI_DIR_PROCHOT	BIT(0)	/* Bi-directional PROCHOT */
+#define POWERCTLMSR_C1E_ENABLE		BIT(1)  /* C1E Enable */
+#define POWERCTLMSR_EN_ENERGY_PERF_BIAS	BIT(18) /* Enable MSR_IA32_ENERGY_PERF_BIAS */
+#define POWERCTLMSR_DISABLE_RACE_TO_HLT	BIT(19)	/* Disable Race to Halt Optimization */
+#define POWERCTLMSR_DISABLE_EE		BIT(20) /* Disable Energy Efficiency Optimization */
+
 #define MSR_IA32_MC0_CTL		0x00000400
 #define MSR_IA32_MC0_STATUS		0x00000401
 #define MSR_IA32_MC0_ADDR		0x00000402
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3ce39c332c7b..b42ba4456f66 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1200,8 +1200,6 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 }
 
-#define MSR_IA32_POWER_CTL_BIT_EE	20
-
 /* Disable energy efficiency optimization */
 static void intel_pstate_disable_ee(int cpu)
 {
@@ -1212,9 +1210,9 @@ static void intel_pstate_disable_ee(int cpu)
 	if (ret)
 		return;
 
-	if (!(power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE))) {
+	if (!(power_ctl & POWERCTLMSR_DISABLE_EE)) {
 		pr_info("Disabling energy efficiency optimization\n");
-		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
+		power_ctl |= POWERCTLMSR_DISABLE_EE;
 		wrmsrl_on_cpu(cpu, MSR_IA32_POWER_CTL, power_ctl);
 	}
 }
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8b5d85c91e9d..3654575e6697 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -977,7 +977,7 @@ static void c1e_promotion_disable(void)
 	unsigned long long msr_bits;
 
 	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
-	msr_bits &= ~0x2;
+	msr_bits &= ~POWERCTLMSR_C1E_ENABLE;
 	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
 }
 
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9327c0ddc3a5..0455aa7e9c6f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2019,7 +2019,7 @@ dump_nhm_platform_info(void)
 
 	get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
 	fprintf(outf, "cpu%d: MSR_IA32_POWER_CTL: 0x%08llx (C1E auto-promotion: %sabled)\n",
-		base_cpu, msr, msr & 0x2 ? "EN" : "DIS");
+		base_cpu, msr, msr & POWERCTLMSR_C1E_ENABLE ? "EN" : "DIS");
 
 	return;
 }
-- 
2.20.1


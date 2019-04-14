Return-Path: <SRS0=GSIr=SQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E326C10F13
	for <linux-pm@archiver.kernel.org>; Sun, 14 Apr 2019 20:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B9520850
	for <linux-pm@archiver.kernel.org>; Sun, 14 Apr 2019 20:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qTC74hZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDNUuR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:50:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35890 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfDNUuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Apr 2019 16:50:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3EKmlsr168893;
        Sun, 14 Apr 2019 20:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=VPkFZctWjheKi5KM7h+0bvUffjqVEEI6NEU7g4fi6Bo=;
 b=qTC74hZ55ZuL0Mx8MxpfA5G5Q9c095Fd2N9VDh9/SqlkGPWgI+qHUz5nEfSCBzfTR7wW
 QhL2cZWwC+8f5Ta8RL966Y/POqNSSaGXhr3coFyYk5Nrgska4WRG5bVxP94YqkMyww7t
 hFTbyHaaqiS9buqwwmPI9gWpp7RCYAvwqDEEQ+OCazOdkjyfhqkLnTsVTRz+jgQVPfje
 XlQyjzEb8Jc7cTlyyQxBdk44Y6OSbnLCAWz9Hm073UXBUyij2Zf2vQwOnbKIpGRmfixh
 EqxOebEEPBN0dcQjq3KZR5GHXkpaP5H9u2s8a0l+noIZM8zYloJL1m/1P4cJePXh2QOs LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2rusnehmnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 20:50:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3EKo3T5053396;
        Sun, 14 Apr 2019 20:50:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2rv2ttuche-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 20:50:04 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3EKo0wq022471;
        Sun, 14 Apr 2019 20:50:01 GMT
Received: from spark.ravello.local (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 13:50:00 -0700
From:   Liran Alon <liran.alon@oracle.com>
To:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 1/2] x86: intel_pstate: Fix wrong definition of Disable Energy Efficiency Optimization bit
Date:   Sun, 14 Apr 2019 23:48:30 +0300
Message-Id: <20190414204831.93705-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904140158
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904140159
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bit definition can be found in Intel SDM Section 2.16 MSRS IN THE 6TH
GENERATION, 7TH GENERATION AND 8TH GENERATION
INTEL® CORE™ PROCESSORS, INTEL® XEON® PROCESSOR SCALABLE
FAMILY, AND FUTURE INTEL® CORE™ PROCESSORS.

Definition of all Skylake MSR_POWER_CTL bits can also be found at EDK2
source at UefiCpuPkg/Include/Register/Msr/SkylakeMsr.h union
MSR_SKYLAKE_POWER_CTL_REGISTER.

Fixes: 6e978b22efa1 ("cpufreq: intel_pstate: Disable energy efficiency optimization")

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..3ce39c332c7b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1200,7 +1200,7 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 }
 
-#define MSR_IA32_POWER_CTL_BIT_EE	19
+#define MSR_IA32_POWER_CTL_BIT_EE	20
 
 /* Disable energy efficiency optimization */
 static void intel_pstate_disable_ee(int cpu)
-- 
2.20.1


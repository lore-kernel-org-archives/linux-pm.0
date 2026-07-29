Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422193A6F17;
	Wed, 29 Jul 2026 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305898; cv=none; b=E6b6bqKgf+F9hrCfQs7o0crA8Lwoy1hgbBDdLbbFHxWZvbXUwafoTbt2XPmqtisZr4Ay1iTgu2IOsn0h7E2Ssqm/XyQS91LL/rIpph7aq8yG8mN+E21E8FIKKy8kGuWQESOEgzBveV8tGpm84UceJmK885NGc4vBubLec6Lq6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305898; c=relaxed/simple;
	bh=kJJjg4HGyYeu3gNC8MTBbPuChpFiVjqZ8Wcvo6sfNsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gsk4wIqpiikKEG8SDjyPbldh7glJAtRwAaQOtHQ9jAIdzSPO3PlWRORa6DFypMzwrth9YHo22ws+8TUoS5hWnd9UdGorIMkZK95z4xQJwBuvlzozV+rA0nPJlVuFwpbRvGu4cnh3n6af47aFqLbNdMo8l1xX/sgxxJeYzlEzsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 435ef9f88b1511f1aa26b74ffac11d73-20260729
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5562d2d1-bc4c-429a-a78c-95e01e8cec36,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:5562d2d1-bc4c-429a-a78c-95e01e8cec36,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:263f498a6fe37add507f90a555bf45af,BulkI
	D:2607211725493N8X2PR8,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 435ef9f88b1511f1aa26b74ffac11d73-20260729
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(106.16.184.249)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2031238721; Wed, 29 Jul 2026 14:18:06 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	christian.loehle@arm.com,
	lenb@kernel.org,
	pavel@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 2/6] cpuidle: subscribe to global latency QoS notifiers
Date: Wed, 29 Jul 2026 14:18:03 +0800
Message-ID: <20260729061803.14719-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
References: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register for CPU latency and wakeup latency QoS notifications and
bump a per-CPU generation counter when either aggregate constraint
changes.  This prepares for caching the governor latency requirement
without introducing a direct qos-to-cpuidle call dependency.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/cpuidle/governor.c | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 5d0e7f78c6c5..bc4a70d30c34 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -8,10 +8,13 @@
  * This code is licenced under the GPL.
  */
 
+#include <linux/atomic.h>
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
+#include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/pm_qos.h>
 
 #include "cpuidle.h"
@@ -22,6 +25,61 @@ LIST_HEAD(cpuidle_governors);
 struct cpuidle_governor *cpuidle_curr_governor;
 struct cpuidle_governor *cpuidle_prev_governor;
 
+/*
+ * Per-CPU generation bumped to invalidate that CPU's cached latency
+ * constraint.  Consumers of the generation are added in later changes.
+ */
+static DEFINE_PER_CPU(atomic_t, latency_req_gen);
+
+static void cpuidle_latency_req_invalidate_cpu(unsigned int cpu)
+{
+	atomic_inc(per_cpu_ptr(&latency_req_gen, cpu));
+}
+
+static void cpuidle_latency_req_invalidate_all(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpuidle_latency_req_invalidate_cpu(cpu);
+}
+
+static int cpuidle_global_qos_notify(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	cpuidle_latency_req_invalidate_all();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpuidle_latency_qos_nb = {
+	.notifier_call = cpuidle_global_qos_notify,
+};
+
+#ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
+static struct notifier_block cpuidle_wakeup_qos_nb = {
+	.notifier_call = cpuidle_global_qos_notify,
+};
+#endif
+
+static int __init cpuidle_latency_req_init(void)
+{
+	int ret;
+
+	ret = cpu_latency_qos_add_notifier(&cpuidle_latency_qos_nb);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
+	ret = cpu_wakeup_latency_qos_add_notifier(&cpuidle_wakeup_qos_nb);
+	if (ret) {
+		cpu_latency_qos_remove_notifier(&cpuidle_latency_qos_nb);
+		return ret;
+	}
+#endif
+	return 0;
+}
+core_initcall(cpuidle_latency_req_init);
+
 /**
  * cpuidle_find_governor - finds a governor of the specified name
  * @str: the name
-- 
2.43.0


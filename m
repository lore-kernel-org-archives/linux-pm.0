Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99879389471;
	Wed, 29 Jul 2026 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305890; cv=none; b=IMGD+n6WjhmABJ3pVvsAoq5kFVl0jl1pr4T5eal7KNsjTmBSbh7nmEGF7WGjdk5PMc7tsqyfHk2eWTsxWfTmjm3eUebSezK6YGRWzKXVTMHQayG0Gah0jByaWZxDelx2lgbbVlorxkVbmhC2cR+J+4M+7URNqgEYw5O+ANFP4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305890; c=relaxed/simple;
	bh=D4MIUHXlhkumx8h96KZ7RU4b3HNTX3DDdQy4oHrg9/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyNHHco+t1YhcxErcqrOvfDtNdyF+YlbS9cAYgJNZqQglu0xdCSXrVog3ngy4SLTnCnuHqXpnxzxi/uJJ+lI6J5cNqypP3Gjum8BXMhWpSCAfyLgfe49wVjK2gFJ23Xx8PJprefN7b5i+H/Tq4NypyQicjojufSUf0/qLsifIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3e701fbc8b1511f1aa26b74ffac11d73-20260729
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
X-CID-O-INFO: VERSION:1.3.12,REQID:0268ae2b-0fac-44b1-8196-05aaa064c7e8,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:0268ae2b-0fac-44b1-8196-05aaa064c7e8,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:f71916ffc941afc6e8f7864eb00a862c,BulkI
	D:260721172540CARXOK64,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3e701fbc8b1511f1aa26b74ffac11d73-20260729
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(106.16.184.249)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 642295072; Wed, 29 Jul 2026 14:17:58 +0800
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
Subject: [PATCH v2 1/6] pm: qos: add notifiers for CPU latency and wakeup latency QoS
Date: Wed, 29 Jul 2026 14:17:54 +0800
Message-ID: <20260729061754.14663-1-tianyaxiong@kylinos.cn>
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

Expose notifier registration for the system-wide CPU latency and
wakeup latency QoS constraints so listeners can react when the
aggregate target value changes.  pm_qos_update_target() already
invokes constraint notifiers when the effective value changes.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 include/linux/pm_qos.h | 23 +++++++++++++++++++
 kernel/power/qos.c     | 50 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..3759b453c6d6 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -149,6 +149,8 @@ bool cpu_latency_qos_request_active(struct pm_qos_request *req);
 void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value);
 void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value);
 void cpu_latency_qos_remove_request(struct pm_qos_request *req);
+int cpu_latency_qos_add_notifier(struct notifier_block *notifier);
+int cpu_latency_qos_remove_notifier(struct notifier_block *notifier);
 #else
 static inline s32 cpu_latency_qos_limit(void) { return INT_MAX; }
 static inline bool cpu_latency_qos_request_active(struct pm_qos_request *req)
@@ -160,15 +162,36 @@ static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
 static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
 						  s32 new_value) {}
 static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req) {}
+static inline int cpu_latency_qos_add_notifier(struct notifier_block *notifier)
+{
+	return 0;
+}
+static inline int
+cpu_latency_qos_remove_notifier(struct notifier_block *notifier)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
 s32 cpu_wakeup_latency_qos_limit(void);
+int cpu_wakeup_latency_qos_add_notifier(struct notifier_block *notifier);
+int cpu_wakeup_latency_qos_remove_notifier(struct notifier_block *notifier);
 #else
 static inline s32 cpu_wakeup_latency_qos_limit(void)
 {
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
+static inline int
+cpu_wakeup_latency_qos_add_notifier(struct notifier_block *notifier)
+{
+	return 0;
+}
+static inline int
+cpu_wakeup_latency_qos_remove_notifier(struct notifier_block *notifier)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PM
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 1944dbeb0d4c..392ab3dbb923 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -212,12 +212,15 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 #ifdef CONFIG_CPU_IDLE
 /* Definitions related to the CPU latency QoS. */
 
+static BLOCKING_NOTIFIER_HEAD(cpu_latency_qos_notifiers);
+
 static struct pm_qos_constraints cpu_latency_constraints = {
 	.list = PLIST_HEAD_INIT(cpu_latency_constraints.list),
 	.target_value = PM_QOS_CPU_LATENCY_DEFAULT_VALUE,
 	.default_value = PM_QOS_CPU_LATENCY_DEFAULT_VALUE,
 	.no_constraint_value = PM_QOS_CPU_LATENCY_DEFAULT_VALUE,
 	.type = PM_QOS_MIN,
+	.notifiers = &cpu_latency_qos_notifiers,
 };
 
 static inline bool cpu_latency_qos_value_invalid(s32 value)
@@ -335,6 +338,28 @@ void cpu_latency_qos_remove_request(struct pm_qos_request *req)
 }
 EXPORT_SYMBOL_GPL(cpu_latency_qos_remove_request);
 
+/**
+ * cpu_latency_qos_add_notifier - Add CPU latency QoS change notifier.
+ * @notifier: Notifier block managed by the caller.
+ */
+int cpu_latency_qos_add_notifier(struct notifier_block *notifier)
+{
+	return blocking_notifier_chain_register(&cpu_latency_qos_notifiers,
+						notifier);
+}
+EXPORT_SYMBOL_GPL(cpu_latency_qos_add_notifier);
+
+/**
+ * cpu_latency_qos_remove_notifier - Remove CPU latency QoS change notifier.
+ * @notifier: Notifier block previously registered.
+ */
+int cpu_latency_qos_remove_notifier(struct notifier_block *notifier)
+{
+	return blocking_notifier_chain_unregister(&cpu_latency_qos_notifiers,
+						  notifier);
+}
+EXPORT_SYMBOL_GPL(cpu_latency_qos_remove_notifier);
+
 /* User space interface to the CPU latency QoS via misc device. */
 
 static int cpu_latency_qos_open(struct inode *inode, struct file *filp)
@@ -417,12 +442,15 @@ static struct miscdevice cpu_latency_qos_miscdev = {
 
 #ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
 /* The CPU system wakeup latency QoS. */
+static BLOCKING_NOTIFIER_HEAD(cpu_wakeup_latency_qos_notifiers);
+
 static struct pm_qos_constraints cpu_wakeup_latency_constraints = {
 	.list = PLIST_HEAD_INIT(cpu_wakeup_latency_constraints.list),
 	.target_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
 	.default_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
 	.no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
 	.type = PM_QOS_MIN,
+	.notifiers = &cpu_wakeup_latency_qos_notifiers,
 };
 
 /**
@@ -436,6 +464,28 @@ s32 cpu_wakeup_latency_qos_limit(void)
 	return pm_qos_read_value(&cpu_wakeup_latency_constraints);
 }
 
+/**
+ * cpu_wakeup_latency_qos_add_notifier - Add wakeup latency QoS notifier.
+ * @notifier: Notifier block managed by the caller.
+ */
+int cpu_wakeup_latency_qos_add_notifier(struct notifier_block *notifier)
+{
+	return blocking_notifier_chain_register(&cpu_wakeup_latency_qos_notifiers,
+						notifier);
+}
+EXPORT_SYMBOL_GPL(cpu_wakeup_latency_qos_add_notifier);
+
+/**
+ * cpu_wakeup_latency_qos_remove_notifier - Remove wakeup latency QoS notifier.
+ * @notifier: Notifier block previously registered.
+ */
+int cpu_wakeup_latency_qos_remove_notifier(struct notifier_block *notifier)
+{
+	return blocking_notifier_chain_unregister(&cpu_wakeup_latency_qos_notifiers,
+						  notifier);
+}
+EXPORT_SYMBOL_GPL(cpu_wakeup_latency_qos_remove_notifier);
+
 static int cpu_wakeup_latency_qos_open(struct inode *inode, struct file *filp)
 {
 	struct pm_qos_request *req;
-- 
2.43.0


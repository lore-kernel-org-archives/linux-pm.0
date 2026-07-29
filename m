Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843E35DA42;
	Wed, 29 Jul 2026 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305905; cv=none; b=gKirw8FxSTwLgL87UcUQGsLdLDUrJgC9Xrk40G2Ut92IDVJJiEk1buqPgHqsmoMg0ic1BXB3NMkAODbpYElkj6wZomUtGQ1Q3vsWL8403wpKQAYLkgnqTetdIiwoKxphcZmpxo+2o/1h4pJ1MRAlIzjyjtWWopFKXWJRH4NTISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305905; c=relaxed/simple;
	bh=KOuIZvCRsLiQEvlpnaZ7j0M7DCtdzRxTBu0j76ihEXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH+pSUmvHBvZ3tZNxer6e4IsyDybsDqvihtUUcQOQHBO9no7AEVDMGscmLnIm7pXc1CbiKmGP3b+CnGYbS6n4E5BTTu/XH+3SLTq16Rf3mMsXlIaAd41QIqQROnveN3l9NM12PkrOhyXxzaWNN2MDdB6bVfcQvII61cpIziAzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 483d11f88b1511f1aa26b74ffac11d73-20260729
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e2777224-deec-43ec-9367-f21014d15bcd,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:e2777224-deec-43ec-9367-f21014d15bcd,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:b71add246676da0a652bb16041216cf7,BulkI
	D:260721172555J9AWZBTD,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 483d11f88b1511f1aa26b74ffac11d73-20260729
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(106.16.184.249)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 730178147; Wed, 29 Jul 2026 14:18:14 +0800
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
Subject: [PATCH v2 3/6] cpuidle: invalidate latency gen on per-CPU resume QoS changes
Date: Wed, 29 Jul 2026 14:18:11 +0800
Message-ID: <20260729061811.14786-1-tianyaxiong@kylinos.cn>
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

Register a DEV_PM_QOS_RESUME_LATENCY notifier for each CPU device and
bump only that CPU's latency_req generation when its resume latency
constraint changes.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/cpuidle/cpuidle.c  | 15 +++++++++---
 drivers/cpuidle/cpuidle.h  |  2 ++
 drivers/cpuidle/governor.c | 48 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2d2f40a2cb81..9495f904fe85 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -613,6 +613,8 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 {
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 
+	cpuidle_latency_req_notifier_unregister(dev->cpu);
+
 	list_del(&dev->device_list);
 	per_cpu(cpuidle_devices, dev->cpu) = NULL;
 	module_put(drv->owner);
@@ -661,10 +663,17 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 
 	ret = cpuidle_coupled_register_device(dev);
 	if (ret)
-		__cpuidle_unregister_device(dev);
-	else
-		dev->registered = 1;
+		goto unreg;
+
+	ret = cpuidle_latency_req_notifier_register(cpu);
+	if (ret)
+		goto unreg;
 
+	dev->registered = 1;
+	return 0;
+
+unreg:
+	__cpuidle_unregister_device(dev);
 	return ret;
 }
 
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index 52701d9588f1..151fa9ebe483 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -25,6 +25,8 @@ extern void cpuidle_uninstall_idle_handler(void);
 /* governors */
 extern struct cpuidle_governor *cpuidle_find_governor(const char *str);
 extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
+int cpuidle_latency_req_notifier_register(unsigned int cpu);
+void cpuidle_latency_req_notifier_unregister(unsigned int cpu);
 
 /* sysfs */
 
diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index bc4a70d30c34..d286ccf19a69 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -27,10 +27,18 @@ struct cpuidle_governor *cpuidle_prev_governor;
 
 /*
  * Per-CPU generation bumped to invalidate that CPU's cached latency
- * constraint.  Consumers of the generation are added in later changes.
+ * constraint.  Global QoS changes invalidate every CPU; per-CPU resume
+ * latency changes invalidate only the affected CPU.
  */
 static DEFINE_PER_CPU(atomic_t, latency_req_gen);
 
+struct cpuidle_cpu_qos_nb {
+	struct notifier_block nb;
+	unsigned int cpu;
+};
+
+static DEFINE_PER_CPU(struct cpuidle_cpu_qos_nb, cpuidle_cpu_qos_nb);
+
 static void cpuidle_latency_req_invalidate_cpu(unsigned int cpu)
 {
 	atomic_inc(per_cpu_ptr(&latency_req_gen, cpu));
@@ -61,6 +69,44 @@ static struct notifier_block cpuidle_wakeup_qos_nb = {
 };
 #endif
 
+static int cpuidle_cpu_qos_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct cpuidle_cpu_qos_nb *qos_nb =
+		container_of(nb, struct cpuidle_cpu_qos_nb, nb);
+
+	cpuidle_latency_req_invalidate_cpu(qos_nb->cpu);
+	return NOTIFY_OK;
+}
+
+int cpuidle_latency_req_notifier_register(unsigned int cpu)
+{
+	struct device *device = get_cpu_device(cpu);
+	struct cpuidle_cpu_qos_nb *qos_nb =
+		per_cpu_ptr(&cpuidle_cpu_qos_nb, cpu);
+
+	if (!device)
+		return -ENODEV;
+
+	qos_nb->cpu = cpu;
+	qos_nb->nb.notifier_call = cpuidle_cpu_qos_notify;
+	return dev_pm_qos_add_notifier(device, &qos_nb->nb,
+				       DEV_PM_QOS_RESUME_LATENCY);
+}
+
+void cpuidle_latency_req_notifier_unregister(unsigned int cpu)
+{
+	struct device *device = get_cpu_device(cpu);
+	struct cpuidle_cpu_qos_nb *qos_nb =
+		per_cpu_ptr(&cpuidle_cpu_qos_nb, cpu);
+
+	if (!device)
+		return;
+
+	dev_pm_qos_remove_notifier(device, &qos_nb->nb,
+				   DEV_PM_QOS_RESUME_LATENCY);
+}
+
 static int __init cpuidle_latency_req_init(void)
 {
 	int ret;
-- 
2.43.0


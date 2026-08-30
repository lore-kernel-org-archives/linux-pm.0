Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C513B3883;
	Sun, 30 Aug 2026 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091074; cv=none; b=KL+OUMLbUIyPV9NvNXqZxg54/UG+3UvsdLzno2A42vvoyV8qMgoYmynCeuhPgUPnDrlWWvK87XNtBLEgndjyvW9rFdk3f7b9sgzCcFiS5b9mIp/MrNID2ibX2pM3qu7YhOIQAzAR3k/MP2skU2ZhU23ZmNVXK7O+TfkTGYUROVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091074; c=relaxed/simple;
	bh=px7DgiUPtoupJpFC7Qe5eJ9vcfrb9zpxpxlpjbdgdeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dyu8KPg+eLXo5/lfMHGsfT77//f5mJAAfqeVod3byDPSzr6n2Q5MVNMAKFUNeI7HnpOsPLNkU/KUU/Yw1dPcHOE2XwLy/+MCfR3i6aqiL0PIdrxDypbewe+LZjvGmS4HvH1q8CNDkxx7R+9jiOt+KNa2yQE5Vm3/UM1qsWgex4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DJUrcVBc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DJUrcVBc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B41D31477;
	Sun, 30 Aug 2026 04:57:45 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.5.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0D0F3F66F;
	Sun, 30 Aug 2026 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788091069; bh=px7DgiUPtoupJpFC7Qe5eJ9vcfrb9zpxpxlpjbdgdeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJUrcVBcKa5h2SinK+icdwD4Vi2ZIydmbuB7oum+3yGmBkQ7v5woqwAkPGP5pjesm
	 wkRSBBQA+66oUUVYJ3jGXjo2QcuVzcQABEB71eTxp08MI85Bsl7LFqI/l0x05YymL0
	 I/SmfgcQQ4jxdRi5AGiMiNmXt7ZTuflbu5DZXE4s=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhongqiu.han@oss.qualcomm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v6 08/15] ACPI: CPPC: Release PCC data after probe failures
Date: Sun, 30 Aug 2026 12:56:37 +0100
Message-Id: <20260830115644.2056983-9-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260830115644.2056983-1-christian.loehle@arm.com>
References: <20260830115644.2056983-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcc_data_alloc() takes a per-processor reference while parsing the first
PCC register. Every later probe failure currently frees the CPC descriptor
without dropping that reference. Depending on where probe fails, this
leaks an unacquired PCC object, an acquired mailbox channel, or an extra
reference to a shared channel.

Factor the teardown into pcc_data_put() so it handles both acquired and
unacquired state, and invoke it on every failure after allocation.

Allocation, reference updates, channel setup, and teardown of a shared
subspace are also unsynchronized. Concurrent processor probe and removal
can lose a reference update, free a live object, or request and initialize
the same mailbox channel twice. Protect that lifecycle with a mutex and
publish pcc_channel_acquired only after its lock and wait queue have been
initialized.

Do not store the temporary pcc_data_alloc() result in the eventual probe
return value. A successful allocation must not make a later parsing failure
run cleanup and then return success.

A later processor-start step can fail after CPPC probe has published its
descriptor. Reuse that descriptor when processor start is retried instead
of resetting its PCC index and reparsing _CPC. This prevents the live
descriptor from becoming detached from its PCC reference.

The per-CPU PCC subspace index is zero-initialized. If probe returns before
assigning it, a later processor exit can consequently drop the reference
for subspace 0 even though this CPU never acquired one. Initialize the
index to -1 before any probe return and only release it from exit after a
CPC descriptor has been published.

Fixes: 85b1407bf6d2 ("ACPI / CPPC: Make CPPC ACPI driver aware of PCC subspace IDs")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 153 ++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 37ff54a048c9..e8ffd5b7094d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/ktime.h>
+#include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
 #include <linux/topology.h>
@@ -81,6 +82,7 @@ struct cppc_pcc_data {
 
 /* Array to represent the PCC channel per subspace ID */
 static struct cppc_pcc_data *pcc_data[MAX_PCC_SUBSPACES];
+static DEFINE_MUTEX(pcc_data_lock);
 /* The cpu_pcc_subspace_idx contains per CPU subspace ID */
 static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
 
@@ -735,35 +737,51 @@ EXPORT_SYMBOL_GPL(acpi_get_psd_map);
 
 static int register_pcc_channel(int pcc_ss_idx)
 {
+	struct cppc_pcc_data *data;
 	struct pcc_mbox_chan *pcc_chan;
 	u64 usecs_lat;
+	int ret = 0;
 
-	if (pcc_ss_idx >= 0) {
-		pcc_chan = pcc_mbox_request_channel(&cppc_mbox_cl, pcc_ss_idx);
-
-		if (IS_ERR(pcc_chan)) {
-			pr_err("Failed to find PCC channel for subspace %d\n",
-			       pcc_ss_idx);
-			return -ENODEV;
-		}
+	if (pcc_ss_idx < 0 || pcc_ss_idx >= MAX_PCC_SUBSPACES)
+		return -EINVAL;
 
-		pcc_data[pcc_ss_idx]->pcc_channel = pcc_chan;
-		/*
-		 * cppc_ss->latency is just a Nominal value. In reality
-		 * the remote processor could be much slower to reply.
-		 * So add an arbitrary amount of wait on top of Nominal.
-		 */
-		usecs_lat = NUM_RETRIES * pcc_chan->latency;
-		pcc_data[pcc_ss_idx]->deadline_us = usecs_lat;
-		pcc_data[pcc_ss_idx]->pcc_mrtt = pcc_chan->min_turnaround_time;
-		pcc_data[pcc_ss_idx]->pcc_mpar = pcc_chan->max_access_rate;
-		pcc_data[pcc_ss_idx]->pcc_nominal = pcc_chan->latency;
+	mutex_lock(&pcc_data_lock);
+	data = pcc_data[pcc_ss_idx];
+	if (!data) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	if (data->pcc_channel_acquired)
+		goto out_unlock;
 
-		/* Set flag so that we don't come here for each CPU. */
-		pcc_data[pcc_ss_idx]->pcc_channel_acquired = true;
+	pcc_chan = pcc_mbox_request_channel(&cppc_mbox_cl, pcc_ss_idx);
+	if (IS_ERR(pcc_chan)) {
+		pr_err("Failed to find PCC channel for subspace %d\n",
+		       pcc_ss_idx);
+		ret = -ENODEV;
+		goto out_unlock;
 	}
 
-	return 0;
+	data->pcc_channel = pcc_chan;
+	/*
+	 * cppc_ss->latency is just a Nominal value. In reality
+	 * the remote processor could be much slower to reply.
+	 * So add an arbitrary amount of wait on top of Nominal.
+	 */
+	usecs_lat = NUM_RETRIES * pcc_chan->latency;
+	data->deadline_us = usecs_lat;
+	data->pcc_mrtt = pcc_chan->min_turnaround_time;
+	data->pcc_mpar = pcc_chan->max_access_rate;
+	data->pcc_nominal = pcc_chan->latency;
+	init_rwsem(&data->pcc_lock);
+	init_waitqueue_head(&data->pcc_write_wait_q);
+
+	/* Set flag so that we don't come here for each CPU. */
+	data->pcc_channel_acquired = true;
+
+out_unlock:
+	mutex_unlock(&pcc_data_lock);
+	return ret;
 }
 
 /**
@@ -805,19 +823,49 @@ bool __weak cpc_supported_by_cpu(void)
  */
 static int pcc_data_alloc(int pcc_ss_id)
 {
+	struct cppc_pcc_data *data;
+	int ret = 0;
+
 	if (pcc_ss_id < 0 || pcc_ss_id >= MAX_PCC_SUBSPACES)
 		return -EINVAL;
 
-	if (pcc_data[pcc_ss_id]) {
-		pcc_data[pcc_ss_id]->refcount++;
-	} else {
-		pcc_data[pcc_ss_id] = kzalloc_obj(struct cppc_pcc_data);
-		if (!pcc_data[pcc_ss_id])
-			return -ENOMEM;
-		pcc_data[pcc_ss_id]->refcount++;
+	mutex_lock(&pcc_data_lock);
+	data = pcc_data[pcc_ss_id];
+	if (!data) {
+		data = kzalloc_obj(struct cppc_pcc_data);
+		if (!data) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+		pcc_data[pcc_ss_id] = data;
 	}
+	data->refcount++;
 
-	return 0;
+out_unlock:
+	mutex_unlock(&pcc_data_lock);
+	return ret;
+}
+
+static void pcc_data_put(int pcc_ss_id)
+{
+	struct cppc_pcc_data *data;
+
+	if (pcc_ss_id < 0 || pcc_ss_id >= MAX_PCC_SUBSPACES)
+		return;
+
+	mutex_lock(&pcc_data_lock);
+	data = pcc_data[pcc_ss_id];
+	if (!data || --data->refcount)
+		goto out_unlock;
+
+	pcc_data[pcc_ss_id] = NULL;
+	if (data->pcc_channel_acquired)
+		pcc_mbox_free_channel(data->pcc_channel);
+
+	kfree(data);
+
+out_unlock:
+	mutex_unlock(&pcc_data_lock);
 }
 
 /*
@@ -865,11 +913,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	acpi_handle handle = pr->handle;
 	unsigned int num_ent, i, cpc_rev;
 	int pcc_subspace_id = -1;
+	bool pcc_data_ref = false;
 	bool cpc_present = false;
 	acpi_status status;
 	int ret = -ENODATA;
 	int err;
 
+	if (per_cpu(cpc_desc_ptr, pr->id))
+		return 0;
+
+	per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
+
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
 		if (!cpc_supported_by_cpu()) {
@@ -1008,6 +1062,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 						ret = err;
 						goto out_free;
 					}
+					pcc_data_ref = true;
 				} else if (pcc_subspace_id != gas_t->access_width) {
 					pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
 						 pr->id);
@@ -1140,13 +1195,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 
 	/* Register PCC channel once for all PCC subspace ID. */
-	if (pcc_subspace_id >= 0 && !pcc_data[pcc_subspace_id]->pcc_channel_acquired) {
+	if (pcc_subspace_id >= 0) {
 		ret = register_pcc_channel(pcc_subspace_id);
 		if (ret)
 			goto out_free;
-
-		init_rwsem(&pcc_data[pcc_subspace_id]->pcc_lock);
-		init_waitqueue_head(&pcc_data[pcc_subspace_id]->pcc_write_wait_q);
 	}
 
 	/* Everything looks okay */
@@ -1167,7 +1219,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
 		kobject_put(&cpc_ptr->kobj);
-		goto out_buf_free;
+		goto out_pcc_put;
 	}
 
 	kfree(output.pointer);
@@ -1176,6 +1228,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 out_free:
 	cppc_free_desc(cpc_ptr);
 
+out_pcc_put:
+	if (pcc_data_ref)
+		pcc_data_put(pcc_subspace_id);
+	per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
+
 out_buf_free:
 	if (cpc_present)
 		pr_err("CPU%d: failed to initialize _CPC: %d\n", pr->id, ret);
@@ -1193,28 +1250,20 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
 void acpi_cppc_processor_exit(struct acpi_processor *pr)
 {
 	struct cpc_desc *cpc_ptr;
-	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
+	int pcc_ss_id;
 
 	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
-	if (cpc_ptr) {
-		per_cpu(cpc_desc_ptr, pr->id) = NULL;
-		kobject_del(&cpc_ptr->kobj);
+	if (!cpc_ptr) {
+		per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
+		return;
 	}
 
-	if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
-		if (pcc_data[pcc_ss_id]->pcc_channel_acquired) {
-			pcc_data[pcc_ss_id]->refcount--;
-			if (!pcc_data[pcc_ss_id]->refcount) {
-				pcc_mbox_free_channel(pcc_data[pcc_ss_id]->pcc_channel);
-				kfree(pcc_data[pcc_ss_id]);
-				pcc_data[pcc_ss_id] = NULL;
-			}
-		}
-	}
-	per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
+	pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
+	per_cpu(cpc_desc_ptr, pr->id) = NULL;
+	kobject_del(&cpc_ptr->kobj);
 
-	if (!cpc_ptr)
-		return;
+	pcc_data_put(pcc_ss_id);
+	per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
 
 	kobject_put(&cpc_ptr->kobj);
 }
-- 
2.34.1


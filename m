Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DEA38F930;
	Sun,  9 Aug 2026 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786256789; cv=none; b=JAwoh3hRiKwWsu4/+EgdQ1tjQ/6jSFhFEvUAVZ9m3XnLWkLTT9KKg+SEW8eXQuW8LOnGykpRNt/YZHnluZrwhVI1ZQOXV5TzGzgb08r0//4j0iCJjGDRu7mfF2zi3pSxBg6PBAbA8z7hNh1Vj6nS+0tqvG7AwCmXzEN4Gt1uM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786256789; c=relaxed/simple;
	bh=Ohnxb0cMzUPGFQXsBa4AH2l+rtntCf0Fl9BpTPUB0dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+E0NtGyLn+ZHKsIKWC1sKTLYjNIstGi12+3+FAbH3ukGuC2zHa++bUTLWTHg7Src2wwHcPIYriOTp5XK7wzsKdTkVu0RIu/qMSoo6I+3H4BfQ5aXhtK+sNUIHg11x6r77In5P7Z1WDgxrK+MBfFcldDie73wngcj5npE3azBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fx39lLcc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fx39lLcc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47ADF1A9A;
	Sat,  8 Aug 2026 23:26:23 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.4.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B168E3F9A2;
	Sat,  8 Aug 2026 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786256787; bh=Ohnxb0cMzUPGFQXsBa4AH2l+rtntCf0Fl9BpTPUB0dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fx39lLcc9MgxXLGFG2C+bR+nAYurRkln9TVTWY1b6WLxPgG8HdNeZHCrskeQZybvF
	 kNdRvy9ZwZwF7XQrZt9pndY2R5K+FyK/XpbJc9Asub0Uka9cPasfe8ArXvuez+65/h
	 zCGwOaq5JHcmje8kRZd8BfcR65QXTBsG781VZNrc=
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
Subject: [PATCH v3 08/15] ACPI: CPPC: Release PCC data after probe failures
Date: Sun,  9 Aug 2026 07:25:42 +0100
Message-Id: <20260809062549.1415955-9-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260809062549.1415955-1-christian.loehle@arm.com>
References: <20260809062549.1415955-1-christian.loehle@arm.com>
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

Do not store the temporary pcc_data_alloc() result in the eventual probe
return value. A successful allocation must not make a later parsing failure
run cleanup and then return success.

The per-CPU PCC subspace index is zero-initialized. If probe returns before
assigning it, a later processor exit can consequently drop the reference
for subspace 0 even though this CPU never acquired one. Initialize the
index to -1 before any probe return and only release it from exit after a
CPC descriptor has been published.

Fixes: 85b1407bf6d2 ("ACPI / CPPC: Make CPPC ACPI driver aware of PCC subspace IDs")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 61 +++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 826e27f61530..ef1f716860b3 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -807,6 +807,24 @@ static int pcc_data_alloc(int pcc_ss_id)
 	return 0;
 }
 
+static void pcc_data_put(int pcc_ss_id)
+{
+	struct cppc_pcc_data *data;
+
+	if (pcc_ss_id < 0 || pcc_ss_id >= MAX_PCC_SUBSPACES)
+		return;
+
+	data = pcc_data[pcc_ss_id];
+	if (!data || --data->refcount)
+		return;
+
+	if (data->pcc_channel_acquired)
+		pcc_mbox_free_channel(data->pcc_channel);
+
+	kfree(data);
+	pcc_data[pcc_ss_id] = NULL;
+}
+
 /*
  * An example CPC table looks like the following.
  *
@@ -852,8 +870,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	acpi_handle handle = pr->handle;
 	unsigned int num_ent, i, cpc_rev;
 	int pcc_subspace_id = -1;
+	bool pcc_data_ref = false;
 	acpi_status status;
 	int ret = -ENODATA;
+	int err;
+
+	per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
@@ -986,8 +1008,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
 				if (pcc_subspace_id < 0) {
 					pcc_subspace_id = gas_t->access_width;
-					if (pcc_data_alloc(pcc_subspace_id))
+					err = pcc_data_alloc(pcc_subspace_id);
+					if (err) {
+						ret = err;
 						goto out_free;
+					}
+					pcc_data_ref = true;
 				} else if (pcc_subspace_id != gas_t->access_width) {
 					pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
 						 pr->id);
@@ -1140,7 +1166,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
 		kobject_put(&cpc_ptr->kobj);
-		goto out_buf_free;
+		goto out_pcc_put;
 	}
 
 	kfree(output.pointer);
@@ -1150,6 +1176,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	pr_err("CPU%d: failed to initialize _CPC: %d\n", pr->id, ret);
 	cppc_free_desc(cpc_ptr);
 
+out_pcc_put:
+	if (pcc_data_ref)
+		pcc_data_put(pcc_subspace_id);
+	per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
+
 out_buf_free:
 	kfree(output.pointer);
 	return ret;
@@ -1165,28 +1196,20 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
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


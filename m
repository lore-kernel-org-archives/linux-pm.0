Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995153AC0F3;
	Wed, 26 Aug 2026 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725859; cv=none; b=MRdl8EFsOUUaC6LkBUeqYZSw5URSyYucHA7PeUENS48RBbfUUfFoCl/jzgWhfmfcFwpzqB6u5PX9kabOcA/AcyZ/bcalCV25hD7SsajyLF6Z8HG0lvAwH6+kykPTZ2D1rms1SOi/J8W5XCnb3p6sbeHkM278yd4DWYh78IiIPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725859; c=relaxed/simple;
	bh=eTh879fQizQXxjqdoOO/N5MCjStdyYXoUbOVgbzJ2r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+5xAh3sPFfSEFiHAejA1ITCRs1TDCdD6uDfp4xJsCV/8mzl+0ajIvkNouf7udUaLZX1oOh2oOcrBgi8Mo+MFjdT2phe3aAqWh6R3RYI6NgBRjS8Fy+3f/CLe+bHgGQybd6fAy6z1O6s3h71GBiGVd68ahsLa/9O40DE+b99NzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OQdq+yWr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OQdq+yWr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B13D1BCA;
	Tue, 25 Aug 2026 23:30:49 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7A803F7D8;
	Tue, 25 Aug 2026 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725852; bh=eTh879fQizQXxjqdoOO/N5MCjStdyYXoUbOVgbzJ2r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQdq+yWraSf7TE+qKHVWsfbGsRu5Tbse4VBnVHs5SCJLc/CY2B/FyIq9OEZqhbQ1S
	 LIq0lvaz0PtpavxQPd7O5czimsee25PpxCW8JS1kV2yOJUaWVh9QxAuSLPbOamSdeE
	 75uQb4vsyaNvhZ1efb/FH9IDT9VhMOrgmwRj/ULY=
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
Subject: [PATCH v4 08/15] ACPI: CPPC: Release PCC data after probe failures
Date: Wed, 26 Aug 2026 07:30:12 +0100
Message-Id: <20260826063019.670240-9-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826063019.670240-1-christian.loehle@arm.com>
References: <20260826063019.670240-1-christian.loehle@arm.com>
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
index 50e3a3b4416c..3938f04931bd 100644
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


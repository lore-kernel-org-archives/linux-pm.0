Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD33AE706;
	Sat,  8 Aug 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177700; cv=none; b=oglMnptaWFN2/1d1tJ/JAuJuSRHQCr1vC35z6G3EljE/Qh7aa67Y+iVxtHoqj8rknTrZZjeWt00rbQ0XxJDOvzr7aALCLIcLIVzFZcY7Zo2Jf3uD4G2rLm9v6nAshGRMVBXlnTXt4ygj2YLZOYd7RYxyVCyx90GpEU6Uy2eoE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177700; c=relaxed/simple;
	bh=9tZ/+NWMwe8tNPizJGW4OYdGplQDIkTHb8IkMDjqUqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTsILV0jsIAnsUdwbnuahYN0PX9tFLHbH0STelN35AII5k0b7lWBF4cFG5TIJSSnvLxX/yZabv9x8LPeEYkzlF28J4EjEHANdSPoPTLqV9hLRVbW/otFBzM5MAuIxjTQqP4L9+NU5TOtkOMaXKE28gwKj6vlFmtzuUvb/5jckzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Nz1T3j++; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Nz1T3j++"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41CD61A9A;
	Sat,  8 Aug 2026 01:28:13 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.5.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27BE83F9A2;
	Sat,  8 Aug 2026 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786177697; bh=9tZ/+NWMwe8tNPizJGW4OYdGplQDIkTHb8IkMDjqUqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nz1T3j++L0deEZeJOb4sORq1LKYIiCOwerw4yqQo6ekTAVdXtAtSu5tcPrMeJnPBB
	 4koR+GartHv3KBWmRlXGQnYsMgAEnRGCigw+QsKafojrKCaJko7P5d7rNbaZT0tbIi
	 3v/4ubLHeDooM3ADEa/hgu07AceD97izeWxt6scw=
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
	Christian Loehle <christian.loehle@arm.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 10/15] ACPI: CPPC: Reject reads and RMW of write-only controls
Date: Sat,  8 Aug 2026 09:26:39 +0100
Message-Id: <20260808082644.1251332-11-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808082644.1251332-1-christian.loehle@arm.com>
References: <20260808082644.1251332-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Between _CPC revision 3 and revision 4, Desired Performance changed from
Read/Write to Write.  Revision 4 also added the write-only OSPM Nominal
Performance control.  ACPI 6.6 section 4.6.3 says reads of write-only bit
positions produce undefined results.

The public Desired Performance helper already rejects revision-4 readback,
but the common register accessor still permits either write-only control to
be read.  Reject both centrally so new callers cannot bypass the revision
rule.

A partial SystemMemory field would also make cpc_write() read its complete
access unit to preserve bits outside the field.  Reject revision-4
descriptions of either write-only control when their geometry requires RMW.
A full-width description remains supported and is written without a
preceding read.

OSPM Nominal Performance is optional, so an inaccessible description of it
must not disable otherwise usable CPPC.  Mark that control unsupported and
continue probing.  Desired Performance remains subject to the mandatory or
autonomous-only control rules.

Fixes: 71e1815113f7 ("ACPI: CPPC: Add support for CPPC v4")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ddfc04d275d5..4cc0e69bb397 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -333,6 +333,21 @@ static bool cpc_reg_is_writable(unsigned int reg_idx)
 	}
 }
 
+static bool cpc_reg_is_write_only(const struct cpc_desc *cpc_desc,
+				  unsigned int reg_idx)
+{
+	return cpc_desc->version >= CPPC_V4_REV &&
+	       (reg_idx == DESIRED_PERF || reg_idx == OSPM_NOMINAL_PERF);
+}
+
+static void cpc_disable_reg(struct cpc_desc *cpc_desc, unsigned int reg_idx)
+{
+	struct cpc_register_resource *reg = &cpc_desc->cpc_regs[reg_idx];
+
+	reg->type = ACPI_TYPE_INTEGER;
+	reg->cpc_entry.int_value = 0;
+}
+
 static bool cpc_sysmem_reg_needs_rmw(const struct cpc_register_resource *reg)
 {
 	const struct cpc_reg *gas = &reg->cpc_entry.reg;
@@ -363,6 +378,17 @@ static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
 	if (gas->address & (access_size - 1))
 		goto invalid;
 
+	if (cpc_reg_is_write_only(cpc_desc, reg_idx) &&
+	    (gas->bit_offset || gas->bit_width != access_width)) {
+		const char *name = reg_idx == DESIRED_PERF ?
+				   "Desired Performance" :
+				   "OSPM Nominal Performance";
+
+		pr_err("CPU%d: _CPC v%d %s register requires unsupported read-modify-write\n",
+		       cpc_desc->cpu_id, cpc_desc->version, name);
+		return -EINVAL;
+	}
+
 	return 0;
 
 invalid:
@@ -1290,6 +1316,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 					size_t access_width;
 
 					err = cpc_validate_sysmem_reg(cpc_ptr, gas_t, i - 2);
+					if (err && i - 2 == OSPM_NOMINAL_PERF) {
+						pr_warn("CPU%d: disabling inaccessible OSPM Nominal Performance register\n",
+							pr->id);
+						cpc_disable_reg(cpc_ptr, i - 2);
+						continue;
+					}
 					if (err) {
 						ret = err;
 						goto out_free;
@@ -1758,6 +1790,8 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
+	if (cpc_reg_is_write_only(cpc_desc, reg_idx))
+		return -EOPNOTSUPP;
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
-- 
2.34.1


Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DB399036;
	Sun,  9 Aug 2026 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786256813; cv=none; b=MXl0gTSDtK8Vjj8Iqc7H3f4dpUJ4Yqv0QIwxy6uCAt/S9Avm4KwbH5ndoSqA80ynNKuFrKIQeICbo1+v2h1k9I9e4s3gogbPrepdDW+JuJ3Yl9346RwENpFbLuLN/ILWD9VuaJK5vPiz3aEtqpfJZvtkV2Yy9VP8cEZkNreNq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786256813; c=relaxed/simple;
	bh=bdhAdb0N58akLs0ylCTv/2xat2KOIebwbEW6dRyXNF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgIP0kVnw4gowHq9TtetpZVDSPu1xdt0IHNur/Wcjj46SQGdpJofaTGEC3Np1VxmgWWUy0nwLtRqhi9NP9FikGfruLIAwkXP9g0rSziJ7rz8ITapb6jusAOgWz9XAYw7pLE7e57xxAKxN5XzexAV3dGMD7gDp+IPuJutw0C9diU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=b8dXtyeR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b8dXtyeR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32001152B;
	Sat,  8 Aug 2026 23:26:47 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.4.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B6823F9A2;
	Sat,  8 Aug 2026 23:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786256811; bh=bdhAdb0N58akLs0ylCTv/2xat2KOIebwbEW6dRyXNF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8dXtyeRL5IBk0yVpZbwUCO+NrEp4j3GptVs+yvUMBOuh4cMOZ51pG+1YVgrMNlax
	 ki0xWAOGoxM+wnNnlX1DKZPfZsWrjydRPlhIDDr12wyW16mKBd9JsI1dul1EcOSk9Y
	 L/YZ/k5oOvyLqykb97wRyC5y7My6z0RtGRUGuHdw=
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
Subject: [PATCH v3 15/15] ACPI: CPPC: Clear Performance Limited without a stale read
Date: Sun,  9 Aug 2026 07:25:49 +0100
Message-Id: <20260809062549.1415955-16-christian.loehle@arm.com>
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

The Performance Limited status bits are sticky and write-zero-to-clear.
ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
accesses.

cppc_set_perf_limited() currently reads the register, computes a new value,
and writes it in a separate transaction. If the platform reports another
excursion between those transactions, the stale write can clear that new
event.

Write zero to the requested bits and one to the other defined status bits
directly. Keep reserved bits zero as required for hardware status registers
by ACPI 6.6 Section 4.6.1. This removes the stale read window.

Reject SystemMemory descriptions which require read-modify-write to
preserve the containing access unit, because the per-descriptor spinlock
cannot interlock that RMW with platform updates. Also reject 64-bit
SystemMemory descriptions on 32-bit kernels, where generic readq()/writeq()
may be split into two 32-bit operations and cannot provide the required
portable interlocked access. A naturally aligned full-width QWord remains
supported on 64-bit kernels, where the architecture provides a native
64-bit MMIO accessor.

Performance Limited status is not required for CPPC control. If firmware
describes it using an access that Linux cannot interlock safely, disable
that status register instead of rejecting the processor's otherwise usable
_CPC package.

Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 67d7f81a21b7..9afc285c9314 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -414,6 +414,13 @@ static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
 		       cpc_desc->cpu_id, cpc_desc->version, name);
 		return -EINVAL;
 	}
+	if (reg_idx == PERF_LIMITED &&
+	    (gas->bit_offset || gas->bit_width != access_width ||
+	     (access_width == 64 && !IS_ENABLED(CONFIG_64BIT)))) {
+		pr_err("CPU%d: Performance Limited register cannot use an interlocked SystemMemory access\n",
+		       cpc_desc->cpu_id);
+		return -EINVAL;
+	}
 
 	return 0;
 
@@ -441,6 +448,14 @@ static int cpc_resolve_unsupported(struct cpc_desc *cpc_desc,
 		if (!(unsupported & BIT(i)))
 			continue;
 
+		/* CPPC control does not depend on Performance Limited status. */
+		if (i == PERF_LIMITED) {
+			pr_warn("CPU%d: ignoring inaccessible Performance Limited register\n",
+				cpc_desc->cpu_id);
+			cpc_disable_reg(cpc_desc, i);
+			continue;
+		}
+
 		if (i == DESIRED_PERF && cpc_immutable_autonomous(cpc_desc)) {
 			pr_warn("CPU%d: ignoring inaccessible Desired Performance register in autonomous mode\n",
 				cpc_desc->cpu_id);
@@ -3081,9 +3096,6 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
  */
 int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
 {
-	u64 current_val, new_val;
-	int ret;
-
 	/* Only bits 0 and 1 are valid */
 	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
 		return -EINVAL;
@@ -3091,14 +3103,13 @@ int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
 	if (!bits_to_clear)
 		return 0;
 
-	ret = cppc_get_perf_limited(cpu, &current_val);
-	if (ret)
-		return ret;
-
-	/* Clear the specified bits */
-	new_val = current_val & ~bits_to_clear;
-
-	return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
+	/*
+	 * Performance Limited is write-zero-to-clear.  Write one to the other
+	 * defined sticky bits so a concurrently reported event is not cleared
+	 * using a value obtained by an earlier, separate read transaction.
+	 */
+	return cppc_set_reg_val(cpu, PERF_LIMITED,
+				CPPC_PERF_LIMITED_MASK & ~bits_to_clear);
 }
 EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
 
-- 
2.34.1


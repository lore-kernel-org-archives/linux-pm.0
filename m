Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6DC472F92;
	Fri,  7 Aug 2026 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101232; cv=none; b=B4aTMU/B1L8RTVpBgsoXR7jApXJnDWQnmCM0lYO4b+C+h5gtm22deLcO7yfyvaJ5xPTBI3a9X3Beg69tcoFK3lPpue5biY4Dt3/Rz/zmveTXfVOZ9zHJbSOdMnCPRASzDsKvEGaxNCy91hihVzIoKyr0ddOYAtEGGNCT81UvR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101232; c=relaxed/simple;
	bh=7a0GirumEDdHHQ/Z8P050Cgx9QYuO7/hotLkwJMhE2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYW/IMcULn+7nudO1ZhVmbZMDV1m59Ky+RTdUvSdcnvPcHweScxKYzIOCUNC8yEmAjhCMZ12BQHB32dG670RUOYL6Cv1lZ/P0IwTpesYaKGv8KeDrJ/0IwnzfxOPAsrB8hBAZ7nmQgydo4w+j82WDh9kGS/ncOtHBZCwMaNL5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bFpe96QO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bFpe96QO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613AE1516;
	Fri,  7 Aug 2026 04:13:46 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79B003F86F;
	Fri,  7 Aug 2026 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786101230; bh=7a0GirumEDdHHQ/Z8P050Cgx9QYuO7/hotLkwJMhE2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFpe96QOX8qypc/pDCZsNabzzFxAAN/uX915mk2B2lGQlwEHAZ7453ckkrjo7x1ph
	 Q8J+4kyL3O6lv+Z/5aB6tJ66NmqqzJPDUMPlcYk0GE5XqYOFpD/bVG+OQRPp9+dhIN
	 VZwvr8PdrVReGq+hqYQ89LsIbGLR5Yd7cKEth3yA=
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
Subject: [PATCH 15/15] ACPI: CPPC: Clear Performance Limited without a stale read
Date: Fri,  7 Aug 2026 12:13:03 +0100
Message-Id: <20260807111303.1062391-16-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807111303.1062391-1-christian.loehle@arm.com>
References: <20260807111303.1062391-1-christian.loehle@arm.com>
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

Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 621b190aea3c..4f55607fc116 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -406,6 +406,13 @@ static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
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
 
@@ -3054,9 +3061,6 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
  */
 int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
 {
-	u64 current_val, new_val;
-	int ret;
-
 	/* Only bits 0 and 1 are valid */
 	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
 		return -EINVAL;
@@ -3064,14 +3068,13 @@ int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
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


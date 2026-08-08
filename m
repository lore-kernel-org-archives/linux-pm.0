Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0EE3B19CF;
	Sat,  8 Aug 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177713; cv=none; b=KB2Zi0VdD7kMcZmHMZ4meVS+2DNMGncu3Ze3+PWBLL0+Wl0fO/N6AwcTWXQy8kUm+OuIyNtO26Pr6ZAFOVFsw91yZTpYufhm99pShzDZDFERLBVl5KriX8nURfoyEMv0kmzAs6/3dZLbZoLTakmTzOu3HetqEWHAmbcxA+b9fu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177713; c=relaxed/simple;
	bh=x2W/qudr6wfVbY9UCho1t8cvHsFS/wHJFGI6BbnPIe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7Z8yYxhpPLBp4SIGwBfWzqIlTRR0V0g+C+c94Ac1FcHYcKY7cqZ8qFUVpGMU2eWFKod/PchNp4c5MkpRHxISbrxi4UtF9imN/DYvp773hdnT7UhuqR9mwxRKMAUXCnTnSdUMaymrs2lgozfHDVpm7nFj2dIru/TEjZqRWTli9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BjHoCqlr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BjHoCqlr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D1201BF3;
	Sat,  8 Aug 2026 01:28:27 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.5.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11EC93F9A2;
	Sat,  8 Aug 2026 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786177711; bh=x2W/qudr6wfVbY9UCho1t8cvHsFS/wHJFGI6BbnPIe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjHoCqlrGreoykr8fxv9gAjT94BvjYbSoxr59EjPv8LU8yh5voZaZnqEQdH6eQj0O
	 FJs+flX77qBoBf/qljS7ORf7anbdG51I/oOPvfp2jjep7vZ5N5Y//QW3X83y40dR+b
	 cVZiW/Tw2DVx2Pkw8P/tGuyRqmFv+vpp8h8AEEWs=
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
Subject: [PATCH v2 15/15] ACPI: CPPC: Clear Performance Limited without a stale read
Date: Sat,  8 Aug 2026 09:26:44 +0100
Message-Id: <20260808082644.1251332-16-christian.loehle@arm.com>
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
index fbbc71671717..426e94434376 100644
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
@@ -3080,9 +3095,6 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
  */
 int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
 {
-	u64 current_val, new_val;
-	int ret;
-
 	/* Only bits 0 and 1 are valid */
 	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
 		return -EINVAL;
@@ -3090,14 +3102,13 @@ int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
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


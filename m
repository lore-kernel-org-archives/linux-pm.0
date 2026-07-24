Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35DE4334C8;
	Fri, 24 Jul 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900595; cv=none; b=e/OdQn51QF2KDs3yYycH0GmiY592KO9ONcJbZCz0JZeQGox9RYN4x7kddW8DdojivDk3NSH8nyk/xET5zta+guGxrjtPVLeD0cyx1D2WBUuv4fH/1l8kzzqAR9qrjIgJPZnAA21D0p3Z8DRg6/BfHAQ2N+MNLfhhZFRe1hcMbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900595; c=relaxed/simple;
	bh=dMB18QgeVAdPqzBMAuUOG2aj6yCR7463Svrc+87yX68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xa/PLP/hCAVZWhD9kfym6nBDYZEVmTejuxXa0XT6i8IFcDNVyLT1VMFe0/i1jDfkfDmk4+iJ6tKgdo/Mk/gwmlMO5IXfRIq0Q9QqWO3LdOxqLI6aXw2s6tMq1TGYUecpW28O5S2iKt6UYGMXTwL8IfwS7BOpMnhEy9zbc0mtMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IrMctGv7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IrMctGv7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CACD1684;
	Fri, 24 Jul 2026 06:43:02 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.66.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A00C3F59E;
	Fri, 24 Jul 2026 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784900586; bh=dMB18QgeVAdPqzBMAuUOG2aj6yCR7463Svrc+87yX68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrMctGv71LZW6FNC/yLG7pWcdlxyQCJ79PnACGgJXLeM1waZ09r2tJNsXD6AHc6H0
	 vHtlJk5M5UuKYDf6mesverHvEnXQr3S3ig1IPQ19ocEL2vlOFSInVe3KZa18fJuUfZ
	 i9a/jjSs4J1ZMcShYkepiNMej5Fp4HFmkbwOkgqs=
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/3] ACPI: CPPC: Avoid unnecessary reads for full-width writes
Date: Fri, 24 Jul 2026 14:42:49 +0100
Message-Id: <20260724134251.1632824-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724134251.1632824-1-christian.loehle@arm.com>
References: <20260724134251.1632824-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SystemMemory GAS entries may describe a field within a wider access
unit, so cpc_write() reads the access unit before updating the field to
preserve the surrounding bits. It also does this when the field covers
the complete access unit.

When the bit offset is zero and the register bit width equals the
resolved access width, the previous value cannot affect the result. Skip
the MMIO read and mask operation in that case. Retain rmw_lock because
another entry in the same _CPC package may share the access unit.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 53d09ca98f06..9b8d68b44ea9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1162,25 +1162,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			return -ENODEV;
 		}
 
+		/*
+		 * Only partial fields need the previous contents to preserve bits
+		 * outside the field. Keep serializing full-width writes because
+		 * another _CPC entry may share the access unit and require RMW.
+		 */
 		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
-		switch (size) {
-		case 8:
-			prev_val = readb_relaxed(vaddr);
-			break;
-		case 16:
-			prev_val = readw_relaxed(vaddr);
-			break;
-		case 32:
-			prev_val = readl_relaxed(vaddr);
-			break;
-		case 64:
-			prev_val = readq_relaxed(vaddr);
-			break;
-		default:
-			raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
-			return -EFAULT;
+
+		if (reg->bit_offset || reg->bit_width != size) {
+			switch (size) {
+			case 8:
+				prev_val = readb_relaxed(vaddr);
+				break;
+			case 16:
+				prev_val = readw_relaxed(vaddr);
+				break;
+			case 32:
+				prev_val = readl_relaxed(vaddr);
+				break;
+			case 64:
+				prev_val = readq_relaxed(vaddr);
+				break;
+			default:
+				raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock,
+							   flags);
+				return -EFAULT;
+			}
+			val = MASK_VAL_WRITE(reg, prev_val, val);
 		}
-		val = MASK_VAL_WRITE(reg, prev_val, val);
 	}
 
 	switch (size) {
-- 
2.34.1


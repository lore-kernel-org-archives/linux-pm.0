Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127893B47C4;
	Mon,  3 Aug 2026 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791142; cv=none; b=frKn7EytWnzXeL6G7hNAQQWQWTddt2Uv1vKTM3wXxBtwJbr/QMCJge+zcx7f7MC4S6UuGtPE56JTEKHDXXfpZGLCIWVGFKDYlli7mIqjAePPDBsIg+839uemYXQM7fEvMVrD3mQqAMhSK/ratQx2E+TqqG0iXwSL6ehFI5Or9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791142; c=relaxed/simple;
	bh=dMB18QgeVAdPqzBMAuUOG2aj6yCR7463Svrc+87yX68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQetaI4pPSgvJWkAVRZ3KZPfNhxuMiCpxRAf9sh+r1osmH6Ls0Lxg/0e8dZaecM5bUoQSABmU+3uwMEu85r4RUWQFbVoKwn9T5DGUm7wYYUwk1hUuE0cLswd4lLqO7lFR9aLq5yIq90vsrpKSxpevTXinbqq63rZDFUsS2iH8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LPnNZk4G; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LPnNZk4G"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 717121476;
	Mon,  3 Aug 2026 14:05:36 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.0.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E1923F86F;
	Mon,  3 Aug 2026 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785791140; bh=dMB18QgeVAdPqzBMAuUOG2aj6yCR7463Svrc+87yX68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPnNZk4GcTaF6g2j76B+zCTIw2JhUHkcP1dFYvLUaO4L34VBCD3rFOvBkrJDmx4oW
	 4MD+FX5620yj8ARscQV/tVlxhlSCIQSyQNMn37YKj2mHPMOgYEytKmaeSMae2hy//5
	 kw/xMTmMEvOMbXQTYpqqlSg/PNlUhUqDAi1wYm+Q=
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
Subject: [PATCH 1/3] ACPI: CPPC: Avoid unnecessary reads for full-width writes
Date: Mon,  3 Aug 2026 22:05:25 +0100
Message-Id: <20260803210527.1285229-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803210527.1285229-1-christian.loehle@arm.com>
References: <20260803210527.1285229-1-christian.loehle@arm.com>
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


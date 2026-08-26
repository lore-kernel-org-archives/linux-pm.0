Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C43A48E4;
	Wed, 26 Aug 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725848; cv=none; b=OWzaE9g3jU2ZqXLjlX/XAe7PZa9/70Zp+YJnxXvQFQ2vODsjhtP7NH6LYLaCf5TCnRo9Jglp0hsaAuH0s7+lmpUa1NEMkJ8RML86Wx+2bdRwJYRlBYm9oSYIsPyxbbNIXNxSTAmQfeBwV+fY6LKoRMUoD2xaIPB4FW9uNNL8964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725848; c=relaxed/simple;
	bh=N7crhD4q5yiop8Ep66Xuv0cJSI2gs/6J89DLcSDT0Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHXeqCZOp3+wD8OYaq63PPoMr/FLKwgALW6Kqbw0GZCF2xDp01WbJFSWoOjZr0Zp5pjGirs7FRjB7lUQPja79XUYhr2Y9R72tMjhrjWJrz49wO+MzdJ4VPpj6gEd9zHwKOs6IzYE76w0sYtT2rUNKWJRo93+QdI3znPu1xLMRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N+8NzSBe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N+8NzSBe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3508716F2;
	Tue, 25 Aug 2026 23:30:37 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 627E23F7D8;
	Tue, 25 Aug 2026 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725841; bh=N7crhD4q5yiop8Ep66Xuv0cJSI2gs/6J89DLcSDT0Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+8NzSBepNKYKxov012Yp2yHCmeed5HC7P3K4NJBq6hXHvbbDmtgcGaUpkMUDOSSK
	 Z1NUEUqGRt7GDnHGykskOM+e7PNu06f2WoUjU+jddjMVFCbVZ5go32U3nAnNyz1Tfi
	 JV3MO28YWB/cr6BgDRN0focdLpk55NoDQyj2LUUw=
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
Subject: [PATCH v4 04/15] ACPI: CPPC: Use 64-bit masks for register fields
Date: Wed, 26 Aug 2026 07:30:08 +0100
Message-Id: <20260826063019.670240-5-christian.loehle@arm.com>
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

MASK_VAL_READ() and MASK_VAL_WRITE() operate on u64 values but construct
their masks with GENMASK(), whose type is unsigned long. On 32-bit kernels
a field wider than 32 bits therefore produces an invalid shift or loses
its upper bits.

The Generic Address Structure permits QWord access units and the CPPC
accessors implement 64-bit MMIO reads and writes. Use GENMASK_ULL() in both
directions so the mask matches the value and supported access width on
every architecture.

Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 32929dbc33ed..794b6cf1e0d3 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -235,10 +235,10 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
 /* Shift and apply the mask for CPC reads/writes */
 #define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
-					GENMASK(((reg)->bit_width) - 1, 0))
+					GENMASK_ULL(((reg)->bit_width) - 1, 0))
 #define MASK_VAL_WRITE(reg, prev_val, val)						\
-	((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |		\
-	((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))	\
+	((((val) & GENMASK_ULL(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |	\
+	((prev_val) & ~(GENMASK_ULL(((reg)->bit_width) - 1, 0) << (reg)->bit_offset))) \
 
 static u64 cpc_sysmem_access_size(const struct cpc_register_resource *reg)
 {
-- 
2.34.1


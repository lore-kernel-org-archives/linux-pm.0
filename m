Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8FD3ACA48;
	Sat,  8 Aug 2026 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177678; cv=none; b=b5tTFjZTHbudAQ5gewjywlFTwW2iegETtdvnIkqEVmo9BLaIzkBZF4Dr1iU8/pxOjqjGzkxAkiwZh35gZsIsKpm+A7S5dJ+JRwTtLptaMLOX+KUKDVbhU+l+dUl9MygfDxqUFQuytMO4VjpIpsuSs+WOiWlmenJoYhO5OnlQViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177678; c=relaxed/simple;
	bh=Pj99XZ2jaP2Q8ChGhjRp5qvypWTDdvKsVobIIMqhs30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqMx0CNozM1IskktxhS/EgBB6uYIaUkwEHMIzfII4rTh1LOd5A4mqLmyDTBwROOtQEaG5JIxslcoWcaQkHq5OZIEnIH2RcN96ti+zsG0q9PVMFYv7lQfDNDbXrH3LTp6e/Xo632SOMj8gxE30fzXnUzO8MwWPgBsK2FolTFg+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZZTO6NKp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZZTO6NKp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F07981A9A;
	Sat,  8 Aug 2026 01:27:52 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.5.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 478613F9A2;
	Sat,  8 Aug 2026 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786177676; bh=Pj99XZ2jaP2Q8ChGhjRp5qvypWTDdvKsVobIIMqhs30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZTO6NKp8EXFIHJ/Ht5/al0ESucQ3UUc8hd9uiHZV71xDvG/F+VYRKPZfIo7kT3Du
	 lh3EY7EkZqzy0Pje+UnQReC+ZDCgHcpjjh36MrEcSdzWBsuLHUaGKmBYQ/XbaKMIYk
	 IaQwVoRoN3KuFm7YnfbyeJfcyye87fJ03Jzg281c=
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
Subject: [PATCH v2 04/15] ACPI: CPPC: Use 64-bit masks for register fields
Date: Sat,  8 Aug 2026 09:26:33 +0100
Message-Id: <20260808082644.1251332-5-christian.loehle@arm.com>
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
index b40052f5a52d..92b7718f306e 100644
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


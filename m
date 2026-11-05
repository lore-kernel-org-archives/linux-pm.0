Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915558;
	b=F9q1utd6zrqDz4XNEC2atjiw9gmtRwso5WI494+462X2GujF59TWn522q50MOPeL4HTp
	 QzeclSa+rlethS0U6x9ei9GZ4akG8fvdzZKUF5hSDESJ/e+KH1J7JgcmqcVF4wMArOoTg
	 DEN/Y8Yks3u8SfAl8ANQcDcnhPkIyxDpmLycfpMufC3tjKDmPt7EgyfANVEd8H4xZPG5m
	 PpZHtYsmwlfXQpIeMkbVoBqLyRwELptcghv0/h+rZN58UlBm/z85zkCA9C+G6TxKWP/Z/
	 +rMHspuahJtCjttqZHlaE5ksFJYukQuE/sXk37iaq6t6oz+51RX+M2sBSG1tZ/25vzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915558;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=htQKH5NrsDBxjh7VK2KlfJWOln+BxMMMQ3kuy7brT0Y=;
	b=oKfUEEZ0yFwPPhxDmYaL4LP2znk7hGncRM/Zb5rraY+FEhGvubcpiUxKAGcpVm1IIPRn
	 0GFqAHXiYZtEzvEdRe4R76aFLHW2iI2LRPgE+9zzCFBH7zqp/1DDaiK/DKmReVa47D0Om
	 20tqG1FbmtGgl+jdVMCrXUZg1r/m8yQIKNfZS1waKKrxoknAJd4q1MViPO4uSAEsOVVgI
	 WBzkOg3CcbFFkCqby+oPSY9HnQPb22Up3XH4nMCVqBW+eeUXge/F44qBniuIZgswbal1N
	 9vwwfoLx/vT5oxMIZIkYs/1zr38YJ7TBUiV35lpMWfL5hBzf9k6Fjq872TBYfZk8AoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="ZEnPAw/5";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1970606A332;
	Thu,  5 Nov 2026 21:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1970606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZEnPAw/5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 279DD168F;
	Thu,  5 Nov 2026 13:52:34 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2B953F959;
	Thu,  5 Nov 2026 13:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793915557; bh=zGFb03FlNjOPjHZ5poQPrpkZh2R07016fhZpR6N0NhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEnPAw/5G9bpq3KqaeSIZXVyd1YAkgRFiA8ZC3kwCzy96xlvLHGDdC0mZInF/r7bY
	 9hejwNxKWTLCwvbb3DX0x+KxRAra8NWv/RzNcJnTmeElaWixLBChXrob9QkoBVipGL
	 ZsBvMBZV6Z0h0uYfUuf51XIiQK7/DS4YvNdzRsoY=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumitg@nvidia.com,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com,
	Christian Loehle <christian.loehle@arm.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Subject: [PATCH v3 2/2] cpufreq: Serialize global boost updates
Date: Thu,  5 Nov 2026 21:52:23 +0000
Message-Id: <20261105215223.1263415-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105215223.1263415-1-christian.loehle@arm.com>
References: <20261105215223.1263415-1-christian.loehle@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Concurrent global boost sysfs writes can interleave their global flag
and per-policy updates. An enabling write can set the global flag, then
a disabling write can clear it and finish before the enabling write
updates the policies. Both writes succeed, leaving boost enabled on
the policies while the global flag is disabled.

Serialize the complete global boost update, including rollback on
failure, with a mutex.

Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 23a77f5524df..d95c849f79c5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2810,6 +2810,8 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 }
 EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
 
+static DEFINE_MUTEX(cpufreq_boost_mutex);
+
 static int cpufreq_boost_trigger_state(int state)
 {
 	struct cpufreq_policy *policy;
@@ -2817,6 +2819,8 @@ static int cpufreq_boost_trigger_state(int state)
 	bool boost_enabled;
 	int ret = -EOPNOTSUPP;
 
+	guard(mutex)(&cpufreq_boost_mutex);
+
 	/*
 	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
 	 * make sure all policies are in sync with global boost flag.
-- 
2.34.1


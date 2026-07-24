Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E93859E0;
	Fri, 24 Jul 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889658; cv=none; b=WYxWQK7zNMVRbTIzwDC8KF2G6ZYaZCujoQ84i1/w5W/6q82Un2cKS26Hh/FgCuk8kouoqIJRPsn9z6CNXm83B3Wkt8pGOoL+9Fq9wXkDCl+NH79dzWMJ5FEtHf09eeq8GQs3HCg9TF2ssB51Etn0XTsbymzv8DtvKMrFaIyKnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889658; c=relaxed/simple;
	bh=0dMTQo4+4RzWdtmKVRgM9LQMQjmSDt0cKQDtgnGATOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RCdSN2UoGhSehHvkllkMOAuJtDmXzA84Viq70Vp9Wr0o+b4qVseXgk91ymwHLdn1BWiTw77xnnFCSNFwN9uB1FAyIUgOZLUvP8cUp9/BpusAot6UjNL3Rua4JbESqL+nCkFHu+G5DeQdAzdj0toU0GfbV5QLfYOjmny10RlMolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CCragE5o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CCragE5o"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 793841477;
	Fri, 24 Jul 2026 03:40:51 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 847FC3F66F;
	Fri, 24 Jul 2026 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784889655; bh=0dMTQo4+4RzWdtmKVRgM9LQMQjmSDt0cKQDtgnGATOM=;
	h=From:To:Cc:Subject:Date:From;
	b=CCragE5op1PbD4HO+pnK+t9Napbjvr8C7r4z6cxBHTDK97tA8kPR3g3z7au+K0+iJ
	 AcozilEJOJ8z7pxuVHq/577AT6mnSQqfKRUuQ6UIrrsVBn5DuqlzTo1ir0wcKb+D1p
	 PZgAU6rfOwGQiRcSOfDicudk4dXUgDoyOz7aQf3g=
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
Subject: [PATCH] ACPI: CPPC: Skip writes to unsupported performance controls
Date: Fri, 24 Jul 2026 11:40:42 +0100
Message-Id: <20260724104042.1481804-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MIN_PERF and MAX_PERF are optional CPPC controls. DESIRED_PERF is also
optional with CPPC2 when autonomous selection is supported.

The cppc-cpufreq target callbacks populate both limits for every request
without checking whether the controls are implemented. cppc_set_perf()
consequently passes NULL register descriptors to cpc_write(). The writes
fail width validation and their return values are ignored, so the failed
access paths are repeated on every target request. An autonomous-only
platform can take the same path for DESIRED_PERF.

Check that each performance control is supported before calling
cpc_write().

Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
v2: Also added desired_perf check (Sumit)

 drivers/acpi/cppc_acpi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d3a94100491..53d09ca98f06 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1963,16 +1963,17 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 		cpc_desc->write_cmd_status = 0;
 	}
 
-	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+	if (CPC_SUPPORTED(desired_reg))
+		cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
 
 	/*
 	 * Only write if min_perf and max_perf not zero. Some drivers pass zero
 	 * value to min and max perf, but they don't mean to set the zero value,
 	 * they just don't want to write to those registers.
 	 */
-	if (perf_ctrls->min_perf)
+	if (perf_ctrls->min_perf && CPC_SUPPORTED(min_perf_reg))
 		cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
-	if (perf_ctrls->max_perf)
+	if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
 		cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
 
 	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
-- 
2.34.1


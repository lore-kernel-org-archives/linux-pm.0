Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4050243302C;
	Fri,  7 Aug 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101207; cv=none; b=G04LNr3DSr/Kb6kuzDXXv5SbZm6vI17RZm5tzr4h07rmTdZar/LU5U1ul8Os1dGuoba/Fjk723gFJYhlC7nnQa74RLWULtz16sHiO3uVgBWi32OM0DjY75er9KUp+3yqDue9uul2/qJJqHOzpd6eMGiK7r65du+iJcSWI4G1CEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101207; c=relaxed/simple;
	bh=YW5/fHTHzDIkTwl6rv6u29uEV3cwmYRIQNmgDadkXy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMlS+ixsRMdME17iTxsZeuOgeK5EMUxSoNhzICAnVesgdW5ofMN8WCpJ/vOFAlJmtt4i1uYcZ8LmZkYWv9zMEl44TvAE7gCzcVwtQh8F32nZZUsD+d0VaIXGjstKkWZMoONpIaxIkLLwMLPW5GOHm0zeGnCNoHSLsZiYwbdsXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HOh0PpTH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HOh0PpTH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C1B1516;
	Fri,  7 Aug 2026 04:13:21 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 890C83F86F;
	Fri,  7 Aug 2026 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786101205; bh=YW5/fHTHzDIkTwl6rv6u29uEV3cwmYRIQNmgDadkXy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOh0PpTHnkkolm8WJQk0Qt/X1gIenqykqKu47KML+7bmd7a6DuL4hqdT0RvHh9gNH
	 xwNdmWWrwIYZR4ssWfH9B9O5RMhe6X/mFTasIyGmhIh1bJS/fywyDaCF7h3JSQLk4z
	 mGxlYvZfROk4BvetwCzfAkJobpeK06ev6cjMMnfc=
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
Subject: [PATCH 05/15] ACPI: CPPC: Serialize PCC single-register payload updates
Date: Fri,  7 Aug 2026 12:12:53 +0100
Message-Id: <20260807111303.1062391-6-christian.loehle@arm.com>
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

The PCC doorbell protocol requires OSPM to confirm ownership of the shared
subspace before placing a command and its payload there.
cppc_set_reg_val_in_pcc() instead modifies the payload before taking
pcc_lock.

A concurrent command can consequently overwrite or consume the staged
value, and OSPM can write the shared region while the platform still owns
it.

Take the PCC write lock first, wait for the previous command to complete,
and keep the lock held while staging the value and submitting CMD_WRITE.
This follows the ownership sequence in ACPI 6.5 Section 14.5 and the
existing contract documented by send_pcc_cmd().

Fixes: e05c75072c2e ("ACPI: CPPC: Add cppc_set_reg_val()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index bfbdf3294017..ca8fd092b44f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1453,7 +1453,7 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
-	struct cppc_pcc_data *pcc_ss_data = NULL;
+	struct cppc_pcc_data *pcc_ss_data;
 	int ret;
 
 	if (pcc_ss_id < 0) {
@@ -1461,15 +1461,24 @@ static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
 		return -ENODEV;
 	}
 
-	ret = cpc_write(cpu, reg, val);
-	if (ret)
-		return ret;
-
 	pcc_ss_data = pcc_data[pcc_ss_id];
+	if (!pcc_ss_data)
+		return -ENODEV;
 
 	down_write(&pcc_ss_data->pcc_lock);
+
+	ret = check_pcc_chan(pcc_ss_id, false);
+	if (ret)
+		goto out;
+
+	ret = cpc_write(cpu, reg, val);
+	if (ret)
+		goto out;
+
 	/* after writing CPC, transfer the ownership of PCC to platform */
 	ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+
+out:
 	up_write(&pcc_ss_data->pcc_lock);
 
 	return ret;
-- 
2.34.1


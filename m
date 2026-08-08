Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017893AC0CE;
	Sat,  8 Aug 2026 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177682; cv=none; b=ZIzoBefiuhud1uf2ZX7xtz0+p4tnRzLbwhX8xiJMRr+GvMRHQdDWTVBltE2IKyPSQBdtQhQOU/pjYCcW4BtXv3lg4uJGr49Suhx1GVRY8a/g4hSoQkxe++9uom2KPHdbE9JRjkELPz1i3KdZyKieo7LHlEakYHfgsA0eu2cx3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177682; c=relaxed/simple;
	bh=wlgn869lnp2e71RThjspr+dlfiV1XqdX2TIQLF6x3KE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7sXCl7HZD1XtVvo5AJxyNtnE0u11N4DF48hyR2rRwd1HPUYmPw2tui2PRQ8arC33k9293Wu/77PCIj8/cwXzrCk8IMj2Tk+uRfbutQyPrk4E0is9KmgqXgSz/AVdAZbonaxfEj1ssae+D+pT27pU96R3N1hNXC3sDMPcSzFAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JSWVpJRp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JSWVpJRp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55837152B;
	Sat,  8 Aug 2026 01:27:56 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.5.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58B883F9A2;
	Sat,  8 Aug 2026 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786177680; bh=wlgn869lnp2e71RThjspr+dlfiV1XqdX2TIQLF6x3KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSWVpJRpbvn8xCA85K5xMrJb0bhhH+AFBhPO6DIcUjSgaoG6Nax6sGF1wekG0rwnK
	 KwpzXSj8dh4D4hRl5H62V7teAsBA5hoNIKF3AGCW6U2Ysn87BIm4Xwa4EdOJZjr609
	 eHfKPhsMq1hlh1EQhOVWSNBgRz6J9h7fOhBya0gI=
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
Subject: [PATCH v2 05/15] ACPI: CPPC: Serialize PCC single-register payload updates
Date: Sat,  8 Aug 2026 09:26:34 +0100
Message-Id: <20260808082644.1251332-6-christian.loehle@arm.com>
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

If ownership acquisition or staging fails, abort any older performance
batch before dropping the exclusive lock. This advances its generation and
wakes cppc_set_perf() callers which otherwise wait indefinitely for a
command this path did not submit.

Fixes: e05c75072c2e ("ACPI: CPPC: Add cppc_set_reg_val()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 92b7718f306e..dcb925301d97 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1472,7 +1472,7 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
-	struct cppc_pcc_data *pcc_ss_data = NULL;
+	struct cppc_pcc_data *pcc_ss_data;
 	int ret;
 
 	if (pcc_ss_id < 0) {
@@ -1480,15 +1480,26 @@ static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
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
+	if (ret)
+		cppc_abort_pending_pcc_write(pcc_ss_data, ret);
 	up_write(&pcc_ss_data->pcc_lock);
 
 	return ret;
-- 
2.34.1


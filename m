Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4408C2C15AC;
	Thu, 27 Aug 2026 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812284; cv=none; b=pXi+EPx1jQ2JyS7GF0iNMr+g6HfXMxhfkC4RC029J2Jwm2ELzRdwA+UwEiJ/FbhBoxCAEya1fxZfoMsU2JnznLNuFF3zpgxTSHfyI/Ux68IHpgcqy8bcpVWJav65WwGWDfSpiwwEibEM4MX24a3wE6Y1g690qlNGhMPPcfZg4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812284; c=relaxed/simple;
	bh=VyvBlNJ8+5NGWPT0TeOwPz9DYpbQ4Wj1Uvy+rpRx9Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkWVTGxJg+GcgtYtHQQrt17qJ+bIQhIz1BJU4GfHvI+wj4d596kZONMF/nn/wKj1cp507SZk1FtkBUBIV0sQ8QBirPFvQMuCSQ+0T77+VxOMso8Ul7fjSXOZr47oHKR1IiXcgV3Mnfgfswoqovf8VwKK8p3+0j7tLrF1G/u8qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EU2CyrR1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EU2CyrR1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2E3E169E;
	Wed, 26 Aug 2026 23:31:18 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.73.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EE923FB7F;
	Wed, 26 Aug 2026 23:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787812282; bh=VyvBlNJ8+5NGWPT0TeOwPz9DYpbQ4Wj1Uvy+rpRx9Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EU2CyrR1FwdNlgtn22krkD/VG4Dd8oqTbLzMCAm3fc4HKpP/DPwChduazl9J3nYoc
	 97IqvIB07/Str24yCGOwdRMcj6PYo+yHr1YskJdHW+Mq3fupfWyeT+a0U9FSmkHFt3
	 pcgQICVSb+B3xVrB0M7ggW2QFxG+BVB2felP9cWM=
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
Subject: [PATCH v5 05/15] ACPI: CPPC: Serialize PCC single-register payload updates
Date: Thu, 27 Aug 2026 07:30:50 +0100
Message-Id: <20260827063100.2741066-6-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827063100.2741066-1-christian.loehle@arm.com>
References: <20260827063100.2741066-1-christian.loehle@arm.com>
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
index 1caac71d3e00..3f025cfa30f6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1504,7 +1504,7 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
-	struct cppc_pcc_data *pcc_ss_data = NULL;
+	struct cppc_pcc_data *pcc_ss_data;
 	int ret;
 
 	if (pcc_ss_id < 0) {
@@ -1512,15 +1512,26 @@ static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
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


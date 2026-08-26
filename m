Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B405D357D18;
	Wed, 26 Aug 2026 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725846; cv=none; b=iD9I5OgRGofiQVUMxDLm4lscLLBHR8Ujd+teBkDJs1/1Ag1EvyZXD9WN4N6E0fzmgG8xocHPvcaZPw7wZVRqOA09BJGwJtYOGtDiurwUJ9B13qReJj/hffnp2KntpIBWvCosWiJHmTHlx29yz7zeWsQC4e2W7NXwPi58tZbMn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725846; c=relaxed/simple;
	bh=BvtTMoOY+gcND5yVH4SFdjezA+IgvbyMtzCT7koNLEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFeDm9WIh/fMyb4X7j7tMUUJtCrrBQJFG8VfbXkqfIrsJoE9zrBZzePaAoGnyjoSF9HjllcsaEl8ORuPZllL6lAK3tR7v8m8HuKXsfOZmDL9/CrHH8yq3uciMFhQAt85I0bsu7MSOBsQDZKngVkrffvCx25vtgHYYxkE7q0u4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AAGG/Be/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AAGG/Be/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39D741D34;
	Tue, 25 Aug 2026 23:30:34 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A44BF3F7D8;
	Tue, 25 Aug 2026 23:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725838; bh=BvtTMoOY+gcND5yVH4SFdjezA+IgvbyMtzCT7koNLEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAGG/Be/TqJySaA80VvZs/kvXLt1hD+swn/BMNkwkW6le33ANcs+qo7RnmYYjzbiq
	 HdJYff1/7nSqh3+nkMBDrsL9aWhD/DZLIAIigyI+wWT5+QkT6AE2ebQH6G2eb4QfMC
	 MqTWqVlRWAjUfbDClMNxapHyx8NYyM1DTxPHB90c=
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
Subject: [PATCH v4 03/15] ACPI: CPPC: Propagate performance-control write errors
Date: Wed, 26 Aug 2026 07:30:07 +0100
Message-Id: <20260826063019.670240-4-christian.loehle@arm.com>
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

cppc_set_perf() can skip malformed controls, discard cpc_write() failures,
and report success without programming the requested performance tuple.

Return every control-write error to the caller. For mixed PCC and non-PCC
performance controls, complete all requested non-PCC writes before taking
PCC ownership or changing its payload. A non-PCC failure therefore cannot
submit only the PCC portion of a request. Once ownership is held, stage
only PCC controls and mark the command pending after successful staging.

If PCC staging fails while another CPU has already staged a request, take
the exclusive PCC lock and abort the pending batch before returning. This
advances the write generation and wakes Phase-II waiters which would
otherwise wait indefinitely for a doorbell that no CPU will ring.

Cross-address-space updates cannot be atomic, but this ordering ensures a
known non-PCC failure never commits the PCC portion by itself.

Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CPPC")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 123 ++++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e803fe9327ca..32929dbc33ed 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -373,13 +373,45 @@ static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
 	return ret;
 }
 
+static void cppc_complete_pcc_write(struct cppc_pcc_data *pcc_ss_data,
+				    int ret)
+{
+	int i;
+
+	if (unlikely(ret)) {
+		for_each_possible_cpu(i) {
+			struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
+
+			if (!desc)
+				continue;
+
+			if (desc->write_cmd_id == pcc_ss_data->pcc_write_cnt)
+				desc->write_cmd_status = ret;
+		}
+	}
+
+	pcc_ss_data->pcc_write_cnt++;
+	wake_up_all(&pcc_ss_data->pcc_write_wait_q);
+}
+
+/* The caller must hold pcc_lock for write. */
+static void cppc_abort_pending_pcc_write(struct cppc_pcc_data *pcc_ss_data,
+					 int ret)
+{
+	if (!pcc_ss_data->pending_pcc_write_cmd)
+		return;
+
+	pcc_ss_data->pending_pcc_write_cmd = false;
+	cppc_complete_pcc_write(pcc_ss_data, ret);
+}
+
 /*
  * This function transfers the ownership of the PCC to the platform
  * So it must be called while holding write_lock(pcc_lock)
  */
 static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 {
-	int ret = -EIO, i;
+	int ret = -EIO;
 	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
 	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
 					pcc_ss_data->pcc_channel->shmem;
@@ -471,21 +503,8 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 		mbox_client_txdone(pcc_ss_data->pcc_channel->mchan, ret);
 
 end:
-	if (cmd == CMD_WRITE) {
-		if (unlikely(ret)) {
-			for_each_possible_cpu(i) {
-				struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
-
-				if (!desc)
-					continue;
-
-				if (desc->write_cmd_id == pcc_ss_data->pcc_write_cnt)
-					desc->write_cmd_status = ret;
-			}
-		}
-		pcc_ss_data->pcc_write_cnt++;
-		wake_up_all(&pcc_ss_data->pcc_write_wait_q);
-	}
+	if (cmd == CMD_WRITE)
+		cppc_complete_pcc_write(pcc_ss_data, ret);
 
 	return ret;
 }
@@ -2158,7 +2177,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	struct cpc_register_resource *desired_reg, *min_perf_reg, *max_perf_reg;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
-	bool regs_in_pcc;
+	bool desired_pcc, min_pcc, max_pcc, regs_in_pcc;
 	int ret = 0;
 
 	if (!cpc_desc) {
@@ -2169,8 +2188,29 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
 	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
 	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
-	regs_in_pcc = CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) ||
-		      CPC_IN_PCC(max_perf_reg);
+	desired_pcc = cpc_is_writable(desired_reg) && CPC_IN_PCC(desired_reg);
+	min_pcc = perf_ctrls->min_perf && cpc_is_writable(min_perf_reg) &&
+		  CPC_IN_PCC(min_perf_reg);
+	max_pcc = perf_ctrls->max_perf && cpc_is_writable(max_perf_reg) &&
+		  CPC_IN_PCC(max_perf_reg);
+	regs_in_pcc = desired_pcc || min_pcc || max_pcc;
+
+	/* Do not stage PCC data if a fallible non-PCC write has failed. */
+	if (cpc_is_writable(desired_reg) && !desired_pcc) {
+		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		if (ret)
+			return ret;
+	}
+	if (perf_ctrls->min_perf && cpc_is_writable(min_perf_reg) && !min_pcc) {
+		ret = cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
+		if (ret)
+			return ret;
+	}
+	if (perf_ctrls->max_perf && cpc_is_writable(max_perf_reg) && !max_pcc) {
+		ret = cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * This is Phase-I where we want to write to CPC registers
@@ -2193,30 +2233,37 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 				return ret;
 			}
 		}
-		/*
-		 * Update the pending_write to make sure a PCC CMD_READ will not
-		 * arrive and steal the channel during the switch to write lock
-		 */
-		pcc_ss_data->pending_pcc_write_cmd = true;
-		cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
-		cpc_desc->write_cmd_status = 0;
 	}
 
-	if (CPC_SUPPORTED(desired_reg))
-		cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+	if (desired_pcc) {
+		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		if (ret)
+			goto out_pcc_read_unlock;
+	}
 
 	/*
 	 * Only write if min_perf and max_perf not zero. Some drivers pass zero
 	 * value to min and max perf, but they don't mean to set the zero value,
 	 * they just don't want to write to those registers.
 	 */
-	if (perf_ctrls->min_perf && CPC_SUPPORTED(min_perf_reg))
-		cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
-	if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
-		cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
+	if (min_pcc) {
+		ret = cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
+		if (ret)
+			goto out_pcc_read_unlock;
+	}
+	if (max_pcc) {
+		ret = cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
+		if (ret)
+			goto out_pcc_read_unlock;
+	}
 
-	if (regs_in_pcc)
+	if (regs_in_pcc) {
+		/* Block a PCC read until the staged payload has been submitted. */
+		pcc_ss_data->pending_pcc_write_cmd = true;
+		cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
+		cpc_desc->write_cmd_status = 0;
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
+	}
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
 	 *
@@ -2275,9 +2322,17 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 				   cpc_desc->write_cmd_id != pcc_ss_data->pcc_write_cnt);
 
 		/* send_pcc_cmd updates the status in case of failure */
-		ret = cpc_desc->write_cmd_status;
+		if (!ret)
+			ret = cpc_desc->write_cmd_status;
 	}
 	return ret;
+
+out_pcc_read_unlock:
+	up_read(&pcc_ss_data->pcc_lock);
+	down_write(&pcc_ss_data->pcc_lock);
+	cppc_abort_pending_pcc_write(pcc_ss_data, ret);
+	up_write(&pcc_ss_data->pcc_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_set_perf);
 
-- 
2.34.1


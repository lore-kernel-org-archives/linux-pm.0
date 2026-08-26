Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783D73AFD07;
	Wed, 26 Aug 2026 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725849; cv=none; b=RVM/I5Vuzgt8Ijrn3HuLQZKjiRx+C9x8cu2uSqMxnH2h21HYR8hirMuxPV2S/3q8MtfY00PQiIpzecSTJbPIAr3elFmo8WOKaW+TMlH6/EOegnSwhiQjFQPYH7wsPtRS/gHf78AypwttgZTQWDHot9Q7fDgRSAmZAn/qbuY6xVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725849; c=relaxed/simple;
	bh=H6rtiRcYZdL0ZTSXwO87FqsXg1TcwL0VedIZr8eB6HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZF3UmKsfMr/Akzcv1NuAVwLN33Hnw+pEl1YjX1/R3t+oJr9knbw92Clrv3y7xrZOLJUDdXcrWwEKEAyIvPJ+4Q0x+wT1BUODTe2Y3kNfMj1oOj3v6ALKL4dWaopDWwjPcON+hs6A9AJ4n9clu1cv5PTUDiDO1tzuR/uyv1nncwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vakc2ozN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vakc2ozN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88E5E1BCA;
	Tue, 25 Aug 2026 23:30:40 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 712E13F7D8;
	Tue, 25 Aug 2026 23:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725844; bh=H6rtiRcYZdL0ZTSXwO87FqsXg1TcwL0VedIZr8eB6HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vakc2ozNlGgKoKoCN0WsTdwv7XfOcZW2k6aXID4ytcbZ2Ky2SUVh8q0i85nJPQuSD
	 0YPpagPXbddqeyOZTu6UV6P2avHGS82E+O8vFus9/fTs/2+q+0Wsifs21Gd4ZEcREM
	 +/La8G/DoF69KVC3dHiGqosOYgpLZGCOzqJsIHso=
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
Subject: [PATCH v4 05/15] ACPI: CPPC: Serialize PCC single-register payload updates
Date: Wed, 26 Aug 2026 07:30:09 +0100
Message-Id: <20260826063019.670240-6-christian.loehle@arm.com>
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
index 794b6cf1e0d3..1495511cb10d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1491,7 +1491,7 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
-	struct cppc_pcc_data *pcc_ss_data = NULL;
+	struct cppc_pcc_data *pcc_ss_data;
 	int ret;
 
 	if (pcc_ss_id < 0) {
@@ -1499,15 +1499,26 @@ static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
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


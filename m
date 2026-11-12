Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489208;
	b=GZyRMhLND4wcxcZixGKqW8Wj0Fmei8Qb4KvYi8f+nCxq59lRFokxi4foo5Ftz4HmJ7Z5
	 OFQxYJ1JZ8ZIjfqt/ZsIdEO9WdHtzxmjKld7CwxXq7OvV8VeZ6NM24XwrdtedmRSLiTfZ
	 lDWfjYoInXg1+ih1KdaBxmtNLPMMlri9t/IZpHOVJY9ifYV6kEfDXpHm0gMPdzBOrtC6G
	 cCa16O0Kk4SCUHNZXozjJ70H518AO+jep3mMCk/xK8sw5r6ivGqJErCe2tB6C/rkme9ug
	 s4DaOgiguZozUlhlcILj/0VyU68Es7lMJjG45323eUN3SifJaXVOcEzCvkOuH0K06EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489208;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZpApkbKU3ZsoiNAhhHCoEVKj92IniiefWTc2Opb/MLM=;
	b=aSTTRtDXJBu88PNprKuahjGYCvHJQrQk2fKzRKBQ7mJqGSvldfR2Crih4Wedj1h6CmJd
	 B/DxkkFZuNTcsa37+mTkLZ6J9WAIqXBHMRvLlntlJSHjbgKgZmEcXdqUdkMxZvqcBL0qt
	 9Zk5nruBkAJ7UtKfX1StFLRGdoGfzIs+Z+O7y5ZITi9hK6YktdSngtO8TeVzhsWvW0kvp
	 jVgJcSY+6bx7FM3NOMHi6PVZxgkyWuzef32cYQTbpQ9MeLyIh8beAKKoG9KCiYxPSzMbh
	 fzK5VQydFXX+RWv2iV3haRyaR1uEbHrObYPM7PtUggNDbKxj93cMkU7xrg0boQ+uwyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=F16yliEH;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52760A3817;
	Thu, 12 Nov 2026 13:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B52760A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=F16yliEH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8040B1477;
	Thu, 12 Nov 2026 05:13:23 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFA0D3F632;
	Thu, 12 Nov 2026 05:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794489206; bh=gDhpRG9HzbH++N3Ou09SmMvoccXoz4cwWE2+zjP2HBY=;
	h=From:To:Cc:Subject:Date:From;
	b=F16yliEH5xITYol5rABPSRESDTPGuk2y21iC1BGKDHgF+SFZ63xsCtpiOsd7ShvQf
	 fjMWVWye8QCD5O3RIzV0iTIV0pUI4FAyaR2dy2S1FcAHMFrONLNE8JtN6B/hh0dlYM
	 A+PiNEDDkcCMsWfbNsBwYEKebsQJtZkqZkLToU3Q=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumit.gupta@nvidia.com,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] ACPI: CPPC: Scale EPP values to the register width
Date: Thu, 12 Nov 2026 13:13:16 +0000
Message-Id: <20261112131316.827708-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
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

The EPP sysfs interface uses 0-255, but ACPI permits 4-8 bit fields.
Writing 128 to a 4- or 6-bit SystemMemory field currently succeeds but
stores zero, selecting maximum performance.

Scale writes to supported narrow EPP registers and normalize reads to
0-255. Cover both EPP setters and cppc_get_perf() so saved firmware values
round-trip correctly.

Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous selection")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  5 ++
 drivers/acpi/cppc_acpi.c                      | 46 +++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index d219fc27a0c9..c63b5cfd993c 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -322,6 +322,11 @@ Description:	Energy performance preference
 		performance increase/decrease and the result of the hardware's
 		energy efficiency and performance optimization policies.
 
+		For supported EPP registers narrower than eight bits, values are
+		scaled and rounded to the nearest hardware preference.
+		Reads use the same 0-255 scale and may differ from the requested
+		value due to the reduced precision.
+
 		Writing to this file only has meaning when Autonomous Selection is
 		enabled.
 
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 11a9f9eb6b4a..10b52163eb56 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -38,6 +38,7 @@
 #include <linux/iopoll.h>
 #include <linux/ktime.h>
 #include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/rwsem.h>
@@ -2841,6 +2842,25 @@ int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 }
 EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
 
+/* Keep the EPP interface on an 8-bit scale, including firmware readback. */
+static u64 cppc_scale_epp(const struct cpc_register_resource *reg,
+			  u64 epp, bool to_reg)
+{
+	unsigned int width = reg->cpc_entry.reg.bit_width;
+	u32 max;
+
+	if (reg->type != ACPI_TYPE_BUFFER || width < 4 || width >= 8)
+		return epp;
+
+	max = BIT(width) - 1;
+	if (to_reg)
+		return DIV_ROUND_CLOSEST_ULL(epp * max,
+					     CPPC_EPP_ENERGY_EFFICIENCY_PREF);
+
+	return DIV_ROUND_CLOSEST_ULL(epp * CPPC_EPP_ENERGY_EFFICIENCY_PREF,
+				     max);
+}
+
 /**
  * cppc_get_epp_perf - Get the epp register value.
  * @cpunum: CPU from which to get epp preference value.
@@ -2850,7 +2870,15 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
  */
 int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
-	return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	int ret;
+
+	ret = cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
+	if (!ret)
+		*epp_perf = cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
+					   *epp_perf, false);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
 
@@ -3150,6 +3178,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	bool auto_sel_non_pcc;
 	bool epp_pcc;
 	bool epp_non_pcc;
+	u64 epp;
 	int ret;
 
 	if (!cpc_desc) {
@@ -3159,6 +3188,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+	epp = cppc_scale_epp(epp_set_reg, perf_ctrls->energy_perf, true);
 	if (!enable && auto_sel_reg->type == ACPI_TYPE_INTEGER &&
 	    auto_sel_reg->cpc_entry.int_value == 1)
 		return -EOPNOTSUPP;
@@ -3177,7 +3207,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 			return ret;
 	}
 	if (epp_non_pcc) {
-		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+		ret = cpc_write(cpu, epp_set_reg, epp);
 		if (ret)
 			return ret;
 	}
@@ -3205,7 +3235,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		}
 
 		if (epp_pcc) {
-			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+			ret = cpc_write(cpu, epp_set_reg, epp);
 			if (ret)
 				goto out_unlock;
 		}
@@ -3235,9 +3265,17 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
  */
 int cppc_set_epp(int cpu, u64 epp_val)
 {
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
 	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
 		return -EINVAL;
 
+	if (!cpc_desc)
+		return -ENODEV;
+
+	epp_val = cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
+				 epp_val, true);
+
 	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp);
@@ -3496,7 +3534,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 		if (ret)
 			goto out_err;
 	}
-	perf_ctrls->energy_perf = energy_perf;
+	perf_ctrls->energy_perf = cppc_scale_epp(energy_perf_reg, energy_perf, false);
 
 	if (CPC_SUPPORTED(auto_sel_reg)) {
 		ret = cpc_read(cpu, auto_sel_reg, &auto_sel);
-- 
2.34.1


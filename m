Received: from smtph3-05.21cn.com (smtph3-05.21cn.com [150.223.194.107])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C13EDE63;
	Tue, 14 Jul 2026 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.223.194.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016407; cv=none; b=tXcLQqFr3PEl6gacXRCMpHeWEW7shEWcRnBp6xDbpyaPs8m5gyr8+wYd6HBZZzMHp6mAM3Kf0wYLBlQBteO1FC75Z4CRCggm8tAfbynj5aINAWath8LUeGtKqZ6QdAjc+8ucKJEHereLrbY5XgX29IeOk28xY2sKVMzgYQC2SYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016407; c=relaxed/simple;
	bh=+cltpD9HJG8140I1RV820WYxNDUkUnPEn+bNyDglrY4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ahHhZorgMfk3+6yGygqERjjQnqiVppwrZUp0PlcnoAIpmDY8xFteEQqvPbb27H4pyAkXdkc3GtKFgvDQH4F218WKwyThw0nelfyC7Cj3LWuxPwSEUyAXnKi9upOGlebyXqIWn8daYXAhuJsk7+L1uaERkNuyTY+gihAJo1XxVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=150.223.194.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:172.27.0.100:0.1528351204
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-139.200.108.11 (unknown [172.27.0.100])
	by smtph3-05.21cn.com (HERMES) with SMTP id BB48F1401AD6B;
	Tue, 14 Jul 2026 15:59:11 +0800 (CST)
X-189-SAVE-TO-SEND: +pengqh1@chinatelecom.cn
Received: from  ([139.200.108.11])
	by gateway-ssl-dep-657b8df9db-r4cbp with ESMTP id fd781366e666437f82459565a48b6125 for ray.huang@amd.com;
	Tue, 14 Jul 2026 15:59:24 CST
X-Transaction-ID: fd781366e666437f82459565a48b6125
X-Real-From: pengqh1@chinatelecom.cn
X-Receive-IP: 139.200.108.11
X-MEDUSA-Status: 0
Sender: pengqh1@chinatelecom.cn
From: Qianheng Peng <pengqh1@chinatelecom.cn>
To: ray.huang@amd.com,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	kprateek.nayak@amd.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	skhan@linuxfoundation.org,
	li.meng@amd.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangxb12@chinatelecom.cn,
	xiongl24@chinatelecom.cn,
	zhangar@chinatelecom.cn,
	pengqh1@chinatelecom.cn
Subject: [PATCH] cpufreq: amd-pstate-ut: fix null pointer dereference
Date: Tue, 14 Jul 2026 15:59:01 +0800
Message-Id: <1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The crash issue may occur when insmod amd_pstate_ut modules.

   amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
   amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
   BUG: kernel NULL pointer dereference, address: 0000000000000080
   #PF: supervisor read access in kernel mode
   #PF: error_code(0x0000) - not-present page
   PGD 0 P4D 0
   Oops: 0000 [#1] SMP NOPTI
   CPU: 0 PID: 20300 Comm: modprobe
   Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
   Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020
   RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
   Call Trace:
    <TASK>
    amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
    ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
    do_one_initcall+0x42/0x2e0
    ? kmalloc_trace+0x26/0x90
    do_init_module+0x60/0x240
    __se_sys_init_module+0x185/0x1c0
    do_syscall_64+0x62/0x190
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
    </TASK>

Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
amd_pstate_ut_check_freq() to avoid unpredicated null pointer dereference.

Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
---
 drivers/cpufreq/amd-pstate-ut.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 735b29f..3b24260 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
 		if (!policy)
 			continue;
 		cpudata = policy->driver_data;
+		if (!cpudata) {
+			pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
+			return -EINVAL;
+		}
 
 		if (get_shared_mem()) {
 			ret = cppc_get_perf_caps(cpu, &cppc_perf);
@@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
 		if (!policy)
 			continue;
 		cpudata = policy->driver_data;
+		if (!cpudata) {
+			pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
+			return -EINVAL;
+		}
 
 		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
 			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
-- 
1.8.3.1


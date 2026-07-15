Received: from smtph3-08.21cn.com (smtph3-08.21cn.com [150.223.194.133])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AE436BE9;
	Wed, 15 Jul 2026 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.223.194.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108160; cv=none; b=JeXAg7zWtzdSzsul9oEw+GWkWIH5sPMHExKdCNQ0Cni0pw/ZOkA3+CUa0aqZ/xvDXfs1dWc1L/umFGnXDcyuyrqcuJ00n0m/dwbbR8pXnldjFrdTUwF3txuK35534HPezwXDVIsPozBSj5VMRYUsL9mQwEBUToOicV9LI3wwGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108160; c=relaxed/simple;
	bh=YcxfcrHYqeLbyiw3uuKPRg2HsomhoFmT+3aey5ywoMs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=k2/gibs0Il5ttX+yPrgdA5QOTll6qXHEXJl4sLmfHULiTHw0FoF4uWuH9liuodkH/F7O9VB22ZhBAEFyV9goKK6v8YiOxYi+6HFQ0zSnStADzHuffzDpDeGHbDmz0YsYc62Fi/5x4e2zWXjNcVGvwhy/5l1x5d5v2MJKgTgS48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=150.223.194.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:172.27.0.101:0.1012423176
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-139.200.108.11 (unknown [172.27.0.101])
	by smtph3-08.21cn.com (HERMES) with SMTP id 89AF314065E24;
	Wed, 15 Jul 2026 17:35:29 +0800 (CST)
X-189-SAVE-TO-SEND: +pengqh1@chinatelecom.cn
Received: from  ([139.200.108.11])
	by gateway-ssl-dep-657b8df9db-xsh6f with ESMTP id d800384539cd41fcbb8212b0ebb51764 for ray.huang@amd.com;
	Wed, 15 Jul 2026 17:35:39 CST
X-Transaction-ID: d800384539cd41fcbb8212b0ebb51764
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
Subject: [PATCH v2] cpufreq: amd-pstate-ut: fix null pointer dereference
Date: Wed, 15 Jul 2026 17:35:24 +0800
Message-Id: <1784108124-19988-1-git-send-email-pengqh1@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The crash issue may occur when insmod amd_pstate_ut module on intel platform.

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
Otherwise, add driver name detection for amd_pstate_ut driver to prevent it
from testing cpufreq driver on non-amd platform.

Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>

---
v2:
  - Print policy->cpu instead of policy->kboj.name
  - Add cpufreq driver name detection to amd_pstate_ut

v1: https://lore.kernel.org/all/1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn
---
 drivers/cpufreq/amd-pstate-ut.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 735b29f..5d71315 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
 		if (!policy)
 			continue;
 		cpudata = policy->driver_data;
+		if (!cpudata) {
+			pr_err("%s empty driver_data on cpu %d\n", __func__, policy->cpu);
+			return -EINVAL;
+		}
 
 		if (get_shared_mem()) {
 			ret = cppc_get_perf_caps(cpu, &cppc_perf);
@@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
 		if (!policy)
 			continue;
 		cpudata = policy->driver_data;
+		if (!cpudata) {
+			pr_err("%s empty driver_data on cpu %d\n", __func__, policy->cpu);
+			return -EINVAL;
+		}
 
 		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
 			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
@@ -560,6 +568,15 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
 static int __init amd_pstate_ut_init(void)
 {
 	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
+	const char *driver_name = NULL;
+
+	driver_name = cpufreq_get_current_driver();
+	if (!driver_name)
+		return -ENOENT;
+	/* don't test if non-amd cpufreq_driver exists */
+	else if (strcmp(driver_name, "amd-pstate") &&
+		 strcmp(driver_name, "amd-pstate-epp"))
+		return -EEXIST;
 
 	for (i = 0; i < arr_size; i++) {
 		int ret;
-- 
1.8.3.1


Received: from smtph3-03.21cn.com (smtph3-03.21cn.com [150.223.194.104])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E33319E7F7;
	Thu, 16 Jul 2026 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.223.194.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192448; cv=none; b=n1qeDhj5vsYb2rm7DoggWjELIJQhISt5KbonsEdvSulArtsc9SiuG76nHwylY4GXzgPBjf+fZCiwG0vvtgbILqSbUkdJKTtVqNG6g3vEiwUDZQfj9y3aKc9hA3L3lZsnr17ajV+bujE902LUp6P/RQ/QASlMhNLgZOHGvSBogZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192448; c=relaxed/simple;
	bh=KLERyX3LdgTykIalvx9HdLdgJtUu/7YrRDduL5pvJBQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kkA/sWsFRzrdGan4RO9yyYu8mkCY4KiezbPHjDFNUdgd4S43CUOjKI+LZjMabZwmwMyShlLvZ4onpfwQyMEk4l4pfj/Unbzpq1vr5og0DMFuNj4aGqwUPceVwP75mCvgTvYwi96ufISyD3YoGkbnYmyVwEnd65D4h8fwAIca+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=150.223.194.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:172.27.0.100:0.1509987477
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-139.200.108.11 (unknown [172.27.0.100])
	by smtph3-03.21cn.com (HERMES) with SMTP id 6E2B2C02D068;
	Thu, 16 Jul 2026 16:51:42 +0800 (CST)
X-189-SAVE-TO-SEND: +pengqh1@chinatelecom.cn
Received: from  ([139.200.108.11])
	by gateway-ssl-dep-657b8df9db-r4cbp with ESMTP id 8fd3ea7dbc1144c88804158b34fa0daa for ray.huang@amd.com;
	Thu, 16 Jul 2026 16:51:57 CST
X-Transaction-ID: 8fd3ea7dbc1144c88804158b34fa0daa
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
Subject: [PATCH v3] cpufreq: amd-pstate-ut: bail out early on non-AMD platform
Date: Thu, 16 Jul 2026 16:51:39 +0800
Message-Id: <1784191899-28957-1-git-send-email-pengqh1@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The crash issue may occur when modprobe amd_pstate_ut on intel platform.

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

Add state detection to amd pstate driver to prevent amd_pstate_ut driver
from testing on non-AMD platforms.

Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>

---
v3:
  - Remove unnecessary NULL check
  - Add detection to driver state instead of driver name

v2: https://lore.kernel.org/all/1784108124-19988-1-git-send-email-pengqh1@chinatelecom.cn
  - Print policy->cpu instead of policy->kboj.name
  - Add cpufreq driver name detection to amd_pstate_ut

v1: https://lore.kernel.org/all/1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn
---
 drivers/cpufreq/amd-pstate-ut.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 735b29f..2142838 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -560,6 +560,11 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
 static int __init amd_pstate_ut_init(void)
 {
 	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
+	enum amd_pstate_mode mode = amd_pstate_get_status();
+
+	/* don't test if no running amd-pstate driver */
+	if (mode == AMD_PSTATE_UNDEFINED || mode == AMD_PSTATE_DISABLE)
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < arr_size; i++) {
 		int ret;
-- 
1.8.3.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82012F585
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473283; cv=none; b=dQ/KnZPUH7laEcawYAqyTwJHk2ZG1dRbBENItuR890ztfxGN6W9b0nWimutrc1oV806hXEXc8w5Gc07lFxQNMkIm+smh+7Qb/w4Y+K006EKJFGlG0rCSEIbWeEuaYMxczi6epL2dXLKIknp7y6y925MivNltVDMuPtDbLfNeHQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473283; c=relaxed/simple;
	bh=1PHBCl6fkaBB6kcX0DfRapCJ2DHs3lNR1Za2ufTgymA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/ALdzE1Q2BZVwK6Kgh7ovQOPy7oYfEL6gJQuvpbrQcXeNLOncJCz5fdT3ED3ld7XA2twukdYeNpaCn0N3ihI6cEbJMnd103m0rc7s4YI/lB+r691VDUDNm4pPhWfQu9S7cAINKIyMiJl/C/Bz0D5Dl6mu4nJOS1fpp1iFR0CtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QSMSu8mj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IcqF+LKJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSMSu8mj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IcqF+LKJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63685Odt3361680
	for <linux-pm@vger.kernel.org>; Mon, 6 Apr 2026 11:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iFvuZkFHBlbWFKTuJ7rczF/bMXb2VQMAzOP
	I9N2YllQ=; b=QSMSu8mj7JqZkdrz0FWCyBxB/sMEUwbQvRppyTUdYnaj8lxWlrB
	lM+Jf+vDKOH0Rk+dELGVDOo/0jHbO2RFEunPD2+cbP3XRI9LgBe3hP1Pi1IB7z3k
	P0T6c4H1y1xGGgJHQVjdyd0IMyDfENti5uOTXQdsZzITFrX/mfIQ7hweuYui1fVZ
	jp8yJk0minRIimcDR9GqCVow8EK6S8f2RR2Vsv2EWWvk4+BzhWvacq2JjDSP/6+x
	EQJd+eOhcg+4aP3iIIGTKIfbuVT2ZjdNcdx7U3Njx4hFarsjaTyxWiorUaNfx7lm
	Ol47zUPdQMyoM+HWiWzhwFH5HjME9BO/nvg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mn2b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 11:01:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b242cbb97aso30872195ad.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775473279; x=1776078079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFvuZkFHBlbWFKTuJ7rczF/bMXb2VQMAzOPI9N2YllQ=;
        b=IcqF+LKJx8km/UhFamWhUuYGyxivnCgmnz5URn6tb85J6lhXQF7bNd46WgrrmCUoi6
         +EG3ZBuOFzW2ZxqKqTZPJEFSc6P/2ydxTHuUiQzjNklKZ/LFvTDZTBgW4f5Whf7mUB8z
         SwTy3sIGaEgsZfVRs2Q89ikEJ+0/YY52R/JzFMd8/x3Wt5hSCuO5l1nU989oAJtMdcnO
         95yCmBRlVvHcw7sqNYWIq0z/kJXTrAEKjIweRPyL6b8oxF/+Jg+Lfz9doMWM+DifiPBJ
         3qUpHNJHa/LLoevZ3UFAswAqGOsseef210b4s++fWnYcAWwyCAHabrn9Br3r46IguThG
         Da5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775473279; x=1776078079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFvuZkFHBlbWFKTuJ7rczF/bMXb2VQMAzOPI9N2YllQ=;
        b=ig/BacGQVgOln1g5dFB/AXd+UwVWK+oHAoNTEjsaa0ZnuIPXKaxltWUOW/SrDT/kVg
         IAR6aUk1iIWdLP9gKAqHQdMCjYS2Uory/kA7KzjRbA34NjtjVgmfTLfdK34d/ddwj88B
         vuChP44Guu51Sm4U2KE2CmIkeWGuj4yQzjqLcj2SgT5QNSvX5pkheOvgcViTz+eiGprs
         60IlOxjLbE/ZjY10rwurGu7ZN9LaNDJv+XDE+rZCIFXSNbjrVjN/wwPAkvktNhh+GaVO
         IBz0GizrVIZRp+kJlwNl1JBy0Wn3OoY504qUCJHDogG/7fmvXpTmK8U/lq4DUZtszm8o
         VBKA==
X-Forwarded-Encrypted: i=1; AJvYcCVnHpyK2TMX3mtclMZ2PMzdLKgDjjNUSa2YYJy6xeyLZvcKyuAoPiwlLl7Dwu+r49SwkdyD9N2TjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++TG6UwYQGX4JpiD5jqU3Gq5bqbLtDB9JLeClwFCjru+Jq33y
	vnVjJH1XRPK9H7au5znhZo2qRZoD1RxJhNgFE+r7nzDxSGgD+UybhynlVzWJNUWRm8Wd8mnnPEd
	sbZx22NACEYQhqtRvGNOwYPMYpAxKO0Ytk4LjeJgelAUFN0ZChOLDqadYLZt+nQ==
X-Gm-Gg: AeBDietaTOW1B9MOXF4wm3EMvOUG5qrDQu2y1JF6QU9ONufrJXLrmKU0fAPS5YVWGAh
	gS3V2P6gPPIQbDMUAKpPD4jTJBx8hlgnH3TZ3EnlGmHJrfxGrBJu+zE3VCshoWyP2eTt+HidopG
	Pomkt1z2AX6Djxp4Gq9qnuWX8i4cA8sMLGzjxtNRq+yobTPzBUgAh0JG84iS4pJhbJSmmapJqwZ
	BQJooDFjyUO2IDrcfwVPvHaOZW7RziCxgM/8h05KKoQAhkDlpGPJIGmjJm7SLU2zPJHdOboztip
	kmh67eau1mOgzUkjcLo4iVMAdTektfTU3wCdijZCr3koFYOjUoZgAsFPijsmibNi3a9xYubQxfg
	DurRsouVfHWDFNvbDv6Xj1Z0k2gqk4f2H5rI7Snm++lSNUbkQEe+xKjt/in1rM1E3q4Lv3mBT9+
	oylUFspSVcOKe4
X-Received: by 2002:a17:903:2c05:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2b28183277emr138123065ad.23.1775473279014;
        Mon, 06 Apr 2026 04:01:19 -0700 (PDT)
X-Received: by 2002:a17:903:2c05:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2b28183277emr138122515ad.23.1775473278426;
        Mon, 06 Apr 2026 04:01:18 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d20bsm136503625ad.16.2026.04.06.04.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 04:01:17 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: venkatesh.pallipadi@intel.com, davej@redhat.com, trenn@suse.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] cpufreq: governor: Fix race between sysfs store and dbs work handler
Date: Mon,  6 Apr 2026 19:01:13 +0800
Message-ID: <20260406110113.3475920-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DMZRzjpM7CLRJ70F2-KbM5mS5QtwOf7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEwOCBTYWx0ZWRfX7VBCgeumW38s
 /M4xygzOWk/QWPsA74E9pAhX+W7TiNuy5J0acAsD/KEmZjVr3slQpbLdWpulhNs62t2yGnN8xnO
 6QK3RFEWuwJBNFCoC1w2WM736VwWIfxaMOlT3afx6RclHmqyM/Uhn6HvPxMxjSgnpo+N1eM+ueA
 x+CndcA0vEu7m2bug435kpvRlerjWu2ZSmCw4RGKSirkvmCoLn7gT7D0Md5+Mm4Au+22gWubItN
 t26QBeKsn6tdVGo3UvgkIap4iQJUI5FDcpcyhUj4e/kQ24X1gnWl2UKrVk9rAf0K+RQA1I9IZha
 ttYwvjDPxhKVmxHzAm5d5XC8lEePm+MIclgu/NVd6FFjIm1ofSVUHxMfn0uL2UdXJB3XRusShA0
 NcLzar5Q3b8SW1CokPgkPCuUVXe95ivACUaoUNMAxUZuBw3uMjB1tPMwRV519H0V2wmZL/VUUxq
 oqBDJtZ3eSER5JfgRAg==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d39280 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Xzaa9a87-0lj3eSA-_AA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: DMZRzjpM7CLRJ70F2-KbM5mS5QtwOf7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060108

gov_update_cpu_data() resets per-CPU prev_cpu_idle and prev_cpu_nice
for every CPU in the governed domain. It is called from sysfs store
callbacks (e.g. ignore_nice_load_store) which run under
attr_set->update_lock, held by the surrounding governor_store().

Concurrently, dbs_work_handler() calls gov->gov_dbs_update() (which
calls dbs_update()) under policy_dbs->update_mutex. dbs_update() both
reads and writes the same prev_cpu_idle / prev_cpu_nice fields. The
potential race path is:

Path A (sysfs write, holds attr_set->update_lock only):

  governor_store()
    mutex_lock(&attr_set->update_lock)
    ignore_nice_load_store()
      dbs_data->ignore_nice_load = input
      gov_update_cpu_data(dbs_data)
        list_for_each_entry(policy_dbs, ...)
          for_each_cpu(j, ...)
            j_cdbs->prev_cpu_idle = get_cpu_idle_time(...)  /* write */
            j_cdbs->prev_cpu_nice = kcpustat_field(...)     /* write */
    mutex_unlock(&attr_set->update_lock)

Path B (work queue, holds policy_dbs->update_mutex only):

  dbs_work_handler()
    mutex_lock(&policy_dbs->update_mutex)
    gov->gov_dbs_update(policy)
      dbs_update()
        for_each_cpu(j, policy->cpus)
          idle_time = cur - j_cdbs->prev_cpu_idle           /* read  */
          j_cdbs->prev_cpu_idle = cur_idle_time             /* write */
          idle_time += cur_nice - j_cdbs->prev_cpu_nice     /* read  */
          j_cdbs->prev_cpu_nice = cur_nice                  /* write */
    mutex_unlock(&policy_dbs->update_mutex)

Because attr_set->update_lock and policy_dbs->update_mutex are two
completely independent locks, the two paths are not mutually exclusive.
This results in a data race on cpu_dbs_info.prev_cpu_idle and
cpu_dbs_info.prev_cpu_nice.

Fix this by also acquiring policy_dbs->update_mutex in
gov_update_cpu_data() for each policy, so that path A participates in
the mutual exclusion already established by dbs_work_handler(). Also
update the function comment to accurately reflect the two-level locking
contract.

The root of this race dates back to the original ondemand/conservative
governors. Before commit ee88415caf73 ("[CPUFREQ] Cleanup locking in
conservative governor") and commit 5a75c82828e7 ("[CPUFREQ] Cleanup
locking in ondemand governor"), all accesses to prev_cpu_idle and
prev_cpu_nice in cpufreq_governor_dbs() (path X), store_ignore_nice_load()
(path Y), and do_dbs_timer() (path Z) were serialised by the same
dbs_mutex, so no race existed. Those two commits switched do_dbs_timer()
from dbs_mutex to a per-policy/per-cpu timer_mutex to reduce lock
contention, but left store_ignore_nice_load() still holding dbs_mutex.
As a result, path Y (store) and path Z (do_dbs_timer) no longer shared a
common lock, introducing a potential race on prev_cpu_idle/prev_cpu_nice
between store_ignore_nice_load() and dbs_check_cpu().

Commit 326c86deaed54a ("[CPUFREQ] Remove unneeded locks") then removed
dbs_mutex from store_ignore_nice_load() entirely, introducing an
additional potential race between store_ignore_nice_load() (path Y, now
lockless) and cpufreq_governor_dbs() (path X, still holding dbs_mutex),
while the race between path Y and path Z remained.

Fixes: ee88415caf736b ("[CPUFREQ] Cleanup locking in conservative governor")
Fixes: 5a75c82828e7c0 ("[CPUFREQ] Cleanup locking in ondemand governor")
Fixes: 326c86deaed54a ("[CPUFREQ] Remove unneeded locks")
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq_governor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 86f35e451914..56ef793362db 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -90,7 +90,8 @@ EXPORT_SYMBOL_GPL(sampling_rate_store);
  * (that may be a single policy or a bunch of them if governor tunables are
  * system-wide).
  *
- * Call under the @dbs_data mutex.
+ * Call under the @dbs_data->attr_set.update_lock. The per-policy
+ * update_mutex is acquired and released internally for each policy.
  */
 void gov_update_cpu_data(struct dbs_data *dbs_data)
 {
@@ -99,6 +100,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 	list_for_each_entry(policy_dbs, &dbs_data->attr_set.policy_list, list) {
 		unsigned int j;
 
+		mutex_lock(&policy_dbs->update_mutex);
 		for_each_cpu(j, policy_dbs->policy->cpus) {
 			struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
@@ -107,6 +109,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 			if (dbs_data->ignore_nice_load)
 				j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 		}
+		mutex_unlock(&policy_dbs->update_mutex);
 	}
 }
 EXPORT_SYMBOL_GPL(gov_update_cpu_data);
-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673843C063F
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775733262; cv=none; b=G8RzjC7stupnAB7rP2fCTG4czC25fRw0fsi0eS2FEyw0AjeIBSAsLVlSwVTtIXaNG/XL6no7KVty3jY1BjvRTPwWFP8Y/GpSZdwHx+skJeySqFo/l7PwLuO8pHK37+hpOc4Rxc9mtTtXFT7RCqnssLKDVHupljpWjZ2k3e5jtak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775733262; c=relaxed/simple;
	bh=TW1Sy9d7aaTRUeCb5l+brTMFGvH05AQvCV5aAedgOAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIHy06YDAElgigxtV2IxQsb9cYG89kWzPzpG80hKw5ns7kfJVT3Y8HS3arit2LMr2IfDpo37bBrmPtinqWuzs5fzOG6uEJHqSg6WzWlCLrerkoOBdcyMjblcVfIXqjdVKbYvLhozgnF6OLC88eR3f3E0PTTT79V10S8ngOt2AkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PAOlnGG2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6KArZMy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PAOlnGG2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6KArZMy"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6395LxWi4107652
	for <linux-pm@vger.kernel.org>; Thu, 9 Apr 2026 11:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6e0+tvJi2nx
	fM5V/oSmNLL+K1b0L8fyniqwMGsM3+t4=; b=PAOlnGG229PWu2kQVt43Qh3Qd0h
	vCBPgMcCLzP+/uNkA/WIAGZT19v/dK3a8fzYuAKnJvjCReoAHJ+VSic3ZTpOwaiW
	dSBRcDKQhqrbAuG54RMziiIOwpWmtPyA7zaDGTIZtYVYIiRMuRxbmrRc83DfO+JT
	Opz3I07Yf2KOD0uFh+ld4JiNdCeaTEk/irURGkn5tTH8gJi9eqmu0z/K+mRPwEjW
	dziO+eTjnNehR5e4SvMyJEUzCiJUsGdjOFJ4hH+9BEXBG1denIa1Em+rhzJmZq0E
	v7g3e/nl2/hGVEa1QFLCWMeFEGG49JtI0nyw2/y+w/PCBkkXqxDyNbCFCIQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddxhajjd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 11:14:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso1061610a91.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775733257; x=1776338057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e0+tvJi2nxfM5V/oSmNLL+K1b0L8fyniqwMGsM3+t4=;
        b=d6KArZMyRW2WHGc6PfRu6dOMVxr1Pxc6uwb1wS/suQZYmK7e8MLAHdojSKQuJJvrxe
         P3YNaQ310SNQFZdsd9R2pqP85ykW2vDXwEkmVOsDB23etnzb6r1hKJZkuCLVRYZZ90LK
         abqgoqQBbd2zxfaLlrR4gtoPNK2uiC5b3smLMddwWxvouNETwVwN6ZSS/onK+Yhe6s2y
         IAwDl+5M1S9xRZUyBhjK6spBcnQaOLBkKHKt+B+RwYzLGhj8SeP1q87cYyJHRbpMR45I
         Efv09sALd6vXqQBGEUeAHQV6zznLOjl4VY5Wo9XEFhsj7ZnllmUX/3LB8zYPxhbs/ANE
         M5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775733257; x=1776338057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6e0+tvJi2nxfM5V/oSmNLL+K1b0L8fyniqwMGsM3+t4=;
        b=LT9kEfV/PNcdfvUQm2Fi+zT39dlW41avp8l1bSmfGc4gUj9tdeOvoQ0lbInjv5761O
         8794YXlzMKUSmoOG853KXg/pCitLz4yDtswrPY1lTvIzNEThSAcYagk7GGTp8hF0r+IH
         SfgWVqe9Q1MF9MONMLnjZDUQ68juIw+ZVm15MmpWyDVr8kTeLkIrbJSOi8oV2VfvI3Mt
         8Plgmsd5+F1/YcmInpkird3iloTKq/B3V/MmfDPOAmHr5k9aTy5HFwu5kYzw0PwqT85H
         Jl0i+5R4fppeTTFTiJPYUhV4Zf/+kLfzUYslWBDziVt8sAfqekgTPQJ+lRUuNA82zFa0
         ZOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+EiBcFO2D907bD6Lve4rjG08g/ZDdxPd1Rrb1d7CfRP3PIoXxSc3ArcqI5mOepzt4PQjWvFlkpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yygg/fVN0SFHuC/hy/+A59g1lpXqGgf29ei4JG3QBW8D8Dz1SrO
	vUdpPitIMGu2JxaXb/QKp+p3MOB1DyV8AzZJ4rcNvpYECbjGaEQiNDpyFCxG6djoGgWQpJoZEyG
	9N4x+Jbyl40msSvNARr5Z04THIaC+bXz3o0k+8HG0GuJv26M92QWrLpjG14xKPA==
X-Gm-Gg: AeBDiev0MtKrcwJtSXq4LntDylSqOxrxMsER8mem/QiLMw3QquNuIXfDgLyMcNOhyrw
	cYTlLchptA3BBT8y6SrsSFFhIMKLYBwo+8FoaHViLK/KkwA6mVNo7y9flkQIRV7XD9WHO/FLeNC
	vlSOTzQ3pX41o/O7Y/J0ljPGZA82dIZdXncBRMw1JE0uIH+47Z5vBOj1gQIWcGRlWwfWTi1bOov
	QnQ7+3ynx0Ru3lTC+PlFc9Pz1HhowXd1GI5Ju0RmZccgbc1HP1bZ/RCgaOSAkM+uBhO4WBvvX3h
	fO+uuBWcNcO/4rHdRlWXZZCqdghkpeDCXYZRwmyR0Ai+3HvhDlTz3Kdv0DqI597tjG2qPbFyKNH
	hvhyGoJQWTmae4dWGIg4aD7qZafjvDH5ME1Wyb8OqXGzgw+8ZaH3Ggj3/PexZ2YSK9lcNdDnLm/
	pxTOcoO53GJeaK
X-Received: by 2002:a05:6a20:6a0d:b0:398:b16f:703e with SMTP id adf61e73a8af0-39fc832eca9mr4081507637.40.1775733256865;
        Thu, 09 Apr 2026 04:14:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0d:b0:398:b16f:703e with SMTP id adf61e73a8af0-39fc832eca9mr4081461637.40.1775733256328;
        Thu, 09 Apr 2026 04:14:16 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm21622903a12.26.2026.04.09.04.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:14:15 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: venkatesh.pallipadi@intel.com, davej@redhat.com, trenn@suse.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v2 1/2] cpufreq: governor: Fix race between sysfs store and dbs work handler
Date: Thu,  9 Apr 2026 19:14:06 +0800
Message-ID: <20260409111407.9775-2-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409111407.9775-1-zhongqiu.han@oss.qualcomm.com>
References: <20260409111407.9775-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W-7XGEYFITtjz5rgGdb_qU6nkisqB9m4
X-Proofpoint-GUID: W-7XGEYFITtjz5rgGdb_qU6nkisqB9m4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5NiBTYWx0ZWRfX1l5kht7aQpzQ
 07xwacYgyIYouArtJG68fetpl1CNiw0DkbOItA2DyqViPnoI6bAxWD1q/5AoWqbDc91N/wPneNu
 jPvRU6NPSVbXZbcAf4vw3nzeqsBy5X9kiimPlnCnMgvMvjd733ds8vcK6GE+6+OxEYSFTmJG3UZ
 Gfx1Ls+zIO7xAHkDxMKxuuNkGsicdL4FKMrKp22WoETGiq4dN94aK4/NOXdWUkBnFRLdH/ChkXP
 167xYDCDQexpuGK3wmZT+tj8qk4GHG2Os0E7WlralQI3nCC1eBQmVWzh/zaLkJKpYlLzX5Y+qbp
 Cqtna6dN6X7PzqFmMGj0ZgTmVEiDk3ebFj5Uzq7GtD+M2PQ3s317hB/lUyd4JNZA4NIciNPnR+U
 eucSSrB/u01Gb0U/bonAa/P9R6aeoa9VYtqA6jCHfXdBb6E0onUOjPA6qz0kW7GesLd+0S1qctt
 rrgRsUkyu+gchS2maEA==
X-Authority-Analysis: v=2.4 cv=BefoFLt2 c=1 sm=1 tr=0 ts=69d78a0a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=EhOh3lww-dzmNHTOE2sA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090096

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

Additionally, cpufreq_dbs_governor_start() initializes prev_cpu_idle
and prev_cpu_nice without holding policy_dbs->update_mutex. After
cpufreq_dbs_governor_init() returns, the new policy is already visible
in attr_set->policy_list and sysfs attributes are accessible. A
concurrent sysfs write can therefore call gov_update_cpu_data() and
race with the initialization loop on the same u64 fields. Fix this by
holding policy_dbs->update_mutex around the initialization loop in
cpufreq_dbs_governor_start() as well.

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
 drivers/cpufreq/cpufreq_governor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 86f35e451914..c0d419c95609 100644
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
@@ -529,6 +532,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 	ignore_nice = dbs_data->ignore_nice_load;
 	io_busy = dbs_data->io_is_busy;
 
+	mutex_lock(&policy_dbs->update_mutex);
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
@@ -541,6 +545,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 	}
+	mutex_unlock(&policy_dbs->update_mutex);
 
 	gov->start(policy);
 
-- 
2.43.0


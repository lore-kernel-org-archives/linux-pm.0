Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265A37CD4B
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776605225; cv=none; b=YZe8knMHIsv6CXlZgtQKa/jztJoJcdpkzGZTDqXqVrAaj3GZcmdbi4fSqyqiyzxqPR1LjOUWGrrigELFB9VlATnCmVH2SY56PMR9V4ttBYULmd8AIZyB2BCbp5TkTnmDgYITT/jYAqBfBCQ9pazNo85shgNtI3gcADlvQBLHx7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776605225; c=relaxed/simple;
	bh=waVur1s1NbhGAVdXbYgap1Gr/DCzt5p7sIh5A4kXf1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wrh/xyFv6xxS16a4zaS7TokTDboVc5cUYr7I6JhtKJt2Lf6yeCvAyAd9f9XzFjxEvcM8EZFmfj5Eqe89QJsodX2/okemJ8Tb2H55cPdZVBogIA0YnCKnYBIbnyo65R5BUY9Na0O6XSglMw1ay3YSLREt9LDDYmtTf9szJP11C2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gcqy66JI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ritl+uYK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gcqy66JI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ritl+uYK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J5piYR1373867
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=U/luz5L2c9u
	5OjLtskUToxTHzZy4xt3r13Mne57avzs=; b=Gcqy66JIO+iH8qeVT/NoT6hls2P
	CW369jyFfHBkH+/HfWik701/L6jHHYGdgsTAjSk8JlLdxI/iAh5unlkYqRf9c5s4
	+vg9pKT6j2a0KGdbSNENg7XESxOe7S/bGEUMWyRbS2F1/vORYqiBwvlRsR0G9ir0
	1hoMYhzsZGQ+7FPc2GrL0DKy+fDGt3Fs9SUlyB4lXt8M6nX803SrJNtwAy0X85iI
	7v2jf+/ek9XS9PHZW2gNJfYdqVjiH2dqViW41Bn/U3HLAYXk/P7T8m+cAaREmkTD
	b5KDC9/JYQCScbwjOACTcpue4SDOjQjMYoGFeOHcPTtw1cD/oK4cYMY+lKw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm388jg03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35641c14663so2480048a91.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776605223; x=1777210023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/luz5L2c9u5OjLtskUToxTHzZy4xt3r13Mne57avzs=;
        b=Ritl+uYKnJlntR7Uhhk7wWea5jQNzVHeOHwr7o+oLs5Wfi9iC2Wf6lv94eiTXNHxao
         D+0GvgHPFZxxVBPpdU1b9M13KnKWFx2cFVDoCLIr8AzAB35mzptME1IqV7yGjHAq+oT6
         ycK1D+uJH2Pt5iuCz3t1U3hdJLVc+T0Kcomf4GqyK7bqdRzRua1dCohawiiqzbqszkDK
         n2tQwBarY+H2UfkC7ZIH9Z6ZRMkVImVzb8cSK7uRr8fFObSyBAXguA0x1MNWZ7VMofS9
         p5P14yJfzueTyFu6dKk06cXCkNyyorvC0wTadyaR3I25h+uYWHF3Mo/fFyE+lMaJy3Ha
         H0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776605223; x=1777210023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/luz5L2c9u5OjLtskUToxTHzZy4xt3r13Mne57avzs=;
        b=J9BGrGzid80MrS8nKe5GrnXoi6ojOkouTCsyWT12jBrYMX32KUaPh6rcula6cDv1Ax
         57CwkzxL5wEWNwvLvt+IyXVY7XmN5mRQmwtU8+2MAe9cMpatrfuo5CWgwiikvKnGV004
         WPGzA+zLCzClU+oAL9FyZcLPXnN4Ma6i3AyjdbFvKTGpQOTiloTOVI9XpFMaCkWIz/PD
         zQrbPJ3f0NvbQ3wn2ThaPIj69Wb7VeemzjVQads3GQ3YqC0SknTZ3EslGWAqSrB8p8j7
         rzWv/EiuTQU2oFdkJmmiQnrYel+zywIUfevSyKvGLO2zACQ7qULboqKr9rNSD4fzGd44
         5wjw==
X-Forwarded-Encrypted: i=1; AFNElJ9bodVW7P1BuFX9d/ljg0b52FDgQndruaqTWzviK9WBO9kdfOGdY4ZQ1N/W9ddqs0joC4wFJPwIeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlPjaY1HA30q1fbXF9xzkGxepuUEYsdUnEDtuPXBZq/JICEsj
	3HZ97fCtl1OOh+MBv1XSjwIS90e41svsG2M9FrK0KZ54qC8X8Y6Rghqg1Bst5bg7thjSygcitTe
	ykCjisZ02CTxP7HtQhEdCv9m6/p3KWUxWNL00mfldJJ/wNO35iAUD5/SxuYSd6w==
X-Gm-Gg: AeBDiesQMbkjlKwcskqeBJAjIY5CM583BbE+61O+CDhcAYCYRM6jpzBxbL4RdTORnfJ
	O53I/MQoHBUTc/Q9wMGF06BU1lyMlDpWseWZzV1molDctdApJjYcNih5CJUW7zID/GQrqZC5M3s
	Sq4JE6F5NXs0zodRSwXEnJtfJc1cwTD7BiK3g1uv5ao4sBwiP8NZX066hYtxsD6KRMHcX3E+CyU
	WcJ5spZcae98L3MRJXKnBbHilABh76gNDZHGX9a2BzpsYvz4ch1YzGGYFB78u1AaWxXOjBY7RcF
	yzL27dabQ3U2WpAMweo0IhL9vVi0LJx7TluS6TmSHjMBSahkonmZnoy0ICwxrr5EAoM6ulkyxW2
	W21Kdlk6xgqgzUBnyZ/S8n2BlZctbgENQfLl5MR9npKRAaPHF9DRrdCnpXVUZB3btbRZVds7oZ/
	OXYwf81BUt1Ah9zzn8+aKnjgA=
X-Received: by 2002:a17:90b:5185:b0:35c:29ba:bf92 with SMTP id 98e67ed59e1d1-361403d5988mr10806656a91.5.1776605222428;
        Sun, 19 Apr 2026 06:27:02 -0700 (PDT)
X-Received: by 2002:a17:90b:5185:b0:35c:29ba:bf92 with SMTP id 98e67ed59e1d1-361403d5988mr10806626a91.5.1776605221921;
        Sun, 19 Apr 2026 06:27:01 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbbb4f9sm4010342a91.6.2026.04.19.06.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 06:27:01 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: venkatesh.pallipadi@intel.com, davej@redhat.com, trenn@suse.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v3 1/2] cpufreq: governor: Fix data races on per-CPU idle/nice baselines
Date: Sun, 19 Apr 2026 21:26:53 +0800
Message-ID: <20260419132655.3800673-2-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419132655.3800673-1-zhongqiu.han@oss.qualcomm.com>
References: <20260419132655.3800673-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GthyPE1C c=1 sm=1 tr=0 ts=69e4d827 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EhOh3lww-dzmNHTOE2sA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 5te4H2wxYve2Tbtw224QoaF-CIEdMQLe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE0MyBTYWx0ZWRfX0rp8n8HJY4e8
 YokDE/KaPSuy608MN6jzZ9UutofNpC/1cgqz7toNu6NIn7RXdGl5ABCHIGl3sE7r17Eb6aY2F3o
 xSye59P/Nxp80gWdAgJXPjcv6oBqYm3HYymnYeimVbx4x3BrWCeX2/Ra9FU8f7IjME3x+o5AXX8
 Dn6yeT99Lzd9gbRDJYFNLybVD9pXcQohUjAxQhHPwq1V+++0Hxe6fsY0X/wXohxGCuT5XHW6g8M
 YzDpgLUL2H3le7E57paAZEPI4CAHz0f6IOnNxKUdwHhf9mObShjvS3hvfIP6PvtDtn48wu8Kkpd
 /qN1ReoMbzpuyW7XWN6IGId8PydODC872Rm6w4wdNbtbXwKug98r2JMrVoB6BisKrXtKxd5MKDr
 lwUr9MxAepBckslueEdKNhZ/nbs4fOQ9Knufdu49GbRC7mXCebyoZ2jps18URusGgHne3Ye9kXo
 MGPGzvIe+Ae7y2z3MbQ==
X-Proofpoint-ORIG-GUID: 5te4H2wxYve2Tbtw224QoaF-CIEdMQLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_04,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190143

gov_update_cpu_data() resets per-CPU prev_cpu_idle for every CPU in the
governed domain, and conditionally resets prev_cpu_nice when
ignore_nice_load is set. It is called from sysfs store callbacks
(e.g. ignore_nice_load_store) which run under attr_set->update_lock,
held by the surrounding governor_store().

Concurrently, dbs_work_handler() calls gov->gov_dbs_update() (which calls
dbs_update()) under policy_dbs->update_mutex. dbs_update() both reads and
writes the same prev_cpu_idle / prev_cpu_nice fields. The potential race
path is:

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
using io_busy read from dbs_data->io_is_busy without holding
policy_dbs->update_mutex.  A concurrent io_is_busy_store() can update
io_is_busy and call gov_update_cpu_data(), which writes prev_cpu_idle
with the new value under the mutex.  cpufreq_dbs_governor_start() then
overwrites prev_cpu_idle with the stale io_busy value, leaving the
baseline inconsistent with the tunable.  Fix this by reading io_busy
inside the mutex.

The root of this race dates back to the original ondemand/conservative
governors. Before commit ee88415caf73 ("[CPUFREQ] Cleanup locking in
conservative governor") and commit 5a75c82828e7 ("[CPUFREQ] Cleanup
locking in ondemand governor"), all accesses to prev_cpu_idle and
prev_cpu_nice in cpufreq_governor_dbs() (path X), store_ignore_nice_load()
/io_is_busy_store() (path Y), and do_dbs_timer() (path Z) were serialised
by the same dbs_mutex, so no race existed. Those two commits switched
do_dbs_timer() from dbs_mutex to a per-policy/per-cpu timer_mutex to
reduce lock contention, but left path Y (store) still holding dbs_mutex.
As a result, path Y (store) and path Z (do_dbs_timer) no longer shared a
common lock, introducing a potential race on prev_cpu_idle/prev_cpu_nice
between path Y (store) and dbs_check_cpu().

Commit 326c86deaed54a ("[CPUFREQ] Remove unneeded locks") then removed
dbs_mutex from store_ignore_nice_load()/io_is_busy_store() entirely,
introducing an additional potential race between path Y (now lockless)
and cpufreq_governor_dbs() (path X, still holding dbs_mutex), while the
race between path Y and path Z remained.

Fixes: ee88415caf736b ("[CPUFREQ] Cleanup locking in conservative governor")
Fixes: 5a75c82828e7c0 ("[CPUFREQ] Cleanup locking in ondemand governor")
Fixes: 326c86deaed54a ("[CPUFREQ] Remove unneeded locks")
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq_governor.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 86f35e451914..fc6f705c5a9c 100644
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
@@ -527,8 +530,9 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 
 	sampling_rate = dbs_data->sampling_rate;
 	ignore_nice = dbs_data->ignore_nice_load;
-	io_busy = dbs_data->io_is_busy;
 
+	mutex_lock(&policy_dbs->update_mutex);
+	io_busy = dbs_data->io_is_busy;
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


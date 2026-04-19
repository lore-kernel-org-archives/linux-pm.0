Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAE37C92C
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776605229; cv=none; b=Lb1hUTIbk1vnvM7ncp7FUMflZvVquQuFnEWAiWxi/qnpePKSahGhk/lzQj6cKMTtC0nvh7qG8Y82qOGn0IDDOsZKAyS8pohdBjdnaUX2qj0UYmjnxJt8h1Z6S8vwzMQVoKAK1h7xSf7x46XdlUsv9Dq5cqD242A6WI22Mr+5fl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776605229; c=relaxed/simple;
	bh=SqYYwagzKgUXaXdUUT/mLpbwszzQTSsSb/97J17FTjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbiftjfVSSiNLD+HXWhH64/IVc3q5GDTJokIAE+rjidFRAfKQSn8YWUcOxmRTHr5fQIYwIImMbFby5KhBcb1Bpi32K21xPjFzUM87dxztwVrUw45Cxz4VYtMliJPjsbUqgZQKtKg0+vdm9aP+Bq5COI1ia4iA40oqaML2OqbkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9QbBgRr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hmK3kouW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9QbBgRr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmK3kouW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63IKfu5L1291838
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jlG38YObrOd
	rmclhtB1ZdTwbzfWyw6aRM/BZaBhSwgg=; b=l9QbBgRrPvt4/zhBfsYtpP3g4pI
	yyVbcu9mBvoLGPUFyff9c0hgtKMSktrTfkAQRs2Ru+noMlTyIRfTuUQUtNKcWdn2
	4MWJXTMBoJHNaYxcedKZwwg5dAu50fxXWqSflDb4kNqnnLkCdy9/JQjm4CwY9eaI
	YZsFay5pHiw/b0LN+ueqfI4jPMNErm5zD9F4Jp5l99DIk6gvNQoRi1yFzq1A+xtJ
	x0c3xGig7IAgjB0GFx1VvQfiPmMqmBRL88+qK4GCItempovFt/DYUCYbuvmBLRq7
	Ix2k9z4UUaiVV932kcxSzCy32hbOBfe5taGkfD2+M6HlzyWmqrxHnILnDGQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkyanjv1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24e9b4d82so27476195ad.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776605225; x=1777210025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlG38YObrOdrmclhtB1ZdTwbzfWyw6aRM/BZaBhSwgg=;
        b=hmK3kouWui0nu7teHj50NcJRwX50NISb05/Kljs03r7wdSTVUxqz0EEM7acUlpXJ0/
         wCjCh2ew/IdTDn9S9KTgLOTxtON6+6xtrqp+ImuNxhH6tZqS/7M5XRi4uxwOK4rk5k/s
         pZv9Wb5mSAT0Z7IcTM4wgYA6V6x4xEtmcSHHyGX51ms2ZbvtRhFFDbk4arUUDjPoVSF+
         gnjEsYHNQExGjcGpSRcaxBomqIfi2dbBboCEqBi3G4dCajEz2Ol8CdzPh9lPEqelTGez
         WOdtcHtbjUeDu9keTIYDnTu2V8ZTirwliOvIiZjB4Xl7fRsbwpN3BIYO+VFyKQo8hJqx
         Y4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776605225; x=1777210025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlG38YObrOdrmclhtB1ZdTwbzfWyw6aRM/BZaBhSwgg=;
        b=LG1CvPxPrjW11oqIdK4oEMdUZl5E50yggAjEPfvxgwu0lACZlH7bC0SBMeIZAC/rBa
         hM4pKnUl2BTxM0As9+1DHjlLE4gjvQMTEAHUXDTlRq4khDuUMZ/5TeTQNJCa9cu7aQ7z
         tYxq9ysIFR9XgWMGBSgvfqJm9OPgdvMZxd0rB8o1FkdkReMlfX7otvPh7znZAbo3Oaq+
         QGmQhGYUew6oamfRT4DZ6G17XT1UlThA2KHV45EagvDFl5j2Gjie7mJBWvUbgRRKVsBJ
         uvYCaXofCDBCKNgHBqElDUSuygNakDJiuQ6PDqRmcZQUpBEBs8HOl1mYL7jedHYOSvH7
         GI6w==
X-Forwarded-Encrypted: i=1; AFNElJ9L81Uu0WS5CtANXBbcn9IRsLdQy43Ho7lHq6UwmpXN9DxoqKHdXuQLOys/C8AC/SLgViQ5tdyDEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHoj05R/mC6GUXvLZrpoxZCHUvHMloyiua4WChyubD20DI+a/h
	KEZCbpZQq2g2hCNeJBxn8CgAd4SUpGy1A3rCdXIR6W1znrpOOJS5zJCEYro2ZIEERfs5YE0a+Cc
	9rfqoyc58AMfxlANeJPTUCf+QmfsdGYq4BFfnmnYhr5Yr8mmmQK4bjl6iuRFU5g==
X-Gm-Gg: AeBDietojbXmquBsCOWINqNSLg37BDphArphG3Ni+PfW97S08n+3sYEnfVRzIOKTu3Y
	EHmbvYk98SmCjvFw86RAvn9DBeKZd7ySLzrsNtRJb9sNIXCuW10ikoqoOe3cuV7aO3DSZ22OW3w
	BV6WHt4v5BTurXMCT3oKeoOo78Qvy7UsJoT6CHSqc0wmbQj1oPw8KZ2QVks1Ah1lLco3rDpwoiv
	0Pa0+kBY0wjLTwKrgqVkO4X5q+cWn4r67UZLIVLH/3Oag7cz5iGa9cU/IGOQj9t9glHyBOnxHwr
	oR8G8QSLwr02AcGoi1zI7nc1NxIaUFKOFUkV0WW9L59r+aOQCwILwZSUwEQf5ye/bjx/QEhAh2b
	mFN7L5hAiuiWnyfJUOdq/gI0Xvq/9/TZqGYX5f9Vny8dGNxx+3SC3o0g+KQg/QbvosxnMSM5OEc
	NiiS/u7bM8w9YuJNEGqWa+HIs=
X-Received: by 2002:a17:90b:4b83:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-361402ebfebmr8081201a91.11.1776605225185;
        Sun, 19 Apr 2026 06:27:05 -0700 (PDT)
X-Received: by 2002:a17:90b:4b83:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-361402ebfebmr8081174a91.11.1776605224617;
        Sun, 19 Apr 2026 06:27:04 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbbb4f9sm4010342a91.6.2026.04.19.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 06:27:04 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: venkatesh.pallipadi@intel.com, davej@redhat.com, trenn@suse.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v3 2/2] cpufreq: governor: Fix stale prev_cpu_nice spike when enabling ignore_nice_load
Date: Sun, 19 Apr 2026 21:26:54 +0800
Message-ID: <20260419132655.3800673-3-zhongqiu.han@oss.qualcomm.com>
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
X-Proofpoint-GUID: B2VXeMrE3SG7XxSTl9Sax4HkCXAM4vg2
X-Proofpoint-ORIG-GUID: B2VXeMrE3SG7XxSTl9Sax4HkCXAM4vg2
X-Authority-Analysis: v=2.4 cv=SNFykuvH c=1 sm=1 tr=0 ts=69e4d82a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=RougvbfpsDdIUb9cXJ0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE0MyBTYWx0ZWRfX+34hDkGFfGoH
 1YWAkuilrmwnyuIZJ3+truiIY3fCJV7XgzMOqom5ABT4vFVDzKlLZcdZWsCvQkARhoDqM3FdU8c
 VbvzRThcSlP4+OsFHMVHRSEpr56YN/52I7s9oGUKE5NYEBpFbYZtj7l4XKCb2SvC/GGnCSEi6G5
 Ss1mkGUiHdgz20ciE7Xp+gQkYg4ztmrJgD0IMbGXMPMVe5s8B94HrRtiCIyd11Q/QyGrMPvqqwX
 pbl2Usi4406Wt3JwIA2vrI5VT5LplhtIo5w9e8HcZGvyExSkLk9M2D0H5hYANz0oYosQ9phcnaT
 dB1BFKz+gFaP4Ok69czukEQh3AeuyLHroaGqzrAmmoHTrE6Ew5WN0sqFU8U1Cqg4p1xOxw+bZFp
 0QOXr26W/c7+ppPO8anjfJnJ+h4khY7hoghJTUWpOYFOszJD1VNJfGFG4Tomkhgdim7nDjJIBPQ
 Tx+LTnBcGolrr3dmsqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_04,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190143

When ignore_nice_load is toggled from 0 to 1 via sysfs, dbs_update() may
run concurrently and observe the new tunable value while prev_cpu_nice
still holds a stale baseline, producing a spurious massive idle_time that
results in an incorrect CPU load value.

The race can be illustrated with two concurrent paths:

Path A (sysfs write, holds attr_set->update_lock):

governor_store()
  mutex_lock(&attr_set->update_lock)
  ignore_nice_load_store()
    dbs_data->ignore_nice_load = 1              /* (A1) */
    gov_update_cpu_data(dbs_data)
      mutex_lock(&policy_dbs->update_mutex)     /* (A2) */
        j_cdbs->prev_cpu_nice = kcpustat_field(...)
      mutex_unlock(&policy_dbs->update_mutex)
  mutex_unlock(&attr_set->update_lock)

Path B (work queue, wins the race between A1 and A2):

dbs_work_handler()
  mutex_lock(&policy_dbs->update_mutex)         /* acquired before A2 */
  dbs_update()
    ignore_nice = dbs_data->ignore_nice_load    /* sees new value: 1 */
    cur_nice = kcpustat_field(...)
    idle_time += div_u64(cur_nice - j_cdbs->prev_cpu_nice, ..) /* stale */
    j_cdbs->prev_cpu_nice = cur_nice
  mutex_unlock(&policy_dbs->update_mutex)

Fix this by unconditionally sampling cur_nice and advancing prev_cpu_nice
in dbs_update() on every call, regardless of ignore_nice. With
prev_cpu_nice always reflecting the most recent sample, enabling
ignore_nice_load can never produce a stale-baseline spike: the delta will
always be the nice time accumulated in the last sampling interval, not
since boot. The additional kcpustat_field() call per CPU per sample is
negligible given that the sampling path already reads idle and load
accounting.

To keep prev_cpu_nice handling consistent with the always-tracking
semantics introduced above:

  - gov_update_cpu_data() unconditionally resets prev_cpu_nice alongside
    prev_cpu_idle, so both baselines share the same timestamp when
    io_is_busy changes.  This prevents an interval mismatch between
    idle_time and nice_delta on the next dbs_update() when
    ignore_nice_load is enabled.
  - cpufreq_dbs_governor_start() unconditionally initializes prev_cpu_nice
    so the baseline is always valid from the first dbs_update() call;
    remove the ignore_nice guard and the now-unused ignore_nice variable.

Fixes: ee88415caf736b ("[CPUFREQ] Cleanup locking in conservative governor")
Fixes: 5a75c82828e7c0 ("[CPUFREQ] Cleanup locking in ondemand governor")
Fixes: 326c86deaed54a ("[CPUFREQ] Remove unneeded locks")
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq_governor.c | 33 +++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index fc6f705c5a9c..8a85bd32defe 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -92,6 +92,12 @@ EXPORT_SYMBOL_GPL(sampling_rate_store);
  *
  * Call under the @dbs_data->attr_set.update_lock. The per-policy
  * update_mutex is acquired and released internally for each policy.
+ *
+ * Note: prev_cpu_nice is reset here unconditionally alongside prev_cpu_idle.
+ * When io_is_busy changes, both baselines must be advanced to the same
+ * timestamp so that the next dbs_update() computes idle_time and nice_delta
+ * over the same interval, preventing an artificially inflated idle_time when
+ * ignore_nice_load is enabled.
  */
 void gov_update_cpu_data(struct dbs_data *dbs_data)
 {
@@ -106,8 +112,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 
 			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time,
 								  dbs_data->io_is_busy);
-			if (dbs_data->ignore_nice_load)
-				j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+			j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 		}
 		mutex_unlock(&policy_dbs->update_mutex);
 	}
@@ -121,6 +126,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 	unsigned int ignore_nice = dbs_data->ignore_nice_load;
 	unsigned int max_load = 0, idle_periods = UINT_MAX;
 	unsigned int sampling_rate, io_busy, j;
+	u64 cur_nice;
 
 	/*
 	 * Sometimes governors may use an additional multiplier to increase
@@ -167,12 +173,18 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
-		if (ignore_nice) {
-			u64 cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
-
+		/*
+		 * Always sample cur_nice and advance prev_cpu_nice, regardless
+		 * of ignore_nice.  This keeps prev_cpu_nice current so that
+		 * enabling ignore_nice_load via sysfs never produces a
+		 * stale-baseline spike (the delta will be at most one sampling
+		 * interval of accumulated nice time, not since boot).
+		 */
+		cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+		if (ignore_nice)
 			idle_time += div_u64(cur_nice - j_cdbs->prev_cpu_nice, NSEC_PER_USEC);
-			j_cdbs->prev_cpu_nice = cur_nice;
-		}
+
+		j_cdbs->prev_cpu_nice = cur_nice;
 
 		if (unlikely(!time_elapsed)) {
 			/*
@@ -519,7 +531,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
-	unsigned int sampling_rate, ignore_nice, j;
+	unsigned int sampling_rate, j;
 	unsigned int io_busy;
 
 	if (!policy->cur)
@@ -529,7 +541,6 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 	policy_dbs->rate_mult = 1;
 
 	sampling_rate = dbs_data->sampling_rate;
-	ignore_nice = dbs_data->ignore_nice_load;
 
 	mutex_lock(&policy_dbs->update_mutex);
 	io_busy = dbs_data->io_is_busy;
@@ -541,9 +552,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 		 * Make the first invocation of dbs_update() compute the load.
 		 */
 		j_cdbs->prev_load = 0;
-
-		if (ignore_nice)
-			j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+		j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 	}
 	mutex_unlock(&policy_dbs->update_mutex);
 
-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE693BFE3C
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775733264; cv=none; b=V36KZntNFgLbmE1suJmKZY79O7NHXuv61KVKAjYQH+W2bUV8qRAvCmFoiQI8wDiyVH8Lvy+tgE40Vppir43IVBSuczwSHPFlkuTewm37ay21r0EwagSbsJVAkyXJ53LzodQKMSrzFzftBqocaKUsQo5YQxRIMPC02eT6RPhXJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775733264; c=relaxed/simple;
	bh=dnHxWH8aSgldICw7ghKnPiWDnjf+yMG3w/yLa+v9y4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0/Vkfkt8CmbY1kDUVmw1coYs78+5FvduQEfXII0+db4rgFr62dX6z+2UlrHKedA+8yA8Izmgb51ZpaNy83pqh2MJ5bK9fTtTK4OMk83OZIX3C8pK07ygG+JoW1ReIRO8pgXg1e/KWMaEm9eVjRJk2hjUFLYamxLEKWIggwoxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p6I+JbKy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LyUfX3Ws; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p6I+JbKy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LyUfX3Ws"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63981dIG1072656
	for <linux-pm@vger.kernel.org>; Thu, 9 Apr 2026 11:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jOXTY5T+IJV
	2dmKbM1/lXW6PkSVMrnV9tU/Yphv++DI=; b=p6I+JbKyBM1P6VmvpKtTS3sh+Fa
	O93PoiyUbcppIHolsxaEwPWM4hOxvJy00l0fHv1fh4dwMu7pcrEbyP24KxLjLms5
	MnqtRFWZsO7JPoUjke0buxo9HmnaNV25/Z2RY2AOi3XKXRyXruBTt/Myw1awrQIh
	DS8GDfT4Et3ZucBaKlvWUTLw8e/HA/Q8bKdWtlmMWQ8kbyQUTg0+TqtdYl1V/Toi
	Nvb1rJgEyKDrQyIQdR7rxjf1wW9+25jCmxFzIwx9UIlO16grxPOHMfhke8130M+/
	TU5BYTIN7VMvBeiRBQGv2X49OgsP90BJ5C1aGjP6Aa+K9Bnbvq7JLItU4tQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtb3bqe4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 11:14:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso661053a12.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 04:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775733260; x=1776338060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOXTY5T+IJV2dmKbM1/lXW6PkSVMrnV9tU/Yphv++DI=;
        b=LyUfX3WsimdldMAmPn7p05heKmTEsMfjC+58Hx/9bmoRze8GFLbXN7cfAFHSt8SQey
         SGtDEOF/Cel3JpzxCMHRlMVJlR74bxKb+MszxJwmD78LgahZQMCA/KYYfvowXbpLbnix
         rD29b9EzGn4+GwtRFAVNl92TZdB1pS2Qe1q+zZYAQxZNIqeVkAu4y5rEuNBGjlBGuMVe
         uB0KHQ2oZYhjcXLORinbwSbxiJ2KxEhavxHLvQFZ4FUzvKJ1CtjJkPfc7lkFGyPC+O5Y
         E4p/wjqu8fuRSijhuOrXop2VO8H2ZivfPJjv6G6w2dAX41792ou6ll/eqkrpQxwa/JBf
         eiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775733260; x=1776338060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOXTY5T+IJV2dmKbM1/lXW6PkSVMrnV9tU/Yphv++DI=;
        b=eS6NESDav6lR7JxPM3uIHMBoSgR0X0i7NN0K2pzEm6TpRGQjuLMbGf4AqCuHEAr/O5
         r6wp4RI+pyj7ZJFuwIUKvInra+ALekLY6rElx3hlncu42/STNT3FHavIaMLvsebMiAB7
         P2S3KgZUeBWzI7g4/FNkZIWd0ILw2bt8Wiivhd8ncUJWyXDd4AZe9KYOhzGKIHBlRq9U
         2VCP7fCpAzkeb667FGBsWi9xgw2bB8XloNulXsT/z3lQ9hhsv9lKu4Okk46GXZyj0fVQ
         UB89HsGW6ZKjNeGeBMaGK8qGtTMPTzNtuTTE1MKTSCW1aueoNQmTVWER3AfgkrLNh/Wl
         s1xA==
X-Forwarded-Encrypted: i=1; AJvYcCXg3zjZZLgxtiCPZr7ZerYq+7nLTZ85TqCY0mdKx18Md4u/N82M8eUwkeWSaiadyGNkG4DJ5IRLdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBjIReS7Amx1ZsdF99pa99FKi0WSZskNLLl8vy8Esi10xY6zh
	Q4tFF8GM8lKs8iKYNX8fYcGZ3iZNqp3izEJtkrWdZCnFcoHm4qqyXPhW7mYqCYg2pQuZlCccOMp
	HTGFP5ZmQEsQiAgk4vLeJQK8Dpul6ppPpwWAxaZq35xhKR0HF8EcFKmEreX5kfg==
X-Gm-Gg: AeBDieu7CROoX/qPVfjhGlQDxTcpW5SjW42vjHLEuLCYgBW4AtRboPDUd5CjZksSC3t
	96zHzM/LFZzWBijtiNPe3MugzZnRrL+NB8QnCnddm75wx1sMstXpelvrqh9N+F/3Up6CWqzWDkL
	4QGZe1EYgdn/SHrxTVvrtPTIDCtuPOMse81KprI9Vy41rZFvfgwIU/fHht9YjT7wpmKuqp1gYY7
	S9shQK2EABgPdubmK87uDIIw9RqOLioOtpEHWucq0aJT4XygNU35hoZqV+eWbisAB4kaz2jAKRh
	C+LE8Ep3RA2eS0/hHeyVjiGws2U77uzT0bswsd1iGvcfztmwnLrcWAO75F/MyWW+obk5Irma2jy
	OiuWhg6mbLb1tLPRA6Mr1c1/j1E4OyyTK6xJIQzEczyn91gZg1Jp9Pv8BNcbMstQ1o5q+ZERjtg
	Mokltgw/h+nU58
X-Received: by 2002:a05:6a20:9145:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-39f2eff3894mr28098911637.18.1775733259947;
        Thu, 09 Apr 2026 04:14:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:9145:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-39f2eff3894mr28098881637.18.1775733259440;
        Thu, 09 Apr 2026 04:14:19 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm21622903a12.26.2026.04.09.04.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:14:18 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: venkatesh.pallipadi@intel.com, davej@redhat.com, trenn@suse.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v2 2/2] cpufreq: governor: Fix stale prev_cpu_nice spike when enabling ignore_nice_load
Date: Thu,  9 Apr 2026 19:14:07 +0800
Message-ID: <20260409111407.9775-3-zhongqiu.han@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5NiBTYWx0ZWRfX91C5Bh95HMdE
 0lMCrNQxKUw2i+8QOQ4WTJbaQ7J7lgf7uGGB3Vvg3KMbzjVvKU0Iy++hQs5CD03VKljFFSSQsHq
 pbo8DYhFEIGRu9oUXxVMw3GmEqkJyD9o7rJCGzh4BcaCKlJjElb940dGefc5WqEcjoxwnq3vsQJ
 LvNY3i4DgsDynb2fAkitHb3iOrpKBb8+7BHsKn3IBikGWHjrSjugGsXqPAarR1t8ATCE3XabNQQ
 JsznPS6WSFqOkJ9wp81i0M9McLz3akHQEAqDAu1Mwi6djf01hbqtkT3/Hb/q6vh0rNYYmF0TvQ3
 ILkkBPja8EYEgmbg1bpbQ/JUFmj5rRBYLt4mgatsCy9kdjfgf3kYPrVq+OK72+vIli741yGVGZW
 /gAetSSauTI2NJYsJaoZhG9CmHgIVPLUzP/l0GtmhJzV78Ib2MYtntNjqjhkSY41nYVPiZnnNI9
 EmNfs8Eon47vLPNH+Cw==
X-Authority-Analysis: v=2.4 cv=eKIjSnp1 c=1 sm=1 tr=0 ts=69d78a0c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pdZpGBdB-CSjEQLDLe0A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: zYMsoadCGhrtzUSfE7OrmNd8No9u-aZB
X-Proofpoint-ORIG-GUID: zYMsoadCGhrtzUSfE7OrmNd8No9u-aZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090096

When ignore_nice_load is toggled from 0 to 1 via sysfs, dbs_update()
may run concurrently and observe the new tunable value while
prev_cpu_nice still holds a stale baseline, producing a spurious
massive idle_time that results in an incorrect CPU load value.

The root cause is that prev_cpu_nice is only updated inside dbs_update()
when ignore_nice is true.  While ignore_nice is false, prev_cpu_nice is
never advanced, so it accumulates an unbounded debt of nice CPU time.
The moment ignore_nice is flipped to 1, the very next dbs_update() call
computes:

  idle_time += cur_nice - j_cdbs->prev_cpu_nice

where prev_cpu_nice is stale (possibly 0 if never updated since boot),
making idle_time artificially large.

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
      idle_time += cur_nice - j_cdbs->prev_cpu_nice /* stale */
      j_cdbs->prev_cpu_nice = cur_nice
    mutex_unlock(&policy_dbs->update_mutex)

Note that even without the race, the anomaly occurs deterministically
on the very first dbs_update() call after ignore_nice_load is enabled,
because prev_cpu_nice has never been updated while ignore_nice was 0.
The race only widens the window in which the stale read can happen.

Fix this by unconditionally sampling cur_nice and advancing prev_cpu_nice
in dbs_update() on every call, regardless of ignore_nice.  With
prev_cpu_nice always reflecting the most recent sample, enabling
ignore_nice_load can never produce a stale-baseline spike: the delta
will always be the nice time accumulated in the last sampling interval,
not since boot.

As a consequence of always tracking prev_cpu_nice:

  - gov_update_cpu_data() no longer needs to reset prev_cpu_nice when
    ignore_nice_load changes; remove that conditional.
  - cpufreq_dbs_governor_start() must unconditionally initialize
    prev_cpu_nice so the very first dbs_update() has a valid baseline;
    remove the ignore_nice guard and the now-unused ignore_nice variable.
  - ignore_nice_load_store() no longer needs to call gov_update_cpu_data()
    at all (prev_cpu_nice is always current); remove that call.

Fixes: ee88415caf736b ("[CPUFREQ] Cleanup locking in conservative governor")
Fixes: 5a75c82828e7c0 ("[CPUFREQ] Cleanup locking in ondemand governor")
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq_conservative.c |  3 ---
 drivers/cpufreq/cpufreq_governor.c     | 28 +++++++++++++++++---------
 drivers/cpufreq/cpufreq_ondemand.c     |  3 ---
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index df01d33993d8..5c316d2d3ddd 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -213,9 +213,6 @@ static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
 
 	dbs_data->ignore_nice_load = input;
 
-	/* we need to re-evaluate prev_cpu_idle */
-	gov_update_cpu_data(dbs_data);
-
 	return count;
 }
 
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index c0d419c95609..cfbfa5d8bb36 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -92,6 +92,12 @@ EXPORT_SYMBOL_GPL(sampling_rate_store);
  *
  * Call under the @dbs_data->attr_set.update_lock. The per-policy
  * update_mutex is acquired and released internally for each policy.
+ *
+ * Note: prev_cpu_nice is intentionally not reset here. dbs_update() tracks
+ * prev_cpu_nice unconditionally on every sample, so it is always current.
+ * Resetting it here is therefore unnecessary and would only introduce a
+ * one-sample spike if a concurrent dbs_update() ran between the reset and
+ * the next sample.
  */
 void gov_update_cpu_data(struct dbs_data *dbs_data)
 {
@@ -106,8 +112,6 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 
 			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time,
 								  dbs_data->io_is_busy);
-			if (dbs_data->ignore_nice_load)
-				j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 		}
 		mutex_unlock(&policy_dbs->update_mutex);
 	}
@@ -167,12 +171,18 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
-		if (ignore_nice) {
-			u64 cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+		/*
+		 * Always sample cur_nice and advance prev_cpu_nice, regardless
+		 * of ignore_nice.  This keeps prev_cpu_nice current so that
+		 * enabling ignore_nice_load via sysfs never produces a
+		 * stale-baseline spike (the delta will be at most one sampling
+		 * interval of accumulated nice time, not since boot).
+		 */
+		u64 cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 
+		if (ignore_nice)
 			idle_time += div_u64(cur_nice - j_cdbs->prev_cpu_nice, NSEC_PER_USEC);
-			j_cdbs->prev_cpu_nice = cur_nice;
-		}
+		j_cdbs->prev_cpu_nice = cur_nice;
 
 		if (unlikely(!time_elapsed)) {
 			/*
@@ -519,7 +529,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
-	unsigned int sampling_rate, ignore_nice, j;
+	unsigned int sampling_rate, j;
 	unsigned int io_busy;
 
 	if (!policy->cur)
@@ -529,7 +539,6 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 	policy_dbs->rate_mult = 1;
 
 	sampling_rate = dbs_data->sampling_rate;
-	ignore_nice = dbs_data->ignore_nice_load;
 	io_busy = dbs_data->io_is_busy;
 
 	mutex_lock(&policy_dbs->update_mutex);
@@ -542,8 +551,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 		 */
 		j_cdbs->prev_load = 0;
 
-		if (ignore_nice)
-			j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+		j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 	}
 	mutex_unlock(&policy_dbs->update_mutex);
 
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 9942dbb38dae..d8d843183c21 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -261,9 +261,6 @@ static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
 	}
 	dbs_data->ignore_nice_load = input;
 
-	/* we need to re-evaluate prev_cpu_idle */
-	gov_update_cpu_data(dbs_data);
-
 	return count;
 }
 
-- 
2.43.0


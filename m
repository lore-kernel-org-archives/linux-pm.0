Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960039FCBF
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775733256; cv=none; b=n6BMiNDkp4XKZu3yf6Lo5lot+FH3WR7AlQAT4FasbBVzCu0DSKWLeIhAq4Lk9RQ/fGjoAIP55cZ6qhxR1R+HNdr/4u+7/nAF6ftQSfOvFKbDxg7V79O8D+qiKCNbOY8KCqd+749kPu5IBn8DuGpUIjwZ2H1FmcxQVPGN1Uy/csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775733256; c=relaxed/simple;
	bh=UPtUmxY97/PXIR21/gCVQJ/FUSnDgzqgXQ1sAhOtFuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zev5yAaNP4CS+2FNF0O0oNkpuww+g07O0Nm+DV3bNQa6pVASkeO+0nIwylHKThmT+GV0vVgcmgRSpHLB6RHZHxujHVT3k8qxOkODBjwDafcTCfAUZ/FTB8sXLQJm+c9ynIkOcvl5eMrQHh8peGMRsP8dKvYJyhSt7FPRrECjJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RdDKeKZH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hmN6iWNx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RdDKeKZH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmN6iWNx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6395GM144107662
	for <linux-pm@vger.kernel.org>; Thu, 9 Apr 2026 11:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pjBPQP/CQq53EsUjYp/Xr5k1hAVuAwxrppP
	5VEmdiWY=; b=RdDKeKZHCbooLW7AD/dNBLApcnAhYBV8piyJqKd7aAsCPUL/n5g
	LO7U/xV/ANk/mVnSKyComH/JOD6euF+t6XyVV22a1fmmhCA6PnCEQZDkG3t5Hp9b
	zhJTHi1Zi3hJKbV5VunbOZv13/T6fXScZa0bYrJ7FmnxrJ4RcBz+ZvXwboQxFntt
	oafxFJ0UblgGgg3xqZlMbrLtKf2mZuvYjSVcM5Bn8Gv4lYIVwslwsKg6bOKs6Rkk
	gmu1twSgUH/CZM+Hb36dcC1HHELzWBHntzvRNI2kWgNWy2UHBGs2AUj29B6wz8sk
	EBt2DIXSLbxBqpHRM0EgERLTRNGMC1F0Ong==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddxhajjd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 11:14:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c76c62eb15bso558261a12.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775733253; x=1776338053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjBPQP/CQq53EsUjYp/Xr5k1hAVuAwxrppP5VEmdiWY=;
        b=hmN6iWNxJXCKkEcJyZv6xlsmELqaErJancukfEoyUMsbYhWdqo11IkmyNIqfb3oKdq
         uHqcCTFevoEOkzIkkg2q2IVV6qckmycYfCwxegi4Vxn2t0WrOC/YLOTNaOGlM/OTixgw
         x8pI45mhbLxMOEUzDcCb3mBmp7BMvtggkMmAhGK4sHke6LiAVt0MtUmLPWe43NlYP6kt
         3LBCDjC4KyHyWe452yWgGRkT0zlzrCa9lykIZUYIki8inewaPwb6ETazr4ko/0PekzfR
         Hk7W1w7rWcStEp46RMmplfPGxtXj9QqhWQfr81/yOs0EIYfC4jka8vz9eNNRcdoqgctJ
         8akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775733253; x=1776338053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjBPQP/CQq53EsUjYp/Xr5k1hAVuAwxrppP5VEmdiWY=;
        b=pvqhLphdGN5c8SbdexKN04BzB8oUpg1kL1k+tvKmlme+SD2IhE+J44HVA75yuH5JjX
         kkQqnIi0O0C64v/MUdBHBr1laZaJ5OFxBvP2GxvPg7+deBer1pvmgYsMMIWV0VyQHfd/
         HmPJdmQeivxZuGM46z729EjKIy2SlyIv/uXMPnC4V/LUYTVZNlUA9K3L8iDKs+d1mT7c
         bttXi4tc/JQFl7543QOt6vv8PAKJttZ4aHrCyZGbPh5rc1NzNwWUDHpKonUpnICH4ZII
         Xw03YmGZkBWiock8jYUtkU5TMMp+A9ac02IqCQlm706FA0XDDLDE8ZerCKMeVFdRRAuY
         +JUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKe536C6qkk3eqZ86TUtEF8Nx/bDcW3CwYJLcmLW91wjjGI1dm4ym5f0QI2S+tAoShkVduDcRNgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWNZsoseMMDwx+HeEJzdnuyYkAmWkfSz1Ccuerm2sK4s9KOcn
	GTqS8nPIk1xWma5XBzkzQXJsIZeiXt7Tz5b+NjplenW309xbjjJ9UX0IKMdBcKTeU7pKrnulAz7
	fjRgeYfaEv4fEmHIuW2FJ15hDnRiLnGaheCDdR0mkmKkl2HlOHZKDKL9YJvbLRg==
X-Gm-Gg: AeBDiet0Nn+UrP5x6X+653jkO6aP2852kvQ3mOmZVOjdaGE5ePQkUPGZ+qrPZ6WRQYX
	LbJyf9GAn9efVrLmu8IqWFGFm/+AnTRrJCs3whbUUF28+mm6Wq0tDwoBpttwzhtyDxsMYnbe3Nm
	D65yvr2sO3XSo8M9+uTvhuXGw0mK2ItVLQ8u/WTLHP3pkf2xTB/X3nl7t4kcxA65L/L3cocS/4c
	3hFS3GxF5PX+gWu3Z1DbYKwBm4AXay58rg7ugMeZSUrnuy9M1lhGhXj2QEzdc4UkivYH4sPH8yp
	bODJr8ZgdqURBj/JfXvpV1dHSCRMKJnqG/UddkTy4fiB5YpjEy5V4c/YXaz05oidty361J2FmsS
	1WOTJEK6gq3oYqtwCtxJoYIz3kKdireU07YoupaSRRqDYAi0xN04zJLfYEf9s+TwWbuV/G2umEz
	49IbqU8pcsibay
X-Received: by 2002:a05:6a21:3399:b0:398:c351:aa0e with SMTP id adf61e73a8af0-39fc81c29dcmr3773415637.25.1775733253452;
        Thu, 09 Apr 2026 04:14:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:3399:b0:398:c351:aa0e with SMTP id adf61e73a8af0-39fc81c29dcmr3773392637.25.1775733252939;
        Thu, 09 Apr 2026 04:14:12 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm21622903a12.26.2026.04.09.04.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:14:12 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: venkatesh.pallipadi@intel.com, davej@redhat.com, trenn@suse.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v2 0/2] cpufreq: governor: Fix races and stale baseline on prev_cpu_nice
Date: Thu,  9 Apr 2026 19:14:05 +0800
Message-ID: <20260409111407.9775-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qmy9sC_4MIgJZG06Nqt6HjEPh4mbgH5n
X-Proofpoint-GUID: qmy9sC_4MIgJZG06Nqt6HjEPh4mbgH5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5NiBTYWx0ZWRfX5I9FLyiaGj8B
 vyMk5wGT5LfeQLJFkiiCBNA362YAe1vbgaZvUV4Rw7HEoYorBquv11424Xuv5YzAiHqtbE9KJLm
 DKzpVyqkpNazMmTq5FwOeI/Bta2hbrB9OctV88S4coqczXeL29DCeAl4Jxq7lgb5Wb5O1/0owjz
 A4ejwkOlmLW1DGSe7aaS8BKjuUQxcDuoo8xk11aBU9IDAQ8ImmcpJeMHWQ2gRsQsCgToqy39paE
 UTILmPWw1NbycQGiCot7Gx1GsRxc2YM+jTfKM6B13NOLifLUtykWAZ5DCnTmvluedINkCbF/HQH
 M4SCPjeDbtWzW+NPtJzF9ol6bm5TsBkM1q4Hj/aMnEDWAM966oJj9UuZf9euic/r2iGYfN2/ruk
 0KBVPZpJXKtvcyeHceRHVv1uXws5vITI3QJiXudIeSOMkWT1GdVAuhlUoSuMa2J/Sic2dyVLURy
 nhqeXlDGuIBNfA1Zj6w==
X-Authority-Analysis: v=2.4 cv=BefoFLt2 c=1 sm=1 tr=0 ts=69d78a06 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kJhCsH8l8v12fBfCrQsA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090096

Patch 1 fixes a data race between sysfs store callbacks and the DBS
work handler.  gov_update_cpu_data() writes prev_cpu_idle and
prev_cpu_nice while holding only attr_set->update_lock, whereas
dbs_update() reads and writes the same fields while holding only
policy_dbs->update_mutex.  Because these are independent locks, the
two paths are not mutually exclusive.  The fix acquires
policy_dbs->update_mutex inside gov_update_cpu_data() for each
policy, and also holds it around the initialization loop in
cpufreq_dbs_governor_start() to close a similar window against
concurrent sysfs writes.

Patch 2 fixes a stale-baseline spike on prev_cpu_nice that occurs
when ignore_nice_load is enabled via sysfs.  Because prev_cpu_nice
is only advanced in dbs_update() when ignore_nice is true, it
accumulates an unbounded debt of nice CPU time while ignore_nice is
false.  The moment ignore_nice_load is flipped to 1, the next
dbs_update() computes a massive idle_time delta against the stale
baseline, producing an incorrect CPU load value.  The fix
unconditionally samples and advances prev_cpu_nice on every
dbs_update() call, regardless of ignore_nice, so the baseline is
always current.  As a consequence, the prev_cpu_nice reset in
gov_update_cpu_data() and the gov_update_cpu_data() call in
ignore_nice_load_store() are no longer needed and are removed.

Changelog:
- Update linux-next base
- Based on v1 review, patch 1 is updated to add the missing
  protection around cpufreq_dbs_governor_start(), and patch 2/2 is added.
- Link to v1: https://lore.kernel.org/all/20260406110113.3475920-1-zhongqiu.han@oss.qualcomm.com/


Zhongqiu Han (2):
  cpufreq: governor: Fix race between sysfs store and dbs work handler
  cpufreq: governor: Fix stale prev_cpu_nice spike when enabling
    ignore_nice_load

 drivers/cpufreq/cpufreq_conservative.c |  3 ---
 drivers/cpufreq/cpufreq_governor.c     | 35 ++++++++++++++++++--------
 drivers/cpufreq/cpufreq_ondemand.c     |  3 ---
 3 files changed, 24 insertions(+), 17 deletions(-)


base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
-- 
2.43.0


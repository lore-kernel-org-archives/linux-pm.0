Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858D34E766
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776605223; cv=none; b=rLWRjW9PmdeZeMnMHFhd9+0Q//f80w7xfhE/betV5vrwA9PNoVcsimex9tEMhMWVAF2ipV66Bssr6O1lkKLLzWfmHYjIJ8o5XZAOBNBcxcGnW9kpkcEDPYmzfrFJ/YZEXjnXifPKBtAwhA1Uf/pPNeMPfi/dXvSYH/UkTzSf5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776605223; c=relaxed/simple;
	bh=WCGA9VJ1tLtlap9NBsRzvun4EiPzor9Iy/OiOgkU7qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jezNSCUy6vNPf+zsjC7mWqN3oy1SnDvWf1BMhPBxpy9JrUkMxEMpSWPEHRI9NPpuiMUj3ombTLuAof90WM1zAdpi32Sd27HYjd1I/NiT0uMrhGk8cT3ISVptJ30aQfpQOCUlslppldA4DI5OXHrrtwW9LQhg+cDoZvSNVwr01x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0OLWaUY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QCmHTGLg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0OLWaUY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QCmHTGLg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J78JfH3230917
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=R5RB/G92AyQbpyoxVOn6eb17AlKkQU19dDv
	0g7VJ5WY=; b=f0OLWaUYqF/uNOBG9wVb8A+dBPBK/ieS1I58Jk20qIDLmcpgVWb
	3aLF0c2f9IZgZgvr+jTeFvRm2TJz2/kB4wloEWBYh1oTKnCjxFPaQg1mGTobMgpK
	SQTh4QoQ+NfYV7c50R54XDU/owKyg07kCtRJnnBCFaWvR4Bk7brXGb1L2Qv5v0it
	MYegw5UpQz1ZZ9G0ddGc9u/1dQB4aGDi/DtS6d9XwEiI4AhVrczrR7khhRrwKRpb
	RLjGRflmyYgV4WyMHqd5T99b7Fqbpn+EKsamnXwN7w3HXkS+MSxACYHLv7GeVFUj
	wL9N4SRwnTXXSuv9+5R5YTnz2hQpOwIKwIA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm1hx2mnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 13:27:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso2187114a91.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776605220; x=1777210020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5RB/G92AyQbpyoxVOn6eb17AlKkQU19dDv0g7VJ5WY=;
        b=QCmHTGLglU+2isUInVHfGoFVgRmtQ2BjQlH7zw/h/PuEbmGLQri7pbsuIFTIHjAsl3
         whTEwcduff4gMYxY2tAV35apjH3NW5iP051clivNG2TQOuqFbKqET6U644AtzwUYnraz
         9ziKlTmSj5v7dCaEWQ1RE/oTp80AikaUvv6bH/HzJeXqCM5vQEK3wv//dcOJvIFqrPTu
         gmeGMQp1yGzSg8hObLXhYq6egP8u7qOXdvJPxp/uR3/KtZVTprvda/L9Uk3Kb3wwifwr
         VtnH1vXeGwido4UhOJlJG20uXXrW/N7wYY9DSR1oeWbH5NDDBUhrIhyNoJFXWTxG/SSM
         jZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776605220; x=1777210020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5RB/G92AyQbpyoxVOn6eb17AlKkQU19dDv0g7VJ5WY=;
        b=KUiEkRi5J+q/+gK3+++zrutCNbFhIaj6ikODcmHH87uWFyUDrgB8R88FcWNANnZBRB
         tapLAHCwDB60aZSMEGkn/pnqvx2Rdrkbb9DL4zDqkABH+rTrEbvfphYlz+DpO9V84QXr
         W9bAV4m1pktX8AiNJBEi58lSuzQHw09Oba1Mi5zeWCScGQkj9Ruw5TDYWFgP2DWF+UbF
         fMU3ceX+sokHxNVPNQZSggkGhKP7vlRBVNsduXwdRGFIafvYVtXK4bHcaieZv/lrUQmj
         dIDm+syi7a5yn/j4wLk7JVdaMa2fDQkhI0/z66ihBfXj/ZOO3jhdMCpnLMOBOlySktiq
         j0yg==
X-Forwarded-Encrypted: i=1; AFNElJ93AKXyKMSofKbrNsNlb4HGGeUS1rWHp7C4VXrhRMLaUKxNg9vFfMhL2bALFWxC5aPBsSBKd/JnlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFr0TTX7o/eXjtc57kXOhkS2qh1xBxToZ5Yu1O2knMvn7d6Poc
	0u+gat2N6hSV4Mh6F+jRRLLBZd6BrQBl93wEs4uqEsaZczSgVd5MEn3zdIlRyMU9SGzSp+3pWXh
	P9lzZdpB1tvCbqa/ic3sEejffe0ZbBhAHfUe6sKL1BmPkbMwzq510abFt2IKtCw==
X-Gm-Gg: AeBDieuWKaoMMQLlczGby8mlFBgnbkRwMqYPWgnK/KHbcsHztsLUVXeGm0lZMSkxqCF
	begujngLoFotc36U9ImcH7Mv7NzLKLYBNf2WeHU4kBWP14MNKuYPVyzblFiamZBTiUOGaZPOnNB
	q3xLohtiOIEEn3gFgBPMDaXgDGDJti2acFoB3uokO6czcdc1mbqtu8uHrcr4okf6EyswwXfdHo6
	EwO3LFS5qc33jPMHVft75r/imrcPaAPyeVrX6NHwcw3iYBm418SnIXMm7g74xqIjB/R6YgyIzKP
	Dlcsym/FqtZb0vmKb6LAak04w40erImrj6bIZJAG2JctUJur4OdsILOF7rhDz1M8GQDwl2knH31
	g0Qrd1w3OmQ4/zoQP3TTjHJn8b/WmPmuQwEOuFr3x3enlvA0mbKEF8S7efoQQ16Ik0bPSlfeEIh
	T810B1uQBBUnHrnQ6LnowKDv0=
X-Received: by 2002:a17:90b:1dc6:b0:35b:e51b:1935 with SMTP id 98e67ed59e1d1-36140462ab5mr9322623a91.17.1776605219744;
        Sun, 19 Apr 2026 06:26:59 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc6:b0:35b:e51b:1935 with SMTP id 98e67ed59e1d1-36140462ab5mr9322604a91.17.1776605219216;
        Sun, 19 Apr 2026 06:26:59 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbbb4f9sm4010342a91.6.2026.04.19.06.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 06:26:58 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: venkatesh.pallipadi@intel.com, davej@redhat.com, trenn@suse.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v3 0/2] governor: Fix races and stale baseline on prev_cpu_nice
Date: Sun, 19 Apr 2026 21:26:52 +0800
Message-ID: <20260419132655.3800673-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kF7rkBw9H1rsmyWgIll0pU-aEQYw9pfO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE0MyBTYWx0ZWRfX0ICUtpWDFyAo
 +Md27PNzA7RqJbFiNG/3kXIVWftHUGHYXGBQOWN0fjH4+CrPFYCD/OExKwpRxBSf9+0GERhv4yT
 QkTkCUzdY0HNrO9NCI4Qc/LSS+rz8lslL4xL9OoQ5j/wv2PqBz9CjKOHCei8MPDu8KdOarnjHgz
 PVURBsoGNPMcQ6+gEth0iQAO8hg3Wb8DF3Gnu5LPPK3CXOxlZxRmWbfRSsogMRIoTyMMfrSSj1J
 Q3Vnw2IhqvoVx8fBnG4K3GuNEzA8FUDQ84HoCbBZsaOVbkJLn1eXRq5oYrXYzDNLI6gPJ4Nt9mS
 +5zSPxp7/nkky/cHbhATOGff+8buimEKt0PacGd8wSu9RYnslQdLCISyj3ggxY1JYLP47te64UW
 g0cEY4J3LYo/nfu6cuX6TJLKzZDh2GMdrCWV2dGcifNHDPghY6PI2GzYSH/4Uy6/rbc5KzYQY+C
 blqijQnwcUR3W63Obug==
X-Proofpoint-GUID: kF7rkBw9H1rsmyWgIll0pU-aEQYw9pfO
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=69e4d824 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=RwJQl_TKvwRCqHG_nJEA:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_04,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190143

Patch 1 fixes two baseline-consistency issues in the DBS governor
framework.

gov_update_cpu_data() writes prev_cpu_idle and prev_cpu_nice while
holding only attr_set->update_lock, whereas dbs_update() reads and
writes the same fields while holding only policy_dbs->update_mutex.
Because these are independent locks, the two paths are not mutually
exclusive.  The fix acquires policy_dbs->update_mutex inside
gov_update_cpu_data() for each policy.

Additionally, cpufreq_dbs_governor_start() reads io_is_busy before
acquiring policy_dbs->update_mutex.  A concurrent io_is_busy_store()
can update io_is_busy and call gov_update_cpu_data(), which writes
prev_cpu_idle with the new value under the mutex.
cpufreq_dbs_governor_start() then overwrites prev_cpu_idle with the
stale value.  The fix reads io_is_busy inside the mutex.

Patch 2 fixes a stale-baseline race on prev_cpu_nice when
ignore_nice_load is enabled via sysfs.  There is a race window
between setting ignore_nice_load and gov_update_cpu_data() acquiring
update_mutex: a concurrent dbs_update() can see the new ignore_nice_load
value but read a stale prev_cpu_nice, producing an inflated idle_time
for that sample.

The fix unconditionally advances prev_cpu_nice on every dbs_update()
call.  With prev_cpu_nice always reflecting the most recent sample,
enabling ignore_nice_load can never produce a stale-baseline spike.
To keep prev_cpu_nice handling consistent, gov_update_cpu_data()
resets prev_cpu_nice unconditionally alongside prev_cpu_idle, and
cpufreq_dbs_governor_start() initializes prev_cpu_nice unconditionally.

v3:
- Update linux-next base
- Fix two additional issues found during sashiko.dev review:
    - Patch 1: move io_busy read inside policy_dbs->update_mutex in
      cpufreq_dbs_governor_start() to close a TOCTOU window against
      concurrent io_is_busy_store().
    - Patch 2: restore unconditional prev_cpu_nice reset in
      gov_update_cpu_data() to keep both baselines consistent when
      io_is_busy changes with ignore_nice_load enabled; update comment.
    - Patch 2: keep gov_update_cpu_data() in ignore_nice_load_store() to
      prevent a stale-baseline spike in the governor-start window (when
      ignore_nice_load is set before the first dbs_update() call); only
      cpufreq_governor.c is modified.  Update commit message and add one
      more fixes tag '326c86deaed54a ("[CPUFREQ] Remove unneeded locks").'
    - Update the commit messages.
- Link to v2: https://lore.kernel.org/all/20260409111407.9775-1-zhongqiu.han@oss.qualcomm.com/
- Sashiko v2 comments: https://sashiko.dev/#/patchset/20260409111407.9775-1-zhongqiu.han%40oss.qualcomm.com

v2:
- Update linux-next base
- Based on v1 review, patch 1 is updated to add the missing
  protection around cpufreq_dbs_governor_start(), and patch 2/2 is added.
- Link to v1: https://lore.kernel.org/all/20260406110113.3475920-1-zhongqiu.han@oss.qualcomm.com/

Zhongqiu Han (2):
  cpufreq: governor: Fix data races on per-CPU idle/nice baselines
  cpufreq: governor: Fix stale prev_cpu_nice spike when enabling
    ignore_nice_load

 drivers/cpufreq/cpufreq_governor.c | 42 ++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 14 deletions(-)


base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
-- 
2.43.0


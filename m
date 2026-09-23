Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602A531AF3
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174069; cv=none; b=ouzwxR5aIrxTcQeipwq9npGI5fnXlq3o28ewgO4FRgzcXbDgKlIL4NREPZfSJnNzUJJKG/r3xMnyR5gchVROKzKBaYQqZFEBwXWtfu8ap90Mpt1j4WmrlDzOY4DazJaofzDn2CE2vCIkDV2w5KUnkpUld/vExeM04JTkKKkxAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174069; c=relaxed/simple;
	bh=Y4khVXeemjG7U5RyghQFLtmJRcCeMF3ra/N19Lc+vfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ca8RD+ykl0Jzxtq2j7aHahKP/4RQW7wfR0ZOmi3OOEm3TWoPqEv+8HPyQ2MB19w31MQPPtD7ePihReSpLJg2hCKydspPU072U15lqMY9TI32do8CaugYqucYUuaA/DGMXndr7y3/DVlrTjtNzKfYs05lB/lDkerv43/28TYpRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EnLAcB3h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i/v8zAuh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EnLAcB3h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i/v8zAuh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbSfG2443257
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2enLtWPV8EY1gFb2HT3py+uGngZNotcbsn1
	pLWbCTGs=; b=EnLAcB3hE6S3oNWlSnjjQxlYSSjanomQaW7Dw+J9nmw4HtdG3Vu
	vHeaWxq7b3AKwTwwmxDPLoqtMiIbM1BeFPN1J83PSK0+hG6Z1ALak/2boXjsqHMm
	/iulsq4qSdJvOtYtRQvLhzRHziv/eXC0yt2WPi2ba6fjKJNM4gwgJtwCgnoAlARj
	I97n/e3phQLEcCpWLPjMD2b4T9Uw9gJPuZnoTasm3/rgsVXhsOkDDcNb2vA9yugu
	fvGhFAPEfOBAhwgNNOJCwsi7R55z/qzFTfc79OlFRvd/Nnqzo4fnPnFzBYizie9S
	5hlnOkbmv1Gej+QlaylleRur7AydK8HkQbg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbx7hac5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:26 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-980882ce555so183013241.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790174065; x=1790778865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2enLtWPV8EY1gFb2HT3py+uGngZNotcbsn1pLWbCTGs=;
        b=i/v8zAuhSUUoyWbGjtLiE71e396dh7cjtS7WgOi59DRBLwNy71FhHcGg6m4Ar9UL5u
         kXWTVP6Ws7HCN2zHeaW0Q1iDuQmbh4djf2luucbnmmYiomGF5xRkOMzWzaej5N5LkOKo
         pWpDZ8dQwoaRQwr5I1C50Y+ati2z5uheDBBG+IAta84DTRQZfb/Gs2gqS1x9Vd/0sDGK
         nGVbW6Gq+oGhuvwzPNir0Ep19ReUN26KnDFpczla8zmSw6W8DqRkIASJDKR4K8qJZFXT
         p2dr/V5N4V2pUpLped+TB+48IDG6/BVDBXqYWgq3UGxOojKQt981H+hFecpXxqsYc8tM
         WdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174065; x=1790778865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2enLtWPV8EY1gFb2HT3py+uGngZNotcbsn1pLWbCTGs=;
        b=YGDJGU374EXvUr2z0Atwcb7HdENVDx4Z5ek05HYXq4SQnsrzwFiEYcDV1xiFbqS0Ab
         NJ4t970psxunHvsZBUeRGX4EXlfe2bpBPHWroxThdhDbpy7Z6qkfE5EkNojXpxaXZlus
         UoW6p/xpW2pn3gb4lsEpkzi+isp0LRAceE9vC6xsd1PgyBPSR2Fsxinr5yxng00XpmKs
         Hpp7pCoWvpcdv1deHJA7sKySEFQ40iXlo1osKCUrRznA6nr84cnZbm8kmBTJZGWBd8K8
         p4DxXnxb4Yc89XVQ5i3oV978F5tZ5Hn5eNkhJjxsipCr091EZwhAMsL6RvdxL2F6a14D
         Z/rQ==
X-Gm-Message-State: AFuF++kg/4+nPONWUAmM/QdtV3B2tPtWNibsgY1yX4HTuC7NEiRzx+JS
	Jzik2GJepIHJzrpvflo+KVVS69ce5BxDPsWDUxzUmaF6BZREbBglxfhLbb5yXVwrTy2MO16hVfs
	Ci6f37L/8Z/QaQLlf38VCb16DaLZnxM9B4OsLFi5fAjuvteh72bdPvnktriJvgQ==
X-Gm-Gg: AYBFou2UT4oXlA84uyfQ8kuoz50OdxXGahxOR17oV2wDOzlJBpiuQh41gp4afIfTlyR
	2Ziox5Jzw2DrwHiFqIAkA9kNp85OQvP7/iiYBLamfFzztRMRYMLtMIEkIHPJnlEAM5Nw0i+5AKs
	yRzxTKPWC/2z891eIh8kGaGXBje2HG80lXbrWWMThSFBxa7wg+brbcCqLZHjXl64CCFEXb9ye6y
	0tixFQD+7ytL9z9TCpGDv5rEj8axFCeKTljmeIVlgc0zvmxV7J7feZOsz2bra4POViflvI/fvft
	xR/qWGAGSYOD+9UsdnlPDv87fVs4MUzFM6fePHPobMHl9D1OwhHRRyKZNPmm7zAVZiReQk7miRu
	JCl0ui85QEwUjJLr+TqjajeLmsLM=
X-Received: by 2002:a05:6102:3ec3:b0:7a1:f7d2:e839 with SMTP id ada2fe7eead31-7ac1da2381bmr2472941137.25.1790174065323;
        Wed, 23 Sep 2026 07:34:25 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec3:b0:7a1:f7d2:e839 with SMTP id ada2fe7eead31-7ac1da2381bmr2472909137.25.1790174064665;
        Wed, 23 Sep 2026 07:34:24 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a913:ba43:96d7:743c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm58213905e9.0.2026.09.23.07.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:34:23 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 0/6] powercap: Add generic hierarchy support and convert DTPM
Date: Wed, 23 Sep 2026 16:34:10 +0200
Message-ID: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WLuNF0hIu3zSfzRHAvcAOAUrNLozHt06
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ab3e372 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_Mu-bpVJhHz6Wm8h43cA:9 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX1URHxfLViuSp
 JAAJICxmdFVZvywSTmUu7CAVmx0FOSSfvUIanNRqxOLGc/At77gyef+GaCQ4zeEXeN9JpW1XHbR
 ktxuz0kFLMEESQWDYI3DMMB8XN4ZSNb/cNHCeBEDkch22x/fz9dmCCH7LJ2c65qYRrZQbq/66uB
 XhTYIkCIY09sZY3dMaXAEf7ohkSJQXtzAySD1YJNzH4zApNM+8G/JF3Mvd5SbGFK8NNU7RsZi7K
 LJOXQ6bbNbY/B75X0FpPSjjUU9dXUsQiELenUfHgjC37WYC9rehgQGFgsou+Ye6keDmZMrWX7+H
 0e3EDRzwDr4KwkP68nuNUmTHPOs5EX+U1v2xL/sLBP8CQU8oGjXMR2sJgFdtjALI6bHaWZ3Nat6
 3hld+BRXbF/gYxmUoJfhrJc68/OkUSo6uHyrS59DKuVYbMTVc+OxQ4FiQqXmUh2HXKLv59LNJLf
 I6ecn6Q0T1ObwOmlEgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX2o0GhEWlE0wd
 IYkyJLB7ks2l6TXovdP2+w4I65rCrKkpAXKyBJ/Xsu/zHjT/hAUlLL6D0ijqJV0g0rQBzolplAr
 iwbNUEvFerKVEKYjG0Y5mJR8uI4tJIE=
X-Proofpoint-GUID: WLuNF0hIu3zSfzRHAvcAOAUrNLozHt06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058

Powercap controllers frequently expose a hierarchy of power zones, for
example packages, clusters and CPUs. Until now, each driver had to
implement its own hierarchy traversal, parent lookup, error handling and
teardown logic.

This series introduces a generic hierarchy description and helper
functions allowing a powercap controller to instantiate and destroy an
entire hierarchy from a static description. The powercap core takes care
of duplicating the hierarchy description, rebasing parent pointers,
creating zones in dependency order, and performing the appropriate
rollback and cleanup on errors.

The API was primarily motivated by the recently posted SPEL series and
also provides a migration path for DTPM to use the same generic
infrastructure instead of maintaining its own hierarchy handling.

Link: SPEL cover letter https://lore.kernel.org/lkml/20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com/

A kselftest is added to exercise the new API. It creates a synthetic
hierarchy, validates the resulting sysfs hierarchy and attributes, and
checks that all resources are correctly released when the hierarchy is
destroyed.

DTPM currently implements its own hierarchy creation logic to walk a
platform-provided description, create the corresponding DTPM zones and
tear them down. With the generic powercap hierarchy infrastructure in
place, this logic can instead be shared at the powercap core level.

The series therefore converts DTPM to use the generic powercap hierarchy
helpers. The platform hierarchy is duplicated before use, while
powercap_hierarchy_create() and powercap_hierarchy_destroy() handle its
lifetime and traversal. DTPM only provides the callbacks responsible for
creating and destroying the DTPM instance associated with each powercap
node. The CPU and devfreq backends are adjusted accordingly.

As part of this conversion, the existing RK3399 description is
simplified. The CPU backend creates one DTPM zone per cpufreq policy, so
describing every CPU belonging to the same policy results in duplicate
zones. The RK3399 hierarchy is therefore reduced to one CPU node per
cpufreq policy.

The Rockchip virtual node descriptor is also made SoC-independent so it
can be reused by other Rockchip platforms.

Finally, an RK3588 hierarchy is added. The RK3588 exposes three cpufreq
policies, represented by cpu@0, cpu@400 and cpu@600. These three CPU
domains are grouped below a virtual package node:

rk3588
  `-- package
    |-- cpu0-cpufreq
    |-- cpu4-cpufreq
    `-- cpu6-cpufreq

Daniel Lezcano (6):
  powercap: Add generic zone hierarchy creation helpers
  selftests/powercap: Add powercap hierarchy creation API tests
  powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
  powercap: dtpm: Use generic powercap hierarchy helpers
  powercap: dtpm: Rename Rockchip virtual node descriptor
  powercap: dtpm: Add RK3588 hierarchy

 drivers/powercap/dtpm.c                       | 165 ++++++------
 drivers/powercap/dtpm_cpu.c                   |  22 +-
 drivers/powercap/dtpm_devfreq.c               |  22 +-
 drivers/powercap/powercap_sys.c               | 148 +++++++++++
 drivers/soc/rockchip/dtpm.c                   | 127 ++++++---
 include/linux/dtpm.h                          |   5 +-
 include/linux/powercap.h                      | 178 +++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/powercap/Kbuild       |   3 +
 tools/testing/selftests/powercap/Makefile     |  17 ++
 .../selftests/powercap/powercap_hierarchy.c   | 246 ++++++++++++++++++
 .../selftests/powercap/powercap_hierarchy.sh  | 118 +++++++++
 12 files changed, 906 insertions(+), 146 deletions(-)
 create mode 100644 tools/testing/selftests/powercap/Kbuild
 create mode 100644 tools/testing/selftests/powercap/Makefile
 create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
 create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.sh

-- 
2.43.0


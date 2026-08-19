Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32933C1085
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152517; cv=none; b=RBkFxs197gdDbNk+ObsUZ13nApD6CV0a6Gojj8s1QaKNAi0QVfVmDDqCtFqUyM2IK7WsL1X83m+vT8xGf4RHOg+6OK8WznPmJvt99x4t44jAVs8SBm5ann7DLE98iLnbj0Tzm1dg9kz9aiAyfCwRej0S2dk1sK2iD/9XlTK6ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152517; c=relaxed/simple;
	bh=Bfy9axGCApkkSzqJlgTxcQxMWqFgzt6WGNk8ImtdoOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGYnaix8W3jtMXJb2BXl1IKqLiHnk9b5i/+au988XlTMLoal/cnghjWzMceXo4LlF/++dg6aoLQUUSOix52ZJVNMWabVfKwvRGI3D+LJYGeREAEus8vNqIsqsKlSKyfWuCelQVDTubcChaxlUg7gDu9xPygXUInwDU5nyPT3+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LL8TthI9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MMhuj6jA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LL8TthI9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MMhuj6jA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbekG567182
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=W3q7tfKJsiKeauJNfR3vMrN+xsb14GxldWm
	wVaAbL3w=; b=LL8TthI91jtL0NnlqqIXq6SsBuXq35cGwwey3QUn7MjSyfyI2bF
	kF7AO4pJD/WNmImaPP4ItE4tJefrBLsZQgwcVZy8BcVi/VwkyA5PG1pUvR2KtEnb
	czYed+1rUWWz1PcfmXcaRI8gmnX9tj69Ge0wOQ07k5FUuG5mNCz3O19kPCTxAuxF
	91x9vcOTFFmATyTHuZ403Zpu/xKaiBZtQmJ/kBmNguiM9VnJDR1kqyImAn9T17Zd
	t4Iqy0B2ItO2Uw2Fr5VwV57yHmYx3N88Lm4I99xr9jdCWXdR1hDtQJP7BS/7vTHX
	QOlDiTB4WbglCv4sU53DYDXF8hjW6S1F0+A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa0hc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e62e3459fso137983285a.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787152514; x=1787757314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3q7tfKJsiKeauJNfR3vMrN+xsb14GxldWmwVaAbL3w=;
        b=MMhuj6jAd1pKCuZg5WeCp5/y+x6gCOyf5+j3zewRMfW6616FMM2390cuTN3FQn6WMW
         tLx9BFqHdVNejhYjDy8R3gmHHb+euzztTnkKb+aZwHJkQtuxDcsHqC9yHmjqARh1zMYu
         I3INOhLAyLRUfAWP0/nHK4CjtGyTlFsvH7DLjJb+uq2zpERN76KjyxiJgeEbZm22vq9V
         whmRZJoUJ/qcTEjirRBezV0XhJ/1lNRChabeDQG77G5vNzUY6iQgKUS9jCZ2vZWLT10B
         vGOladEjCtueD3z61nvK5GuECtXafDMY5kHCy4ybzv77eQmmM7Y8HmBXgGeZ8+uiHzE0
         92mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152514; x=1787757314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3q7tfKJsiKeauJNfR3vMrN+xsb14GxldWmwVaAbL3w=;
        b=SSKLFb+Ol8dCx51nqIMMN3yJ+yVl7L8DUFgFzBLEG+GxHYTQfRtzPUb5TgbRG0mLJe
         J6Yzdpr3b9fORN1+BZ6jSo073sPPXgtCYt2iEt5f9SikT68cmduwhHX7AuIivnvj++2C
         Qs6EW9EEK6yOH33dH3gJ7Or+zHqKusTRicXY3/2enjQaFhIl1RI3eFrRfsPnQJ+3+22o
         /E5LQo2dH1fjjAlwA3LoTrnSnRz2ILL+Dvhmjo53fe986eSot+utFEP7pANCx2ciwgHi
         5WEfPW0RAX7J2A7/469phOQSrn/PoJ0xMsDjwWwkoEwQKV9SrjVLsH3m6ZmWeiZBfuXr
         F0Dg==
X-Forwarded-Encrypted: i=1; AHgh+RoHc2/o+S9K6cbYiuTauKSaG6g6vZ2uJQEFeBlqO8ZWA/YzWfk4+Iu5xTAzTsW+fXZrqHjpVC9tOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5fsRzQ8PUf97qwq6308C7/EPkwqITZqT3Gjqo42OCe+AwnTI
	YoQcsQWzUgGeSsxGATg89ucHAxlb0AcxzmVbgdXOpmd8rfx9odQq5bXPnfDJ5O8NSdeGUOdF8KE
	y6hEg5ro8nq2lBXXe5671Zl/oHb0ttlNf3MfqN13CX2cArjfpBYeIS3O6JjgW8w==
X-Gm-Gg: AR+sD13/YCpsx5mL8R9i5A0aBYPdwoL9BwiObBR7/d0W1yFkZ1S/rHu74AmNFxBERBI
	P7ROnEo9yC+Cv0vVJwKLCS5tMsUA8HgIHi6DHigFJMTqu/TlzYfuaNUfdRmVd5L6Ki5gPZnCkBJ
	oU+KFhxOoo5Amw6G+w40EYRp+2t54pNi8dOGP5jg4lWlH4U1pShZmCkXK/DacdQY8YFLqjlGCn7
	/qUFOx3VOOIEDJxLW0kvDCFDqG8tgW8vfbu/s7IrdjXqsQbvLF1/Vv4UsPj8+7WFuLCkdKC5yl9
	ot0Oew9XhZjSvXFcIT8bEJ0gMZVxwUrCUewQFVmka6MqQHJJpVKP2fqjGBmBKK+Ceo0BIWw36A6
	DY+g6TFEFTO0WjRo9+W1UQzF3g/ayIhJ43tbwOonSFV6fCfTBrpuyL+OOeQ==
X-Received: by 2002:a05:620a:319b:b0:92e:e3eb:de54 with SMTP id af79cd13be357-9371e21caf9mr551848785a.11.1787152514029;
        Wed, 19 Aug 2026 08:15:14 -0700 (PDT)
X-Received: by 2002:a05:620a:319b:b0:92e:e3eb:de54 with SMTP id af79cd13be357-9371e21caf9mr551834885a.11.1787152513400;
        Wed, 19 Aug 2026 08:15:13 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c4ac06asm94124666b.33.2026.08.19.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:15:11 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>
Subject: [RFC PATCH 0/3] pmdomain/cpuidle-psci: Fix behaviours for CPU PM domains
Date: Wed, 19 Aug 2026 17:14:50 +0200
Message-ID: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a85c883 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yh3ps83G6N8KMOvRL6AA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: GyY7zSGEptICYCYNwpi87Tq4T2IEtkCQ
X-Proofpoint-ORIG-GUID: GyY7zSGEptICYCYNwpi87Tq4T2IEtkCQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfX1/zQL+SE6mF3
 nRWZ/ETMLzo2At4/56eDyupnqCpEWB2iy7OZdE2nFMySZDzaYjN7UxHfMFLvkpdrZS+AWTTf78K
 Zr6PWgGTQbXyuU9B1jwN+egaVG45UWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfX7Br/vk5b8pcQ
 QU1R9NtE6jjrbKMUPEFjecbySr2Ra22YG1AreRaa54LW4hgF4J6hSnY748kE7ARzhd9w152hKIi
 bOUDPDwWQcbmsM6IaHPxamFh0UWFuesPQFl7hSzSkm/7zYNmFRdIaDTu7mZb2Zv7W+EglO2iRcu
 +pR+EhPb/rHWQbT+mRflc6GLA5pc7m7YOZ3sfpRpNqrD95PbUhRogwFLcOtCOBISQccR16SGzbH
 0URxCIqB6QxbXhCkYwYXn2dWAnQUW18U0uppJltB5wAxYij8LvPhD0KNrSD+KuLdkwA5FeWz9QI
 O5xo5ZNF1bixo7K+JpYtFoXq96p7mo8cUblW2dq0jSA1EjdFZ0CQHU/x89URn7qdtW2LjcSum1D
 iAV6ntTMzSuzQpw0ruM877jqEmX68+89tNoD4dfs1RlEAmjlCPw6BEPgeCy53BSz9bBGQw6iQYk
 EM1qN6rHB6J4gh/Fw8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190118

From: Ulf Hansson <ulfh@kernel.org>

This series fixes a couple of different, but highly related problems, when
dealing with CPU PM domains. More details are available in the commit messages
for each patch.

Note that, this series is a follow up to fix problems that have been pointed
out in a series [1] from Yuanfang Zhang (Qcom), to add support for new
components for the arm coresight subsystem.

Note also that it's RFC, as I expect that it needs some more testing/tuning
before it's ready.

Kind regards
Uffe

[1]
[PATCH v2 00/12] coresight: Add CPU cluster funnel/replicator/tmc support
https://lore.kernel.org/all/20251218-cpu_cluster_component_pm-v2-0-2335a6ae62a0@oss.qualcomm.com/#r

Ulf Hansson (3):
  pmdomain: core: Allow a non-CPU device in a CPU PM domain to do power
    on
  pmdomain: core: Add a genpd config to support unknown initial status
  cpuidle: psci: Initialize the PM domains in powered off state for OSI

 drivers/cpuidle/cpuidle-psci-domain.c |  5 +-
 drivers/pmdomain/core.c               | 86 +++++++++++++++++++++++++--
 include/linux/pm_domain.h             |  9 +++
 3 files changed, 92 insertions(+), 8 deletions(-)

-- 
2.43.0


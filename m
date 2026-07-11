Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B4381EB2
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776324; cv=none; b=BHG+afcW1+ghFeFNvTW/ZcxLYFmtQPvx5OLEcSY99Mgch2XqE1ynPIeZq2cWIiwKWwcKiLk1hfjawbbqiw5sDPo6kZ8UELreqH1zCK0nvxR7mAqAco+xd/PDbtLhXq8snLFTkNY5A5xPtu2O2aEQc58afWcTosNMM3eP1cq9Fa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776324; c=relaxed/simple;
	bh=8TSs9Nfkta2iamspr9QqU/RBcCfAwBGsHHf2WNxtx7E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hQSJaJrdOqyrLb2jSMqx9Wvk3qU02wj15qehewPppiN3RgOuG7xQTb9Nbq+oHeC4XaRybiHerefarHuaEPEgi7MWCLpsh6UAC6bTJBzkSNuklFF5Njzds3ogL56L/r01PgpUNO2ZaL0bdsWCG2IXnVKUX8HNKDLKkGq8E/YmfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BNJpy7j1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NS1VfX4b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BNJpy7j1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NS1VfX4b"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BAnqoA3434572
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wDO4niQLIzyaovhzjRfqwU
	vDa3R9l8wji1/eeFWSTzU=; b=BNJpy7j1d6O8rzmlwcS/dMkRHXNmEjaoeiq0/g
	H6luACiPLywWfOidvBGHDgXnaiSbLxo0YhBQ3UERyK91UpZ/Y1i46ynVWGNoQICn
	LDU0cX7cTYWS55z7xXeOk4U+2PK1ztwq7DzIERa3vthcqyvvvfmT5WeWnBJO8QLJ
	LHa041hRZmZoRR+MQ/Tt1qqApQB+Tl1myGaCCPIiXadzUOeesqTlh/cGZI3IVZ4D
	O6caX4IBQmd56pjxLAUtwJ+6F9h82/Uf2ihWBQ74wXgCD/RRQYEX2S5BZLN8/cyj
	VTQqP1YZC4f6szKGxjuajTkW2fjVJ89edBrSQ5OY8Vgj9knA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf0ggs2b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ea75996387so44263846d6.1
        for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783776320; x=1784381120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wDO4niQLIzyaovhzjRfqwUvDa3R9l8wji1/eeFWSTzU=;
        b=NS1VfX4bJpoh/lL0BO8UFZ6Xy8ukD5cnIHy9yMrzU9qf+jePhjTnbv1aHbcwNAJ7/b
         rHvtPUGoMNaHNTgs5qPyHmtwVGnNBpNl/EtksiTi2cWuWeKbGt6IQJ5eVRDRqO2OptO5
         BI9Yj3sU4+gQyFGSgvvf6j44TXD7mEYfetk7BsaNgBDva77oIQg3XTTj7ytwYqm/oi/r
         l+3aZRyvMFQwT34eb2E48Ld+lH1cf2S2oDyL0FFcRqn7ADvuMiqWNtjbUGno/PRpXy63
         oh9pnECOzvfIL0V34+kQgo3d/pCTOUhoIBLizBMSUSfLzSHunu+dSUsm03Rn4CcVqNpE
         0a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776320; x=1784381120;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wDO4niQLIzyaovhzjRfqwUvDa3R9l8wji1/eeFWSTzU=;
        b=bJXnkMjLFFxas7xsM4B5wXpXKu9qraoV2Xu8LUKNXZiFqHMDrjI2zHdA/5myYK3T9s
         CbDD+cNq0I5LGTArxjaQMoAV/mg+tM9jjoCR9AQubO7GGGrDTsiSWrcGzcNBiv1al7IJ
         7iOsMyDnbfUmz8IJZM9tbOsrl++LvG3UzqYCHvOXH1qhzKQLa1sdO8nKLK9HUqEwOZQg
         v8Zdb2Z8depBoPtHrUZ66lFgkTmR+rjFKjPDdggd4e4H4EkpkTW/6cavWqhhhzGoeitU
         sOSOt5ARKZClaw6dc+e0EajFqtDHzcpqRGv391DRqx+kB0HuidO1VVC+WatKj/hQbrqN
         7mNw==
X-Forwarded-Encrypted: i=1; AHgh+RqOkm0rZCDWh502ip+D1O9mL+YfWsUXWDneCblOehE8iiee3QJykR5/j+jI/9Ef5xbg131vAEkhWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJrUWepaYqFsTp811UT+qqCnsJWd+gdhkSYnnolWrUBJ9LYmB
	/VeaUg0ASE0Ev8/o+eAih+4J26FPrmvB5aRUtXODVVaVEMBycgsLRz2SuuFnbJDZai9uas0hvwa
	kFQSJhFacyafL7K2k1k/nG0WT32nhmLqCqUWGYnLXTuj16DYWQ3vLPndxsf4WUySLAxHH3g==
X-Gm-Gg: AfdE7clTPzrVkcddenGm8XU3DzhXvbfOg7phamAIzZv+IVoTAgLWfQUta6xqV52mwlI
	swI1Ql2Q7hRFGNyiTw22tZ5SLQQD9q1466bDeKBJVfNR1SK6X+bUAfe5AjDMwHdQzfSJDxwmIkC
	Gi7PHSZTImEryQ5mn7eOmHokNNDp8+CsDmbyTr7BwA0lpo3jLyRttXH54THqMexZ1satijECglt
	A23hkto7uniKD/dQhDs9J0AhonlNQvR3V+pduv2uK6xd00WMek5xSMUZFO6BYAFd2MZa2YWHr+O
	owAe0jr/jEFemZKkPVcqmDNmbh78Ip4XBZI3QyA+WlbvfMzm2GwQca7p2/4zE83nd0ye9DhhiB5
	Cx3iDEzGuPL6fkYfXJxVXwyd6x2ld7j5NHR0=
X-Received: by 2002:a05:622a:4c0a:b0:51a:8c86:bd3f with SMTP id d75a77b69052e-51cbf2b2fe5mr26441281cf.60.1783776320674;
        Sat, 11 Jul 2026 06:25:20 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:51a:8c86:bd3f with SMTP id d75a77b69052e-51cbf2b2fe5mr26441061cf.60.1783776320284;
        Sat, 11 Jul 2026 06:25:20 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm67915265f8f.14.2026.07.11.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:25:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/5] soc: qcom: Kconfig improvements
Date: Sat, 11 Jul 2026 15:25:00 +0200
Message-Id: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0JmbUlbEFNX3MOwaEuBUaHSAaIh3
 N2CezeTvOT9NyuQC+gIrskKwS1I6IcI8pSA7fTQOoZ1ZJBcFjyXio3W94y8ZQ/rhwZbJowymaj
 VhUsNcfYKrsH3kbxVP6bZ3J2d9s5udEiTD5/j5yJ2709+EYyzQhl9zrnJGqdKT5SOs35Gs0/jg
 Wrbti8DWKFWyQAAAA==
X-Change-ID: 20260429-qcom-soc-kconfig-1b9b31d9702a
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8TSs9Nfkta2iamspr9QqU/RBcCfAwBGsHHf2WNxtx7E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqUkQvXwITdca0se8nnUoVzfWvtUvYU2JqV28F+
 Ah+iGiqiAOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCalJELwAKCRDBN2bmhouD
 12LrD/9Qeu56Tax+tHcvSdDvNkCO3jvyzqnfwDgEkBpej8cfWEplQ9pRvWkATnS1ILpvHa4gqFt
 u5MTCIyW+diVrVI61AC7p4Jt2wgMg6ASH6PmDHVYDgSVgWVvX07KkqXCejXMppy2MN2kEwJUEUZ
 3n+d2pRtjOyST53j0BvjKWp3XhlWQlRJurekbjD1UqKigAoJNRBT/rXt/RxMLy6QW8J0edXiDRr
 jhSDpnaC1wfNUHPUWgc0YNuMIGP3mrqgjaGeTxbLmnHOU4xt0eSN3dMlEgNXezsJ6bCczJUOvt8
 t5iLqXylVgOOrzs2um+dBLs/CQsk7gRfQm9o0lhd+Ls9EXaEsaUCmQQ6QBQuunyb1DuaNTUDr5p
 Mi3m+BlZMfJBJSLRSkxGoU7eTNFF5ES9ZqZgfLmLoyIz/ZSx0478kI59Cih6te1RGhkuU40sl9p
 sLGIpdl+/aWGl168La+vYg02yjfdl0IiT+Y/10l9zbD0QwuD2Ff4u64oOmGb4z2mezBRFjAzWyT
 WDL4DmsJlIE4H2IZi7v3JvFDHdURQYFKlFx9N0YWI287WjjLRnZ3hTDjMwv85/kqLHDJvlmryGw
 R2YOIyDKt+rpKbBT8yE26GwyuCeYTccqxJ/MpicHaAiADp3I/DKBd01dozX5OpNkP6VUkBJTBbI
 vNOD42zU6bxXESw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a524441 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jSXdrQWe9asa5pOIQp8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: b4SFcoIxuBANQxUgVFEy07MbHlO1HQuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfXwF1oROQVBiTU
 jqeZ+mxmqp2nByz1OYNvi02brTiIrW1kY/umsCmEWVk88v3xuJMBNMHIM+WVj8SHBBj2V5RQSm9
 s/g/+PQIXKrBxXDBqQtBbjebH3zkVMCd3NoDNjPgDmGWR5An33YCJ8+0e57oi7W9bNxDUXcxL/9
 RJHc3ndKfPSIx1qv+ZW34Dzn5oiNQ+dfXeUiRl9N4eGRuOG+BToncYgfrIXq+0J0QKjJBVf73wT
 udiyjSVmBPLAz92bKftMH1+xJiVJlBrT2uXYfjpuf0wv8jSferiG0QJDYf2cvKZ7pNrmWIHUmfn
 08Ea9nFYigEGooVYaCaYTb+QBMK7subUeaAhnZcSLPkpTix7D1tJyEB265704W5CLS+9YhzGiMY
 g4Xl+m2iKHHt0RsqZvBQJSPHoVLe3LOGNp37Rd6hl1uUdghCJlNPBtah2jc97VsTu+E84O1Il8N
 QGOmmm3WM21gw9Ob/Ew==
X-Proofpoint-GUID: b4SFcoIxuBANQxUgVFEy07MbHlO1HQuo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfX5aVGajLfL1yH
 HWVND5cgN61GtbBlbTj2b9UC3mg2hJh/OkAIQ9KAYzW7rsYwy7BjdD7QNx2Hx2QA7OjpamklUM1
 opV4+w9FltaOKxrOoO7wreEPYhRBFA0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607110132

Merging
=======
Defconfig change (last commit) depends on earlier changes, thus that
patch could wait a cycle.
Alternatively, everything through Qualcomm SoC tree, but then please
keep these on a dedicated branch in case defconfig has to be shared
with soc tree to avoid conflicts.

Changes in v2:
- Implement review - changes in individual patch changelogs
- Add tags
- New patch: soc: qcom: Avoid SCM and SPM for cpuidle drivers

Make important drivers default, so people will not have to choose
obvious things and few other re-organizations.

This matches my other work for Qualcomm drivers (clock, interconnect,
pinctrl).

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      soc: qcom: Hide all drivers behind selectable menu
      soc: qcom: Restrict drivers per ARM/ARM64
      soc: qcom: Make important drivers default
      soc: qcom: Avoid SCM and SPM for cpuidle drivers
      ARM: defconfig: qcom: Drop Qualcomm SoC drivers with defaults

 arch/arm/configs/multi_v7_defconfig |  11 ----
 arch/arm/configs/qcom_defconfig     |   7 ---
 arch/arm64/configs/defconfig        |  18 ------
 drivers/cpuidle/Kconfig.arm         |   4 +-
 drivers/soc/qcom/Kconfig            | 108 ++++++++++++++++++++++--------------
 5 files changed, 67 insertions(+), 81 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260429-qcom-soc-kconfig-1b9b31d9702a

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECD38E5C5
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996648; cv=none; b=YGlH5/4QeyWJUVYDwFjdjThtNW1mOfsCRPCDPtizOHq/qaEEQn/ErXeoIU1oIXOJ3E1radnJZi+U94slaSEZZkma+IxL5DW/gOtrOQ1GeXcSXE1fDbKlL+Pft9WwwkqiY8CuurzV/HwxMucNww9U6bVXfy0gak0bUKbpAmX/reY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996648; c=relaxed/simple;
	bh=6y/y+o4RlL4KAaVKm4DbvYmOZUkmbOZpf+COAG6J6qM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f/3XmpVX2dfj7cd2Hfj3vmCs2+RLTbSK8ti30kYvjRb5w9/rs9MzXiolq+aFwr078eQgdrZQxAaAXQAW0B521EkOSzNkm33Pvc6xXrlYKoysjY7uQcPpN+CoixDB8tsrU1WkcSgEfNai8Ynu9PPO+2qoCGpljm1YN+zDrtO7/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZqrWPjf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EkvjKYbR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZqrWPjf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EkvjKYbR"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rqVe2001516
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 09:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3iQhHYNcO6wxAKlVH8u/ni
	r3axKCEi6MPIMEH9l9Dbk=; b=cZqrWPjfbLBQgwJoh5jNLPbjc9J5RhTxu3ekU4
	LVGwIRsD6LNlmoFQxH0snzDdw6a7Y8vStRGsM/VW4BB6Ti21Y6CdlF7/Nzcd/fOC
	SpF6y4/XJmhszWHTg3B4B9WxdGUhvngW/3BAcU2phi5KAvl1SFTaykleBHyxGZ8a
	mkaozH1yEDRcH1Vk9rsBv+CZOJxe5qBCSFK/ZFW0Z9oLaD2UAtG08zqyoDGvaC6U
	p5BhevyhotWfHWlDiYSaPxA+56EH+K+fxubb3lp3LWEf6OECZq3Tlwk8C8I8syDd
	VYBlbnz5TSIM6NAAz8D7Z89qukR161WYl2ENjXBomnWkl50Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25rj2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 09:17:26 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-842308adb3bso7195785b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780996645; x=1781601445; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3iQhHYNcO6wxAKlVH8u/nir3axKCEi6MPIMEH9l9Dbk=;
        b=EkvjKYbRGf98BaL12FfqAk8WG94OGqRfsEzZH2RkHEiNjpdlStxeTbzwdFed9sYJ2d
         MsG7eyEeJ7m+Dci8ukzTTL4v6PV6pnZ/YszQ0bZojhOrDfSLkjSial1SJxrDwWOhH57x
         VC+3yp/erJBU5vf+AZESdoOd8X8/N88lfbLNhs5fHd0vBRRbqxzvkwR3uccKynLZwakR
         H7ft+BtYnVFQ0i7ujp+JSyLKONLVQPQb03gRTf4admuJi/Brwj0ZsHK1ixXBM/ZY/gG2
         6i1UKwUBFWJyDwmbm4cQc8VIevaJ8vz2kpn3X0Pmi6stAcnUL7ODWKB+bl2ML/ywPzdf
         7LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996645; x=1781601445;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iQhHYNcO6wxAKlVH8u/nir3axKCEi6MPIMEH9l9Dbk=;
        b=copQ34Ac2heYrKomsWb+nk9T5DvJy+Os4lA/UBtm6+iFN5DiGCZte8eF/13742P+OU
         sVDV8blrC60dHJINuj1lDOSAtGZtaS1mvmPT7K2ojxSad39Hq1FOVwJZW68pkkPeSu35
         0BgHYldTjMNUNFPbB1xRge21MTm/MRVWT9Rn9XNfYkin+MOsqklBBWGAyECzWf1R0ROw
         XHyay0c3Ju6f4wjFKfdgMjhNmNKMPiwTBOSQrctxzUtqxfPqoZwGwSV9LX2xj4DVGCvq
         VJlQzWoJ4eGCupqEmUQwsDEbhPJUgcZXtXs9lKo7Vs/FZ2Cg5UBO4gB2BJyWH1aNjCib
         3bmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ySkJpe4o3yz1T86lwjhY8n+DQ8imReAzm+l7buACH83UtuI2ehvCrn2xnHiVv7PJI+UIarYN4jw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8P50r2SCA5H5Tfo5CyOxsOvJ0TQSnnMXXcEae72pqEKENtKQx
	cAvLzHZARKj6MfwWwy+Or3sEaAnV5voaAaotMnU1PJ91VRuk+JE/W3L5zqF6wcBZ1kkkeu0xtSW
	mAcGhlAOPFVUHy/UXfqyDHGLuUvG02EFbsIYOD/1KB27+77V3J+3Fcm4OnXbfJQ==
X-Gm-Gg: Acq92OGkSvVxHuuqwhNh6gpzI8S/oZvRpu9szC0zPcZz5pLKLbm8buMW0QKq4GaJZ84
	TQYHWps8hpttWLg/YJoI1T0ZF70i+2zuzr5M/t56zPt5R8OJMVUXltY71gvtUSHB+ILI6AxVZ1r
	tPea1+hpnt2E8ueM/5sKIGanC3PR74DnRMxrfeOBKBd+MLjjZCedlt+OvXt2u4a8DI3f1gBBWVS
	s8U0Tfyh2A5TgAM+6kBVUnJhzOR3j8rEDlllyqp+L/Mna2CAXaFGItw6+fz5X57t3VB7n5gzrug
	mSiGq3T9/r6XYyYohdiJh0tTDiLwD3+0D7NBhNxpeG4vQbqHx+29t7W30kFq5rJcxj3G1PaLYqm
	ivijQ4j6Lq5KgsNMc+OS3BWySl0a5K92DfvoT5qrQZ6k4C463IUV2xIijxS9RtP8sVBRC
X-Received: by 2002:a05:6a00:21cf:b0:83a:3135:edbd with SMTP id d2e1a72fcca58-842b0e1e1f7mr20190692b3a.7.1780996645071;
        Tue, 09 Jun 2026 02:17:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:21cf:b0:83a:3135:edbd with SMTP id d2e1a72fcca58-842b0e1e1f7mr20190663b3a.7.1780996644550;
        Tue, 09 Jun 2026 02:17:24 -0700 (PDT)
Received: from hu-drajpura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fa877sm20974879b3a.51.2026.06.09.02.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:17:23 -0700 (PDT)
From: DhruvinRajpura <dhruvin.rajpura@oss.qualcomm.com>
Subject: [PATCH 0/2] power: supply: qcom_battmgr: Add thermal mitigation
 support
Date: Tue, 09 Jun 2026 14:46:41 +0530
Message-Id: <20260609-cooling_device_reg-v1-0-e15bddcb0086@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPnZJ2oC/yXMUQqDMBCE4avIPhtIBSX2KiIS1zGulKQktgji3
 Rvr4wcz/0EJUZDoWRwU8ZUkwWc8yoJ4sd5ByZRNla4a3ehWcQgv8W6Y8pgxRDhl0NZsYO1oNOX
 jO2KW/R/t+tvpM67g7SrRef4ACws31XYAAAA=
X-Change-ID: 20260609-cooling_device_reg-8e95c8eaab80
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dhruvin.rajpura@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
        jishnu.prakash@oss.qualcomm.com,
        Dhruvin Rajpura <drajpura@qti.qualcomm.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Umang Chheda <quic_uchheda@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780996639; l=1877;
 i=drajpura@qti.qualcomm.com; h=from:subject:message-id;
 bh=6y/y+o4RlL4KAaVKm4DbvYmOZUkmbOZpf+COAG6J6qM=;
 b=3so38CBnoTEALhZAdXlyV4TjVPIXrpgmHSEVdpIintZcdr4wttuQ/JNsNLTk38uQXwJdmXklG
 GVoXQRgHEVdApnoC9qqwjVQkBX82/NI4UqjaarOnEMbFBEjHUaVuwsn
X-Developer-Key: i=drajpura@qti.qualcomm.com; a=ed25519;
 pk=955XCRKkDWtR3Z/wycEd5zolAQt3Q1z7vODzFB/Wn1g=
X-Proofpoint-ORIG-GUID: s92pZDNEeTkkRr5Bf7b87k70ZEf2q2Bl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NSBTYWx0ZWRfX6ZLX5ElT+auJ
 xnI10FXSuvC6PS6k6I7m0NbxL7su4UCIl3tZ4R4hUiBUl7kODBnHp5G/yRzbRdix/9pmy6xgw2y
 ATGNU6Bu2EocKQHrZwCwSAT25tfbO3NMIgjcVdf26HZ7oOHFsI036CtLRkqs1mAlhLAcRvBK378
 XHH5X8OBjr5P0EtDISgubaAkwoarsRiYEjqoGj/uKWK+HRripcBmnpzGZeq1RjhPW/zfJiomldA
 Ex8QirmwTEEYlBtIzqfGftUS6fNzHN90mN8Snm44OE6PL9gUigcXwgEFlhbq17I4n5x0xFpIHDa
 ct1UZc5EXZH9mfuLrHa1C+pGHo1pHOO1LuM63kmWVn6K52VGnOqhQsPHE3mwC+ET+Qs7+vHNSkJ
 +QkRZ7qxfW2Ip84f4eYGXzN2WxSu3DnehrAq+ugQ5jE4l2TlFagkh2CBKAHP1fDVY1uoUVfWweq
 FwkGcc/oD4W5t9RrKMQ==
X-Proofpoint-GUID: s92pZDNEeTkkRr5Bf7b87k70ZEf2q2Bl
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27da26 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=t4I1CaprmQ1JAsFGgRUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090085

Commit c85c191694cb ("power: supply: remove faulty cooling logic")
removed automatic cooling device registration from the power supply
framework. As a result, drivers requiring thermal mitigation must now
explicitly register their own cooling devices with correct semantics.

This series adds thermal mitigation support to the Qualcomm PMIC GLink
battery manager driver by registering a thermal cooling device that
controls the battery fast charge current (FCC) in response to thermal
events. The cooling states map to discrete current limits defined in
the qcom,thermal-mitigation DT property, with state 0 representing the
hardware maximum current queried from firmware and each subsequent state
reducing the current to the next DT-defined value.

The series is structured as follows:

  - Patch 1 documents the new qcom,thermal-mitigation DT property in
    the qcom,pmic-glink.yaml binding file.

  - Patch 2 implements the thermal cooling device registration in the
    qcom_battmgr driver, including FCC control via firmware, PDR
    restart resilience, and power supply property exposure.

The implementation has been validated on a target where setting the
cooling state via sysfs correctly reduces the observed battery charging
current as expected.

Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
---
Dhruvin Rajpura (2):
      bindings: power: supply: qcom,pmic-glink: Document thermal-mitigation
      power: supply: qcom_battmgr: Add thermal mitigation support

 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |  10 +
 drivers/power/supply/qcom_battmgr.c                | 256 +++++++++++++++++++++
 2 files changed, 266 insertions(+)
---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260609-cooling_device_reg-8e95c8eaab80

Best regards,
--  
DhruvinRajpura <drajpura@qti.qualcomm.com>


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125A3AFCEB
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717094; cv=none; b=GL2LEplS2cT0XiQBuTb6R/MpnsPbJnXOECS5+I5trHnJpXTgkWPBsib5KO8SBMfkEWX/gXGgzFsJ0YcYYIwGa5946mBUBJTeEasY8Uu7LfaWbnSjXBrULyVKNW7CZyc0J1emu050vtK+eQ2tTijMdX7c6qqs37GNMgvWQxMdrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717094; c=relaxed/simple;
	bh=/hhzK5a/lIOKTiOtAp1IjbgyGrXH+zft7tpO5DhdPZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rvbS+vAKPn2hGo0ngmHy873gkZI72z83+ieA8y0qBpxxRTiBCW4kMtnNmgk2SCfOmUdjNDaXLb0o4EgVK0TLYsAPOLdegYEd/35EFQIobc+gp7GMjqFZcz4pG5ONNybK4wXVPMBJxI8PkFQL61HJEU3XolNl6daPjkE3Ajf3J8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JvO+2d+2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HMAxfAn9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvO+2d+2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMAxfAn9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8xIpH4018311
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TziaN4U3nrUm+NPafU8G8C
	93XGXYt0jtmEq2paxzJuk=; b=JvO+2d+26nKPRuzfFOIPM8lZELhNwYm4AYrExF
	Tc0HQuMEVfCLe7A13vYk9VciariP2hRr10e0ZP70EFY1iArRf7DA5GDjZHy1LWj/
	f4/a+qsTF5COq4cPsVh3dsv8NjNOlsPyhqyA2sxIRRVQdxt0ThV+xbUzLe/RVbTv
	i6k4RY+zUQy1V69h99EMKt4zk0YRIJFjOP6+Ndkn9OSqXSl5IJPzCCBlNFdYqCfr
	kJHFG6mPDYixZgT+qOoZw5paxlUdTqXk1Uj79zfUrfZpG1Sny4YrTL6ckAekJu1T
	aT+SNKNpGBgQhBrleRqmPdv3bFnlCi+Ko09Ct65jEIvKBEvw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6fumxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:44:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccafc5e82cso120800675ad.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784717092; x=1785321892; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TziaN4U3nrUm+NPafU8G8C93XGXYt0jtmEq2paxzJuk=;
        b=HMAxfAn92CuMUHLCO6sIU8cDqYecJZbabpK3sllny2xM8pIjxs8N0vPQOzPCfYB7+j
         5LiSUKWf6w6ciyODIj470+carYcvnL5pg7Aj52XfUVAdxClut2YYD+nsayc4sUHgT9nX
         j3TTyMZ7WwfjcabwcfxutvSgOuWi9sTGrX6Ba5lcCs/QzFhnP0ma1fwE0lz6pIPxkBKE
         c/MBJucJxsaR4Ewo0FVGbiPjiwsNorgsegprfR1iK637fBufVC80kLCvrIxBoFBG+/yJ
         eSYeAT3z6HPww6GxsHabV0lFfyj8/Ft/0q4ZCoLzAt8f6m0YTaKKIi0j41CIMAwShqz1
         RV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717092; x=1785321892;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TziaN4U3nrUm+NPafU8G8C93XGXYt0jtmEq2paxzJuk=;
        b=U5jYpqOpJQNkXTJ/A/zHMtmvgFYXr5YGe27uVjpc6mL1Uze2+CYCiBdQ9Ep35efXKe
         ANwklIL97lc/RQa7YmqoVYpT4qkFuXxOzrj/P5Coja7+Zz3Cj/Jak81WO/eJ8Wx+6fZx
         CTDvsmjzaIVEoAsrz9iHd31KizrWGYk6kuAGCIY17ctRykWfBcoaPmmJHBLp89b6KHan
         UIquA4LhWKZwvW3GA9uOEoD+iayqMRd2O7w6SPnef67/TufbkYQwrcerumkjBnhg1USE
         eFSaE78WCbpPNmPtjLCiVbV8/xpis9UPHzfEDlBgcM0p7kWz9MvEnT06hz046TI3SaWr
         Gb0w==
X-Forwarded-Encrypted: i=1; AHgh+Rpbw94sII6CxWMgfKLhZjNepJLlPP+ofEJbTaRBc7ozFw0DzJjUns98iBF/NxV5TyiqfTYfGIjKbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGF0CEbd9MT2XxZEsP7GGJG4whAX4oll1nMWAXkDmvxgjLmG65
	k9dio1ur0bGANVuC0fUTPn/N4Mi21Ih6auEsuDHhPZd7xNzggObtlaaZra3to2HjXVqbf+InBSw
	Dryh8hBYoeopLJDlCpRhVFa/tTkp9fywPpTwSFaZnaI47s3k+/e4eCiiYmjD2/g==
X-Gm-Gg: AR+sD12q+iPMnekm73zsGNKpSoWgkodgAGFbRplDe0l00984oQeWy6w2NTU1tPqIdsM
	eNg13uabwWHZfky8K91MVjQ8eEMQzrBRATlBdoQrTzOH6yOZXts1O6uYjygVi2TL1n/EbSptOPS
	f0DNUyo6vLcpX3qwB/NImyfCl2ERo4aNG10jivgCfRv0rBcyZRhmO/fGDdZDfxcCMJw48komfwE
	qNtc+vLI33yJDj52xIBOPZYiIA5y6uk+sktAxVX32FAic6ldsBQVU/w8FW9kcc0SkpWH6cU0bEc
	lCTqaCA0ragbXTWL5lwHk2QgwS0UAHYaA54wUHgEbq++B4dYMVb+zIXmHUgEqGZucFv0Yjc1tJr
	TiqN5b4IlPLsocR2CEf5x8kXEACK4WRm+
X-Received: by 2002:a17:903:234d:b0:2cc:f4d4:29a7 with SMTP id d9443c01a7336-2cf3499781cmr240607085ad.24.1784717091471;
        Wed, 22 Jul 2026 03:44:51 -0700 (PDT)
X-Received: by 2002:a17:903:234d:b0:2cc:f4d4:29a7 with SMTP id d9443c01a7336-2cf3499781cmr240606795ad.24.1784717091000;
        Wed, 22 Jul 2026 03:44:51 -0700 (PDT)
Received: from hu-sachgupt-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e797asm12382455ad.39.2026.07.22.03.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:44:50 -0700 (PDT)
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Subject: [PATCH v3 0/2] thermal: qcom: Add Qualcomm SPMI MBG thermal
 monitor support
Date: Wed, 22 Jul 2026 16:14:40 +0530
Message-Id: <20260722-spmi-mbg-driver-v3-0-ef73064f2789@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABifYGoC/3XNQQ7CIBQE0Ks0rKUBKhRdeQ/jAlpoMVIqtETT9
 O5CXbhQNz+ZZP6bBQTljQrgWCzAq2iCcUMK1a4ATS+GTkHTpgwIIgwxhGEYrYFWdrD1JioPKSd
 CSCoEEwykr9ErbR6beL68c5jlVTVTZnKjN2Fy/rlNRpx7//WIIYJyzw9EUipwrU8uhPI+i1vjr
 C3TAXkkkg9TI/bNkMRoziutcctrfPjBrOv6Ak0BfxAOAQAA
X-Change-ID: 20260601-spmi-mbg-driver-582aab5aa6a6
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, mfd@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Sachin Gupta <sachin.gupta@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: u3KiYaV7xthhG93KU1AxAgOqis6ODvRp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwMyBTYWx0ZWRfX6rBAlemMw9yv
 XVm8P6s6+qc1vhs3qw6m49fA3kO0H7mFH0TsHipKswFz+tcoCHCdbHUPTJBwepWW5Np6GtIi8Hg
 QB3/XykcaAdAb/ewCzizzKvUNkiPedw3UMa0TtABMKystzLb0BdZKf8VWqUVnG3SwtKW5wjUxBh
 NMVqrO5Pbs1CCMRkIUbKE2MIMUwrILzMTM4FMiMl6w3FC+BaX11z3u8iFRhjU7Zp5zhYy6hKKDU
 mjybPHPcuiHH0cFopJu2gexSjdCtNMqhmK+Fm+ZQ5ZXEUE6nhyHdwsKoz/kJU8/s/pjC58T69Nf
 vOalrhDojDqdqVxhBUbt5G1aY2SftI2twSbJYMMVDtL1XCwj2sP7ZnLtCc8QltMHNYA21Uk3luB
 15wvn1m0z7xnNtaL9GvIKWAwlEwclvtg34lgLaIU7013tXje7sgK8y0o4FGhoH75pf8ichbkKZP
 pAWZfsFtujytZE6KsnQ==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a609f24 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=iUTBZumk_BVKSr9I0GoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: u3KiYaV7xthhG93KU1AxAgOqis6ODvRp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwMyBTYWx0ZWRfX7ZLyiqGswCEV
 lQ4CTkS0T37wgkHs5dNj8Mtx33CfGKLzPbRxbHvXmuErktI5Eku2QrF6jmsT0iCnUr0b8hmh/a2
 i2zXaV2eRHVUoSYesZ36mJR9mcEHpxE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220103

This series adds support for Qualcomm MBG thermal monitoring.

Adding support for:
- DT bindings for the MBG thermal monitor peripheral on PM8775
- A new Qualcomm SPMI MBG thermal monitor driver under `drivers/thermal/qcom/`
 
The driver monitors die temperature alarms, handles the MBG interrupt on
upper-threshold violation, reads the fault status, and reports events to the
thermal framework.
 
RFC patch:
https://lore.kernel.org/all/qq3cggafexwpdrv46eqijxfmrdbqusl2vpbuswqmcvshqueaiw@r4mrmap4nwkt/

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
---
Changes in v3:
- Fix Kconfig description and update commit message. [Daniel] 
- Link to v2: https://patch.msgid.link/20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com

Changes in v2:
- Fix locking, -ERANGE, enum check, and flag race. [Sashiko AI]
- Rewrap commit text, rename binding file to match compatible. [Krzysztof] 
- Drop redundant comment, return -ERANGE, fix ISR locking. [Konrad]
- Link to v1: https://patch.msgid.link/20260601-spmi-mbg-driver-v1-0-b4892b55a17f@oss.qualcomm.com

---
Satya Priya Kakitapalli (2):
      dt-bindings: thermal: Add Qualcomm MBG thermal monitor support
      thermal: qcom: Add support for Qualcomm MBG thermal monitoring

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
 .../bindings/thermal/qcom,pm8775-mbg-tm.yaml       |  72 ++++++
 drivers/thermal/qcom/Kconfig                       |  14 ++
 drivers/thermal/qcom/Makefile                      |   1 +
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c            | 256 +++++++++++++++++++++
 5 files changed, 347 insertions(+)
---
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20260601-spmi-mbg-driver-582aab5aa6a6

Best regards,
--  
Sachin Gupta <sachin.gupta@oss.qualcomm.com>


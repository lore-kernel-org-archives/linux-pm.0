Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1637C923
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325730; cv=none; b=sKWT6B1LdT6iEsV3KK2U8P8gMDtknQ5aBN6Sul49lWRLBQ2APy7arpvnxy5pxV6L478QxD8fMENWr683s6KW3vl3TCFuXBf7jniKAnigR9CEWFoY8lOKtjBmLKiSA89q2bABoLtlxVR7jEV859qUA6PnHJyxnyQ9nKk6akDkIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325730; c=relaxed/simple;
	bh=RNJIaocZYsVAyi9K44GDvBfuC55YSi0vUGWPt8ppen0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nVByLR59u/bMUPgk7vVim2b6vVct20U7s9xsDBxl4IqNMwF+rkNyvVH2rjPe9/oKn3Ja/W3AKlx6ZmIED/hLU89k+orCR6eBgRF8wyskh84s9PFG9afrNCwgqWms9hibhPsVtk3e7R06eR0p8OFapUlcBmOwkr0G/uct7I+z8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ltw/ycGj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yy6f1VSe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ltw/ycGj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yy6f1VSe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641Shn3593985
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 08:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zNW0xFIonHoxP9CiO/pPyT
	lRjfRihWd8KfgBFkWrZRg=; b=ltw/ycGj6/CbJcfap2Pa9jgnEf8tKpeQszceMS
	8Yq7/66cRbtMtmoPCf0QVLA86NRLTWDwSkcqngPiyPTZvIpHdNp6ejdIiapX7QWq
	bkFEOg7bv1x+iKUwboXicsEOdFN8qrPvhhRu8m9hQBtk/tTcYn3VoEh1NBJpgn4f
	G6f5Egih+rokwp0pkPKORaxnJnB8OFqd9d4iD2RsfCgUlvg/Gl4oXIHlV/aOr904
	e2sr4WnoQ7MRW3d1GpFZF9Bq9gRJL2HveuDoWa6MhjpSvVjjzpDfJpPkzvzL5ORY
	W0iwFV6Hntk10fureFA0e5GXr2CIV00zK+leTSCRjT3mRKIw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgwj4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:15:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-847c3a12ce8so2858032b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783325716; x=1783930516; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNW0xFIonHoxP9CiO/pPyTlRjfRihWd8KfgBFkWrZRg=;
        b=Yy6f1VSebpJ4aUHkUGYAzjjQWOtQ1hCiPCYP2kvgrmXLjOhl6G1/1iK4U7WIixNr7c
         IMyhdVC/VbaKxFUu4r73eV6Vn0OmF9yaixaC7ajh9lBf9m2T8G1EvKXo1C4WFIAnQdW4
         Po3l9l8z7GAtIFlxOT/wfMzh4r2+f3pKFboFNaU/PHP3UpmcI8Q+mtN+kSFor4OlIQHW
         Z4mvLuIZ0WZ3kBGO1dxr1Wlp7uI+J3rePjeiNJ4aCywD5k14FARpnAkhwqfAuzAlXSTL
         lk5S/Y1Hc/k9mWj4XyhTNZfvLpvW1Mu1I2sE5akm0QTBkGolTCfndKjkxN4r5EgN9woW
         Vu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783325716; x=1783930516;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNW0xFIonHoxP9CiO/pPyTlRjfRihWd8KfgBFkWrZRg=;
        b=S7M7LhF2uA+++NYTN7fv0RQexWJ+4WPxPIqZYfRuMG0ZJbpQFNO2zcYtaCm7LJD1p3
         29ndx5/wIRRCaUiQ4wpGXlgrF1Ai+CMsN0vXiz943PZJ6kHXoPOtkBLcvRidykSp1aJa
         AeOcrkMHEVbMgckHia9XaSHsR4jFfayPhZrli5Ht6seXl8VteeRkr+Gs5fqs3nyGy2x8
         BCHSTiqcmHvpnsQ390CUuR8jqV14TNONvHfdoAX1pmUOpqp+Ek+CX16MA6XLX+m8BbQV
         pkkwW83VJ+72NtBI5ERN9ABgqGfeSLL5cTOhreKCdRbfD7yuN1AmWceQIf8F4KKS9JZU
         1DWA==
X-Forwarded-Encrypted: i=1; AHgh+RqOxh0py4/3+kM7WW81iSwnZsfQVvlY5ZoxfKLrl1JLBIHQ3I1/u+ppcMlLUXRyeImkJ6u7tnTIsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf4qrhnljV1l8rclNioHWoJAFBUB57N6L7ji+9/tAGbyAImBSD
	tOyZMlKJvETggrPOq+HtYa+gZvXnef32sqv9HComRrfGdKZWrlDGBDT8d792CmRFyYU7Gk/38lW
	22Oft70NgK8cAt/OiEjg9ThKLM7AjZ86wLEYNuHhDjKIWsoTVjNODcWS6/PfiLYAkdHYKEw==
X-Gm-Gg: AfdE7cl6MWxXe3Si4iBCvp9UU/nf52TwjzLi8aa1g8kx5IFpfr/CqXDtvIaC1zTXQyg
	tQnCq8cZNUHvRrcU+BkMwWOaHM1lQr6b9kSuzuDdor/p8juW8G1gvPzVh/E4xzJhVN6iOnfvqvg
	oypAICr45AxZYNr28jvMcSn/wyif82dbVR3Pq/H0Gkes9HRYNek9cFbUjT1hXQmK38ptOhYZXbD
	H36HfZd8ZLs0nKq+DuikIj63/TLXz097+6lFqtM0rXI2vXmIh3gsQQf5PjXynIhFyQN07gHkhi5
	8TRSxgkJM3cXSJf5J6mXFDYxb7hT9dqY0bWpW6V6WcPSjUkuPt1TFXqbex++CwzUxMOn3ZWf6E3
	VARaWFkzt7aB5hR1M23JcTL8nxFwL6UetMsqeALvlsKs=
X-Received: by 2002:a05:6a00:3686:b0:847:99a7:c751 with SMTP id d2e1a72fcca58-847f6dfde0bmr7953179b3a.25.1783325715841;
        Mon, 06 Jul 2026 01:15:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:3686:b0:847:99a7:c751 with SMTP id d2e1a72fcca58-847f6dfde0bmr7953100b3a.25.1783325714598;
        Mon, 06 Jul 2026 01:15:14 -0700 (PDT)
Received: from hu-sachgupt-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f4cd4b1sm5584525a12.12.2026.07.06.01.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:15:13 -0700 (PDT)
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Subject: [PATCH v2 0/2] thermal: qcom: Add Qualcomm SPMI MBG thermal
 monitor support
Date: Mon, 06 Jul 2026 13:44:34 +0530
Message-Id: <20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtjS2oC/3WNQQ6CMBREr0K6tqRtbEVX3sOw+IUC31iL/dBoC
 He34NrNJC+ZebMwchEdsUuxsOgSEoZnBnUoWDPAs3cc28xMCWWEEZLT6JF72/M2YnKR60oBWA1
 gwLC8GqPr8L0bb/WPabZ310ybZmsMSFOIn/0yya33354kF9weq7OyWoM8dddAVL5meDTB+zIHq
 9d1/QKKGIYcxwAAAA==
X-Change-ID: 20260601-spmi-mbg-driver-582aab5aa6a6
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Sachin Gupta <sachin.gupta@oss.qualcomm.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4b6414 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=iUTBZumk_BVKSr9I0GoA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2y5wP7E-f80e2corTaRj2M0W4hw3BKw5
X-Proofpoint-GUID: 2y5wP7E-f80e2corTaRj2M0W4hw3BKw5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX8aEpH5/yl43V
 c338Jd4/CLBgc4R+HBXLj/5CnsEKMy/CYsUyCtKO1iP3ZexacpK+iRfkPYlswwQY+v48seU9pIm
 +XixkelEhb5ZEzc12vUNvtw0eQ4AWUQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfXyV9C5fjIeAK9
 BNJARKXwtABWuNgoSi+VbC6dIjmI9eNEvXAYlyA73J7RI2tldeHI2b2NTUkmhTPkqxP7EYFYH4W
 XbxHTeGqtiOhWDL/e8Ikq4zPdsso6ZyczbQNoUbC1m41NCRNi11AXcYcpXfReotzjsi6FmoESiW
 h8Ea2J/9UUPdoMF8hsoQGiqicNJdJOeDYOuKUpda0w5e92OMfvkyHHORmaiinY8hmYW4TvYSvz6
 VXJco8dKVuCj5oVzD1n5z/F9Lq19oBcTFqgL2vnv2ifrl4EdYDv3M370IEZnKOhdUJYJ8NAjo9/
 IGtuz3UDcuUlIqxwyFhtrMiX3LHxQ1lOfyom57KFGgsnPTF0GvMc4q3Bgy9MMe0l3SRXzfD3UVF
 DF/MeFuBFLYc6WA0CAaNBhmUBgzeOUY9lG54KoHWtE78weJe9Wwa2VskgvsSjhXt+uF0tRtyJQG
 PFaIqx8nCB+PmfOp0Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060082

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
 drivers/thermal/qcom/Kconfig                       |  11 +
 drivers/thermal/qcom/Makefile                      |   1 +
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c            | 256 +++++++++++++++++++++
 5 files changed, 344 insertions(+)
---
base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
change-id: 20260601-spmi-mbg-driver-582aab5aa6a6

Best regards,
--  
Sachin Gupta <sachin.gupta@oss.qualcomm.com>


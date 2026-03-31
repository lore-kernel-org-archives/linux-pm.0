Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B54282F06
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917635; cv=none; b=mc6Icg2ZJYEx2Dc3zG0fpldVhXGYEzw4fJHqCbU4YLiqNrPvThnDX1RbVCUPS+grz7QpXKdWatlBo0USnrNLk50pRq6oUmsxf7d3DPCzl/CaF1R2HT5gfDoAcasgAFKrWEGrVyCdg2L62agNChGCEentU1MvJzPv9hHRrn4PQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917635; c=relaxed/simple;
	bh=LfqcOZfZvhcwZNbwczyCORllU/SVkunTmXAiwRXBkjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DJ2qZCKUVBOrT1ouiIoDddFf5U3qpgqPRCQemTX9chiOkQ+GN+dro2isAKEhzl6i0E/idp3D7zYZrfamJxlDdf+py/Nk9wCb1btotBqME14fNbXKcRgbw7m5Utc/DT2+997gZuOfdSEHFajfJoKJwo19d5I9uOn+aPOL/vgtmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O1ahBajX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ItTDOnko; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O1ahBajX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ItTDOnko"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UFN5iZ3173912
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yGlqzkun2mmYZWtqvl1ev6
	vbHU8gWKSr0vNUZcrj+RE=; b=O1ahBajXtfwbeABd4Ha9DEiNuVlD0+t1N7oWRn
	KlsZrp3Ohka/u6sprFpQGUavLFUBeG+t23lYkYtE4j+2ndyI74SoqkwxrzrFSlpW
	hH6GoAhVnlDmFKpPIxx2oZIjJZVRSrIFHcsnfzUS2HEob4Yr8sGS8a53J8k1qgXf
	0P6vYt+fTqdRgip++O1v5vPNuzj4NHNyViA2drXU1iY1mMhfgG7m7Qqwd3gFbLfQ
	9AttlE3wnM0grN1FPAVHLJMDT2BwJXyctxXVx1HK4LQiXumTQN7bh1YDWPCwXcpY
	2WWH+y8pUgjTAksJdod3FAIhgZ4c5fKCJcMmrP9ypw4KIQJQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h30bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:40:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c72849f648so2617092eec.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 17:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774917632; x=1775522432; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yGlqzkun2mmYZWtqvl1ev6vbHU8gWKSr0vNUZcrj+RE=;
        b=ItTDOnkoEXbTlLWxPaJpJLRDRRuw0AGSCcWCgu/CyziAzjNo9aX8vT0aa4N6ZmG2Cu
         L5ecyd0LwJUBXeDo0fwmp7LtHQs7CpiHXm11cy/MNMOzeNEI98gyJKZ8v3Aad0Tw84CF
         H1fcypQ4dGkIpvUnR5fr0JZTbe+4j4Nmoz/EiyehJKSGGUs8l82InOMCPur87BT2zZDR
         Cy/gG2la0F9m6Z3uunQ8uKAz2mP1qIPQJ8W/eq9F+Z91Bafu0vlpc/I23A0gRAd/gHY3
         d3WsBi9HrlQOUfTYVmnrCmnh0zuj+fD2pVWQkPEnOm8xhQVOPMtgZ3RzdGjMpZcLWiy0
         FLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774917632; x=1775522432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGlqzkun2mmYZWtqvl1ev6vbHU8gWKSr0vNUZcrj+RE=;
        b=qHnW1sN/auTi2n/wz2cD4dSzoTOaDqnL6IaRpTI9zPM4L2KiAxi0Mz4mnt1qM8B+LB
         WmqNwLRESkNDNRxoA3VNXaXfVAaZPqPXje0wKCfxy6q1IdYwxOQXUxBvkmJex10yzwyn
         FfeDOuQS1WnGXdp9qH3l45eCldsJHBB2VDicjCj7uvD+/IAh94OTpqAdkvhF9WgEhOR5
         Y3zsF99akprOr8PYEI5jxK6KAAvyfbkKCk6lwv4uZmp4O/GUiSI38Oi6Cnn8YpTlj3Cy
         /svgCr1jhxBZf9yB8hd8HkfZ3slOIzn9J/7kFY6mWKQoBxourmqB4LHSaB6SWFBvHwzJ
         wj0g==
X-Forwarded-Encrypted: i=1; AJvYcCVv96mCwr321GqVyzTjf67C34uYLbtjCvQQO1NogSyd0H11v7w2kgQh/Ja4sChKUOlcmT4ZfOntcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/Pa+/Qy+Hv20AV6IFN+vwwmDIN/1INj7ijtxYWScbY3XpKOW
	pqcpDXDlZSFSLu5/EosmOwpKXBqdCOn/SzwHM5xKm2aPl7ZC6To8S4sz7bBtCJNEttwXu8pWqUk
	ROco6tI76KxK+G3NB0JZimoLTUbvTzQJlMuZ/T4Tt9BYINavguQ2/+M5FokXJqw==
X-Gm-Gg: ATEYQzxAsg2JxsiC4qrskncxlOCPQfm+3TZCn4A64IxcchTH2u7DGb+xew6CumMxvdc
	OdOHBsndPhC5oP1NTFf/wYjbIC/Q1tpaObo3UsFmZQ3sWNua4IJpvwTk3iLuOB09dDJy0XfkJyt
	xzZx0ovGBMxA0eyrU94oUJD9obDisVwBOU5Z2vu6Ol3jESeY1n+t/MQZOfnYhZibe1iSnCPGLm2
	NmNHQn52ZHlM65cn5OeG1UlwWzNvsWgvqgm0bzeG3UYO2rS6fS9PGPIWuh/KfexwzoQ9/2gQdiD
	SjPfVIb7J8fVCUjyiAjzYO3r3LFfp7FI/D7BdfUGGMORG3pdhF7y3RyJqjI6JhJZXj//43YxIVe
	5sUKjwA7OwLCnxjRTcjIrMYmC5hn4oZ6aEmMPbTI6izNe7EYBbgmuMYs6zqVDlOP6e5fsUs7L09
	ow
X-Received: by 2002:a05:693c:3008:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2c185d0165dmr8811679eec.14.1774917631791;
        Mon, 30 Mar 2026 17:40:31 -0700 (PDT)
X-Received: by 2002:a05:693c:3008:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2c185d0165dmr8811667eec.14.1774917631217;
        Mon, 30 Mar 2026 17:40:31 -0700 (PDT)
Received: from hu-viveka-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c10361e7sm8959988eec.0.2026.03.30.17.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:40:30 -0700 (PDT)
From: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Subject: [PATCH 0/2] interconnect: qcom: Add support for upcoming Hawi SoC
Date: Mon, 30 Mar 2026 17:39:59 -0700
Message-Id: <20260330-icc-hawi-v1-0-4b54a9e7d38c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8Xy2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ND3czkZN2MxPJM3RSzlGRDM9M0C0tjUyWg8oKi1LTMCrBR0bG1tQB
 VxmfeWgAAAA==
X-Change-ID: 20260311-icc-hawi-d6dc165f8935
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774917630; l=904;
 i=vivek.aknurwar@oss.qualcomm.com; s=20260311; h=from:subject:message-id;
 bh=LfqcOZfZvhcwZNbwczyCORllU/SVkunTmXAiwRXBkjI=;
 b=MDpvj5aQAAeoHrotKVnzuHgYx7Ia2rbhJRMSzG9xSHXHql/O0gmqanoOu6XVPjU5Lp+2eQBVC
 4FHloYIuq0qB7LMlR+EFr1fJWJEiiESmmok2FiTJtemQdsIZP+IzEKj
X-Developer-Key: i=vivek.aknurwar@oss.qualcomm.com; a=ed25519;
 pk=WIVIbn3nJR9YRWNRyJiEbvpgoHhNyYrmVqMUXWqAIC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAwMyBTYWx0ZWRfXyD+GxodsLrfA
 qvbYyWGR5/fHX2TPpc9MQgZRHo5Nw7KcBfkUjlOVerdPm0xHI18o+F7V1zsoMBP5C/O9cpiM5Iv
 R6DMn/+TSzCydtTznd/BPu4Z5T42zbw8Vcd9Apqbd1MwvpHfqTjCSRx5u1wSETleSf5Q8xloF8A
 OmSd9ikNyUQl9610pqxlWmsOWceIih8YKnaWGVo3S8g6d6WPCVGn8YfmaDJ3jGut33t7KZbvSgk
 XBanV2DWGkJl8NgByzFm2YDKq+gXf2WrPGvoiXHEjzJzxJwCZxq5ZKK0i7zN8fG3QNm0qFsm+C2
 qtfrUJLHqGXL8q+GwIyi3WDZLjQxVJTA8e3+2uCyXQg52uxAVJQl3HS21rCfyPc+eCv4otLZdbW
 S3iCuoNE6uAaQ8s4k43wxQxtwwoCYkGRsQcw5sKxPfD5laXfYzr/AVp2AI2Xt1Vyd+1ts+DcFjW
 BUh28ay6yY4TP1NuqSg==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69cb1800 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=QtE5Bt5ectBoWJzr9z0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: OL9BdP3k32s2RGW6gIB9HVMOabloOYWe
X-Proofpoint-ORIG-GUID: OL9BdP3k32s2RGW6gIB9HVMOabloOYWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310003

Add interconnect bindings and RPMh-based interconnect
driver support for the upcoming Qualcomm Hawi SoC.

Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
---
Vivek Aknurwar (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Hawi SoC
      interconnect: qcom: add Hawi interconnect provider driver

 .../bindings/interconnect/qcom,hawi-rpmh.yaml      |  126 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/hawi.c                   | 2021 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,hawi-rpmh.h  |  164 ++
 5 files changed, 2322 insertions(+)
---
base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
change-id: 20260311-icc-hawi-d6dc165f8935

Best regards,
-- 
Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>


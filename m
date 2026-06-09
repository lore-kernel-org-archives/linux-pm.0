Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302D383C66
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988098; cv=none; b=Dg2eUp1+AhzQSJRQK9CUOMTcwzusCHxJ1rbkgFViJTRKbK0usvKpfH6nD9bt4DnZa6rUfyYbGZ/3bLZID5njj4ee0hpmkA0RIb1I97q7RZNA9C1mBm26rhv4PJ09Q9PWas9e9BaIZsmJYOvwxuVXYHRmoSmWiXd8EurSc7DmM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988098; c=relaxed/simple;
	bh=P0Rvy7ba8na9OOAKgVTrVcNkZDLvIMoxbJGmhR9MCic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kwt2LYGKXhaqM6NH8tyG5SwJg8d2msMDHhPFynitfJfGMzWznAe3SQAJU70lisjj1PhQI2vJkuTrzG0i5oIez2wSn+aw/bgAM0nxjPBxkis39Bv/HY1EoWlgEnZh2nX4/543MeYyuoW2hDUt52HkVvyyTtDgqzrg+REm2MGoOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cccoHyIf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Haesl7O2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cccoHyIf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Haesl7O2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6596HeHm1364864
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 06:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JjS4922Wi791YeO2uSYBt3QldN53otSS5AL
	ybDv890E=; b=cccoHyIf40ir2AIAkPBP0bGxzMWaLzlOWLrM9NlKUdgirVWi2q/
	yUbJyx7XIxoftX1VRtds7/JNL6Fjqvi8q/DBrWxSPRt72H2ep7y6pv5/shk4CbHC
	89SzIzxBIe5wQfrWW93p6yS0cksBeTwvDE3L/g22BC25St2PEl7FEmXTorqW93dR
	3Fe4ReUX0Gbf8id0yESlmFkYvJlgCwKitrjb4U8u2Kb7MjrShlfk+GOV22Il2JB+
	VLVABIbb7j86CNMo14BF3FC/u//sMdmYpKVIl0JqaycGMY2ydiQckktbieCFlm+P
	TlxUsSH0XpkxgU0H6u/ts149edNG48b+DxA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdeer51m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 06:54:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso9259324a91.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780988096; x=1781592896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjS4922Wi791YeO2uSYBt3QldN53otSS5ALybDv890E=;
        b=Haesl7O2JZa3JLOZxDrtQphnTYlb8Qs6wDjYSRiAcCGzSMK/B2YG+YL3iKT8p50IQH
         v7rfn/eJJ2sEv3bePZ+mJEVifzRPWR1jKKHcgXxt6ThNBhq2LJ/dxAIq1AQMTJZN1shD
         qT7GF/nkP0qv1m01oAPossJIlKlLMiJeE/xbOF1TF99RxPED9wakQwFPC3hcWIf+sVYu
         5JLMhY4eNXJ0GKPj2c6ehFrnUz56xYJ+degKmhSZE7Az+SY49PyPFgNAEuuMeUQVwGgR
         WPm/zG1FGD/zQlTq3U0xPBpOAXWJqnMHNv+epAhgVAvNNhYV6NVBnEtdVj4iDjS/QJBo
         YuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988096; x=1781592896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjS4922Wi791YeO2uSYBt3QldN53otSS5ALybDv890E=;
        b=G/HBdPnqzSxD8lMNuqP3w/B0YStGjH8F9YRP2AxGLnfaB/J7Cc9AbGWbAkqmJ9xjKd
         e9r6iIUcb4OqsWZXPiYuXkwIxAH5Q6U+80fwDe6rORsOTOKc+hQiTT9rGKBj9v1alrKd
         geaz34OZtuf7VFOCHTLpqn8/c0q8RJOazK8vKsIn/tNA9gh3E7EyF47cIKHOU2Ttn5+2
         tMa6FHbuU4hlyoSwMbOw8T9alpxauByqlapv+8uBmih+x2WZWHucWudGorR8+VBmzsC9
         zKSP48Elo/xOmi6bAspo8jIpN943VCKm0Wd+s49dKwtIVjcCnBxJvwnQql23kV4UhCpe
         /Ixg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZkbeW4Kf9FaRjgx5wvWBRk5fAHnzXE9sRRT+we5zMBYDvvRo5B+0YCGYUKDCGC5hi5OfoRYCe4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZB9Caei3WnxDvppZiCHBB4AcJ6cXlC7oMKQ3PYdVTrKSbqnAh
	XLyBJuYG51es5Yq2VOg01H/EfIV9vw3tzdSKdbN3IrjcYcw4/7l3nb8CyVLWWkCfcqJizuXXyxz
	0GbIpNzgvfcZ1Rb/5wiL/KpWCKIzNRnzp4lgr8heljXK6zeDwDRCE/bIWxCSMGQ==
X-Gm-Gg: Acq92OFADLC49lr+CCZWdV4QT/i09BS8ikckkx9I8mLwBEdIrvBqWE3lSgeuf1frDSB
	CWYFlhDGJVdKTY6bW2DCZ6iS0uJN6DYWq21tpbwHH9maDCWMqqU/BMPbk02v+W0Znoc5D+wqutG
	XF0ZPmirmZfJjZ2sAwpo9dcpQbuklImdDWn57wyLXv00iADDSSkP4LR+7ZgnEfXTnHZvUlbPUtr
	MBRGp7S6GtdDdjnF6KA+QPwYEuHBnRMVbHXY/BxWX7H4xDMRsJ8vd4xq6B84yzcB5UAESlXk/2K
	s66c3kKBCu/nJbkhem+BPWvvb4TzyugCXAhqs0kMbCC84w2mRHUnbgJc8zsaGIsYNbVMuQUOk8i
	NDRe7TndT7Dmc9UUU8AOuDW7yKfAZNPtcVcAv32ZrbqPwiMmszb1Lp0u3elF6+eicsRB+zyetKd
	Kt1S33dJxv0BXfURaf4kuaremG6GveEWKAVEuEr+dbc6Vyn2bfELeIKV/3lvzAUg==
X-Received: by 2002:a17:90b:5906:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-370ee344dc4mr19888007a91.3.1780988095709;
        Mon, 08 Jun 2026 23:54:55 -0700 (PDT)
X-Received: by 2002:a17:90b:5906:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-370ee344dc4mr19887989a91.3.1780988095328;
        Mon, 08 Jun 2026 23:54:55 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712fcb3a9fsm8607926a91.0.2026.06.08.23.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:54:54 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH PREVIEW v2 0/2] Add support tsens in ipq5210 & ipq9650
Date: Tue,  9 Jun 2026 12:24:45 +0530
Message-Id: <20260609065447.4024695-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H+DrBeYi c=1 sm=1 tr=0 ts=6a27b8c0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=O98__aPPj8GWcYWuEFUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2MyBTYWx0ZWRfX5jzGeaGNWNze
 vWaUMygEquWMPleQmgXugCVt51FFNpLkzmQEPckgivk9cePa/4+IYjqWWbEFqwksgzuLCKhFva3
 ykR88V8+evHWbLWr5mFVowQzzz5n0g5Zjyt6wVeiY7DWNkjjQGg9UgPqGt2xA8HZYwr2RAeZfaT
 gXhYB486D3xdO9eAI3KWuTZ7cbzNnx47+6dfHcn4ugOPfGOu/LpYwSUX7TYvVg8fxEz5cc84BjI
 j4uB/NWm0IFuVaxl84PqLEMB4MoajpqOdSdoaP6QxuoLwZKAfR4TgTQrB9ovLghaWor6YB/YdIZ
 jzqpj2E5RM1M5rtP8z5QAF+JFBJkgrxMnqMryzNcpkuUEUxhvp6YzdOZeIWbzrulqbhaPu1DVBR
 lge3VR0XEPxBXE7fShri65G+5EsQ5JTUT9i1DEkCKZpbzqJ+tgTsH9HtbC54qG5iXU/f+zY+5bU
 N/+Mgnns7Gszml7vRsQ==
X-Proofpoint-ORIG-GUID: Xuevr8SSiL26F7FReGMa0yy9dtuUkotE
X-Proofpoint-GUID: Xuevr8SSiL26F7FReGMa0yy9dtuUkotE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090063

ipq5210 and ipq9560 have the Qualcomm tsens-v2 IP. The tsens framework
in these two SoCs are similar to the one found in ipq5332. This series
adds the sensor data to the tsens-v2 driver.

v2: Combine bindings and driver patches
    Use fallback for ipq5210 and dropped the driver changes

v1: bindings - https://lore.kernel.org/linux-arm-msm/20260515-tsens-yaml-v1-1-8039c62cc249@oss.qualcomm.com/
    driver - https://lore.kernel.org/linux-arm-msm/20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com/

Varadarajan Narayanan (2):
  dt-bindings: thermal: tsens: add ipq5210 & ipq9650 compatible
  thermal/drivers/qcom/tsens: Add support for ipq9650 tsens

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 +++++++
 drivers/thermal/qcom/tsens-v2.c                           | 8 ++++++++
 drivers/thermal/qcom/tsens.c                              | 3 +++
 drivers/thermal/qcom/tsens.h                              | 2 +-
 4 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.34.1


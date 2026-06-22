Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3135BDC2
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110094; cv=none; b=VHRwamdsLz1a0FzXyikbOzclL+BOGZ6AISjmEpkHCouy0DoETEMhEe2qMP7H9SDxlK2dF4n4+brxhkUOp4u9/e3PiZlXdu3VUonCzbyxMiFJJ3EsfF4PW81JNYWCoD7ZesJQhEfFfU9jOvndhaZlnX9kxBqeVbdk3W/znlkQnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110094; c=relaxed/simple;
	bh=y2wQGhHfzqHJ8XiSXx6NumNVZHYZ5cj7ZzBR6/fGk4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sX7hKAQbMkZq4Oih/WQ/qYR2olWVfGFjSc5sSNAP9XeJVAlt/5tTS8L0DjCg6QRAfYdO8rc4WgQbfsBgJxBo46o8H35NOUO55EmrCEX2jHe6MbwersuXSt+EZ8NGC2fobeJDg92QPJPMyXP6t9N/z+E2qCRuNi6UtfTsvqXu70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iCXoXeLA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bvOdfpor; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iCXoXeLA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bvOdfpor"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M6Gls1095353
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2/zbJ7RlGGpzLIcbdISYH0
	4tzgGv8nCYhHdJBWBVGp0=; b=iCXoXeLAVipEeEmRkRlS8syMvhLY/AJADt5cKb
	riZMsjvLvjgEI8GF5tSaPVhgYeqx7NLLw2GH1tyXQaHaq4v9MFlzr2JN3uMySCLf
	9wp/ES/vlLlfSAwesU3zw9hCLvQwNstuHaLl0LRXLkBG91h52ojezasb3rYA4+WJ
	+3+bAvsqknYZsSiuOwq8gLznircQ717WrDY/EO1x/4jnFXlagI18wD5II7OeF2xN
	Mo7QSZKUkSUuPEsyjg7f4lX9YoLR2tmIVVxEAP6iziDnPHHjXnr2ninzY/9X3aLL
	GMZpvS7a08Zw0II/bkea/nPvZbl5GIcE+jDvTc85XxDL3hlA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1r1qs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:34:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37d378386d0so1738247a91.1
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782110091; x=1782714891; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2/zbJ7RlGGpzLIcbdISYH04tzgGv8nCYhHdJBWBVGp0=;
        b=bvOdfpordPQn9v7udEnTswtuqfPlZUBvvYAEDPZmhVpakiS1KFRir32VRQVvDH+SMI
         UCdLxiSqZQ+10AG+kFR0LndjzRDaU63MfWd+wI1HCkd4RWz23bse3InvzhykJ/FKukpv
         GWxtiqvvdOy/qdqZ5Oc+L9Y/BT3svbQsUolziR3oEoi3WZDnSQ/7FkZkh5C+wRC/luLL
         1l2oswRtCUMJnHUVqfZzVj7GFndmNSRZUPw1YX6tFtzYdTjX6++vpi9W9gJNMcAr2rXJ
         iXKWca4Ny4sFpor9tVBMlfBnkNCebXZ3YFNdB2AMt6aSCa4NbeDCU35rN7jhUX+37W5D
         TLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782110091; x=1782714891;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/zbJ7RlGGpzLIcbdISYH04tzgGv8nCYhHdJBWBVGp0=;
        b=TG8qp4dITRYCI1F3pNQXz1LFa8U7vlt54TnjIUjLWH9wKRuzK3TLzsP7h6yI4dgXMt
         fqNwU0zcb/vTZMQfOksRb74xRJPSrH6pe6ORgbmJCBcWMN5qhyzkSIhl/pJMSbKQ62Dh
         Ms3czRNff5LU00kkD/IusKSNhgYAG1BQVnD86ylDJdBWCmYvx2S1QE0ycHQ1PuDfn6DX
         ntGQKLCpBD9fRE4lEc2AxDQGXqxHV5lnM8554HzHN3vi2FbSLDScspwxk5lBNJfimxLC
         j99jPD/08OTaIZVcF34v89pHwBRBJtLUx8kU2+BrlhxbId9Kz9XZeyNCuVO+HiaywPyG
         28IA==
X-Forwarded-Encrypted: i=1; AHgh+RqhR9qRtIgfxQPsfI5HEByRlnSRvsQ88Eaftu8tExocGv+4sGjgRvTMTWF6O3g7fH8wABiyZrPH+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZjuHMB9qjyEjsNQGTULWonWrAxcLrwCOu99HYoVS35Qe9cF2
	0F+iGqOLUalQ3PQlQM4kuo44JdLAcT9h10mKv0YNJhJP0rmtQq6hmgzeuwHRmME6MkatbytZ4x2
	78A9NUf5kLTZZe6Z2GZwBoNnDAb+9HCnTXCrk58GdG4I/ymFoiNj3Y4O/Wckz3w==
X-Gm-Gg: AfdE7clwLsqdARDTVinICQztR6Rwp1LHmP+CtjMHB8l3j8fdCX8RJ9WdLvHLA0SO73X
	E9OjrUKAlbtdXbUtiTJ0a4AYNE/puXekYsxEmVQFUpP6r1DOWhVVRklqVcjZRS/4SuSFsPRbPYr
	D7rXO1ql0+2ZdiBps5Hmeml5BzvOhqfXAi2VBTg/u4oyyEdjC6bh7OZELHFAtfNKeA/icJ2P0n/
	Isqqkvl9CkRmH/fYUrHCmCDoqQShDQMUeL2RhjaMX/wZ6Zjvlyy3MFmaScckRqQp/9qRutkGBcl
	KbXI1cn0ULl/V5swbeyaLv1Z0bboz1KDxHN2SOYZVbCLKDXAI5rPIEAVCjunGrbuXUEjPuro+bD
	+D144MRbbQvkXK21HfpLCXtbiTlp11sXEhQ==
X-Received: by 2002:a17:90b:384f:b0:36b:877c:42e5 with SMTP id 98e67ed59e1d1-37d1a32ba39mr10978181a91.17.1782110091099;
        Sun, 21 Jun 2026 23:34:51 -0700 (PDT)
X-Received: by 2002:a17:90b:384f:b0:36b:877c:42e5 with SMTP id 98e67ed59e1d1-37d1a32ba39mr10978169a91.17.1782110090631;
        Sun, 21 Jun 2026 23:34:50 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc2c8de8bsm5928321a12.6.2026.06.21.23.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:34:50 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v2 0/2] interconnect: qcom: Add support for upcoming Maili
 SoC
Date: Mon, 22 Jun 2026 06:34:44 +0000
Message-Id: <20260622-maili_icc-v2-0-18b5ac08c04f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITXOGoC/22NQQ6CMBBFr0JmbUkZSUVX3sMQU8sgY4BqB4iGc
 HcLbt385CUv788gFJgETskMgSYW9n0E3CXgGtvfSXEVGVCj0QZRdZZbvrJz6phrnVU12rzaQ/S
 fgWp+b61L+WMZbw9ywxpYjYZl8OGznU3Z6v3rTpnSSltbYGHIHPLi7EXS12hb57sujQPlsixfK
 x3jPbsAAAA=
X-Change-ID: 20260622-maili_icc-94001df2a4d3
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: F11_f7bTRwpcm1DGesa1P2a5vY0paObu
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a38d78c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=e3PGyOgw--WO3KluFDwA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA2MiBTYWx0ZWRfX1aeCKLiPIj/+
 mMO9nusqZL0xMuUFaSMkX7W9q9tppn78mm/+4mkWqf8LQ4ngChHOKJ4Y4a5ciVbYGFKPqxafG6Z
 nlwpDXM7CSCG9NxTFGG2rnxFr9KN+ns=
X-Proofpoint-ORIG-GUID: F11_f7bTRwpcm1DGesa1P2a5vY0paObu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA2MiBTYWx0ZWRfXyYgD6/w+WsoG
 RnNkgp+aqLW079gsuLrepns9nis/CDj4NhW1J/hSBswnP9JA8m/zeEghh+IO7Jj/9cNbLUB6Ndv
 eHXciodganNdIRmkc3t95KTUvnkBLe3h2Cp+Q8mMTWr3Mf0Rbpw4sdIHDw8WfbB4xLzzkD84VN2
 x+3Wz1e1g7MqCmWXihJPb/hBCK47FoqvN8Unt/c4oWPiRHyfxFcqaYfAhxPOHm9mK0hC3CVxuMa
 j6a0IZo+Dt47Gsp62oF06/XTmej/Vz/L5RKTVHLsZvmtE75+WPTmshhwHDG7X0DqMVT6biFDc2X
 E1toolHFye9lvK/h0HwmjZfBfcMe4FLKAYkN1mkfXaIHJLDaQF8x48S+C5nB6p02vSf//7i/+Ms
 z9UHQKW1amoJIeNbg3rEZ2vVZASNclQ0xHHR+iaiiiULJOY5W56PpEKvHBtH26PRWz4ow2Nqpmd
 g9On03FAHFjaGINduug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220062

Add interconnect bindings and RPMh-based interconnect driver support for
the upcoming Qualcomm Maili SoC.

Device tree changes are not part of this series, they will be posted
separately.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
Changes in v2:
- Fix the incorrect endpoint ids in binding header. [Sashiko AI review]
- Link to v1: https://patch.msgid.link/20260622-maili_icc-v1-0-0aa8286e6748@oss.qualcomm.com

To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: qcom: document the RPMh Network-On-Chip interconnect in Maili SoC
      interconnect: qcom: add Maili interconnect provider driver

 .../bindings/interconnect/qcom,maili-rpmh.yaml     |  127 ++
 drivers/interconnect/qcom/Kconfig                  |   10 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/maili.c                  | 2091 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,maili-rpmh.h |  171 ++
 5 files changed, 2401 insertions(+)
---
base-commit: 3ce97bd3c4f18608335e709c24d6a40e7036cab8
change-id: 20260622-maili_icc-94001df2a4d3

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


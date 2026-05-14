Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA383C4165
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767551; cv=none; b=L3jWL14SBI+byN6jR4wkXuw3262Ry9ITvhvpgfefnfT0RT81u1BqOx/+RDRoY9wVphpAikIKjifcgYt9+Rc5covkLuRrZDoKs+C8v12VjV1O1AzuJ2O0ILvrDXgCXN82CIgDZ2jjmFvFyn7IoD3pc7G4ZDc2Ih7adydobhDZF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767551; c=relaxed/simple;
	bh=qPRFTDUweQw/Bg+8InHG5MGn1nxVYQBxlpc83Dm2Cfs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FHgGffosU4c0bPssOjbVAWOmUunaebMiO2Wsbc/bBHDxJgt42TFj1OjDKhjXHHy/H0G5WVOFwrdcqcp/LNm5SuCZsGDUtQMUy/cbgSKRUsBgaeCz9jIMg0Wcn/we9VUoa5PZVb+pCGVBOSRQu0PzV0u5zSpB6MSikt0mPfiHliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bVq4c02K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Obyr6l1A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bVq4c02K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Obyr6l1A"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeRbB2713164
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BtIyNwC7xLcnaPOBk5SgDr
	thyH8HcI8jJbORo7uZcKc=; b=bVq4c02KdHmZXwc40ECJ/PINw9I7M9YzeZwFh3
	lb5tNXe9XkcF9+YqfiaT5Duqpqk3gzhqxRapENKLh2Hdr0W82egOKI55PQZkokUN
	iXLlxJK6y2MKJKrsE+/xSd4BegGvIU5PxCYuSzNeK8Uo0npSti6X4vAj2liXzrW8
	dsq30wcYphXaWzWu4Dr7/txK5WFJ4INFFvhIv5Cx4rIo+BvyGRBmFkndrQkWcOJg
	71AOSs6zCneYD9rqmW0YP6pzge8sDqPay8JKZpLd6EmP9oOc9lHukK5yKRu2Kkt8
	THayFlaPmqSU7PBgLqbi/XxeFofDnXu5UBhTVrEKWOmomRHQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e58v89k4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:05:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-365ff2ab7beso9133967a91.1
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778767549; x=1779372349; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtIyNwC7xLcnaPOBk5SgDrthyH8HcI8jJbORo7uZcKc=;
        b=Obyr6l1AXAKxDWD4XslUG1mcs8nRYCVju8O5rCnJXtr2F7fb2VEmqEtyCzrJoS+5BR
         aI88woVD61fkLdzQXWasSBYAGP/x9Fjx3894FegZ+13Affhg3krLQ0CkRvCyExhGen/b
         OFoVzJIkrF+7gsds2W8/IK3gZdoZSJhErRI7go6pmxCSEio0w4/u1RWw239PwliJ9AgZ
         JzC2EMcMVxSRyR3SrGAeCi3ScY1/xDbuP7080+THXJgpDkiH7GxGN6hW9RmB1C8Fr/T4
         gxFpWNX8i3FVOwotSt/guVWwJGUhxT72nDLPR924AJ3eWMBpvIT4cLyxVjgkJNOk6BQ8
         Jeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767549; x=1779372349;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtIyNwC7xLcnaPOBk5SgDrthyH8HcI8jJbORo7uZcKc=;
        b=CrynLb0wsNuGhXv9SyzClOl0qqor2ML94azhXtKKVQ9fxyzIFOQJVKrIjfIxxbK0Xq
         fc3K+yfwNdWwB++P58vD5oeFKtp2VtxUw29ZMHvzNICGieC7OyTvy8OUcI3g2BUZP6KU
         0biwbjIUCuNm+BgK+BmGyc1gIZxecCdzOrMXf4DppyTS59CHqU6l9xEudni5T9Uoqssb
         LSnLLQ/zFpiqJfOViUfQaVIIu2GYZiNGu+bJjJXs/HmF3C47i6Hx1S6lHnUbRCmYdgFL
         RTp2QLwSMDfmvxGD2mSdW96s6MMl0eUJz5EwzC1O5K1L1gko+NpcCHw6grRjTSjRdGR8
         SGjA==
X-Forwarded-Encrypted: i=1; AFNElJ+LbRkArNvAPPpDMd+vwWWUH9R5z2rqAdXQ+BnKM/az9UGhZ4o5AwQzg1IOlb++Codazdyp00q5kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwtB2exNsIfrqLbhcnxgCrODdaDrXQokSRcMTDJniStZ4HEO/l
	qd2NWcurjpD3ir/OCIudoDidpK5z7T1V/PmM6HeyxXV3K/mA7VkTgpuPAePUy+fqh3Z7ZZXfjBk
	dkM4JppcI5VEPXuSvimCyapUt61uycKA6yXErSuaRVEcnBCOTqRmWpOEGN0A4
X-Gm-Gg: Acq92OFKmJhQGLkrQ76bqKYmzbcYrxKuQmK8Q1Y7sIYpREtaVXbiXoG8qimbT7iLfT9
	9JHSQzXW2eudrWgTstnBjM7kTCHZjTZPKvbN4DEuLIf/yoTGPu3KDDKH6+QCSWSOl377my84ilp
	OAu1BTueSVIpm4J8ib5+vkLy4saNEe0viH6m+98hF5qQsl3L66riuI0TBSZgTDkjUA0ulCjBzwR
	K2rsQkOIZhSis6V0U2Qml4bDE5HNmXLCJAkvsWEG5fTVr/js1ZAt/h1GwlSrej7Akf1NIGdaHBE
	cJZDl5VwL7MBKD1vrWS9MRr7FdWNviEvJgZWvq3tdY7Pn2WRX+m6lZab5NW1iQ0D96o62ncNprP
	GwtGqXLFvxi/+HgF6UVJ6aRvsPcFLpMOwmUH3iZGFBSMTStRahfU=
X-Received: by 2002:a17:90b:2e0d:b0:35f:c5b8:ef6d with SMTP id 98e67ed59e1d1-3692334308amr3271324a91.3.1778767549128;
        Thu, 14 May 2026 07:05:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0d:b0:35f:c5b8:ef6d with SMTP id 98e67ed59e1d1-3692334308amr3271290a91.3.1778767548611;
        Thu, 14 May 2026 07:05:48 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36928a8c1fbsm1502813a91.4.2026.05.14.07.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:05:47 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH v2 0/2] power: qcom,rpmpd: Add support for Shikra
Date: Thu, 14 May 2026 19:35:28 +0530
Message-Id: <20260514-add_rpmpd_shikra-v2-0-20bbd37592b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnWBWoC/32NWw6CMBREt0LutyWlPIp+uQ9DSOlDbrQUe5VoC
 Hu3sgB/JjmTzJkVyEa0BKdshWgXJAxTAnHIQI9qulqGJjEILhpeiSNTxvRx9rPpacRbVMzVspX
 lIJySGtJsjtbhe1deusQj0jPEz/6wFL/2j2wpGGfODEq0dVOVLT8HovzxUncdvM9TQLdt2xc4b
 IO9twAAAA==
X-Change-ID: 20260429-add_rpmpd_shikra-f57873b2fa7c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778767543; l=849;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=qPRFTDUweQw/Bg+8InHG5MGn1nxVYQBxlpc83Dm2Cfs=;
 b=rg3xr0ohd2vem6pj2pDY+nv1sNQEh/qvsW54j1vfShDLO4HtwLzwGvldsCgQZR4I3WqyzPpfd
 3+fFo9+zIHeCTxJB7FRZXEoJJwZFykABujLnzUpzZYFrIcMUb+DaZCs
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MiBTYWx0ZWRfX6In6uPxoxVPw
 785tvClkUvHlEA0zOrN/qZ+RLoApj21+WWKOH7N8bSsWhGJrnae2d2PZR4cajNsUE/MaH/hXRoo
 7vXjZN0SYNuTtY5veenJm26bj52mj9471J0kGncOlt+qd4E2Ulm8UbJlpLG171YxqFb8rAoLgtG
 DQDgdRzYzThKHSMqhN0bE7QGyX54IS+hYNBKC+Yxgsem+SmhUdQ6jBDX6LiH8nNg19i1efD5vbX
 PLGhEQyhJLknfzE/+G5ffrA01CyPnDXFzy/a2wIQWtq72iWwBZZBXbnnSJ0p9FFGNu32dXAdeaG
 rnrnI20gW/lq1acSHuAg6CygTEbW5yd8Tsd/O6/DzCOGl1rKufUSKamfMDJcBqSInK8186wSer+
 d60ZjB/zvtFlsgNCqxMSzNjh8xtgVsKNY37TXsn3RyxSDlvTTuBlc773A1eszAjsCRTBdGp5qxZ
 5OnNdbM2p+RxAZAG46w==
X-Proofpoint-GUID: IYO9JpxcHD2NZsAA0_8a4aM2J2LTDfRd
X-Authority-Analysis: v=2.4 cv=YZSNIQRf c=1 sm=1 tr=0 ts=6a05d6bd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w8gYdMrFLoSuhkYnXDgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: IYO9JpxcHD2NZsAA0_8a4aM2J2LTDfRd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140142

Add rpmpd support for shikra Platform including RPM power domains.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v2:
- Collected Reviewed-by tags.
- reused SM6125 power domains as suggested by Konrad Dybcio.
- Link to v1: https://lore.kernel.org/r/20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com

---
Rakesh Kota (2):
      dt-bindings: power: qcom,rpmpd: document the Shikra RPM Power Domains
      soc: qcom: rpmpd: Add Shikra RPM Power Domains

 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 drivers/pmdomain/qcom/rpmpd.c                           | 7 +++++++
 2 files changed, 8 insertions(+)
---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260429-add_rpmpd_shikra-f57873b2fa7c

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4C4418CB
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131939; cv=none; b=V1Fz92cntjHR9Smh6Qpxm/AyDw2izvF1MtED6LgtE1XNlbk0EZiKH8N7/dyrQsOMYUlLP1O44DotchhVLUY7uojZivmrOYSvtOZ7Hv0pGcTRE0Xlv/Ev6Wd3nxUTCHNqb0uAY9fhc7Th6dwdCPqOtGE6v/3MNVyeqNBjL97uStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131939; c=relaxed/simple;
	bh=Dny+RyY3KCk6QKMt3V0eqBv+pyXgn2zC1F6QFIIgFCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/xt12B3ReadD7ZHpaDI/wKDVwFB1SgYYH9PujhOPBpn33yfdE6jZ/Xzt7uoQYzK/6ZdDYEB4Nnn9QHYXmKHEhdLhRxpfFlf9ssCbxP863uywcgmvkW8eCEVUlBYtDcXMknBI3zEicGb6QQJEBzaFtNsTmhBLK67nVsQuqBwi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/YMjsTy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KvOlxFwa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/YMjsTy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KvOlxFwa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6ZI9t4012752
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QEG01RTtqXCwd0jf8aNVkVVQzTpHS4N2f1Y
	pFitP50g=; b=O/YMjsTymSto4WIklKqrPyoxllrtwSFJpY7EiG8Wkvv2WAwfC8p
	3AoGE8faUDRF1kcKcxbF7AKI/nxJinPC5sIAUhDERsxA0urFLWF/Yi0S6mp+a8WO
	jZGWzyJj61A0pAeDkwhuTbRBwzo0RjD3nK9NxKHQvLC5nTZ2AVo+uBF471hcFQ4S
	9joyt8s3evsCX0l+GQx0OKYwXQMcsmVMm3kr5/NelurBQj9JUk1QYyxGhLtTN+Xa
	lrO0yZK4GIrMwF47GV7PKOlP8q/ZRGh+mHIMwxYEBepbI7difInlxJrDjt2qNsRx
	ux/pdR+xxkS2SHPA/uS9wFyb3nDUfzwoIjg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmaecq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:32:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c01ff996dso9147311cf.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787131936; x=1787736736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEG01RTtqXCwd0jf8aNVkVVQzTpHS4N2f1YpFitP50g=;
        b=KvOlxFwa4Vh0WZdL48PW5QHzwsb6+5AjnbtKH7AOvB6Ockdwsvk3ZpBSK48IxqDJGZ
         wTigjW6JWvX1/8iYs6zST6Vil0G5Ba2K+1g/AVV/pwm2Jpa2M+mJcKc/A8ie/Y++31AL
         5NNM1j5EQFXbF7dxbTeqq359r2nMrxnv+yIFn1Xy7+s8NbxJe0MjIrQTykIJF5ZCudMY
         SlzjZ5a2u7ik0/0UJMdQpDKv99q+KE6aiukp0wGJPO3MXWlOdSbhx8yUk7N5ri+jLwD/
         6XtBpVyyPVod+1ogd/Qv7vujyn1AxNI76uy10v+aLe/kWm8UWl23JuNeg6UHyl3OGUPj
         S7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787131936; x=1787736736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEG01RTtqXCwd0jf8aNVkVVQzTpHS4N2f1YpFitP50g=;
        b=H+p6Tdi9GEzhtFNx55r1NktI8JOR4GJVMZ/eh0omkfwYRVnVPkH/rviYEVafjTup8b
         +sx/sTzQ0v/O7A9VkwjsMAqlmY+zsnbC+WSRURVFvtGGlYc42Lf1D20yCCoyD3c/wv03
         6IciTXCSCTBLvsk+Jryb9UaujuR80uv7nANyaIoSo4KQ5VSLHU/j1btXvA2eNpDy4Nmf
         XQgOYwInyfjZSwcP/BGmhJJle/cpLjezRiKt8R1bjjxqGkjOG0sI72cXFPlaZp5mh9hK
         7veM8FcDL8wuUn3rlikdMKamouAHEk23iWqRI4Hkbb7TsUerTveQKApkhcHBCHiOoIlm
         IAPA==
X-Forwarded-Encrypted: i=1; AHgh+RqnF2XkKrNtzcQnPaOUjcV9WwzGs8MEq9XDE65cqxcUSkzDpXsTtg5Mc045EPkftb669Vd0wiNVow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzscSWZCHW/X2cuOeRpL/tfz5343QSjLHzjQ1o1V6qTFJs2Tz87
	QnIHswgpEa0DRmTydxfKVwaG97uDnfhozL/NfYlRy6QknKJcMUBNpStziPrdYyQzFWeGATXQXVW
	UZIyeFiEfXat1EzogkpswGrBr+HC8YmijRSRxIgFE0CiejI/XTizzUVH9GNqKQj8arj6/uMzr
X-Gm-Gg: AR+sD12rFRuTr5bCCLRad//aod1BxLod8LvutItzAVHHYFKz7ktn2UPEJTwFLhSZxDC
	S+vmP8gmczOIMigLEF58F433W+k7gz5tVXVAl5oAgvChJnX+WIqV5nLmWIHWiOmTOMmzzK6BdBM
	v/etnR2Arr6O8j5yo5n1h0D/1cFMX/mUz6zzTeuMmBZM5KkUL/MVF1HgEDNwwzw/RNp1PGQUIKT
	j4pgX6Px0He6fe5hW5TJt55tBhHZP3NapRPsZ8B0OfOlnJguga5V+R14Rb6NYt0I/BdK+4NwSE+
	8DkrcicFp1/0xFb6sL2y0ZCnI3GXYxW47txCJREJhoFK/5ZGUnvCnL0qfKSBsPAqIX5l0VNHG0C
	z0xaxauCdtxwcBj3U6+t8LqyH
X-Received: by 2002:a05:622a:309:b0:52d:6afd:7d9c with SMTP id d75a77b69052e-52dd5c7ffa0mr28372161cf.29.1787131936178;
        Wed, 19 Aug 2026 02:32:16 -0700 (PDT)
X-Received: by 2002:a05:622a:309:b0:52d:6afd:7d9c with SMTP id d75a77b69052e-52dd5c7ffa0mr28371651cf.29.1787131935691;
        Wed, 19 Aug 2026 02:32:15 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8050sm4402835f8f.19.2026.08.19.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 02:32:15 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add Qualcomm CAMNOC ICC provider
Date: Wed, 19 Aug 2026 12:32:08 +0300
Message-Id: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C_AYg0NY5VswHXCIVkfcUaebjeTtUEzA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX3pIGz2zi3hoM
 9jkYDNSd9Gdoe2eInqCl0aWb2eSVq6cYaiCiIdpipNsAyYTlWoPkEaqbzFjAvUjyo42Gf9rT/gS
 yhjEDU7HOFD2NHOaUCAsOuio5cXDRoc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX3HiWzdHKBlwX
 GczOuwloDlpVq+VEvD/L1K0wsTD9ULm9wcmu5lxnM2ETmloZSeCXnSAVSuBUD297uPJf8DvsB9I
 Bk0oCxhImIP5YOh+sOr368Za5Ia6PMFS/vBX4fBCj3skpJhkZ4DJevzzJtVFNdz8tKuyU9Qa2ei
 1+vnDrU1NW0ufwrNiRuaihdO+wdufuseZTG3Apr7+POLtn7JaMk4NnNSYOptV6Rcn0bBGnaAaey
 nsdGcmuCPCLKfyRKBpFdZkCfk4qEuxtIsHU5CdbgrFBzC+jYPS0ZGlUus7MeN7gPzVHJAqQHJeS
 AFYiCRIZNprx4LdmnH/i8yOyz7Ch8w+LibQ+zUDGZ3lT5v9zvmQX/eh9Q7tsdnN/g6AGL2LMtte
 73BsVgKVlXEZNx2VyDX58GsRt2XhJGH4sabNV/PuFwVcvpnNEz9x4ntwPxugdf7orEp5PsNkm21
 t49gPYohKG/9MyIotZA==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a857820 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=hRO0oj0PTDvf3us77KIA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: C_AYg0NY5VswHXCIVkfcUaebjeTtUEzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190072

This series adds a device tree binding and driver for the Qualcomm
Camera Network-on-Chip (CAMNOC) interconnect provider for SM8250.

CAMNOC is the internal AXI interconnect within the camera subsystem.
Multiple camera sub-devices (IFE, JPEG, BPS, IPE, etc.) share
CAM_CC_CAMNOC_AXI_CLK. Direct clk_set_rate() calls from each consumer
cause a last-writer-wins race. This series introduces a lightweight ICC
provider that aggregates bandwidth votes from all consumers and applies
a single clk_set_rate() call.

Changes since v1:
- dt-bindings: add all SM8250 CAMNOC master port IDs to qcom,camnoc.h
  (IFE 0/1, IFE Lite 0-4, BPS, IPE 0/1, JPEG, JPEG DMA, CDM, FD, SBI,
  ICP) with a short comment per group (Dmitry Baryshkov)
- dt-bindings: add IFE simple consumer example alongside the JPEG
  OPP-based example; clarify opp-hz and opp-peak-kBps semantics in
  comments; fix maintainer email; align provider node name with DTS
- driver: register all SM8250 CAMNOC master nodes

Atanas Filipov (3):
  dt-bindings: interconnect: Add Qualcomm CAMNOC ICC binding
  interconnect: qcom: Add CAMNOC interconnect provider driver
  arm64: dts: qcom: sm8250: Add CAMNOC ICC provider node

 .../bindings/interconnect/qcom,camnoc.yaml    | 124 ++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   8 +
 drivers/interconnect/qcom/Kconfig             |  10 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/qcom-camnoc.c       | 279 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,camnoc.h    |  52 ++++
 6 files changed, 475 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
 create mode 100644 drivers/interconnect/qcom/qcom-camnoc.c
 create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h


base-commit: 9e970952a9503d6ab471a2fea4c10b6a2785406f
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453013;
	b=3R4Di0y4NMBKcf1/oIP+aNSW03SS/AJxS4RZdtfmlcFv/yrSJ96os1jO1fPFE2lsFgAv
	 QY6byhv1CPoN7weHyoz/8zCTVQ6BH+2cyBuLMog/zvHHsYVgJUKF5vrwjqCs92cTuTzW0
	 LDmy+7Br97dILcRx0P89O+hwc+zGF7NzZ9/gVWXXd5r9bt8IqN0jZZY4zKLeeNtdVx6Gd
	 FpMgtu64Khehoe4c1dHM3o/zSE+3ehH8opNQ5+zOOPYMhjxYNP7HrE4iULiYYzWyQdoip
	 S89KgEsA9/UGvEPujmaKbEHhRvKfD8Cr18+yOrtN3t9IaV2zJAOBV/0UWt4zNZNsywA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453013;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4JcE/VNendmPfJ887BCBrP94/QxycFFpBFFllayWf30=;
	b=YwMqmwPWOyF2rEIRoVDgAmAnmrccg1HI8EJDYXqGdJrufO2DNx5KNmixGya7mxD/kKdr
	 oDrv76ef9I58ULPnAPdKx1QKKZzen1GUiG6o8I9t/KmZAl6qhoD21TcBnvWJzu36rjGg0
	 xYda9wyQ8nEoYZLvoM9F0QEO1FHLRbK3QppYZJ52WotEhEBbtXnq4Ozt43LSXFwp4Nf1T
	 z9enkVEfgNRAyJpEwQqIkQC1zQUGbR6rwMkc59JBAyqG1+iY0Ais1m0/2s5aXTGKe80KS
	 GVwylR4uvCSzlCM6Ju3JXWTLhwif/fWN9pcApHuTYqDnIq9WQ6pr8ukkjtv96EtJ3aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c2rYv4TF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="cfWAd/M9";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31813606A31A
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31813606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c2rYv4TF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cfWAd/M9
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VD04gN3208637
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4JcE/VNendmPfJ887BCBrP94/QxycFFpBFFllayWf30=; b=c2rYv4TFvpuDjNPm
	KvBMRy+iSTWSiOtIftr04F/V9HhCFxI/wLZ5yRWabtjLd9wLXBAl/7Vc3rZn5zCX
	jXXIvXn/t84nHzBCkyF8HgPNwXnG/Y7eJENNVAs5rwB56+KB4t0xPNB/o11hxQYN
	Oh12Y0z8QJTPo6xKslvcRtLnOJEo+7Bg20vPDnHegfJ5pF+9FSelZliEdrQc3x7L
	bDNLoD0keSOm77meQ5U/l0vdLdSZTm+Yfz1yXmOy6/vcitj6cwse7bR4yP94pwGL
	9u114U59lxpImBxyx/ZkVU0pQhl+OQBFvSfcnNG+L5U47rIkyDvu+aO6N6WVVrjv
	32whcQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79rsapq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3045780eec.0
        for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793453012; x=1794057812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4JcE/VNendmPfJ887BCBrP94/QxycFFpBFFllayWf30=;
        b=cfWAd/M9XiKmc0YsI0jZKS+fXOdzXm40BCLWHLhBivjVDra++ShmAjQcCr7slyqC12
         +7slbV3+R8iKXAtcCOvUyEJsgM62mwScqK/iHHtHksH5fONQvEwAIfhZD9uiqoYYFYrs
         xoIjQHA56kH1xiQuraYyXLSdiabtBpLBoRHHruceEdQGH2FrsrKSfaaPDUjpoiwiaUTH
         91PGt+OF6JWMHQ24+FLdOjQi6xDaYNj5Y4WKn7YThB+0ZsPIsTp+5di7pyzanIFvB40H
         1GsLG7NJL+3puyzwmkfIbrbhwv2CHFGCw/t4H7WZt4IYA9+AHvlJc7oZ12BoIUF5l21S
         OKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453012; x=1794057812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JcE/VNendmPfJ887BCBrP94/QxycFFpBFFllayWf30=;
        b=yXdiE5YCdWYvmW2Wcz9r91cVEjbrA6isiNg5FtlMVeZuESdrH3oyj4dSADwUgqIcpL
         dWVQpupuGw/d2tnBul5EDN/9OKu0/OkoGlCkBkf8kFAaBkIyCnlpYO0ja7MdlMc3k5O5
         xvUu3m26HIES+mP+genwYCoUBRolu3xneh+7TM2ffzhltbMYqJT3IZeUyzj5E5n4j80u
         +KK8DNvPG9BHg1oany98WhkYDMt+2ZedxR53LI+Kz4RqMNDC+bUwjuVSp6WQ4Poaqa8P
         Ux+w5pgj8f/kborod8Kr+aNvse2+Lz3iyN0PllU8COBrIC3Wfv6b99+u08ylwW503eNm
         LpOg==
X-Gm-Message-State: AFq9FYL0+1BS1foIrj4XuxQKAZpkqjm5sKuBay/Jzrz3gqTcIot8pyTQ
	e5aM2rELszYtfUGA+VXWRp0LN0qqcCjLz0t0onQ1NcHdEjT8YZEzq4ZoYc+y0aPpY3JFSGB2f7Y
	L1yly2DZEBoLtjZDjEuKcSKNQtetyBqilQCOg9Yjj/eSurD2881BjqfOAI/rGNA==
X-Gm-Gg: AYBFou3HgunUmqLd8C84Rw1d0CIwdX7fBHqTTHHC4a6ja8RxMYUthjPyb/WYf/S3UBU
	I2aJ31VcJNtrX7rSlArp3A9pDe3cODOd4YKZukLEd4Jzuj7gvFqLRsvYiooOcgo34Tm9WfsKQj6
	UTIax0i21I2610aPmbgcWUbX30JEOYftNPeblZNWU6eVimB8/kPQcwPm+maDtq1WYKxNhCUMGfX
	3WSuKtrXJbOuqwA/b6RRuXAaW2bNSC14AtSEDUANDPlLePPJRgEkqDE+1QYLxY2L2HIoWVpdO9/
	wu1VTv+gk/Hls6bNECZ2KsAAWlcqLXH7IN7Cs1xQxmq2jEKRqx36Tui9EJTXwur42fc3Uj6+BQt
	9lbYHBUcnPblaBf92396vIhbfajxs9gNBy3HfuXAXKp5U7JjUiLK3TWUAfNrCmCVHtgSEzezBNe
	MLJoc=
X-Received: by 2002:a05:7023:a42:b0:151:ece6:b16b with SMTP id a92af1059eb24-1ac5da755bdmr6447677c88.7.1793453011909;
        Sat, 31 Oct 2026 06:23:31 -0700 (PDT)
X-Received: by 2002:a05:7023:a42:b0:151:ece6:b16b with SMTP id a92af1059eb24-1ac5da755bdmr6447639c88.7.1793453011363;
        Sat, 31 Oct 2026 06:23:31 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm18234699c88.11.2026.10.31.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 06:23:31 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 18:52:49 +0530
Subject: [PATCH v2 3/6] dt-bindings: thermal: qcom-tsens: document qcm6490
 tsens
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-thermal_bin-v2-3-d76fd073ae98@oss.qualcomm.com>
References: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
In-Reply-To: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793452983; l=1770;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=TcfZeA/waj0J1JOXR5aaLYuqHVj1MdThFVHzlUlOpuM=;
 b=3Y/Y8DbkZHHp3RmsPF7huUN5sZdXxDlrfYSb4AnGAX7ah8k0vgRRAhqdE3cqbDQfR5sGu2+PZ
 7TYJIsaVQ5PBy0wh7txpYwXCTPVpNpEBj0EUwzhS/kiaSbYPtHjVPLc
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-ORIG-GUID: ZLB8jzsjEcgU00QzDJjrHjV0oR-drRUK
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae5ebd4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VzBDfsQTI6wPN1YFWBEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA1MyBTYWx0ZWRfX2ZBqGnHLlzzK
 65nPvz2i/BxKCAhEZ/+3S4R5laOd9WL360l+EQ28Ib5GTHY3dHU5IbT+SPAyhyXDlrahGwKChBe
 mFpTQIJIFI3B1IEj4MS0U1HWRuLZT1M=
X-Proofpoint-GUID: ZLB8jzsjEcgU00QzDJjrHjV0oR-drRUK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA1MyBTYWx0ZWRfX6Is9w+PWfx9A
 RHC9/RoaGeVqcG76aajW/sq1805eOmR5C38FaW4gMCETHT/BE6ecz+mB8anz0nVoV1auPp+na/i
 P9H+6AvwFty2OC3S48Wgtpl8thwK41GBw9XmHyUcqd0+C1KAIWHtZqwehgPrRwoIN1Pz9QXA+RP
 uzow4+gT9mXzBoTSvWT5GVbi68DUpzpiRauIWihXFUWUKgLNgdcaiwtVlBsxISyNXYWWkmKp08C
 WfQyn++JR9D+/x0LTOMIs2vVvTH0i6bPxPZKMkbtaHN6pOjaz9FQIgrhFuroXTyLgDQKqBJHHgU
 Fc5nYmu2dcXJ4L/V3IIx4d4zQ4hNg2sv6Mye5vjVPS/3eG02t4MB50jd/R+/JErqc3fNrb3Fius
 5rDgV6smV9hi92M4uQyI56O3FtwgR899rMiQqNOUqIF+hEy3aWGQ/C8nIkxPySk0o2EzSNMikQo
 0XQ9S3jchEz4YJ0ofEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310053

From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>

QCM6490 uses a tsens-v2 IP block and supports hardware-binned critical
trip points. Add its compatible to the tsens-v2 enum.

SoCs that support hardware-bin critical trips read their manufacturing
bin from qfprom fuse cells rather than the usual calibration cells: a
single "i-temp" bit on hamoa/purwa-class parts, and a "jtag-id"/
"feat-id" pair on sc7280/qcm6490. Extend nvmem-cell-names with two
oneOf branches so these fuse-cell names validate.

Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 5a8f7673e730..6899f07ec218 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -65,6 +65,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,qcm2290-tsens
+              - qcom,qcm6490-tsens
               - qcom,qcs8300-tsens
               - qcom,qcs615-tsens
               - qcom,sa8255p-tsens
@@ -244,6 +245,13 @@ properties:
           - pattern: '^tsens_sens[0-9]+_off$'
           - pattern: '^tsens_sens[0-9]+_off$'
           - pattern: '^tsens_sens[0-9]+_off$'
+        # hardware-binning fuse cells: a single i-temp bit
+      - items:
+          - const: i-temp
+        # hardware-binning fuse cells: jtag-id and feature-id
+      - items:
+          - const: jtag-id
+          - const: feat-id
 
   "#qcom,sensors":
     description:

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D0418365
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037590; cv=none; b=qOCK/AnRo9SpivrtuyQ58jkmYZkb+wm3UEkNy13TUyZQuUfmuoByJy4aEPWbU2if9ga6ZT9O8xCWGR4bMNussPmD5id6tz4xS+cEWtKT0mWqMLuw1UuhF9Rjau+zh+OYT45fj8VF5MbXLb/N+xHwF2Rei9Hy+moX8GAPIV9MKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037590; c=relaxed/simple;
	bh=sAQjUxIjl8nvqblAqmHcPV7IsLhvqooON8HdUtzV9R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sl0pniSdU0h1znRTqawJAmnKdMq7NH72vfUKUPJMiVTDdm5QjnQYzV1RqzDdwzqeAiNNj6tvo+MCV7w4Gmx+oxX15n9WtfsrmcciZPI3O4S8PjliWZ3qYBdEvZ+t79tOxhcsPCPNVtz45s8dFK7ek/DlUN2qFgaFcuXmRy7FHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/wvFhNk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DMj5QhXh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/wvFhNk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DMj5QhXh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EM8RNS500302
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I+/LBRpEdI3
	GB5BT5qug2KBLpEPGdwxDFcSS+HFEn/Q=; b=Z/wvFhNkjpzEL4rlfFHP+T4j7hG
	Jm2GfYV4c8XgN1xwHgd0JISeGIY2doxhgLrdIZ0+PPlRXXgiudslDd9MeSbpJErq
	YjCaUS0gKIn9P6MlKyNUF0r29yu4iaeCMt+YOH4PI71O2q9Q1CBs64jqCuJqSI4g
	UehC6ZhiO5LVbW/n6SbTCrWxEGqqwDBuiL05eYQvqGe01OAzISjaX9+ROSu8WuoP
	cGdOlyK4HvGcaBGHXqCBT1Zy9/I3nASKmGH3FXyWJ74GcHWuaecNjcNoA3KLqgVt
	V37McIQgZCBhzupnaREHvTS4nJHLGyg0zOSgRYwhFJEZDRSLNAbcSCW2b1A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf334e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:13:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3aa8f8c2638so1420364a91.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 21:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792037586; x=1792642386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+/LBRpEdI3GB5BT5qug2KBLpEPGdwxDFcSS+HFEn/Q=;
        b=DMj5QhXhEQRTPs161s/v57nRZbMX6YB4vKZwohDryEVRejZzPoN18WKNF6CVSLcZsx
         1kJfkpZVvZrFMXDjn8wsvZVLNkRsmYI2qLn9i1s9Byg0+C/EWtxL+ZhZ4dSeV+JVW+R8
         cs8YVLVMgakuLwjPv0+Zo3KvbDyXW81J5jzlp+NAJXF8PbtCFEfn+josbs6NtuGvwj9M
         DRmq7lHg74OXmm0AKhaMUM1NaBOkXdpDPMfv1MEo6Jr9yrkngYDCme/NLUpLuumLJmu0
         aY7gh/EeDE8ici0IIjmxevfPjl+Qcc5LVVLqmzS5hD39GIa/61P7mJm2mTDJ3sIPQAzW
         DhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792037586; x=1792642386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+/LBRpEdI3GB5BT5qug2KBLpEPGdwxDFcSS+HFEn/Q=;
        b=IT8eeVcUZcFhJOlLGgdcL0IcembVskyi1G85eTes0ThFjSEs6TdQ7Lb3/aI3vcxb3z
         2hcmGUzn2y4M2p1hkD9dVt4+0dCBekdQqA+Vp4/XPIeu+tMpbWJ9UNQATBHjWAIemgF4
         gJgPqYRRSaVWeJF2Lyykh9dnL/8xzBRGYeIJPjDMePVvZXz4Ao6MGz3+Ny3SDT9tYVCJ
         V7ABsseNB5duiY7//hvdgr34RrfSOIIlxg/JnH3A0Zz0et9lI2BxCAPG0bpXoEPaDJAN
         weBmUNLtEsMOAuBy3Kp1YNfA5VbEUalXvAhlmqWmpLW5jbkXUXmCVeqDolcyWJlbrPA0
         ztbg==
X-Forwarded-Encrypted: i=1; AKwUvBxVQrab6H5YLpLLyY4FUWd1pGUnrUc75Bgf798i2VbRKFH4b3cV3K7GG8TDcV2PPgP4anotCy5JWw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJdjtX/Tmrr/IUHBF/Cdk17q3MnuxZIGIzPpsC9pNnjjqe1pUVV
	rDa4C69mwbGoocapIa+1eWC9DIhGh9tgbmTc5UcTDTsSR8HI7aV2lEr4D3kJyaHRE7Jown5WRCU
	AhsLNqqP5Q0f+n0aIpLedk9WG8Qed7p0U8gBAWD/59G9h8Ua1M2plGD++oTfbZg==
X-Gm-Gg: AYBFou0GsmQGyFwNYK1+3KcsjYHFyTZIu7rzj3iZLJH3uGQ70euwJ27j6zHmbEXqocW
	xLh5AlaY3FhYKRalSECoMD+N369/M/n4Sf0flvjH+kZYrMAuDjUMfo6yH2CzBK8o90wIoS5FkLw
	F+43TXflPLl7/qY2x//IRU4LMMoCJn/JQ2oJ3lrR0gObGkF6AcXEiK6IrjzHim0bqbJ0HZhKi73
	abQJDz5tRbLPtKdf6o8BJsV48ZOCPY5cDOzT84EvAC+SOaxjDzG5V6B+AtZXUglGMFk53G9CDZu
	N9T7Wn64yVHmM1hcFnjDFKAx4tttj9X4BMpMM/wuOP+1qRd29truF7G3sFfzlFv/SKqEeUM3Ku2
	9m7aEu9QOBojnpoKhn1ClkWFHXH7Y
X-Received: by 2002:a17:90b:3a48:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3ab3a33ce37mr25720239a91.1.1792037586308;
        Wed, 14 Oct 2026 21:13:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3a48:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3ab3a33ce37mr25720214a91.1.1792037585841;
        Wed, 14 Oct 2026 21:13:05 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944af2f1sm2267762a91.15.2026.10.14.21.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:13:05 -0700 (PDT)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [RFC PATCH v2 3/3] arm64: dts: qcom: shikra: enable WCN SW_CTRL wakeup
Date: Thu, 15 Oct 2026 12:12:41 +0800
Message-ID: <20261015041241.2186521-4-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015041241.2186521-1-linghui.wu@oss.qualcomm.com>
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
 <20261015041241.2186521-1-linghui.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxNiBTYWx0ZWRfX6KiE0jxMQX8/
 9jXGoBek/wFmftReWRsYMiinbt3Yxa5MiqxnJ87QotG2eDyDu6rvEH/7vQQMFmQcf15nIj6y/En
 fVXU/q582tJsD/lyn6OtaF8Si99IYuAW2jDwZGfoL5Qwv4VZwYm0Qh7FSuSYC6ttHoKezsgPZWC
 fuQuDW2xJwZG8R3pJxFvILX5vhv9F0Yfqz7wBZ+rhbrpKEE4nBdMpnOuVN9X7Q37QurUjiIi41O
 lX5m3VloQ7FjN1FGNMpU3cUAcpwD+832dwzk39U/cWAYJ5QvVKZZUo09swrPkOraUUXZc24wlUw
 luxjpVrDMh7tcJDbjmQLIQ+mMZ67vcHY4vMZxJv63HvNO0S0Mud+glq3kBS2weuErelcJk38wgQ
 eNm0QCg55kSOvrvvLgShGoAD4mINbHmnQ5fCtD5I5IEjiVos2HnPfgtA5lXN8VNEcsoc5HhR0wV
 3/6mZFF6Kwi5wkY9m4Q==
X-Proofpoint-GUID: riVFeFVVrzmTZeXFT-i24sIudNxtlB_8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAxNiBTYWx0ZWRfX2Ds6tjQc6PZp
 XCxM8DVR7z6JDYplDCAJ36tOt5GF+Ez9cU69SxQCXxSKKuXetNVngOIABjurSMq165V6clXv+uv
 zusz8dJ1+6LEN81Z69t0d8ANjYyIH90=
X-Proofpoint-ORIG-GUID: riVFeFVVrzmTZeXFT-i24sIudNxtlB_8
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6ad052d3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=GJxj0BfhqkdqIuq2HFIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150016

The WCN3988 SW_CTRL signal can wake the application processor on the
Shikra CQM, CQS and IQS EVKs.

Mark the WCN power sequencer as a wakeup source so the driver uses the
existing SW_CTRL GPIO as a dedicated wake IRQ.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 1 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
index 95eb7255fb22..c7b894b6126c 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -102,6 +102,7 @@ wcn3988-pmu {
 		pinctrl-names = "default";
 
 		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 
 		vddio-supply = <&pm4125_l7>;
 		vddxo-supply = <&pm4125_l13>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
index ebc3052d57a9..5edcabd9dae1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
@@ -85,6 +85,7 @@ wcn3988-pmu {
 		pinctrl-names = "default";
 
 		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 
 		vddio-supply = <&pm8150_s4>;
 		vddxo-supply = <&pm8150_l12>;
-- 
2.43.0

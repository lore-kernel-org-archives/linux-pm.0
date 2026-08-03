Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21737206F
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750379; cv=none; b=AIXBGmpxZY0TPhJ6p2iNHYGyTz/7NEMx9oIDS7VXVnQRT+zdxnW+SsIXEwwnfT8Aa2tjMBFTZ8BNzZZXK8YXt5TzXnHPdugNFkMJZ+VLss/mzT3RB84ZNWdTziSfkkk1ZqqtK+pcBITeGZ4jRSQmjeWo9quVR/oFLsRyal+2m2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750379; c=relaxed/simple;
	bh=7gXNlR1o8pvBTeUND9fIjf5bCHj2X+kzGUngmo2YPFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isXf1gkvI0zOlsbk65ZRdn7JY5OxKJzXuhljLRwjgYApn+vzty2Dm6QgmjpNFp0s6AFkF09MstimpDjuo0WEJ3R0remjVb+pig8AR/zI6neNnYbXfNbPPZyb6lNCVGLaVxdSiodE+mepUrcrbgHfKYYWgwsms6BkrcXGWvuaEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FuBW1BhE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PwMKLqEJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FuBW1BhE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PwMKLqEJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736F6cN006205
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 09:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CcMzfR8AuBhxlCwjCxGKeA1DUODDCoEWqiB6TsALmRc=; b=FuBW1BhEuWRozKGx
	JeO8DS8E2PuCuK6pGbqY/68JvA05vuF/Gh92L4CYelvStm7lUseeFK/3u6XMwXt8
	fy1zqlSQIeB8toqYATO3T6IIgLuhIopR9eHiobuBCdbmUaea+A/m+yEGsI0Ncr+6
	FLyVj/dHyhfWC0yNNfXlSfn3wr+JzQjMXPvv1U/SW2Rl5C9Tg5m4NuYbYRELjQCy
	61MfCBQqS2OAgUDPbymd6oc+Vs7MnnxxGXiEc2P1WrZOJFn7v07K+n418w5lF7Rg
	lSiIQJht3F7Hur6PZYKk2ZAXWPlpJZfOYS35zFcy2d0CMoVfrk2YLU5Har/rbPcI
	LCVeIA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnj78vx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:46:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso4377774a91.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785750375; x=1786355175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcMzfR8AuBhxlCwjCxGKeA1DUODDCoEWqiB6TsALmRc=;
        b=PwMKLqEJmZCqk2z7euhim1B1VJb2VHvuPfkTh+xAsZMyDH9oxBYx68xOvEEV2t+HzV
         xuGz7yLUUwemlcP3b7Y4sxhypr+ugsaOIVHq9F0Y0sXVx4RQn0uUdwaFxDH0iwP78s94
         v3gNTiOvs+EB0zHufXXhkjP+Bu9LUqRKnbuxxn2E55S2BV7Ujnkn4jZ4GvXs9E55I1Uy
         P3ItqWXzTYbz6MkAr8kmeOTY4G6/o867+zXOD3kMJYyAoF9KjHzBVmUNa3bKD70Wrefb
         1nVO4aCec2540NLOvrmjtcq+cNj/IRTyvFHK+KiowSWO3bxfzJfg6Ax/bLOAy1P6jFRM
         p4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750375; x=1786355175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcMzfR8AuBhxlCwjCxGKeA1DUODDCoEWqiB6TsALmRc=;
        b=Yr2Cohj4FjckRsW7CFHi4HlcrwVKwkOxyQiCwyWVK/T2Nt12ox7NfXhSyTIwbsO2EK
         nkc0HPbqB1Pa2N5cg4MWaJ9DtwGap8EYfs5tjmRGe3B2FcZgLVqG1SHYt/TGbe74Zbka
         5+EZVo7Q1Fa8Dc6jWROOtHFcQtetLfhNhBhEoFYZ9bsse7m03XtUbLymzABrk82b+ilQ
         WVZDFWYQBELxRSMaaNjO67EC0vqQmvj+MgkjQLwqBMOCaqCgCUmPVQI/mmk0tDyRhM3X
         xG+T4BA11gpjCDEDSdRkjyXC+rz//lNlfB3R9Px94GYJSU+82m10Mo+TFwwzkavja/DR
         yMKA==
X-Forwarded-Encrypted: i=1; AHgh+RpE3KGEVmbr+wb0UpTVIs9RJFqvvHRbDWN6K4y8QOv4m7Z4q4PwR6G9vtPlKManIgVwIKcH3Ubk8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6h3+8uYn7AEFEbCx9c145rc+Pxsgh6fJS5YMlVHosSrxpSISJ
	KSC+o1QE71NyV8QKYI4rcN3GbYlv3LI/RkD85xtF2I1HJbu1mDghNpa8VHxIQTJYmQqw4/xAnxK
	+HcpDFyijECtT1dBz7k436dgXgDCi5PnJF73FcexTJy86EWouKqPOBeLu/n73BQ==
X-Gm-Gg: AR+sD12iDXux5eDYaI502FblsOQysYry4NlV3i6RnI1o7Kr79pt/MQPKpALnhLvSp+f
	K0d5SQB5QlMVbm5MxyORv/emZ4aRsVql4p4y+oKkJFYBZqHJcrdNYXyJbnCnZXVtFQJLqT3LJRg
	g1fzM91Y/I/UYAKYa7MJxgkR8dNG1A3ydfvaUGii6adKrykT72LCtk+pUrchK3JWgeYIt5peIYm
	V8mZtyV8P5mLY9dGfsM9hpLWLIWF8GA8Yry6eUKXJBySmr1Y/Herc+J39Zmovn5R7dcIM2seBZY
	1Zs/681CjDV/LS/jyepvzhuVm1lDXNYb3dEawQB2WX7r0w/OHwHexeucvUDz4hJuF+DgxbtoEVD
	YOJbbZDgp0r2eI5WrS9Zf9VPlvpBoP8T6u/d1
X-Received: by 2002:a17:90b:4c44:b0:38e:baf:6087 with SMTP id 98e67ed59e1d1-38fbc55b78dmr7942285a91.35.1785750375171;
        Mon, 03 Aug 2026 02:46:15 -0700 (PDT)
X-Received: by 2002:a17:90b:4c44:b0:38e:baf:6087 with SMTP id 98e67ed59e1d1-38fbc55b78dmr7942240a91.35.1785750374705;
        Mon, 03 Aug 2026 02:46:14 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2be6c8csm3660671a91.13.2026.08.03.02.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:46:14 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:13:40 +0530
Subject: [PATCH v24 09/12] arm64: dts: qcom: Add psci reboot-modes for
 kodiak boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-arm-psci-system_reset2-vendor-reboots-v24-9-889281373870@oss.qualcomm.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
In-Reply-To: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785750274; l=2145;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=7gXNlR1o8pvBTeUND9fIjf5bCHj2X+kzGUngmo2YPFo=;
 b=QnPk8zoYCiSKzuRa5gqJtn5pFY6pPshnwaLvDzq0DRAMNJnv3wwALCsoc5TnH3xAy/STPH0bO
 /pMa2XbKfqICzDVEPwpxaz5Qk0kjLWwfbu6UWG6z1VoZ7+bCFOEYbhC
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 1PyMHyL9NdwG9mITsHPv8Y04xCavQKOh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX6+3hcd3J8EYY
 adspkziP33pWCMQOvnqX6VBz28wcMhEYiTLEJpmaS4sowhWqP7ysx3fZTe4/280fL0/M7UcvYTe
 mFR7yxPIj2rV32/FLpYAG5/6M/o9t5ImMWIY+u16jiFf8pF4I6/1IT3YZGHvBzE164wLPIzCtec
 tWcZhsQVmU05zzIIJfKwhTClI0/sOpojbFSp+jo6hI6UIcUNrkUTpTx4DOlHw02bjsBMe1Lc3hd
 l22qOHnsUMObU3/1sK924JuLo+/kdyf4gI2kKudXLReYGJNg9tIwiO0GKaFcTQQio695gj/9J7s
 jVBKN6GFwoDPzsnBYCB5nYACnQXQqYIhopHQGt8BhdsMo0ovp0Kpd2EH7zHl/mq2dfNrtY+Wd9C
 86cU3GoqNJ+t64JwGylArCtPA37xY68EJ9epSPFh5BlcCGYEJIZZzk1VAk0B1L4LfPJAwIcBnNG
 69nD3sV2YsdZ+ygQLZg==
X-Proofpoint-GUID: 1PyMHyL9NdwG9mITsHPv8Y04xCavQKOh
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a706368 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX2JtlZGWKyxi2
 UhAcn1C96SikhFBu1eNVwUFJpWh5kDi5CkdtYx2tFDZx8t5s02rltkW/r5CWt2ZX4FMPGSqeWzh
 MhL4KAIAlwFMXtgV0kXVKEerVITxFRc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030086

Add PSCI SYSTEM_RESET2 reboot-modes for qcm6490-idp and qcs6490-rb3gen2
for use by the psci-reboot-mode driver.
The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent and not available across
all kodiak based boards.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi         | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts     | 7 +++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index f74fa66f1a67..6e3837c2490c 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -866,7 +866,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index bdc02260f902..b7a0b5347639 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -786,6 +786,13 @@ &qup_uart7_tx {
 	bias-disable;
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 90f2eebc349f..4ba5246fe3f1 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1105,6 +1105,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qup_uart7_cts {
 	/*
 	 * Configure a bias-bus-hold on CTS to lower power

-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789730;
	b=O7oAHMhiaN0vg0cUrjsSzEYMT5B/kZ9vN4v5C37Y4mNz4pQUfoc9/GSQ66Ak4CMT4+iF
	 IOjdO9RFDcK/ciawRGmUN77z9knf+buYCCT55uKIVUyrXswc3Es+qORxd35kedVgW1PY7
	 kI1IBO7LGCFkBlke2xF8gEvrse2kRYzaHyWr6CqkKkJYUgfQihHtiGBuuwD+Vrh8WWCip
	 XcH9Hvsfj1O+5ONw0Ewv5vKdHBiZ0fBppzHCdCRP2FsBTXTgGlDslHgouRa4g75esFEwY
	 4pNDrBWsKQb1TBnrQM2XpNF8hrmqqCiJ5UX77gy8jxVguJ7al8nHFvSyABKz7FelS4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pl61tywIjHKWOijz0wTqXxW3qDD1wHyEe1xZW1YEAMk=;
	b=DHIidSeaoaAEjaVpb/PLSZqRkNX4rG+FZxhvCtba2ouVLbXIJ+LTla+5i74D6rlHDgRG
	 n+6LbckaYzhkkVfc654HGXFUbpC/m0BDltYbkrgfULMoCHh+7NUEPO31XIAtBtkPGgy7J
	 dEUhORztoKDK0b8r5RCkWSUHT48XCaJko571wfyNPZUVvv0ucql2kQoE2wSourNmC3NoP
	 Gq9HuWOXI4NDpJu1FM519bAaqCNmTCNdBjJw8K5FwUYDsgtHENobxMvRNzAExRO8Gv1xZ
	 Q5kakSiG2okEkwAWibIXidOzO8ojLDdWtX1PCwS6YXDVvcus/jGsCBkIhPfPnlPb8wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pwnz0Gye;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aroR9315;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAE606A330
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7CAE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pwnz0Gye;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aroR9315
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1GR32376250
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pl61tywIjHKWOijz0wTqXxW3qDD1wHyEe1xZW1YEAMk=; b=pwnz0Gye62u9Xfkt
	E5sKVFoBG8xOnqk3DfCYPhRQk4zDZV1DF3dkkZIe8XsDV9KN5KF0aWR4F/19lbCH
	6CcvGsxjmtJnfIud2lTeCOiMewyRP/Nkpk2fNtJvzmTkSixI5UiRA7+LJSbLUIUz
	CFaRgCn55Bw+aHhI3zkXpzpg2d7/yueVreOFN++cfEUa9oznrtpHl1HbIUOzf5Qm
	zMLP1OQOFlTc2dKBpq+nrx5shsgOWfYpjyEGcK5SQvFS2PAbZowoK6q5gAJBVMwc
	pyqlr+I7Hsv5P8CalbOB1VsUiRLHiN7lHTLW7B/KSYtZzuE+F80B01spDJiA0M9A
	hgjWXg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hues0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f04053e460so68124345ad.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795789728; x=1796394528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pl61tywIjHKWOijz0wTqXxW3qDD1wHyEe1xZW1YEAMk=;
        b=aroR93154XL3S6bUELw5W/GeHqfJwyk/tJpN+vwbucZMa1aVeW3/f1GsBUVmN0N2Ew
         oGRB6JkPsNCOk75TVanC1VIQMxuCvGvIMyGyAvpxP99p1MbCXc5JyXKj/+g2bvgDDQDA
         0oraa2H/fsG4GXjDH7cdeSqs1kIubCf1Fi4WMYQ73hzdlhBt0Tdt4YjQ/JZiPB9/YFAr
         wdUrKh0oYcQ/In0Gi1Pcp6FKHdGBPtw4uYd83Mk/XuUOE2kEmmrnk2Y6o50kMfiYAYY7
         t+w4XeQPW8BnD8g2YnlN8i+0IOl6ZUezkRef1b4x3UMckxAM1ns49fXlRPoMbI9p/8Fs
         8SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789728; x=1796394528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pl61tywIjHKWOijz0wTqXxW3qDD1wHyEe1xZW1YEAMk=;
        b=vwmw7Tt+l1FFsP/B6h3BxcrxmdWhECEBdFOG/h07uMUy6D5tlml/ggLRa8Tm8LZIuT
         ynnath84m/Uqj/Uc7Eb0LLL3bO9IY2mxUlISw2naLN5Jx17YOeIUP6RR//Rkr6TaqWtj
         YESb2kGd2tcgBTxrSycbVXe83VBLE5t/PlSWK4i/BjY7/y6cUNSg+xyt33A+XjBIbw38
         /5N+PUSeFqVoFfqzGMBogyQo/CAmQgDixASCIJO/bOanbxuHPd7hB4PVkrTRdIvuZJZ5
         Itt5+hzZOUWhCr6RCGFjRul9EulacZe5jo94Ux8JogT1ra1hId4XSSZhxtEfHpKzUwe2
         JVKg==
X-Forwarded-Encrypted: i=1; AL+hErFKyObkzxptSyyrTVwAXvE9U7hWZIZl5VQ5c6+RwcDGBRrDCSrk1S8L0SCJwVeMyqDgm9xIjIqBVg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8hJC8FumNRq5gSP2twkT+iv1B3NWz9+MeZEE4OZeHNjOIfyXoN
	8/cDMvHqe02EALbqSiTUvUYIcgYj6S2vTeWdd5uDblXFAlo6En6XFYAEIyNz4Fy4XbLwxpjm9tu
	EkHhbvFvT1WTVRjX7/9ARH1JFvYRGnug0uyIapHppvchqMQOWAeVEVSdDNesn9A==
X-Gm-Gg: AZFdTZfFl0rkoiMR7JpnFvlhqkqX038BZCFmG8hIdn5z7TSgoG7B/vX3MLUe1t4nrQW
	PY7qyPuEY+b/0K7DiwLhHRC8Ry1lI1INoLC3zjFAbd9vvcGPTIADnvIrR0lAXzR397892LcRK48
	EhN43dv6pd/SpeB7Ec8WlfDErA5rMM4H9tF/lHW8alkw2Pq16NfHd+cvPuAWSj3+0oM6oF0rOfI
	3Bs4QcZfKUEeUf++PglCN6SvxUCXsGikpltC8RvaQ2LerBF/FZBRoMS/VgRiCXF76gqqDr3xb0e
	o7JDlODOg+JzmPokS1Xawo27O6BDh/ycUGmtSRxdIOu0AoaqzMzZG403FqE8DCZ+pASRyYthuvV
	VF4e/F5KuEin879K+aGr4czArPvZQcEd73gvTBE7jIHzwWguJajcP0IU1XFwlpioFD5KOvduoeT
	2NyLSXWiAs9A==
X-Received: by 2002:a17:902:e80b:b0:2f0:943:118c with SMTP id d9443c01a7336-2f03f18fceamr239299355ad.25.1795789728337;
        Fri, 27 Nov 2026 06:28:48 -0800 (PST)
X-Received: by 2002:a17:902:e80b:b0:2f0:943:118c with SMTP id d9443c01a7336-2f03f18fceamr239298905ad.25.1795789727763;
        Fri, 27 Nov 2026 06:28:47 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm120324055ad.3.2026.11.27.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:28:47 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:57:02 +0530
Subject: [PATCH v28 09/10] arm64: dts: qcom: Add psci reboot-modes for
 monaco boards
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
Message-Id: <20261127-arm-psci-system_reset2-vendor-reboots-v28-9-da05a33b08d8@oss.qualcomm.com>
References: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
In-Reply-To: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795789617; l=2135;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=dSQwIim7V7/rULXlCKUdNr3qm3JfQWAAjzv2bwKQVlE=;
 b=H0ydfSAVrKfYH6W8G2CaDvfckptjvnYSi2jHXy/IdrzR/rOdsokmCe/1bwvzr4ps6qctiwHlh
 wGGivLVq7Z7A/KAWiHwqC5PNb7ZkliL5N4SpGRmFS2P/JUe8eq5ff2w
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX5UHlwHIzARRi
 Gpz3VewGk7i0rNlRkHY5s1r6uAF80V5Hs5QaO03CEb8Axq/mlYeOmB+s2e9if5AuRI7l0l2lR44
 G46BqUEl3EhQjgwZfvhgTKtKfdJRyJU=
X-Proofpoint-GUID: 9LkNIX7nuWmFldIUV8rW-6UjT2JrcXUA
X-Proofpoint-ORIG-GUID: 9LkNIX7nuWmFldIUV8rW-6UjT2JrcXUA
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b0993a1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX16L4ccrDFA8I
 BvANrBZ5nKCSxTzpTnMPi1vQpmc/OulMwIhverZf5/SaVppjq8J2uOW3jfvJejonLWo/pO8dK2I
 WDrmBSfczk5qr0Ln0FEtRgfC31gc3xP/zXYR8B777DU1JwVofgTt0IrN+yA/oMQSpSGlR3iaijt
 YGtM+ZltEDrh/WWu++3C20RmvJkwTwsGyc0usHNCfrFnjEaIoBOTP4MpOEGK8B1v/GL1DkyQzJd
 x6T/3gGkfVdTQqyNZA7BWlcSsWW5CE6h3ILeWyg24XXHSdPyFwPogXXUiFYx8hlgfc2UWgadnLl
 tSMG04TlMapvFRU2MZ1QgX4UGjXkIPYkZzSpC7JX6ACKHtNxg8uOg8GkheubhKfvLAtZz8wSE3z
 wAwtZbmRy7DGhBzvr14zeHvjpyCd8aSkd7IxyRfiyLyRZDrV7+FqIOkWe+4HJKwIVsWSQuwYrEA
 7CjxjU1GFmtCO9dvckQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057

Add PSCI SYSTEM_RESET2 reboot-modes for monaco-evk and
qcs8300-ride for use by the psci-reboot-mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts   | 7 +++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index 539c9c80a808d..074971d310eaf 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -711,6 +711,13 @@ usb2_id: usb2-id-state {
 	};
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qup_i2c0_data_clk {
 	drive-strength = <2>;
 	bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 3541313a79bf4..efb233458b3ae 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -655,7 +655,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index be850a23472fc..abe21242d7104 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -678,6 +678,13 @@ &mdss_dsi0_out {
 	remote-endpoint = <&dsi2dp_bridge_in>;
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

-- 
2.34.1


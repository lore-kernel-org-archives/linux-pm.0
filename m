Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE73E557F
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311419; cv=none; b=ZMX9e9cTAtLrHxViTjjxDImfzqNXYLomFQ9oLctUnicITtosVgqljPDttMEWmGNhpdCPz7Uj5pyOyL4koHrQFSanUZf5dl0XMG2YvyhCubBqbxylfN7Hjp5WYJGWri1ogxM8KFM2rcV7s/k/olnjEIfEBIYDq5AwX3HP/0I3jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311419; c=relaxed/simple;
	bh=lzFmHffITL4MZ7Zhg3ubOyGGeoOeSnOg+B50ouxJsO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9fJZAoadmQjV5LL9AgjFAUSAgZvtnGvSOR0fJt2KlZIn8ivnANDNQT8QwV4B7ac0aGLiu3tKtZzrB7oSNCri5wCKjRLE88vp7ApYB+XqNE4oNlxVWNlQqwh5HFE3JNmBiXXolv3vQN7OlD3CuMU9ctmYfAn+BUN9d0rzyb1sc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oNmIGO0/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UjxugvnD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oNmIGO0/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UjxugvnD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RHNePk662935
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q/yZ4bIJyOI7G4zqRHN1bsvi00G0rNpCoyBy2l1oBTs=; b=oNmIGO0/RbQPH5mY
	JAzuBa9qDcZ5+3btq1ypb+yXum2qudj6qLr/7W3ovxv71MyXPsqvLIaQX6+/tglJ
	7Yv/ed3eh84VHBS8J51wBfNertGUzw893ZTwItDPNZwWNAuXITblVhFsD1rGsrHr
	2n2Satt2oMFq5AxEDc0HgSF1z+rVFvdfmB9owAJAojCgfofdRqfqYZvYFd4QrhbZ
	+r9fayRmSH+2CkqgKYmypRQGy+V8eFWciJDGhQdjwwD5vU+B+w3l5IjC5Wlv0D3r
	3LfakyVZATidcLQxflcjm9rYRmb7cdz+tJBWpGNB2RIOG5K5KY+HPHVcr56O6nhN
	ARzzEg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n023w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so195306505ad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311414; x=1777916214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/yZ4bIJyOI7G4zqRHN1bsvi00G0rNpCoyBy2l1oBTs=;
        b=UjxugvnDCpdw2hjcD7FtmB6Cn+JwnRAvQof9tjS1MwPjjyccpT9Sg7+REZV8c+GsQm
         FhYtN3StaIp5/BlG4qe0KXygiaRrtgVz5VAGd9ZXwfclDrNVq2oyYyt8xJCbj/bY3qlJ
         ew+E5WmVyLdPlswIIWT6RjCWF1BLTEVvuOBCmR61XvvLxBmFzJYtCNTPEEYT3djaIbym
         +XCWIAuQoIt9JBf69FqOfoiB2NCgOHAeIUMES8eDAaRpHi2nxi9lfBQ0Q18ZJsLBMJ1f
         x/jxG8JVdfduBYq5BRCEURAuTBRlaCfb9ReFJVrY46ARgm0gDbLfVoAfBpLesdT2MxQl
         0feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311414; x=1777916214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/yZ4bIJyOI7G4zqRHN1bsvi00G0rNpCoyBy2l1oBTs=;
        b=K5myf9FkqZ5SagT8hCKXv42KF3Mmw+97zNiRu5uVgzs3xW55gbNOZB8vutx9h/p2Cs
         5nPva3Eq3uQUFajMEr3hdJcOVnXOrM5X1BYr/euJ6AhO2hLKcChAQ7yyyREHCVc4pwe3
         WT/XmqmuT3cVsqvrwxBXC1hEc5FZKOhSoFwVuetXd0uyDX6ETjlgQ7iluINamOPLVPRl
         i4ij10lXjq05YgpREvcK8MMPSHOvTAl1QmgsvPiKLUBl3s5GXArL//77lVDWl+Uj9HI2
         LZ5YMv4quEA2JgFHUyxh1aseTTNd7T72ensF7+BM7y36nRuTAvMAxVj1Ha4ua0+YeD6g
         ew4g==
X-Gm-Message-State: AOJu0Yyo9YbRpO0JYPzfg3QF0/7nzb88ghle4M/7M0jcH6Kaa9ntwXlB
	JYr+3+ftZ5mmHV/dZIREOtzmA9kXMGy4jk8K43ZCIvQylz4VVHRle9VjzT+iLCAO4hQtA5w2rJd
	4FBBc7qvspJU6WZ4rmOlsOtEAl7WUMmqH3Co8jkBqLpameVW9tv9qAU/471E5Pg==
X-Gm-Gg: AeBDiesxwIKqmz8FkK1hi8AOX7FCzqjvoq2Qso3jR/ciVtLpYPuz8vQ0V8qc6MWHB26
	LmTvAmCRtRMqAxLll7dQOw8RuW/sRXFcQYuQi4J+/Eh800UwdAhQuf7Fx4jwKHnvd1ZgrcAwHX8
	N+F01qeIks7LWMbF3vvv/GJ7f1U72j5LP7JgNP/Qm3ilUzln38PV/ghCK0HJc/aY0Q44ejz4Cgs
	njvUzd8lEMuc8HM0OHJXeMItbQL1wRNiXQh+sx9qe20RMkUmJJ1CXPxOTU55gP3ZsBursVTPw4u
	vChjHXYCYV+SvHbSepBpiwPZCL0WENb30RWhmV83S2GEU+gotFq73dQt5EzWK+YD+epYEqcjNdI
	P0g5P16n7LABfK1X66FM6DVBfmINhxq0+s5dU2LOPsssK8auRHTrulDyHdknqWvSJ/63v
X-Received: by 2002:a17:902:930b:b0:2b9:5d1b:73da with SMTP id d9443c01a7336-2b97a9498d1mr1240585ad.30.1777311414272;
        Mon, 27 Apr 2026 10:36:54 -0700 (PDT)
X-Received: by 2002:a17:902:930b:b0:2b9:5d1b:73da with SMTP id d9443c01a7336-2b97a9498d1mr1240115ad.30.1777311413824;
        Mon, 27 Apr 2026 10:36:53 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:36:53 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:50 +0530
Subject: [PATCH v21 10/13] arm64: dts: qcom: Add psci reboot-modes for
 kodiak boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-10-dcf937775e73@oss.qualcomm.com>
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=2240;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=lzFmHffITL4MZ7Zhg3ubOyGGeoOeSnOg+B50ouxJsO0=;
 b=98cReqLFE1VvbI3WMdumayFbZvKuX+6jokI+ZbKawI/g6LlmRmm1VnxCiGnVLXZwxNIU5qBGG
 YfhdC626zMjAwn8yAogRwMIqB5/RL9mpWKk8xilVRkbwq7id7zsCDrI
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NyBTYWx0ZWRfX31a+fv5+J3sT
 dBDkTjpDx/64f2vU1iqC57IeUSr/YYTWBgpALh9xVR7K3j7Frp3WfFE+GlVKhnhzx50j4KxG11j
 YA5xQInbEmv2XJ3A1Egn1A32PNOiR0u2tClanxclb7ufQZq/fMqrnha3+aWecBjKfUuH2wffJHn
 jNE/UjFb8FNPjRmzNJUZpjUYqpnKsbtF3FqrTGVJ+wFu1TZR5WFnrc+NL6DgJwkNMX4032lHrQB
 +7CghbxS2Hi4Xa1hgIbS1CKaxjJK1HjnCs95Y+GXzSF5HRtH9E9SXn6Nm/MVKVnJn0GPypkdU8c
 2KcdpdQHGgnDRfksIv/GMs7ziAARIL5/aGHG9Kr67VvNxqRrl4UWwOmjW9WaE47b9+7VQFCYdUx
 jXyU3YVK6iiz/ZImSUD3rBJTxlb3fgLmC8SJZvQlXUW6hiyDBH/yHLKp6iJUs05R65K5TCkOGMe
 hBrwUMUjdxMSV8S49WQ==
X-Proofpoint-GUID: q7uaiLCVZUN_9BOgVumw441Gw7jZ5R35
X-Proofpoint-ORIG-GUID: q7uaiLCVZUN_9BOgVumw441Gw7jZ5R35
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69ef9eb8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270187

Add PSCI SYSTEM_RESET2 reboot-modes for qcm6490-idp and qcs6490-rb3gen2
for use by the psci-reboot-mode driver.
The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent and not available across
all kodiak based boards.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi         | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts     | 7 +++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 988ca5f7c8a0ec5196c88881f529236c321ad617..72bcc732ab7b64288e1848edb8a55e2c7fe34f98 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -863,7 +863,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index bdc02260f902bd37242ba96b90a858ff091e0c80..b7a0b53476395c25f264f2808176588f5943c4c7 100644
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
index e393ccf1884afde7816739053d41ca789acfca91..ec614003bd83664b5485940edd366c9ddbd57340 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1088,6 +1088,13 @@ &pon_resin {
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


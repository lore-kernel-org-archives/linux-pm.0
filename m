Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7D3E639A
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311438; cv=none; b=k0x+CgZvMhXOM7bThlJh2kebNYQN0RMroFluKZR0o7yAHFforQi8XQnt9xvl8FTo6R8zHpmFXQGNtGbTeBSPhi4lXfqMnaD0Kdd/vwEh6RUD3QIdSVzwfar6x7QssEiUOxgln9HOsl7GWjmLEtuJovPGHmJ9mZKKndS5Hn1Bqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311438; c=relaxed/simple;
	bh=5QIzxz7gWGxheo3NhPJy7cnaOZvXTFo2HH4ZUk+68mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rv+ltpM/9Wvi0F52aWrIjPhDZLUg6zzUs8RMZZzrugS8+TNePQG0lGHnvAbjsIi0jRzJ2aVduXJ1A9kMM7KFFozUnrBJ76RO0c8cdlt9z5menmzzXe86hVi6Aaj3pVFvJDaI+t4G+wPrH/fuFBRdJHw7Xm6OJeP5vhoZBp2FrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pa1kiRR9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kSQ4Yvkc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pa1kiRR9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSQ4Yvkc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RC5uGH2006990
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xbPQdWSvpV1A9Kh3jDfv9xIG/RX44VAlr59SkR3C6Vo=; b=pa1kiRR99pQd0rw/
	3Io4uUb5Ect4M7AQha7O+U9rTWTepqY+VdZPBtStrlH8sbijExxwtHilnTjbion3
	y/RhL1XNQJYxFOnOqA3AQFwgx+ts5LWckyghw/wvDcu5TJuYftDfbsZs2cNBsa4h
	GN9s0xbyjUc8n3onvZqYi9uJQbkA79yS0e5xHCauGBO4CZNPQKM/T8HNqycel9nT
	CHa+zHfJgmLp6gGhfEXfdo9NxZioFXUz6WZvzCGsrhys9sgyIqPDrgZ6qEUx3Zvl
	enYQjfLRNHStjulukiCgLJS++Le/1r7kW+dvriqHmb6gy3UD+CS+5YxCI0jQZMYk
	5Oal8Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkh8hb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da1c703d1so12329089a91.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311434; x=1777916234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbPQdWSvpV1A9Kh3jDfv9xIG/RX44VAlr59SkR3C6Vo=;
        b=kSQ4Yvkc8q2aQ4Z1IBP5EH79GFaxgN/BE9Snz6hxws36qOCf8tDwKFms/FMrcqgGo/
         r2Hhj3zKLFUN1ZHuzVYCmy3zSwXtnM/WSJfDz68XvP8ap0Tn++poSp3u5IuWTwU9YAm5
         jh2eWV6tSfWqxDL4MM4rVFPn5N8W4TITd3WnU41gHJyL0qRuSM+1UQ359A9HgvHwrUnS
         VCCkszUkFpaqorUoxIKGf9N2bWfELFk9nza3mgjFkroBR+cI4seshCjR/nAxnIr3sE4T
         pUDFyxl5IIj2e4fWgjCN1clCG2fiDPiZu+YiFtQCvqsDplnzIgd8LtuBVT8UfgCuUb27
         Dubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311434; x=1777916234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xbPQdWSvpV1A9Kh3jDfv9xIG/RX44VAlr59SkR3C6Vo=;
        b=CCdqYnrra/EDXPEJzRyGNHh5jiRRpj2W4Q+u94qtbZ1l8SuAblgP31pfvaL/yQVH/c
         AQ9H6iO2pzQIE/8hXPB8o9XBr8uj8i+56F9RcIInbopzicXwv8T8+2IOQb5NZWSYJMud
         iDS4fvAXml0vaw8ysoG/HhtjOOICwm8qIkmgO+VXV0MrDw0xYPT5IXL0kslmxEoClI5y
         cLSyK/O9aQD6GJyq3M5MaoeLssV2mpiq//YLIS4hULJuM0CzSAICRohLm7cpKL3oMKqg
         Wykv2xJbWX1Wf+cm09VVCQe4oaXdpfoz3wOZfM5y+pAD3PlitnleaRIXVQso8yorzFnb
         7oTg==
X-Gm-Message-State: AOJu0YxYT10bjMKEhVqwHGRf0c3q6Zy57nQu5aENXHGriXZ67jIhq3pI
	D7DvuiVuntZhSwlxp4k1WTkjgoIysEde9OJ7bCAfKgbQrhzyw6wo5+Ai+BTjEFDnb5EIT7es6uj
	n/rfqCs/tnFq4q1D7AgF7zx/VO4S6hWKghh4qac61Qd20KHGddupeRIT976YrCA==
X-Gm-Gg: AeBDievZP3r0TBjaTVNZwNPVG9v0emmEvI60ZKDlZITvCWKEp4PIE1GH3SD/b1i07U0
	UNWvaAORpbyeRbMs2TB2rCWQmaCz76VuYAj31OIBEWHR022Iiv7aNIJvuFb4wGz35W4FPRJUIZE
	Sbgbu4kk4028gfeu4Geb5Ix3D3g45FZZgLXUDDe1kHAR81qTwbdHtbvgvCWlu60bi7/GK/rpWVa
	xxO5Cd6YXsZRUd+gh4mvIvc0aWXMU1sEymGBpDC+NUy8a6T3CYi3KMiAb1s6G1AYYzSrS7Z7NWB
	CtLfWg8hqTrvagR1Y2hMPjjySX/t33bvYWcP3uDkud4sD3ZbqiYXVoLOkQ4yb9UlEx+LR1cFDVu
	6vJLf56R2Uj9eWVRzvDbKkJVGL0Scb+KAr2ZWsQx336khCOYlpOUxgwNgIiETWE24pnui
X-Received: by 2002:a17:90b:2747:b0:35b:a7be:ae47 with SMTP id 98e67ed59e1d1-36490caeaa9mr35342a91.21.1777311434386;
        Mon, 27 Apr 2026 10:37:14 -0700 (PDT)
X-Received: by 2002:a17:90b:2747:b0:35b:a7be:ae47 with SMTP id 98e67ed59e1d1-36490caeaa9mr35301a91.21.1777311433790;
        Mon, 27 Apr 2026 10:37:13 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:37:13 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:52 +0530
Subject: [PATCH v21 12/13] arm64: dts: qcom: Add psci reboot-modes for
 monaco boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-12-dcf937775e73@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=2171;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=5QIzxz7gWGxheo3NhPJy7cnaOZvXTFo2HH4ZUk+68mM=;
 b=325D48bjWTKLlbPLVqjl4k3qXSzuj715BcxjqaXLOtBtLhOIIX41XNRMTpsTte806BXO9r4FM
 h4AC48/o5MuBi+c5QrFZhPxIMh+5eaRSzd3aPipb6c/EUTlGKfAshkt
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: 4PDlvONsNEwMMYs4Y1MJA6TssiIQ0UbM
X-Proofpoint-ORIG-GUID: 4PDlvONsNEwMMYs4Y1MJA6TssiIQ0UbM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NyBTYWx0ZWRfX0zAVxOPEx+aZ
 WLUzwODFpn9c6xjMzp24d29qeuIXCtUrPWSJE6bsMPqdDSSd+bLJNmC9biOOsRfd/ECWIsFvtGi
 WJwWQ+VHrrFj2ieuZtiOgWXUo5DdDk4apHV/o9295eKr7L3XIRu5T8D/jURIXjDK5pODjrPfiFU
 ST2rx5xQih2dSdzhZTH/p7+SVqDxhTuuBAVVJGZViTQx55KesAYQvUdzBCIpI9vs4mghJ2X04et
 Q0ea98f0ORynhyBy8NpEeLIviXanKgwHvwHvS/Dcgg9glQbAR5f29PONSduC2qdAh4VIDPNHx9r
 8CjXvnwSPMzg2hscayLxHMdqMqqLIchg8pyPV7nLtb8Xb9BpHAxAxi1xXT//hctPTZzqUx0cFsz
 NLLPIgBFzXLwNxQHLNXQnPMKvGsC1Hjw3gXmgb4LLQAKa9ujlSQTRfC9ugxfH3qkKgvTzVFcmNU
 KMR5+5PzzkF80/aJ/eA==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69ef9ecb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270187

Add PSCI SYSTEM_RESET2 reboot-modes for monaco-evk and
qcs8300-ride for use by the psci-reboot-mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts   | 7 +++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index 9d17ef7d2caf130564efc2d0159ac0de39126e80..df668dbf2bc60175c36cabfa310aff625647899e 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -661,6 +661,13 @@ usb2_id: usb2-id-state {
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
index 7b1d57460f1e6953acc7fa06d22a1f83ab24edb0..da675f7a8f2d83f3598a6a7ad71a99206213d03c 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -674,7 +674,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index e9a8553a8d821ca88a38ac59a78625707850bb5d..3ab5ae3124ed5314f04202b6b247fbbbef665053 100644
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


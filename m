Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2A32AAC5
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652247; cv=none; b=Pf2ZCOPmGVGyIx+onKx4i5MARWMlIJ60zVAUCrFZPaFsxGBJ3cDJR3Y87/sVbAIjDGG43ppo7ErnI1JV4UwdLCLrl8FB6imY1X/uEHx5MWLtKqhTW5/lVw9KjDs38pjsPNdZxpFHTiAaJzSn/z7Xww3S65hk99HfMcGyANPsb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652247; c=relaxed/simple;
	bh=myXGbohZc8eS25QokdStbNan6AbEa0EEYXTBb4ty0eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDg7HmTct8xmqdikN7QdQHdb8M8TGPqwsyrranZsDO/8ekpvLdMvphemrMbWMfcOGNyicOfO6asBOFcPjY7bBQ5NKRzBoHyvIknx+486Tmz+1vRXWDWIUVHhi6TtgKt8SSAkoX8I+PJ8EZgJXpLI6lws6w2rs/ImxqXNY+lthU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YUJsQEJW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C404NPY4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUJsQEJW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C404NPY4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJNt6s1771110
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HOFM+2dGVt9R7ANGb/sbfRd2LQ9qIrMEUWcvtpHzlQw=; b=YUJsQEJWZ2AqUZAA
	R6XhWPTPq4klgrnlVW/3DMZ8wt1EJB/6dCTw0x4CwH03o7lt0z+Hm0MYHdNcjZAr
	Dvf2d+hCx64jc/z4cFjfUXs/SF91Andd4fhoYBn+UJ32d/a6rqfZk4qGPlxddlZk
	hlQf2M8qpS6zD4azNSJ/yAS6GT0SFGHswxb8Trd6fvYiaCXH4T5SLTJWjdLUUOqd
	v4c6s4TwfhsYJdGngVn33YJrjJPdNgKmN0NFgIAQR4wRS2iez6v11mkNZJpiEHD9
	LvqPDbf7UFdRPzgzQbPCrlOf3p7kYr15ST28qKrBzYy+1roHh+nGMsa7eEjlAMYL
	Daf+dw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asuwb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36629e48023so8365728a91.2
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652243; x=1780257043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOFM+2dGVt9R7ANGb/sbfRd2LQ9qIrMEUWcvtpHzlQw=;
        b=C404NPY42RWYYmi+uuls/ZjXm5Vez02bXSrK50+hoALhVtM+MnqDXSMrB2vbfDvGHn
         X6y/ZNIzwJ/eo1iBwVXiL6ZkBJLNK2TM7Pu70bjESvnlRol4SH2Mwdp33TJ+fmTqOYDh
         9uKKGAqEp5PEWPVAuLxtEKWhgMw/svY6xidD3JNW06q9p3sE+ZfhZS584ZqYhlEtUcMi
         AM0fIYrCySYb0TPTyqMVzOIixmq/i+YKKDKD9RlBCXoPXEOuqy/fewCtQ0CSQhHApZYh
         lpz68o2gB7kBjB/5TCF+LRMJKvAk5d0KNb9CBEhvaqzFyceNJ3Krd08TtMoq4Q2JnZAU
         mZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652243; x=1780257043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HOFM+2dGVt9R7ANGb/sbfRd2LQ9qIrMEUWcvtpHzlQw=;
        b=jteagfoblltflc837BMkR4AKpsorvQoI+xbcxfozw/27YHFD9JAoNeUJaTUyl7W881
         KUlQqwVmG8DNwjppWkjQw9s6M66GGEEVenvnuR1i4vKi9VZNwlel+M0hfUz1Qq0AFUfs
         asbB+2jXZn4JTiwfMR+3yg4JOY+4EOjTFPtf3GxTDdZStb6lr2lUkcCI3SzKWUXfvRvV
         C0gpOu6Cgc7FNLXaN2ttdjkSKY6DIsAKJ2UlKbOgp8bteQvdhx0Y7V7JzJWPE6fKwZxA
         PU1sp1SingfajR3BaLbZW9jkTLQ7V+9DI+V86WuSj/MhMmLwCQ6LhOY3Bsi/JjYq0n18
         NcTg==
X-Forwarded-Encrypted: i=1; AFNElJ9HbuXQ2PnVVeTitYiAANClC5KRNpkGxMAZN8cw9m3RLs58tdVmdJVvRZRfkOF+PtFlEZCY7sKyww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAToKhw+PLEGLT5/xp0emWKy6ah+XPc4tNXgMmJhXuEbK8FLDA
	ijmGl+37+AfBx1ShYG3aZo/+kuyHZUO5SH1OXnm2tVzYbDhyA6JblJrfARzs6JyoT42eAQVjuCA
	S96dymQD8aW8Cqk3ZvloXTDc3uab8nic7ieuWkRSdloYJel8BqrEOErKuQt594A==
X-Gm-Gg: Acq92OGUIHPnzpDeVijaY55byXwkxqfSmvhsSF/+zWnEZBRis5bmF/o5/zqPBGc8gGE
	zhhsXTKO8ZwbfpW0FN/Imo0rew24JvHEJiYw/0bCTnrOsiBPxysqhV5gyPvOUdYGJiNZVLNkr4i
	b7rJotE54+BfEG1KL1b+/VD7l7/y6q7EZc5Tx6n4pGhvUL+VIuA1bT8wCk+/h1Rs7tgiai9kPQ6
	C2t9hqm49ro9+wOa83cz+gkKZ8wV1dV/5s1aULRphirfceLGIkX75RqG8Z/75sxARzERDFmBJd6
	7pv7zkacqVngb8n8AxpJPoj44D7h5iVQG3ODo5v4UjFLbziRZrD7V3ZSvbZh26S9yBOFtKOsU5/
	ym+1kD8ywcMeNgiFL4PBF45jWYSLerSgtd1FghdHcr8MtV8Q=
X-Received: by 2002:a17:90b:3f4f:b0:366:132:fda3 with SMTP id 98e67ed59e1d1-36a67475eddmr11595866a91.11.1779652243380;
        Sun, 24 May 2026 12:50:43 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4f:b0:366:132:fda3 with SMTP id 98e67ed59e1d1-36a67475eddmr11595838a91.11.1779652242807;
        Sun, 24 May 2026 12:50:42 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:42 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:18 +0530
Subject: [PATCH 14/16] arm64: dts: qcom: shikra: Enable BT support on EVK
 boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-14-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Yepuri Siddu <ysiddu@qti.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=3298;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=6YTvlWrfOM9Uj7YIFxrI0dRea/7p3Vn/P2SEf4jl6Jc=;
 b=SXx+h3+DeUTd/cTjF5htX+HJ1y7t/RGA5O1q7a2cEmM+1xksj86jubrl+UsbvoPjQZZD3hd+m
 iFXBLLVFAqtAkBnzEuhU7mJYXT4CSSsh+opIugMRizh16ovhdizEU6U
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXwQVMauiLhPfG
 xPMv5AmRkkoCamPduV9ARDXm11R7SFsap4eFM2qdOC+Sio6xOuuWagfrlWcGK+Gs4ZswOhH636O
 QjKshY3rMbAb/pBXawLUJsNXCRyKEZvks531E1Kf39fzB8XpW7TYucJ5IAloSwfcyz3kC7eofbB
 7YH+HxMv6DBgZi/OVWpwIVUJxGTMROarLWYFJw+GVwXmXBYOrxOw2hulPFa3CRd0kcH9HOkwVQd
 PrmwzJ94RepzGqBzlEDpFkz17f83Qopv313kkKHRGizM4r3LEeYgKBRIixEGdx0+LSgY8heVFjA
 P82Tu3SFsqsynJ/KSh1lR6FfBBBLFa3QdDEiZYxxQxjTscV4p8iEYOLa/xy90Ji9hpjkfOXNmSY
 4BfFX7J8oFVWeJQD23kHJoucOfZEVC+wZHo+DIvHgpuM+yV7JYlSr6qJaIsL8VxDLiUpmht9Hd4
 Pm7AWtlIf7YiN9TsvkA==
X-Proofpoint-ORIG-GUID: l2qsd6Hhz1SowzByyNB-NyDIfqkNRoJM
X-Proofpoint-GUID: l2qsd6Hhz1SowzByyNB-NyDIfqkNRoJM
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a135694 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=OP1gjdvSne2naBZ_9ZYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198

From: Yepuri Siddu <ysiddu@qti.qualcomm.com>

Enable uart8 and add WCN3988 Bluetooth node with board-specific regulator
supplies across CQM, CQS and IQS Shikra EVK boards.

Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra.dtsi        |  7 +++++++
 4 files changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index b112b21b1d79..259032bd20af 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -16,6 +16,7 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
@@ -57,3 +58,14 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index e62ba5aef71f..142cc8da53ce 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -16,6 +16,7 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
@@ -57,3 +58,14 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 727809430fd1..9bf52030bcc5 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -16,11 +16,20 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	vreg_bt_3p3_dummy: regulator-bt-3p3-dummy {
+		compatible = "regulator-fixed";
+		regulator-name = "bt_3p3_dummy";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &remoteproc_cdsp {
@@ -57,3 +66,14 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		vddio-supply = <&pm8150_s4>;
+		vddxo-supply = <&pm8150_l12>;
+		vddrf-supply = <&pm8150_l8>;
+		vddch0-supply = <&vreg_bt_3p3_dummy>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 124d0f05538d..73681bf0e3ea 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1753,6 +1753,13 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 				pinctrl-names = "default";
 
 				status = "disabled";
+
+				bluetooth {
+					compatible = "qcom,wcn3988-bt";
+					enable-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+					max-speed = <3200000>;
+				};
+
 			};
 
 			i2c9: i2c@4aa4000 {

-- 
2.34.1


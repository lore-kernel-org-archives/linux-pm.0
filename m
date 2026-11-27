Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789720;
	b=GoWehtyMCxxPGo9ozqtLRnVq40OzbYWU6Va12isfOOvYXNhQgzEQtT+oKmHct9RP0iRs
	 kql5U3WT6t/b/rvUqVGJ2PTVi74PlquqHPQhNL94j0b+ehM6zZW1N+Z9pk9q6ozNdqzU+
	 2UAFYx7lUCE9VbOFqRyayvfg3wtjoo9G5ic0IgBpdX7PgN45gug3qZvI2PRlmrBW/2LvR
	 eY9Q+Wc6OrXN/ILt4O5iESZKDDw25e1pj42GZcgLhS7NvM2w2wJo2CNu9JrSH5hx89QDB
	 b0oYmzraTGvEfxJTNU8dNTmkfNtGcrf05ODNDj+GAcdDM5ZAw+srZAon995bPIodDBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789720;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=x4DDgHMGUDoGUNMv7s7GvGD/D44GU6T8zX6XEPszIc8=;
	b=PqfbO5YvR9QMixz31bMpC0t3XffumpbfcOl28EkbYWYBcRTmcbfCMGtOLle5Od4tiq6m
	 ntdqNUNKRtHNWqinGdjAR+MEiluEFZlQLOWGdjlmlnqkdItCfq9CHZF6mmMu/V5DJxkk2
	 7fLWjtByuYKZ1TTX13M6pabEdlJr/X9bGMsPArKgdD51cYDVDhHFK4PXQiHLQU3K7tSPZ
	 B7e4id7Kk6PwXjCzfhKymoAxiiANfYHDnzXoNMaOFQi4EX9i7sQ76a55/mD9lX5CtjNj+
	 yvKr1tNec0oewVGiiiaw4RBmPcRlLRJmWHkBDwCcswmrQn9i2rNm+9hDKFvftjAjylA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lulB0Jm0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=joVjI7O5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A585606B40B
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A585606B40B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lulB0Jm0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=joVjI7O5
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1HMG2683919
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x4DDgHMGUDoGUNMv7s7GvGD/D44GU6T8zX6XEPszIc8=; b=lulB0Jm0sBwZApTa
	ocZKVKaV6qr++oOxS1yVEAozW9+QnCdQD23D71LUCQ1l7S1ngXwE/hoq3j4SvpYT
	YCDCz6sRjA00Rlv/qS8ZQiOx7hR3XsRLDnZXi6lnlfYhRyUJfISPlRCjeOY01fOK
	czf+KIT/23+9vdGumgBa6euC4Nj1nH+3z0emeoabTYvJ70mnSe4ZQOlCVv2ptzNO
	FJSiAHlFSG2ufWZPemjmOO31DX35BZ/mlcXaC83FT73qUdYZGyHs9YUod/HmECOR
	Hb4B8gxrYAiU5PNsnd8JDIpVqrQ6VcvLIVLrqekDkp74M8vtZ8ZbnbrVxmaHB5IY
	6avXWA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhj1c3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f02c63901aso73057415ad.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795789718; x=1796394518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4DDgHMGUDoGUNMv7s7GvGD/D44GU6T8zX6XEPszIc8=;
        b=joVjI7O5LwPSNZDoPBf1UuomvNTg1A1LCV+SUQR8t9xceLGBv2lnI+HXGpCrFyP8fc
         ip5+eMoIYM9eMIKHFW6sm8Q8tmwwNNTIuFb1RF7PFM/tM1lfYACu0HzovhHJwSp7vwrl
         /lAdYHo5bdKq1+wbOzSo09FIdL+xiYOcPRnmS43kky17k+pSf79KE0yQyEzjLG4BHBCH
         Eh/cuG3AU63KQo6mfXL7ochhzUJgfgJfE1gpIZ/n5+mGAeDwGEgzqzmApLOYB+L2E3pb
         U4dWJoYF4a1KUhAf95lGgFZhwBQ9wFa1yeQshnGYRHQoOjdAsyav9HkEo4zgtohckWDv
         mJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789718; x=1796394518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x4DDgHMGUDoGUNMv7s7GvGD/D44GU6T8zX6XEPszIc8=;
        b=OZGkQ2stUxwNAUCxfG1MQLRxQKYXILe3xpLxTQexvxlx0ciC3YUtGqwrkZEMC8oeTG
         IHbDo/vAWnHgwCfQUAv47MrBgv4YwTM0rXU/sLjH0rcSBBqkZ3cph6A5eEs6Yu8VgrjO
         7pXpFuijutLYypEs1IPI+SJpwNQODCs9xL3+79XFLuGbHF1EDFfsBmU4VWOKsY8zKZYs
         Dx1vwfQhnSmu1+ybS7Z/s/qAH4Mk3I2PqrA1IxJwoltNCN5tVvVWBixU14kWiPoHL+a+
         mlkx7mEaa1rFdQMP3T7KXH8F5xNGFNur2DOoIyzuxaCJwfbznHLak+sInnXEqa77rTT1
         LLDg==
X-Forwarded-Encrypted: i=1; AL+hErEpLVEREnPgJlMWoiKLFgDsGrv+t+7htkzNeCXkxlrezcsuU8irTudDtx4DxPiC49zH1oD1imyc3w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+6I4uVZRlzSiRd1q/pWuUFA13+GsUPqucMocim3I5KWpEtkTHZ
	75VLpw2zBsZrcbntNBX62laQKKTL52gxd5d3TFQufsSUea5NnhkuoEQO7UjxI9IfuS+z2frImu4
	C59G8ARk6EMSgXrRc0xZ8DjkhmsUIjFHswjhQf/K/hApOh5MRTl51NFNeLjyg/g==
X-Gm-Gg: AZFdTZfqKnFjWhvAFWKjbucGvvT9Ojjikfbh4+2+PpSNSX1w7FayYddTOVaOqUbMnu8
	0+NnOMP2drn2xknnHbuK4KBk5jOTVVXVQHg+ldNZHogwgYirss7ohgdMslUg0FETvoi7PVTFS4Q
	yZJU7Hx2L0sIzJ29VT7w4paUhbet7UnI4W7/Bngy+BACb/8j8/qKPbPUvuJitFQKCGi7CTNXcwd
	mkxiZ5YdBRXAyUhQ3wCmFVemojM+TXJ47y90dsenQsCZASrz4EExlmqsZACSI+5qvmfou4Cw/Cq
	zBETxnlCjseezPgH2VZAk05MBdcN4oqcNCvxcYJyAD0or7xk8YFXHKC07HJgrmd5cllrzGy8tIK
	9a2H5tebl6yqzUKtSXu3PSoEqlhgk+gLuzTXI6yZJl5e7kFCSgRM4w5/KPr9Bv3HPoCrD8Odp+x
	VY+ZYA6aGJqw==
X-Received: by 2002:a17:902:e845:b0:2e9:5714:6087 with SMTP id d9443c01a7336-2f03ef58f10mr266789825ad.5.1795789717260;
        Fri, 27 Nov 2026 06:28:37 -0800 (PST)
X-Received: by 2002:a17:902:e845:b0:2e9:5714:6087 with SMTP id d9443c01a7336-2f03ef58f10mr266789325ad.5.1795789716664;
        Fri, 27 Nov 2026 06:28:36 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm120324055ad.3.2026.11.27.06.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:28:36 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:57:01 +0530
Subject: [PATCH v28 08/10] arm64: dts: qcom: Add psci reboot-modes for
 lemans boards
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
Message-Id: <20261127-arm-psci-system_reset2-vendor-reboots-v28-8-da05a33b08d8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795789617; l=2237;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=9Y63x7L/VrfGqCVKiXMQ6AYnOAt/WI1fwM2YMUVkWxE=;
 b=FG4TKnzLBLe9HV5AzTlr7b2MHYUXVG43f5q7Y7s9PtvUaXhNbwL2HMGwz2MozLLgIADtTWyWV
 pMafjfO+iWwDjSO+dR8pRdxRD1N3/ZyzPh0AecuOnr0+xXelclU9osK
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX7/Ej5IhWf07V
 00YCYhI8bmypDGYoDwzWUP/VWLaTopiOjQrai5aIETX5Z8OFUvCoMFDyD97uxFRyPoaNgV3uFtw
 lfVWrHcoHvJvG36lDnPB22hnvfsrod4=
X-Proofpoint-ORIG-GUID: gg6N1FtIXW4RXveLMAIOIp6Si_R4wu9-
X-Proofpoint-GUID: gg6N1FtIXW4RXveLMAIOIp6Si_R4wu9-
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b099396 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX9MSvXyqdtfyw
 rXA2SVdVZ5Osirs3KG8P8awZsc65xTOJQeIQgEoartE2GCKA0fwbd/Mz2hwfSthO8c3NCe4IRVF
 sR0PS1SsLrmvGAmMV0B7v3/f/F3mXEOSdekJal6Q/xYO6X3lysdeD4nmgese7leyVI37PwZPsBs
 krdkTnJKzQO072JgVV0Z8K+z1wHzx0aEJ66kbjJAQFO1RDf8t9LnR8eTotPNH5DNDcRjnVwmHYx
 VMuiYSdwZeIstyd1V0P/3BpQQQhyrk7noeIyDy2ff9+4ac9Qzk6NTxnk3Pbxm3R2yUMdX610hw8
 Mm3/k8qTPLXydrlgB3Xcn0hyM0QzCZ1CLmRxy6H8B2ZTQBZnejS9ei3sfvExWDujjc+wUL4yyR2
 qyGHa11O9OiaeiXSzSUu5hVR7HFjwBgcRTdZ//lW4hMeOkyY7s9ZVnl9bX1VriZZyq3pzDgwQM7
 ZNdF+G5wvv+SBb9G+cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057

Add PSCI SYSTEM_RESET2 reboot-modes for lemans-evk and
lemans-ride-common(sa8775p-ride, sa8775p-ride-r3, qcs9100-ride,
qcs9100-ride-r3) for use by the psci-reboot-mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts          | 7 +++++++
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi             | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 603a3fa18994a..69617c4e43df4 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -912,6 +912,13 @@ usb2_id: usb2-id-state {
 	};
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qup_i2c19_default {
 	drive-strength = <2>;
 	bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
index 22f764b8d721d..a530a363a9bf1 100644
--- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
@@ -800,6 +800,13 @@ &pmm8654au_3_gpios {
 			  "GNSS_BOOT_MODE";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index e298747c06bc4..a3f0eb587ba62 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -296,7 +296,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47B36A35A
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768932; cv=none; b=bAbPKemHJ6V7AILcWk07wJuwm6vqqBvl+JLd/hlU6pKWSDJKRa668KDQR6zy8435G9hEU3DNmSmqshbR/KD56U+G1IXWgQeq6GwHNv59QpQndn2KmYyVFArqeYsNio3PceY5TtCbglrVTN+4j3YZY3lH0/r2Fz3ubjICsG50Tg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768932; c=relaxed/simple;
	bh=hQWk5GnSgPwZS2e2a67KLI3RcOaWHf38dgj5HvuzzxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfP7SkQJhvcTj2/P1Hg/QBBzAOaISgS3LC6uuCYyXf3dXBNPzHkvRxh8VL4COqnJfkW8rg7YbtHr6bNUSUs4R6N8jSnA2hFkPghmoZjuPXZn8FY3+mPWVJ6Xvoqo43WZgR9+++leLOcONdkYRphrFXqTcxs4jVquPLXHQqdSjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gnaUlrBt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V2Sq7VMw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gnaUlrBt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V2Sq7VMw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeUi22241709
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z3gmXevIZBqHz/6HbBP+YQLOenk6XainQhMGwbD9zac=; b=gnaUlrBtcmS0yLMj
	vnRNkqwnm2zN+h3FF5X4ixzhDVvpd0mG6TP/s5+7fOYUaDQZRnLmj4VvKeKKpoor
	op+2LjuHq6qdeQMCZuiU+0S53gGhSsTFWqqA0mGixkqkZVw/2Iwo3KQh0y+IPAWk
	ATJ96uE57gT/luf7y5L/5DGSAdXu7nm6ttZ17nhyo7g44pryVTy0uJNfUr75tmG3
	0oI71fdz4XFj2csQjgQGHxshAoP3Sc5CWVps31rAs8L3XSiO26Yrc7aapFcpxDU0
	+QpKtMxx/bLpQhrWpXP9d5gSgb5F6JTht42+rejUgKDiQMAEOMAHe8ojhNEAhS9T
	jQd+TQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513gb270-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba3245a43dso73544455ad.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778768930; x=1779373730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3gmXevIZBqHz/6HbBP+YQLOenk6XainQhMGwbD9zac=;
        b=V2Sq7VMwpC8x3jANRCDeUxejcU36ry6+wC8p3xmajwW6a9w1xPzMQrhSugBFQmAOP6
         DzCYLgH+6i5OJqj26pfVRj8D/nf2nbE/QEJu5yUDdyN091AJyLPybfsM9yjUpSYFaWN4
         aaDQvferhYxTbrx2di5A8OqQIGAe0Eu3XjaM8jZV21MWNgPUkJ7kEEJcAkQ9zXXWndRb
         Fc+HFD5XPl+sSSf8nB4HpV7PWcfi8rBhI7man0DEOc1RIBg1Ua0GHUyAMdSBY990bRdZ
         3Tz7L7i/1fS7/HYoIQO4h5/JIz7vx8fNV/WruF6h5jqIsq1wry8I1OmZcDLmBydAWkLu
         R7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768930; x=1779373730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z3gmXevIZBqHz/6HbBP+YQLOenk6XainQhMGwbD9zac=;
        b=NmkL8VYWjH2uWHmhxAKRnC3w/Pra4xuYl5eUGwoY4B8dCr9eH4So62iYdDOi1Ae9tL
         Bg4L+uDhMICQYWvUcD/KpBtGCWECFU7KB2jkJzx6F29qPl4Bnz+0y9dkSLryzhSsl6xO
         gtbkpOe6z2CAyWTma46grPYGJD5w9hmNsnreVnwi4i6B7jfe+2Bb4dy7hHbJuMtyoBjV
         1JlB6jjoqYscGz1MSdJ5BP3+vj2BxQTPC4nf2lsxAUDWwADrp0ETnnZZptZeycGQ4iKJ
         Ax60gmWuDJntV4Le34xm356IQLwTwydGpAmfVGqN8eUPpjL92YoeLRX0PmCb2pSJhIOX
         LnEA==
X-Gm-Message-State: AOJu0YwmGA/uT8Z4XmbIs0s+ueS9NK7bfgRtCilWbqjQnNKJN8Og8QSm
	uUzB/fqoMrITPXMH2IEsqQXoj/Xy8G4IR2uG9jP//6zjYGIQWzKRZFXSQsp9bNZpmnjGPIya39s
	NW4xCFsOqjo4lS9RBnVYSS+wGk0o12Y7hsyGBleoI7kim+/pDShMyt/A1BZvQ2Q==
X-Gm-Gg: Acq92OGHA9uXYkGf46irgjB1iTvA9qezzN3NCGzXfHsd357vqCQ07GvsiM65TbFURTZ
	g/1jtZuz98cjgR+LvfJWAq5g4zzOjbWm6QOV/zFWLmkZE2wJMrINsiiFC9I/mpmkPkCal+jD86/
	N0xPpgDqmPU0mx0xfUZRcfrnRtlkEXtvJNmpWnV7PBg7SbCUnAt28x/WZXH8WGxrwm3L0tQ7i/h
	2AN8ICJHvlkvwr1j8NE8vd338O5q1Py9AA9ESEASZZS1OwlQN2hX9GPR6s9n9k0t7iy3DkKq2RF
	PII7PhzMqs+qR1oj/+0b0t0D01F/s0Px8my9j7AvxMtvJeSlnSmTEn6xdovo69b6SC1hnBvolpm
	YrlMRz8ElT1LjREyC0Hf/2aiT5zLq7jZjS8l28FuDElzK0YTjmbPkIz35gQ==
X-Received: by 2002:a17:903:fa5:b0:2bc:f3f5:a6c3 with SMTP id d9443c01a7336-2bd276f2a78mr89745745ad.39.1778768929776;
        Thu, 14 May 2026 07:28:49 -0700 (PDT)
X-Received: by 2002:a17:903:fa5:b0:2bc:f3f5:a6c3 with SMTP id d9443c01a7336-2bd276f2a78mr89745225ad.39.1778768929231;
        Thu, 14 May 2026 07:28:49 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ffbesm28566485ad.27.2026.05.14.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:28:48 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 14 May 2026 19:55:52 +0530
Subject: [PATCH v22 11/13] arm64: dts: qcom: Add psci reboot-modes for
 lemans boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-arm-psci-system_reset2-vendor-reboots-v22-11-28a5bde07483@oss.qualcomm.com>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
In-Reply-To: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778768806; l=2346;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=hQWk5GnSgPwZS2e2a67KLI3RcOaWHf38dgj5HvuzzxY=;
 b=8HTGNQ569NTCRAx7lz4yBrYgkXlEUi/4SOkrgYaKZRigAugMeSI6jpFJU4nygrEPOBC4fE1SH
 3jYOuzc8rIMDsTnHivJRdKPKjx/MAVpDeDU87PiKaiePS32/DUYOZ8J
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0NiBTYWx0ZWRfX/g/8wspYA/1a
 jEHJCSn/TWyJXE9k9+vrlB185ZS43M2XqYZpNMYcSepGV2v8nQrqSj4S6K0wP34ofExtWuDa0ih
 WejED1X20t6PEodMA1OPrmoqK3wMxWp78PUqt5kwcB0fZtsBDvuw57m4yL4s2DBuMdbqpSfc2AK
 48zMbpHhpRaoiNQs+1ljszERnl+RDgTMSHhUgOxTx41ckl9DqDoo1UkkOYYTbNicDN4I/UbLp5J
 1b8gd/8klEdQtd26Pq+iXt62SBBpdWOjtFK5Y2PhWpGAaiM3Zgavt5o7DQjhGiKpKJF6zwAI9Gz
 glW9rmvpOYfuW8DoHIwqOUIgbggmnnsmO2uvcs2yiLCntrsVgKydaJVvHBXZGH7G3WxT6/7Hx6w
 NAz7ksGw3blj6B01+10ZRjQydnOUU0HgcDPaDj43Gn/b1+QjvhYSGXYDT38VDTTmuqlVl2k00yN
 rPDBWwCNYG9+UKQNKOQ==
X-Proofpoint-ORIG-GUID: Nfzjc2hcOD7UGItLTGdXFFuhqsyCkcw5
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a05dc22 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Nfzjc2hcOD7UGItLTGdXFFuhqsyCkcw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140146

Add PSCI SYSTEM_RESET2 reboot-modes for lemans-evk and
lemans-ride-common(sa8775p-ride, sa8775p-ride-r3, qcs9100-ride,
qcs9100-ride-r3) for use by the psci-reboot-mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts          | 7 +++++++
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi             | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c665db6a4595cef441f4bd5ba21fe133652b97c6..8be0f50188839e6301e33a50948a523825fc5a6a 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -758,6 +758,13 @@ usb2_id: usb2-id-state {
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
index 40f88498999bd89e030a6685e6b84e7283e866c6..2a9ef170f654b1e270b1fa6d4b861dc0c4642760 100644
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
index 84a1e5ebbf5e58b2fe11978c3af08cda614605f0..447d80aec5bfa1fcf11a933669f4740ef310c9c2 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -559,7 +559,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


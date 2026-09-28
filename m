Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2037E5D4
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575870; cv=none; b=JJP/D4UGBbFuDwwMn/1NPA+wiriZJ7SNo+81tNwTt/LcpRmwjMFjbOwKlmqZsA5y0uqQRAJGLjg3e/MHo00SgF2ISAQE5NvWV7at8dsZ9XZufoHEJxJ9JSpKRKPlFGnHfnUubUWCQTYIfnbBW//1YeEcN0qCQTNWNkrYNRbLr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575870; c=relaxed/simple;
	bh=HciPNJeroVrXrUOsjAQZrtcE5R9UzHaUh1eqHckGx+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQQZUnWQpEtEsn7f1Cok/mTjp6t1e8TpCCgM0JoQnKt2PxlgVtkOlRHHuj+SGR5uPNiUUlIZrntwgJD3zsmKrwvVlfrV0KMQejrzRNC/kLVukS0Va1qw+xv6mNYkNf/jxEro8PcP/23Gnwd3L1ubRQ+J5IUavIRfNlYXTi+5A04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lT6eAn09; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OtXwLI+1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lT6eAn09";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OtXwLI+1"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S0pHTF3890290
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	btXV6KHGAw3+GaDmIGslj+LlIRfZXkr4tQ4AjomFcuM=; b=lT6eAn09ZKNl93FF
	IwDLvdXtBQkdHxmSi419qsPKTJyUZUAfCVYakruwKtcv3xSjTGH8pNaLuj9LpgCr
	Xvp0SS9c6YJBSzSfwFHCDQRz/oPKWMmXUvbyUDnUYQNcA/+iSsI2bzHL9OZE2zq5
	nUm6OwK43BhDnkJUyhWz06+iUXWor20dYxEf+myujaQfhrpwCacO5hdGCxSlnHaI
	DTPQ67V2lOlfENuhT9DeZorI9+jKq9rIBpxKTm2Y+dlmPIgRgRIk0i+flndELyaM
	h9LL6nB5Ja42OGVkksvsSMSx11VZBguVxWWANfy+2lJAPffSI9e+enNMkmbDQt7X
	lTC1UA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jvmjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:11:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so2032151a91.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790575868; x=1791180668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btXV6KHGAw3+GaDmIGslj+LlIRfZXkr4tQ4AjomFcuM=;
        b=OtXwLI+1cbHwS+BkmEm2a963LbSE8+iYVF3L0vVTnpD3nTKxWQwCxL0E2oQl01w3ep
         gd9T+CI61e5SvmBJi0CxmrOBPdIRlfL1R872grFEjNolpJSyd8VmIsSvyvm7/kIsKxBt
         CjnZQonyq1L2d9feOnpnxZRefHjBKkEHtg/8cJSsFsccBErCSa3JJH3Ve9CIDH9y9ALR
         UzSdlvuyu1SWqBeO7kNa9/L0tZTk9uaBHFVJUp1wYqfVHUv1kDh5ScCyFmy+7fWJ5t9J
         e2ev1AwajObCYOcXu10mvlqk14bqPBcSWsWlWpSXDGTtgXjMOcKZZDG7C6NGyU811W25
         mrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575868; x=1791180668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btXV6KHGAw3+GaDmIGslj+LlIRfZXkr4tQ4AjomFcuM=;
        b=2E2RsjenCUTythcC6lRz/3Qx/eQqCSWUsSYKYKhmRnvdTDyk5wLWmV+khP82nCaSf9
         rfh4DdBKXYeXspAw5tKTWloXkkSqPilGSK/DZwF6UsgS2/wqecgE9/+b6CjfpWh2zjVl
         jpnBwyuZCb2LeBooxXRjrFVnywclq/qAbBwQxakU1Ek2vaneMG7U68PQCQDJ7VLUAzO1
         IHxeHaq7Hv1ZKk2FcuUHWeftHf3GyEHgSAVy6E1l9UBYvE9yEdffAvfFk4gSdDF/9YzQ
         ZQ6tbPtdNs2Cz9sDsbMGvP2sArSCujtVIt9vbe70edk3DyaOxLbre6INCTpKTJ+lG8hB
         Ha2w==
X-Forwarded-Encrypted: i=1; AKwUvBw4fNQEgIG9CWy4ne2xetj9bK7cvPTO9x0PQ21dgBeoEqiUiyg+z6O3ElJ5sOdpf6jDUm5oOpyGxQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKP+npfsTxqWQMbrpoI/spbWL2Pzi662j8S1mUd57Kbltoqlu8Y
	WzI12m1yqNReWQK79UsU1kr9quAGE7PayqZ/R11SCdQeTaTWSrPNZVN1TV2Ruv53Z4aePW0N/qv
	vVV4U3N3XLEtxeE+6aRkhZFanDU/45EyeuAeU+c9To3G/S5VtE3eeoeBY1lDLqw==
X-Gm-Gg: AYBFou0spk2N3RybPZIFrIU3gs4oHBufRlmhwOOSSLQWKK/T0DuoramMbet6l7MnN42
	wHm/xQ+xsc8oVrMR4a7zS//UAurA4NiKWbqqoAa+6IGDuXObLee9HYnfmNEhh+Ny13fJLooecpR
	v+2F4sR9uPKjQlu80u50A5I8uqWiRoOCZ4MYp5dMaQiPhPIabmyG4TpMYtytFv6zAdhyrVx597+
	5PXdlcMcU6XxsaCICOPCJ3IwVDvjraFA8U56iZPrFaEU6/vf4iUNC9YEBPgV01BJJJYVeCGDT/P
	LPc9Hxd6ZSNGffKoLH5A8Q8nkLaXDw0cCnEJp2XshDI/r0RZYuSkPKlx3sdoeqr5p7tmr7t7F7t
	aXjSioUNnlg5ojfm4ICOvuN4rKapQpz+F5XZP
X-Received: by 2002:a17:90b:5447:b0:3a0:af81:3bb4 with SMTP id 98e67ed59e1d1-3a0af813ec3mr8396937a91.3.1790575867629;
        Sun, 27 Sep 2026 23:11:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5447:b0:3a0:af81:3bb4 with SMTP id 98e67ed59e1d1-3a0af813ec3mr8396900a91.3.1790575867160;
        Sun, 27 Sep 2026 23:11:07 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm20040846a91.1.2026.09.27.23.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:11:06 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:39:21 +0530
Subject: [PATCH v26 09/10] arm64: dts: qcom: Add psci reboot-modes for
 monaco boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-arm-psci-system_reset2-vendor-reboots-v26-9-b24e2348e8e1@oss.qualcomm.com>
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790575761; l=2076;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=HciPNJeroVrXrUOsjAQZrtcE5R9UzHaUh1eqHckGx+o=;
 b=hPf+aIICqH5htfgWp4dOT7kChia+2ZMeqDSjDVyVxFVsQKuug44L112lAdROLl7vrj4p+53OX
 YYt2OCBrbX+BYkXzqST4XOmtjjqMQCT4q7YuDtFj8Sd1NNpXztj7COl
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX3QKpvr6E2b9v
 3vwN/Qjx0uv422wE4Dv/VrLHj3ojpz0zB795cepw/W0gtxTgjd/JOU6NFrdNWTDJOwlfPbUsD5H
 odM0IyHpJNc8Msy3rZwybKMRkPrjmLA=
X-Proofpoint-GUID: 2Dw2Pv9mDoCcq_i8Zizp4YclyqdzKKIr
X-Proofpoint-ORIG-GUID: 2Dw2Pv9mDoCcq_i8Zizp4YclyqdzKKIr
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6aba04fc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfXy2lK/GKZ+hnR
 3/0KlWrYle50BblyAw76kDbhHS6JsEA+qv3HsvdzcH9vQBy109wLog5SrMKCuIjEvreUwksVta6
 rb7NZvFWz2HAkq5FzNj+WGx+wrbvGexgLOHhN8/6ByhKgMUr54GFiXIKCu0WOrsYCQhaT4JWQ7J
 xdh/c9CbDabl895L0e8oiV157csoiUfKLCjSKglXu6jmCzIddG8T//SVy6mc7nxgk5jeNFYqvxj
 +gT6K/NGbPLWcRCmMMh5xVd/bXpv6PJFMBg367fttbaBhl+3M7KKl2hFez9IIn/CjSwv7OJ6CQq
 0+IsQSRFujggUELDtRRyUulpaYTM1CUf1TJovsJAYJYWD26vGJfTZFxvgqc1ioN0Ndlog9ZeBG8
 lOG5Ct89omOMZMQQQcZVbSI9XmUnUmyEUuKvw4NuWVMo1QTprI0M5SPshCmqVZR4NpqIZEqTiq0
 LwGuCDGaBbEGGWJU2fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280024

Add PSCI SYSTEM_RESET2 reboot-modes for monaco-evk and
qcs8300-ride for use by the psci-reboot-mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts   | 7 +++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index 9d17ef7d2caf..df668dbf2bc6 100644
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
index 395d32d36844..9f1ab59dee2d 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -654,7 +654,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 1ff39530ea3d..aa95584b000d 100644
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


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E54825BC
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398085; cv=none; b=qLD0XquyQeYguSwlJu5TxlFD9tHBCDhvpt51CkCqu2/wJ3HeXlwEwRKEy7csqol8yZTkj+2FhLywuNTApe1oo+lfGwBC19oItb510RfcW69QLrXVWAXsWqA08LNdnZ2v3fTy/vW1Oojm71OFvNFjDPf51q8Re2V1UwXYrQoQo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398085; c=relaxed/simple;
	bh=4fTpCSkuJ6PFbWarr8sThQ/LuS8y6G1v4667LcR6KHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYBPvHNPYDlWUmhYe1y2wjltg0DQaPVVj8nz9YL6sc/xCLZy2Ow4XuZbhHp2IXDPXEowElgx68DxpegD4w9DVREcMcqM0UwjUJAatIrhRwgSaDREIYk3eTADymWTmI5BacXLKD/5LTpnCL1Ml+dk2XvNvei/kIXSUyOqiVRb2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BuDVlL0u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bLt+8MsX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BuDVlL0u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bLt+8MsX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0Ta71761365
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y8QpsQNU1m4GxJroPAMjexZ1MBknKFRA0AkELRZtXV0=; b=BuDVlL0uPLQkdBFS
	gRWCtoIyDiBTwF4lUx+p42vEDb036xj3A8f+89JrezOJcuVBwwLCiJFPvOD0ra/e
	vQ0a+zi0zZczTmdsi8H188hBQTYvGIvsWDmAsJT9bmOOKfD+H3tG3SU3CmEVgt+Q
	oHeS7QDwwsDusUEXQIJLco5XBChlHMyktNnCg8azHxOjURS4/W11rHts2dO7cN6m
	T8LkkocuB5oGBNt6o+bMHI5JJ4C9zcOQLGw7dZyB3fqa3vLrRo7HzDIOHgkj+BF9
	tHaaQH4WefSa+HFvFQmGoyxwRJ0rJGGsG6S94iC3/EU0mKry3dadSV+CWb/+fask
	yO52TA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeex98c4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:01:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd667770efso7782735ad.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789398082; x=1790002882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8QpsQNU1m4GxJroPAMjexZ1MBknKFRA0AkELRZtXV0=;
        b=bLt+8MsXKohEZkZ/v5x6taQBYhqt38tplqKnUUAqJPKJLfqOD5DTzsoXQs7WhR6eBx
         3q5MNCM2O2eiVEWLlrGulcHEGkEfP95kpFKiPzcYaiy5B+w6GsIZrBA+OBLBfD/at62V
         eVFwv1Eclj/NJxTHtDkEnGnlG1KZyTkY/RYfajp4bymGu8ztmkwUK6OedAfgFy9K9us4
         G7UdFxHUAyGqep00TLctFPInstu739lkeonLxz7ANmfB7x/hGK+2fpfq5m61XIixFEpg
         TZ51GaEe3IWdphAXWns7o+ufuXpLHOMwpdnvMD0vVIttGSTQwUG8RkLQEh3lA/a58CXB
         YqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789398082; x=1790002882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y8QpsQNU1m4GxJroPAMjexZ1MBknKFRA0AkELRZtXV0=;
        b=XeAbLKrhtkruWEsBTWxD2cRAXDuLxRmbfGWx0kEm4vxAYSPWoqtcMpS+IJDVW1U44R
         /ag52wTy1OP/HwVmTRPvYQ44a5+84bgGEeSC73Qzu1cbmaELxr33IHx3+l584OfeVafw
         PKIT3tJpZwnID0WR3DmgJ3QFu/5ZAfGCAvQ8BDnlv7zYUpoD07/eSsjbQnFWiy0iobiA
         wBOBtO19TUqrZ9h2ZTG2TAph4OtkwPTWDla4MWPaZEhzP7X4raMysgoJlAwDak6FEW7A
         vqE+I6GmC8kF0OqKvq36RrPjsnDLmBEV+2ZzoVdb083NjNf1/N3oERG4iT47DW6MxsS4
         n/EQ==
X-Forwarded-Encrypted: i=1; AKwUvBwu00yHMIl98n2wdp9vAXKgrcCPJr+6+H+tPNmKq5MsCNrmcz7jw1dz338+6lisSp/Rq2rqLp8bJQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mEVy1GLB2tQ3OMjtOXhe1P7Oz3UKVGIB7eA6ZWZc1mwPT772TX
	uQy+6wJH9O97jV37zSxTJl3G1ouZCfbeeVF0XtLnr6UneUEi2zkmP8Xb+tkD7NmAISDqZYI/r/C
	7A/jQbT5tBNciARSSqbvqyczrevWK3cJ3aLh5m0NwykmxKtaSa8sxn135om8SGA==
X-Gm-Gg: AYBFou3lmtdTubv+IMTyH+LIDdvux2D/eggP+vfpG1+nnoHNNrXlZdlftIz6BghPh+x
	x7dL3AqkwSMUeqCzNqOdFAeeJBIwcaJ4eosBRjVRG8WbnjPN5wx+FiMAPpAwXGTVTPCyePaSRry
	7sAfLreU+jGFKFu3VndlzcHH99k/q6i3B6bec+CuCJS6xjqrW97f6IBwz88A6fIorZL8WzBJdzL
	hpDT/2Y0cbL7OF61BGRvkYO7G86MwAiVpx6YBV4TH56EP25wcX/c+ff/Pd0wmpIJefBA2qF2hLI
	oOLS6v/mHHuwhT8bXmRiE1ebbYR1/Jlc0UZG+FPPRYbu+2DEh3v/h818jLKGy8hW5hWnsqTYfr3
	VknrHaf8z6Aqd/d5IcjIaC22IO/8yG7zdO3FY
X-Received: by 2002:a17:902:ec84:b0:2d8:d4cf:fe48 with SMTP id d9443c01a7336-2dd6c7af936mr37525955ad.14.1789398081792;
        Mon, 14 Sep 2026 08:01:21 -0700 (PDT)
X-Received: by 2002:a17:902:ec84:b0:2d8:d4cf:fe48 with SMTP id d9443c01a7336-2dd6c7af936mr37524975ad.14.1789398080977;
        Mon, 14 Sep 2026 08:01:20 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4007bd4dsm42943345ad.4.2026.09.14.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:01:20 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 20:29:14 +0530
Subject: [PATCH v25 10/10] arm64: dts: qcom: Add psci reboot-modes for
 talos boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-arm-psci-system_reset2-vendor-reboots-v25-10-4aaf5c09b5c2@oss.qualcomm.com>
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
In-Reply-To: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
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
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789397948; l=1558;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=4fTpCSkuJ6PFbWarr8sThQ/LuS8y6G1v4667LcR6KHQ=;
 b=OK+6WeOtO64lo0FcZHTNlZGIoPXAR7yNvptpjLckifVArrp5hx2yljQM7GJx04qdJ9a+fg9n1
 IBav0oSF1hCD7C0am0pWIpUA0S7pbcnv/yiFUJ/CrmRTv4cfbCR4OZq
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfX+A3OIJKrSmgp
 OQUkL19LdmGl1m3OpPtisBjLodn2SPlgx/vk7CzqBudIFnkVDCtqe2pgIYv9+f5CyPvr9kxLmG8
 krmdpVpLWPYFuXYOYsQV1PnnX5OLPBcwlSuKR0VkezsIp63mp5nYYAHKDfe4qpiOV3W3wWq6WJN
 XO7ULlnLbviRC+WU2sQWlOMrFjKd7BHP7Cuy/AwXwau10AmpkVR2Nk/VfTQBkJs/B9eLJX6KerZ
 Sn9kE41ciKK2nr5fzkq2/DVbmsyK0L23OXFrsFaZHXCeEKcKh2hu7qsHVHVWJQmxRsvgyZ4Qu4J
 Ho2SGfrLsZ5AyuKZP1j7++25uSQW1yimKmQIGcLAi3p2Le9YTxCE1kDizW5ZEUyVABV8b8gGIXS
 8XI5XSpqVnXOdTK13dmjMpv6jLNtxTu4IumZMncbkxYntsGLxVC2rZ6M8WWVMFRz8nsTmizKEk0
 BDjncCUF4LKtUcvQy+w==
X-Proofpoint-GUID: 0Ky2n4-F4J7Eqc109lno8t7-P4BNRKll
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfXwofYgx8CMjmK
 RNBfC67e++cQu45GjkC1CS5y1X2wt5yRo6hDFKUc2GmDxyRTNQPOnAZ0QcCE0idpwXCokIbyQ00
 DzxZmjJY6zQqyhsx5fiyC1MDHzgolOg=
X-Proofpoint-ORIG-GUID: 0Ky2n4-F4J7Eqc109lno8t7-P4BNRKll
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa80c42 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=bjH5yOvFM8yfI_BY5k4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140215

Add PSCI SYSTEM_RESET2 reboot-modes for qcs615-ride, for use by the
psci-reboot-mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via the
  Firehose protocol.

  Support for these modes is firmware dependent.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Song Xue <quic_songxue@quicinc.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/talos.dtsi      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 047b4efb04b9..48d3519f50ff 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -498,6 +498,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qspi {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 531cf41b94dc..a2197dec430a 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -581,7 +581,7 @@ pmu-a76 {
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


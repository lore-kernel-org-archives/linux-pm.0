Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F633064A9
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049539; cv=none; b=kB6h4/etWXZ/wXbRl5LxV7MYzxOQ0YN0Qe63b+P/qAWckO60x5gbgUX2GBbkJHIilJ1pt8l/VtXx3trrjVLyBmvXvGcBT+Vq1msjk6ZPDLQ3gj2gqPsTq/phTbfR5QPgXaMLDS8IU2a/ZUCbIOu+HQVD1GQZL+zO4TYeVUMRggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049539; c=relaxed/simple;
	bh=/qLMtF4YYOHcd2N1W678IQPXyBmX86FCA/XfWBXjocw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=suzR1UQhuODdU3ZpmG+XKfUU9FfGJiLX8gxIWCF/kJvptDc2bvVLbsJvA/+lRvjUOS4Yw2zU51miPFKtuyYvNp6IUi4qHqDW9fJuqBAUn9XUmiRyu6hboiEGy7akculSJ0bR4MI7PTZ+Q4qwq26/0wJaXiEoG7abm5wL1273hNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G0qCDEZ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fyk6JADB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0qCDEZ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fyk6JADB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6uCP975506
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WlWwBUz8oIiLyO7bjGs1oO3T6bcXCkYkZ3ytXjL7maA=; b=G0qCDEZ17DRS3o0E
	11ggJ5j39opLgDxXNK/d/wONKxa0fVnp1j9mZQfJ5c51xMnCvqSw+AjQ/xNUsThs
	5KAB7Hc+Lv2RM8XL5wMX1Ojr14IumaPWXwjjM/thnV186H5c+BEnH9Rf6wpe/f9f
	Kgwl7uwHWicwx2y3C1mf+uCPeo7zX7Aig/AfPDNNg21mJCe4OpgOp5jnlQcRKgsA
	1Senm7UsHKP73EwEWGE/ApfeigX/PZY9w0UekDDkNY1tqyApbxNJ3uMlFAqx6/wx
	RQCeM9HFe8/pZuIDQao7b16GfptJPaP2zchdS2djMOIDbzhBlw1EluvDwEd2bJzT
	RvMu9w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq2dda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848544a8496so1580544b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784049535; x=1784654335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WlWwBUz8oIiLyO7bjGs1oO3T6bcXCkYkZ3ytXjL7maA=;
        b=Fyk6JADByf8pihKmgB9KVDx0IvVW7QbC7XbKs/CiAE292mqCdiNvGeuLd5+7L5sA1k
         /YfrnUmm5sG1+ommHZPMQr5iWj5t5ChydpioGK6ajIzcR+tD5uc7GEV7Q+YR/fPzWtRo
         ZV7l7Myak40rQkio2nGh2/RiVKfzwM6LX8NI4p+zUVxLFXrLy2kE7ANaNLE5dDoeNC/D
         tnXkjpTNs+Bq8W2e99e3Q++j1NHI90T/R5xUJT7ZyW4y2Qb2ChVgY9E54YFcgJPfGVsi
         y/xcjw3G00KC9iHPnY142H4qXSTrFJYoZ/+59F9Qjed9AzcpL1GUUL0wVQIJGoYoz32/
         S8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049535; x=1784654335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlWwBUz8oIiLyO7bjGs1oO3T6bcXCkYkZ3ytXjL7maA=;
        b=kWYpw/kcWc2iWzTuaS6Ar06wLYOIx2Ce1W4OVjBN7LYpsBbSp9PCAHJVd9BSuS/m/g
         wfor5vapDinrqK3aOBr4bVmJrO2MH2IjY1vv0ghh1zQEpN9uH83yWbVVuWv8/IfyZDcO
         cFHIZK2Wz50QFB0ZKwwADmI7yCQFDcD6kWpCQXmllWAE3BsQe7a/7SzgWUuOXu5IY9nE
         rThVpu9nZ7Jml0Iiqz9XF8F5VEWTYq1HJ1AxY8GtiLoehcWroqBtzn/dy2SUXnNqVfU2
         Ieq6airJJ+y6vp+gmnB0GEzwOeV6s2oxJgmtoXFl/+SsW36YOEeaEkntJVa89iKgRggN
         Mvug==
X-Gm-Message-State: AOJu0YxW40JPxeMM6Zq0EVEXBkjDJ+x5OvsPOI0DlDZYxG2/j3f5WHrs
	YIrvrkcmZR3Qy692QbBMAY7VPVzP3DIBmnlSdUy4k6tFiBhLcGjU1OZV+Ju/RUKK3HsBp9SvZjx
	t73bAMTEqN701cnmdsA6sraW6z9CEubZZJ5vcx8l/tn/10zpDiTmOPlJXtaaT549PWb2JZA==
X-Gm-Gg: AfdE7cnTtkvcq+yk//FGKyn2yODryPZarr2ye8dpqfpe+iUCPKvkgiucOe0mK841Y22
	BcaG0JIgrKfGtxteZsl5xhZM8jTdH2d4hwYTcVYv/6KneLD8jrCx7Vc5ywQvW6fMQMwUZRA0hvx
	EquSnGsE1o6uBH/tV64C6upIfP2nMWDAtVW7OoMk7ilRw5gRXIKFDAKd5QUM8ErM9mB7/OAsOIg
	/zYhcFmL9elR5x7FSdzE+iwpx3IJJ1HUWiZxz8z+set0eSSO298uh0K+8Jc2pr36+3NUSlgZlSh
	UqHPWYL9EB4CsElrQ8eri80Sa5NjM3FWNyAlmqwzCbDjRAW7A6C+Pb/IcGr7SxZILHd5omgUEUn
	7alj/1wOuwadNKvKp/cfJEd79fLYckzlXZ/cAGdcuXWQrjSk=
X-Received: by 2002:a05:6a00:1741:b0:845:e1a3:107e with SMTP id d2e1a72fcca58-848896eb340mr13731435b3a.52.1784049535199;
        Tue, 14 Jul 2026 10:18:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:1741:b0:845:e1a3:107e with SMTP id d2e1a72fcca58-848896eb340mr13731384b3a.52.1784049534635;
        Tue, 14 Jul 2026 10:18:54 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a5bfcc2e5sm731773b3a.56.2026.07.14.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:18:54 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:46:41 +0530
Subject: [PATCH v23 13/13] arm64: dts: qcom: Add psci reboot-modes for
 talos boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-arm-psci-system_reset2-vendor-reboots-v23-13-e7453c548c21@oss.qualcomm.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
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
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784049398; l=1558;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/qLMtF4YYOHcd2N1W678IQPXyBmX86FCA/XfWBXjocw=;
 b=rUE2oOT0yyF7AuITx714xgSvucEBSc9KhTWpFSLaurtFc1XMsG6TrtEbHt/m+uYS94IanfqNZ
 NwgxWKW/LsVC7sB2UWTCKChhYXd85Mq58VSCviNCWEBEwY4SaEZPtkL
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX+qBPLMEKAH9f
 eRqBIJr4HDdfOJR3HxmPnaVWAN9MiMDrqtD4mWspVtSrgYT75QtJ56pyOYCAXDa1QVBgwNyfvff
 SMrbyMYyrW5WDq2RUXHB/janPLn1uwP9oyD5AiUtZEIbgphafpivWd2XNJSGIXkCsXXfkg4ysto
 UTJF/DoW+JyUU7lsg5jc2Hi0+V2ElXsOzqX+1BeCin151KcJI3R3DkdgfbdGccncInn6GaR2pYz
 UCqjR61vQMnAKUmyNjEl/lCEFyXyXGVp5JPYZ6hRQecy0eXnEBEy9rtLdDnN5a/NJn/Y+5f6CvR
 W0Rfly46reM0dFLRqB8xyLqDtskHNivuDAACYEezaG6UmquTXR/Sz1GoQD8kw5lprMEl2c92WlH
 mnDHXl76IZ2LGjt2agc8D0Jrwxmc2wF2nBLfGrJTY/IkwjHwyCZqnWTO0nku8NjxMJF1CCExZOv
 2+jxWlFFJqXOmtylFCQ==
X-Proofpoint-GUID: PcfNrErf9_e0JkVq8mbUcVKq8u8qQpBG
X-Proofpoint-ORIG-GUID: PcfNrErf9_e0JkVq8mbUcVKq8u8qQpBG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX2VaN8BSmrjqP
 9rJXkwRKdChz20TGAfMYCZWqDGM0wlOYnV1H/FnALS5UtvDaBTgpebMcVgGZO2tpxNApwbyMWm6
 UdTk8wjpqCKAbz/g8CcpP4oaahlXB3o=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a566f80 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=bjH5yOvFM8yfI_BY5k4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140178

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
index bdfb70ca9740..6a7ce5a2963a 100644
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


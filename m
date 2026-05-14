Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F8406280
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768953; cv=none; b=r2+wpWpLYEvTxekQ7wSwTW0OPbzoc1cCFtDlkZSEu+sb6SmKabXi/kBHejnK1el3RMX9ZyQq8Y2ykevCmeCbDayDi0qm0cyKsiPidyky/97Qt50VhKAGf2tU0N55AVylOcN7Fl2PsjveOeoRr7Xf3SlvSiMiU6+TRwDEKOxUVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768953; c=relaxed/simple;
	bh=fv/5hA6B5h6bSFJ3jKPW5Yj8V7+yiEtiEsQ3Jf2Ak5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjSIKtTdODGyuZtYyH+fCBkaOZ6dowskuNg3kVdcIaW1bL0ucDQo2Cb7wWPXm+oW2l1Zruuz03AB6zf0JrXyf+EDaW3HsIVi1DvpHLUtMAU9wlyW2Z0NvNceCO6UEyk9DV4DUFIhjdqj6FvWpZmvdb+G2JaW07n7KWo06xwpxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i/7XF9ck; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iEdYyYl4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i/7XF9ck";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iEdYyYl4"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeYwG2241750
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o6KLS8vHiombqosDZEYpdFeq0nG5CyaHud+DvpMo+CE=; b=i/7XF9ckTQVND/dC
	TYkq0l/GzJfcDmNbkYBgu/dmSahdZq+voxXEMKcAkQ9jb3/EwuGoHCDIB9g3hBoL
	q9hjln/GwV1tjG2/W5JoAHU0+pq9IWdB/WR93kiDXc/zJZWyhGwH2aTxEy0ZaFvS
	rPqIeaNy31v4dslLkEQWftw2+af/NBnBK70hNs7ebp06nZLJUVKF7AXg6Jdk/NN8
	5cms4Qk5F2qvkU1BJ4CexyQUXHzxVce0pkvKcF3umunCg1TvR5t2qS1jiqGF8xps
	BX2OmFHWyceJkJzvPJRDywNzES0NDADXC/Wo0ktlcdA7dcPe4HeFe67OTqd7xfSi
	BDLE6A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513gb29d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:29:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba838d3fa4so87736845ad.3
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778768951; x=1779373751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6KLS8vHiombqosDZEYpdFeq0nG5CyaHud+DvpMo+CE=;
        b=iEdYyYl4lphwBFbtQ1IbURYtbPQF+A18cAGAxmobfi4MON7iuVyDf/sJS5bWGjaE8A
         +JV45Bzl9MX0uKlu3XIPiVioGg5jYH8j++5pP8VZNjYG548kRbLBmITO+GKJfFndO3k/
         NZnkrea54xyHWMspgO8fsVcneA+EI8wAoJAEkVsATu8oHH5mFMcMkRwuOeFHfEhjH106
         LVp/GxmsgRPSaGciWHSJY4SLkfN/odIDqm1MOv7D5HRir/F1OaJIXrKo06usyV+p8qkB
         BrahTJxg2ubHs7LVNSY9K+qpazL66qnRqkii6KpQ1BU2AlmZT97nBF3AGFsuut81hLwi
         VRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768951; x=1779373751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6KLS8vHiombqosDZEYpdFeq0nG5CyaHud+DvpMo+CE=;
        b=j3P18nmzYR1DwGlXLgNjyECCiiwqDO73J26iI/OzGD6T0baGRu0qb4fRNGug0CjAYI
         OyGWdd1e+4qphBAMUObQLT07TdZc9cLJTerYmCCa25CtScGCFHoVFMBI5XAmnKJnGc9Z
         aDY3ChzdQHBCxHBOkYpcy7M16+nayBdsp5hOoc9jIWn95D1gxrWjgDldeGqfrrMR2FR1
         VGp2j/8nE5ZPjN6HHkvckjBjSSOvc2+Ojsl+LaB987we0LsinwgW2Nlh+uLgqGnmsA75
         nBJBqH3nA+VbcpmcoE938CjJfMtw55eA6Zq1hf+i2zjrrWkrbQPwvX/1251ISJhsv9dg
         D87g==
X-Gm-Message-State: AOJu0YxB0x8qm/z1GPOI94n+Ro7DL2tYL7BfEsyXk4l7TSTF+o46J6EC
	R0/m7BKt0mXpLOT/9bYJ+dAC0l7S+VJLPWfd5ZQ+vNDjc5fDuDZfTHjpBRJnZpBln6yVjirK+OY
	z+olms9P3O1iC4yFQ897ALTUL3oIgZdo/TLEmvHlgfymuQmSc8c1KCSowlQtwkg==
X-Gm-Gg: Acq92OECJA7PBnHDuFUOv7lssmXp2WfXOnAGNrNL3vyezq+bhlgakfcCJT/1dHQKVLE
	zmBUN4KCqqJwyBnHx+payhwLcIifvzjN4zFzWoLfZM1Px9HC79pT6w2MhS8sGJbjWxosKF2lP2E
	PdjvMTKCX2ZE2t06ydimb97iMuPAt9Xl3Dsldx1KEEedNtUd0tjuvFUP+oye6Z0Cpir7lCDErHl
	eWT4v8NKd59DO+RdsHa7pp+GF9XUbOSYJGsnXJidnn6xc+D2AiYkAlZzjr6jD0vEc9IACHvynur
	ygoMUqFMHOCzJR/BQj8QquaRilNrYr64oMdLzAF3BrO18iev4saJ78luq8/CwnCDbaJDuj28QQt
	GtkVGrGI2xl6rqaXYLtz1RaZqq0BlYI0FGzm6ks3wUSRitjoDG/N2FG994g==
X-Received: by 2002:a17:903:120a:b0:2bc:78ec:54c0 with SMTP id d9443c01a7336-2bd2ff2a51emr89626705ad.31.1778768950476;
        Thu, 14 May 2026 07:29:10 -0700 (PDT)
X-Received: by 2002:a17:903:120a:b0:2bc:78ec:54c0 with SMTP id d9443c01a7336-2bd2ff2a51emr89626035ad.31.1778768949767;
        Thu, 14 May 2026 07:29:09 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ffbesm28566485ad.27.2026.05.14.07.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:29:09 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 14 May 2026 19:55:54 +0530
Subject: [PATCH v22 13/13] arm64: dts: qcom: Add psci reboot-modes for
 talos boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-arm-psci-system_reset2-vendor-reboots-v22-13-28a5bde07483@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778768806; l=1676;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=fv/5hA6B5h6bSFJ3jKPW5Yj8V7+yiEtiEsQ3Jf2Ak5E=;
 b=DTfcdvmuHlaXJOFI959VmgqyKdy4KwC74h60uKvEJMgANVtVK6agBUfCB1qK6VdTsL7mvl14J
 T3zgl6il8yIDiXblCoQ5QJIMe1V8sJGmhryAweJi3aC5fMddvtrdDHs
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0NiBTYWx0ZWRfX2/Jiba0ax1zz
 L6JXDGg6TCEujknyG7dRIjwGZK/J8cm/Tnv5ywHjerrEl95I+Bsi4FYETJhmlCQPlT3ykKtL9ny
 o0XQ6PB18F4aH4TE1xEYm23zy1eU9R9nG+sP2AbFHmGQIK/iavvZ4v4Xgu5J3QIzDutTM/UU7NS
 t4T8uIs6TAevzz6SNoCYkF+ZMCi7fT1WnPC5lGDRSz72Hdyu7iEoe1V23UNr823D7yLbA4NrRQ3
 b+zribbPIGEQm/WqgqoN0x7XBEr9zQDkqr0s/2MhY7yDTeBA2+wy9DqwirMcSjQ1xnKRovZs5JA
 D9bHLDXduMu0pt1WIuVBU6XCLB2wS2gtwWqp78t1meWHgP0I3vOVBMJ5/c24jyj1sPZ830GILIM
 Ma4U4wTEIu/lLaR1CQI9vG1j9kLVkSKZXYG7XJ6lLObjR32C/ia3lB4DuvIlAU7Rh5Bg6YUPIh2
 /nHXRRQn+/Z2dDfzu7Q==
X-Proofpoint-ORIG-GUID: XCJFYReIiNskIDe77glvLQrHAdgelSeU
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a05dc37 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=NtfjKPfcWimlndMDSJoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XCJFYReIiNskIDe77glvLQrHAdgelSeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140146

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
index 831002789838033ff6c4135f2d558a0af0d3ec83..ad488570135591eb7a9e5dec5fb1924163a159e9 100644
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
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index ff5afbfce2a4744777829a1938754f02a5f6cb5c..83ba8d3bc40731f54d71b6892045bc1dd15d320d 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -560,7 +560,7 @@ pmu-a76 {
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


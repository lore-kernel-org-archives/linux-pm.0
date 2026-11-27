Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789708;
	b=zXbzTdHLKvqyBgchabXVTnlmEqYYK2cC3kcYydxTrCXSex1rBk/qDgi5nJlWLfoDKUwx
	 Hq8p3LbkLN8ofWVfdc5AEIbgbjKzZ+IZGzI1rqAJAMczPQxJT/oRyZjpDWKmRuGEoKCS+
	 mmvJSWWHqSAva/ethkOQvvMWpZhran8pIvNmritKrMWbtGi+B7U65mVu1RIQ9ZQxsOXog
	 B5QNpIHDApxoE3LhlT1E82GMHVJ/KIK0Tf3f941+AH49Oqf1+tM0ElXb1Ihgy3UJd1XOf
	 7wN+H/DWiKLr9Imu7O1Fzc4CxDLJOFgeof9wN8EBbWzV/GXODAmkwJ6Z2oyjubYzHyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789708;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jS9BluJCySaQDiQCJg/b5xIv0etaVg+CtYndynJGMRY=;
	b=09SqZ/NGtJMrycQlqe1x/B3VFjoGb9H4AEDdtfPjkT5Hx+D/gpn/0mWCzx/OpqemteaP
	 GXV417SHUjhBBJ+iNSbXtuKDUtc/kJ+LphE5s5NS/PkW6LnSpgOXXIRvSv4abB822IxyQ
	 0cmEul+f5rozV5TMRgvTy8S71xy8EsgsBfIkLVIvmwkurbCfL97tmV0bg9wenbOHMPXEo
	 Cl4e2NoLsc520/+AE4cpbygtXtcL16gSfw1Vl+zUb+ZpMPS3e2KHhuwb4F1k7i5fYh+QF
	 WL1/hZk6k3EEYq8lOlAEAQ6sRBteSZRWl+rhlbYjveHJm6MA3B49W8mJDMUGJfLiaKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bPBsS79E;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QIJDayTd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C4606B421
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE9C4606B421
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bPBsS79E;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QIJDayTd
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Q0H1462721
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jS9BluJCySaQDiQCJg/b5xIv0etaVg+CtYndynJGMRY=; b=bPBsS79EvMz4ITgt
	ZIE9FSOFkFramLP0e2R0p2Nzd8F8UO2hZjbGFGgTr1PNVQKEZeJVZEUyVgqssqB2
	kvwbvJhN4IzWO+rF0VZTPPUUjwVmkv6oFAbNJZXEoS5BqTQseEqiRum6Uc9YvFIJ
	asWiZKJGLGkumLuTcUUS8qIafHn/sGvCZOm7+IxgHk59rd4ehGDLqE7Yf34j2IwC
	7iKN4boWKj855Whq/gkD4wxbvXMrHU60QCkhXmqx6MyB+uXgi79wIMBo8YQOZr7L
	loi56rLpUeOYoFI7vNYAL7bKS5uZMkAxFDDerHuHAUlJk/NhV2lo0WMkNIGUJkD5
	eZurVg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqmc6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:28:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f0717e54b0so57896245ad.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795789707; x=1796394507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jS9BluJCySaQDiQCJg/b5xIv0etaVg+CtYndynJGMRY=;
        b=QIJDayTdtjCYTiOQuEpO57m5JZdsG/AKEi1bGbwM/Y38tqsIjqzau71EE5XeHwuCR6
         HProVHdlY87wsHboe8AAv9+yNXwRzMNtLICdHR2EStCQ5QiCkIWOH+7CjtOdYmp/DVXp
         3Gl+smywFuMi+jRgL6igxWHFaGX/JNE/Go5DtDXm1QsDudWnTWdc01Zej9KMVNH1UR+x
         SAKQ35ZU8FoscqnAppiFXB1zXeQ9K8VC4hnLGv3v2xfO8btU3nWLZ0mS90eET0mTA0Pe
         c2ZQmbjVa8r8/7oDTuY5O2W2fwpIiloAuVp6ee/A8i63+HwcQND8cF4Dt5HkpAi1FjSd
         G5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789707; x=1796394507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jS9BluJCySaQDiQCJg/b5xIv0etaVg+CtYndynJGMRY=;
        b=o6i2okY46jK6k6zfamvuozUkRGK79piBQdV7J42BOsBUkxV3wDxYojwJbCenpUawTh
         i8u19RvG0QWvXCl/1o54jtsqk6UfYX5JHncFksH6mawFljFhfsTYcGtlXFsAhjQhHXh4
         qsZJ7QjU9s3dtTVMj/6PzOMrrP5xDKGLOV2q4Eu3qfdHCYEkUIdSlafyQ9rfBmPv5IN2
         h+42g6bHyGFGNv2/DLxeFRMntl4K3QO2WNwv/GglqFKMXueKUGZJ4sQGoqGKDCTsVtbx
         BlvzYUEhsmhXNiTkbPr8dfgw1w8Y/k45fjf8NfnIXbwFxlABjbwwA/ETb6PeGYkhUnjK
         Qpmg==
X-Forwarded-Encrypted: i=1; AL+hErGDqVYsbhGo01vw0bTf5/JKHiqh2dLwCpVLehqo0XZMGZi4y3VszklRlxdg39BO3b3P4yjTE/5oGw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9UyvFfJIPcWPBxHJGne4PwrJ9NlAa+eILdHPGkMxMPHNChEl4r
	QCVJQvo8IN/srtjEM7y6TfhGujumMn0So8Salxof79313+hMfAaTR3Z0u88yIEBR05G/ky7O66u
	Jdjz31+Uw4wm1d9ivpcw6iyK5klvBpHBazzFvfiS0r0H7RJrbGOstxFhmspW34g==
X-Gm-Gg: AZFdTZcn1KJZbCsyj11zh4uJd3ox5xjcPAkoOiSouYQ3cv0RzKDGE2nEZhe2E0iYAHt
	YEyTPg8uZ2y2FDSg227VSG0Mky191vKeMrL482m8Tsun5lyAS2PDLHH6WwFmVs70BzNzGOudGPl
	TudigSsVX77O7m7MPaCO0zFpM0xt1yR8M8QJNEGyA8VFiPPWFbax6ZjoCn/lQLMRCmFxn6ZSouP
	v4V68ZG3d6oKomGbOD4tsXjyGJQSJBwbodQf1mTwhYgIbdFJJO7qjuCk5zf2KR06pNSZx1efeGG
	9BN1pofzMcBanLXz3XrkHxl+U7/cNXPOO9GI2LFF64WE1A+GR+0tCAXnFW9ZzGphIFFvsHDWxp4
	MNVWtFz3fjYCUMtz73dpa8PISgWp7J7DRz+Hg7hFSRk1NRPdTyqqclX+Nmvp0pf8oHMAtjZeIN9
	332WUm87yM8A==
X-Received: by 2002:a17:903:1ac8:b0:2f0:a586:81d9 with SMTP id d9443c01a7336-2f0a58682a8mr170116635ad.50.1795789706526;
        Fri, 27 Nov 2026 06:28:26 -0800 (PST)
X-Received: by 2002:a17:903:1ac8:b0:2f0:a586:81d9 with SMTP id d9443c01a7336-2f0a58682a8mr170115435ad.50.1795789705484;
        Fri, 27 Nov 2026 06:28:25 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm120324055ad.3.2026.11.27.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:28:25 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:57:00 +0530
Subject: [PATCH v28 07/10] arm64: dts: qcom: Add psci reboot-modes for
 kodiak boards
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
Message-Id: <20261127-arm-psci-system_reset2-vendor-reboots-v28-7-da05a33b08d8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795789617; l=2209;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=0YQGDiz1F/FLEBDHTFy0NPa6QbvpSRgMVp0jR7EbIWg=;
 b=hH1f/4RdTgXXzUD3HLooxCXl7oj1YeLziyFQ1gZrW49x1biAd1StmoVIoK3SxAEPlFz4X4Fht
 FHtkMV+tGSPBpLein2a+YAXPEHX4HXgHfK3UpVGEududkLK7ut2VfC7
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-GUID: HeoLedppWz28O1QN1x_amwO-q9QVWeiz
X-Proofpoint-ORIG-GUID: HeoLedppWz28O1QN1x_amwO-q9QVWeiz
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b09938b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX6cI75Wbq4X5r
 TqGWffXXry38Teq7zqcBarXU6wjvMs3HuZROauIj8EWMMv5wkLh9UDTtRd0nQEzipL+eMGfxeGU
 aY4d2qGOBguVVJk2jJpKY4CB8oE/qZc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX5wBID55LHxc2
 6q+xc1WTBpsmTKcDW2NCrKDIn+PWBnOflsDZUUIYVu9MABieePkigaWW2/TN6+7hhHNaYB0+Gh6
 O4UwAQ9A2Yq24osImtKjbF5wYaJ/U1M5Ruwg2Xq0r5t8CWVxujsxbAaqLJQRP4KD1oeeNPjMJFU
 RWFqxXpIur05msa/qNzDnDK1iK0+NmAGAz8Xww4cw89fc4zm7dT6UTGphnhrLqyE/KeASoRuXtc
 B5ZzWf/n+/NxPZeLZPegQ+i2EJ65gZtfG3zC/Ze+u6GIeoezcUWgkROHSQ1uVYSZzVPqCiZS6Du
 g5ktYx1ci1Cv+pSKdzDvOvN0kk4etxQTAYp/jnw60gXdhO/BVoQY+PRLbRoqteganGA/9VitpP4
 bhUFhQC4MIDJkttkWZkk2nHCljDO0GWe3QXQ76RZFTu3lTzDc+WGBfxn90I48MeVm+fhFp2qGpF
 J3Hzqy3+53IDfYY38Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057

Add PSCI SYSTEM_RESET2 reboot-modes for qcm6490-idp and qcs6490-rb3gen2
for use by the psci-reboot-mode driver.
The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent and not available across
all kodiak based boards.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi         | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts     | 7 +++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 10e9a5279ed60..f1c27f9769fba 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -876,7 +876,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index cb90a83351c30..501e3c0d14028 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -791,6 +791,13 @@ &qup_uart7_tx {
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
index 682bcbc0b466b..3c05ead3a7ebb 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1136,6 +1136,13 @@ &qup_spi3_data_clk {
 	bias-disable;
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


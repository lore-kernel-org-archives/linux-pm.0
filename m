Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453028;
	b=HyYbYhs+lPl6viU+EZZV5daY6jXN6KPBAGXI4E4wfUlWnZ3c8Ap0+3usB/+XW4B3aLnm
	 YWmZ3poiMjCZvXhrncVr8WnPW8KrlF5g1dJ2XIYVQXU9efYgaNzuj81og3EZmsMhmGHmj
	 sSMw7vKeISnBtZnjfr45ojJY/84lW219Ff16BtAZWSE8B6hdFc+NycgyEeGeURWpUKQCN
	 1khELPjnwLnz2NrfDVzaa9QBJTb2Of8ZY4UK0eQAgXjsXvH7ctF3n624emxozkQxl5PzA
	 sHhxoHHHiHflZwl0QQR/NbkJpnMdAW60vZF83RoW8MAxhnhWIl5sTL8ncWOYTbVp3Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453028;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QK/sB9dSAJ/2G2Zrti3sXc4ovzV/2wnifjT8fx0zQuk=;
	b=DB8WgBIkEYR9qtPkhykotkH16eD/oI333tTW4PqzhXZM1e63fZCcZMZbplWmPZamEAZt
	 hWN+VjzlYRhYBvkKLYMAuA87PcB5Rpnte/D2tOSAur/n4jG0ZJkcQGaK4DoleTdpwP8e4
	 tz7qCraUXQDqIm/PNlogZ97TsLXSbwfysrbxFGQ1oXaXtDStRR2cF7Ph1FcQ1Eoq5WhB2
	 q/yXyWzS5c+xh93UhlaBnoURAXJ21/44wcd4NoxarpVMRkE64YFrvEkbE0RDgFIK3PX0Z
	 CVs6NW3p8odXiyzqv5FGZ9tWf1oW/FNxQTTXKeezkcLhrbdt1JvCm6Q7iEIEqQwNmCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DAiH6qaW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K94VOunY;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F1606A31F
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 998F1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DAiH6qaW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K94VOunY
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VD09w61630989
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QK/sB9dSAJ/2G2Zrti3sXc4ovzV/2wnifjT8fx0zQuk=; b=DAiH6qaWy3OIoFXK
	tjVtIZQJMMM3ei6OwfCf4EAUNyUcswW+pMQ3QXnvzl1y5jRjxg6miU3yhBdJmScY
	rrMXoPwcY1JjK2a8MYTqaFyDTT0hkRw1fCHbd2GdHhV/czB0pv/xe09CfqLlJsuD
	ltQNEB2UxIUMrvzhbMH7MRZxEXUwIwHxxUgyDLeeofAim6FIXgP1GtnWvGros8QJ
	V9Hoesmrozfe8mQgLlEu+TX7RZQ4LfsVSmU8YOIRuq5Oa6oHvSh5hAsYPbRSZJKm
	H/cHbzGwZCzDjDJW+6Z14zy+je+E85A4ZZfJxmDlpUoeQpYKUKJc92s6jo/Et4oA
	I6zwSw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn93eh2ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3425098ae4bso3834615eec.0
        for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793453026; x=1794057826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QK/sB9dSAJ/2G2Zrti3sXc4ovzV/2wnifjT8fx0zQuk=;
        b=K94VOunYFCTJucjPgXdzzsE1i6nKnoHTpICFaG0+o72a3j+IdhQ8ITjJiKoZ3JLCCU
         c0Nbd7b60tGtkGbZXWS4nREbu3TnddXR72zquVuHjB8I53KPsqHPXp0geLVAiy6RnCmQ
         tZl8kQ9c/zXejB4hPsikFgemTX8y38DeV/oIxieEV0UVAftf7swrfdnEuh8VkaeahYY0
         D1e7QlNXKxJk6nZ2cZBg242thMw/rKeHdW/96aSHNSRQfyrFqBSmpdU3VgRaERX7+X/L
         UZSuvwLtt1lbNdLhgy0x32FFptYcze7FZ7bZ7Cos95kjdAWJSC/5jHqj7TFYeEkzLV0p
         blJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453026; x=1794057826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QK/sB9dSAJ/2G2Zrti3sXc4ovzV/2wnifjT8fx0zQuk=;
        b=qZsCzqoYMWtBDmuKwpAE1wYRZGAffSnhoKRXXfP4JFeflqzhFHXuUADaWFlw06KPQJ
         v1Kepi5FE8Cz35nEzcpblQCjHGfNyotpiDsqJirTKJ/1tryxOfunBpzQwineozEUVAIO
         evf/PbW6/Ls83aJCjASXDR87vouDOUEb5FHTOq+z+be1bRZDxnCsoz4GL94dphb6w4RV
         kcsTpmtoiIrMpoGKznG/D0VQcz5AJOjAn/OxDC7yNEc7kMSpR7lX84a3cMJEYh+XrnEx
         ZQDT+XzDt6iKTEfVwphl9PHYoCvdGQaUqcSJdh38lyejKxu8IxF0tXtpR+nA4UNqiUUX
         UWUw==
X-Gm-Message-State: AFq9FYJGi1YW2NRhh6tvrLiqKSFayp/t9gxPAi2MirYpftvGhsNOm7tT
	BEAzdNPXEe/tYao5Xat5iIbhL58JGv5D+vX/UunrxvkZhHRBvVu6YK3ujkbPV7EOUzCL5j1hJkH
	nRulOrzextQFX6Kobacb4Fk452b4ZKGpDdAbncoTshgE8BgYXNJxxMl7aHfL/OA==
X-Gm-Gg: AYBFou0ppOFYoBLq+3CCZuqDHMZHHkXacit5CH1cqJqFZ300In/l5qJWjzcuQCHFCFm
	LNPmtfpNwSnsqDbf1gxTDqGI85A7qBrubHQJITTqqMaieOucydi9xKoPmxV7RkUi0pTGC1mut8N
	fS5w7OFqWRqVkmHA/eQ+nNCDGFsC8CpRLK00Nbu8ZxlG4wX0POUjy5w2jOlOrGR8nOMDnEacmGm
	VzvgUADRNdAPbzOwTNGCuvGM5cqSY8+5oPOe3bP3MNHmIE1EZhh/1ei7iJGTjY1agrj0BQGxCzf
	UBsO+EDgq/k2GuBR26NnMV7FYDnQPVFWw6a41OR+9B3ZtYchFg2APZ6AZiMqIy1O9rB0T/yKWp6
	gAUBuhTB4BL53U62NsRFAXf7yMEcftymvZ6oCSdYmF1VC7ww1By0J1ePyiOuQqB5kI9QOv3fii5
	CAov0=
X-Received: by 2002:a05:7022:619b:b0:144:eb3f:563a with SMTP id a92af1059eb24-1a9497b9d52mr16175350c88.15.1793453025787;
        Sat, 31 Oct 2026 06:23:45 -0700 (PDT)
X-Received: by 2002:a05:7022:619b:b0:144:eb3f:563a with SMTP id a92af1059eb24-1a9497b9d52mr16175303c88.15.1793453025137;
        Sat, 31 Oct 2026 06:23:45 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm18234699c88.11.2026.10.31.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 06:23:44 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 18:52:51 +0530
Subject: [PATCH v2 5/6] arm64: dts: qcom: kodiak: use thermal hw-bin trips
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
Message-Id: <20261031-thermal_bin-v2-5-d76fd073ae98@oss.qualcomm.com>
References: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
In-Reply-To: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793452983; l=6059;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=zx/+KrnPBXqW3IXQIcYA1/rGyuK8dpGWYkITAXNPsCY=;
 b=landNCcP2nN/nDJm9jEwbRau0/QrQklY7co+ps2J8y2O/5eYr/NHeZXlWxOMXFTITaO7Ec188
 lgLUtKStI5oCbtZuCH6veO9WX5jrTp459fVs3SQ3tsKgkFER7dO397L
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA1MyBTYWx0ZWRfX8mEgNM/I0JRJ
 U+11ud5jRDF/iN0ruvr6AuePQqVwDKagwugm0zTbL0GqA1bvd0P4FcwA8uYx8ET3sOjfXg4hc+q
 f0kZqvrKPB8CdM7B3yn9OFBk0I8k9i1X+n7nzJ1azKhKctKxDu9itN/cgNyMdU+GBlZTZ0m223F
 L+uPGyvhbLs2roR7789hCjZQWt/W9JpH9ZUf4ar4DL9wJFM0KOWZRnbFdbpNmEGG2wPtAdY8XAL
 tQ2Vf3x9R4Z+v3MkSmlXSPhAlrujhFK2MYc/Ae8N8aI14/berQG9DenRZza2iUarbezJKywIut5
 Y7kSDoiGZHRPsRTb7h7YRskR1cwl862y/jBNkqLvxloQ5jpreuIvVomD8LNkNML/C4wP7TmEuff
 8EKrjBYC4gIPamV/WADr1E7cFHoMewPHamvwl/ZIEY5znIaVSRXjh/yfgNmthOOscb52Xgvk/Gy
 LzbBGs49dxP4q7dmUEA==
X-Authority-Analysis: v=2.4 cv=FciiV5+6 c=1 sm=1 tr=0 ts=6ae5ebe2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=PCFpqnHMHODqJTmB6Q0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: OWa3PEUWnMkKb8kCFcQYzYckuNMbdzRd
X-Proofpoint-GUID: OWa3PEUWnMkKb8kCFcQYzYckuNMbdzRd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA1MyBTYWx0ZWRfX+Oc7MHaUiEyT
 UoYAmvdYvPnGIcbvPjeuM/j002/U4yElhsvy3HTYWHjP/fFTOKFSzzuT78Ba8bUlu32cGxvhz4Q
 fttsN3fNOcs0jYKWUKfXkULSrS1ZNMw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310053

From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>

kodiak-based SoCs are binned at manufacturing time, with the bin
computed from the jtag-id and feat-id qfprom fuses.  The tsens driver
now reads these and feeds the resulting bin to the thermal core, which
selects per-bin trip temperatures.

Add the jtag-id and feat-id nvmem cells to the tsens nodes and convert
the passive mitigation trip points from a fixed 95C to per-bin values
(95C for bin 0x1, 105C for bin 0x2) using the new
temperature-bin/thermal-hw-bin properties.

Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 58 +++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 347815e5983e..b984cf47b70e 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1019,6 +1019,18 @@ gpu_speed_bin: gpu-speed-bin@1e9 {
 				reg = <0x1e9 0x2>;
 				bits = <5 8>;
 			};
+
+			jtag_id: jtag-id@180 {
+				reg = <0x180 0x4>;
+				/* bits = <offset width>: 20 bits at offset 0 */
+				bits = <0 20>;
+			};
+
+			feat_id: feat-id@180 {
+				reg = <0x180 0x4>;
+				/* bits = <offset width>: 8 bits at offset 20 */
+				bits = <20 8>;
+			};
 		};
 
 		sdhc_1: mmc@7c4000 {
@@ -5782,6 +5794,8 @@ tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sc7280-tsens","qcom,tsens-v2";
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 				<0 0x0c222000 0 0x1ff>; /* SROT */
+			nvmem-cells = <&jtag_id>, <&feat_id>;
+			nvmem-cell-names = "jtag-id", "feat-id";
 			#qcom,sensors = <15>;
 			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
@@ -5793,6 +5807,8 @@ tsens1: thermal-sensor@c265000 {
 			compatible = "qcom,sc7280-tsens","qcom,tsens-v2";
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 				<0 0x0c223000 0 0x1ff>; /* SROT */
+			nvmem-cells = <&jtag_id>, <&feat_id>;
+			nvmem-cell-names = "jtag-id", "feat-id";
 			#qcom,sensors = <12>;
 			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
@@ -7136,7 +7152,8 @@ cpu0_alert0: trip-point0 {
 				};
 
 				cpu0_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7179,7 +7196,8 @@ cpu1_alert0: trip-point0 {
 				};
 
 				cpu1_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7222,7 +7240,8 @@ cpu2_alert0: trip-point0 {
 				};
 
 				cpu2_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7265,7 +7284,8 @@ cpu3_alert0: trip-point0 {
 				};
 
 				cpu3_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7308,7 +7328,8 @@ cpu4_alert0: trip-point0 {
 				};
 
 				cpu4_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7351,7 +7372,8 @@ cpu5_alert0: trip-point0 {
 				};
 
 				cpu5_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7394,7 +7416,8 @@ cpu6_alert0: trip-point0 {
 				};
 
 				cpu6_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7437,7 +7460,8 @@ cpu7_alert0: trip-point0 {
 				};
 
 				cpu7_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7480,7 +7504,8 @@ cpu8_alert0: trip-point0 {
 				};
 
 				cpu8_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7523,7 +7548,8 @@ cpu9_alert0: trip-point0 {
 				};
 
 				cpu9_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7566,7 +7592,8 @@ cpu10_alert0: trip-point0 {
 				};
 
 				cpu10_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7609,7 +7636,8 @@ cpu11_alert0: trip-point0 {
 				};
 
 				cpu11_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7724,7 +7752,8 @@ gpuss0-thermal {
 
 			trips {
 				gpuss0_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7751,7 +7780,8 @@ gpuss1-thermal {
 
 			trips {
 				gpuss1_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};

-- 
2.34.1


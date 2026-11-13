Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559503;
	b=vEZuF9ND7O+uJIpBRX5OdlEcfd2ZiR4zYYyupsPPIlykLc+f/V0kexMoANauI8SSquhI
	 QlfNgoaIax0QGO442tnV8LQM2v2SHEQwpLdI2Ld2PbktJkE02yDRDAJt/wpi3HufKv5yr
	 jAUdqxnySmYOCA4QL0PjQv6FyPTuTwbxPELYGmurOJm+XFc4lr7Q6ecVKftZDfuXCop+/
	 DJS6af1A4AlWyCr+h6qlxJaRQy4RPxjzbdgzrZxEDPrqizQIOVA8rOrVAF+G7nsOMNuFJ
	 FzDyCw+QerjkWyx849/lID5Hi87FrxRK4Ad1fTVbUq7cuW2R+V54Tc2K2oyIxxtJjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559503;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4B+k4N/WxVciI3gaNDWzFpGczUzeXz/gtMtUvkPRnj8=;
	b=HH23G2523c4GexbGk9O9Hk79BpJpZS+7tjuNITkpOsA0UE1KNdL9SYuhksLabQHKTZYd
	 u5Lt4ZK5wfEZtB+PKjJubvtsnE3+17oWpXpPE4QI5W/Os+R3kj4wH3V2Eyi1DUwZwb58e
	 taH/Op0d7Dj0Bs/eiqZEGYObka4BluP3qO2mHZxouKMh0Rqdfnxks1TzCG6V82VqX1s4Y
	 UMGjWrAW2KVKux0n59Oc6l2BtribLWeoeetuscXdOpuZlugSVR8IriJyzXjkSlo4jUest
	 flgXAE9ubQ62Zy7kvv9g7zXaDY+iUqDaYoYz7wi5Vawi6mtnnRFdkDcynrnxDNw7x0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dom3x4pk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b1ysmHWc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B860A6F56
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90B860A6F56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dom3x4pk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b1ysmHWc
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8VTQO1527768
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4B+k4N/WxVciI3gaNDWzFpGczUzeXz/gtMtUvkPRnj8=; b=dom3x4pkyLZav7kJ
	NBsEngBMtcc0Djs71P6R/T3Bcrjdc72HpbrHPIJB6Ui8AJre8inGfB648giq3Fl3
	UgLySVcffL6nEOYYpiT3og2/pOi8oQ3lphtQwyxelv2H2ThhMuLCsXPktR8HiXCo
	AHjlXJvP+/YYR38zeN2Uir4OFu9LTOMgkkKOBYLQsEN/twfpDcATKq3/G2jiddWC
	1DPPgSDeGUy2y/XDwwPWOTYhIGgAQ9PKJ8Km8f1SHgXXfKlgMC1doKO+B+A1YSDR
	6l7bfa2ikEl17AASKG1z9TNUEvJk7j4Ox0TxnMycnaffvNfESpa8h5Wp8GurIoTZ
	OHYcNQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hww5r8g11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:45:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1155187eec.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 00:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794559500; x=1795164300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4B+k4N/WxVciI3gaNDWzFpGczUzeXz/gtMtUvkPRnj8=;
        b=b1ysmHWcROO0CzlmtI0KZNIFUTypatg2J0hElZn/VTxurAS7/i9TN/6/L/5F0xnM1o
         djui0CVBJ65/YrpJH1B8ot8QTHoonP3BLt34/PfeqJzeMyBnZHqKnGYBpWMiWZ5WoObo
         9A5GfeLatpRZKFlwYmHT7GhCgiqN6hGMZTznmWoMQ4mk7Ix43CSMieSUW8ldXwMKmvYf
         3vGo33vQ5FtZdXyZuBNXooIXEdozlfbxq3p+WqIxaInKQdw4Iw9ofM1kqMqYTmNviSKn
         TTw9Any6iC/hFipy5yA84M1vmj8bH/Z2mFU71khYZtFwo+CvQfqJR8pYhZYjosk7+GI6
         h5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559500; x=1795164300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4B+k4N/WxVciI3gaNDWzFpGczUzeXz/gtMtUvkPRnj8=;
        b=aLyzIVNSG0aYDy/vZm6Ga8OjZqvkH4OY3/uPj0zIsRfjYMSGifa1d9nXAE3hTv4mB+
         B73r/jdj6cTjZZS9MoZupCmvnfTfdEWNektuvl9CgWIpSYnsJfc8/Xa6WdcQLSbjyP+2
         WFVBUcU6q2FkTUNkF8vokXEYCr+2eP936mLOA5LkPmp4ubK0fHy6EDp94Y8aZOEN/nkz
         uSH0e9p4pjScux/NSY8bmBtxMJz/xxnzAh+tsq53/lVDMZJuhrFhbYwZpM8IAooY2zWd
         aX7IUkr1ZPK+RILqh0fyiHH3PHUkkwhOJgf5UjI59viwxLEJqvknwGroQ2ELuou83f/d
         T2Mw==
X-Gm-Message-State: APuU4Z8LYrdpOMgxRG9Mw0DGzC1luIIospI8C/zTVYliFUAYFjpNMwFU
	vlTLO82o6R8206eAeigiOe7GcoH/2c3loLXKbWJ/R+jytDJ/MD3XPX4RDQNqyk+o9AxRWvjNljh
	Q6Q9315cG5aGrnaYyZt4lDMZxSTvoepvB4AHKwHPJzPfT1w7YFFwV0Vf+8skemQ==
X-Gm-Gg: AYBFou0AdLmAqNwOeDf8NmlUMdRzAgQQb2YoKFMunx8KjHtIWSskK/APPHJsdpksml3
	z2sDFBruoz1uA9R4OBn3zshO386rTrW+VDwiVS88yOe7aU+8nNjKCT9uz7lJvOu5c48mh9sDf4s
	Jz+k1SRt8t6D/jHjGI0Xr6gyc0VA4NWYYB13xjVlHR4ylXN9uLH4n3j34mR0al/85eBAUSBtF9W
	YNv5BXujYqu31I5Fj2KBv+jcF78jSYGWEPYEsWpwc9cOlUnKuHS+IZg6CXClAJbZae6FLauAT11
	WQw5RLWgEk39V4x5hZTacYU7OoX429MhLQ+gvI0eDRaEZqfpe4ZMJd31jREleE1pQ+YoOc3W7Hz
	RdIK/ZW2JPNSpGoXEJnT3j+jHfYNSg8GqrtEO4058mioBqu63nxaPUXiKL/bcOLUtuu5+GH7OMw
	sjSVs=
X-Received: by 2002:a05:693c:87d2:10b0:36e:53bc:467d with SMTP id 5a478bee46e88-3796047ef7dmr1517282eec.0.1794559500083;
        Fri, 13 Nov 2026 00:45:00 -0800 (PST)
X-Received: by 2002:a05:693c:87d2:10b0:36e:53bc:467d with SMTP id 5a478bee46e88-3796047ef7dmr1517245eec.0.1794559499442;
        Fri, 13 Nov 2026 00:44:59 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm9662357eec.20.2026.11.13.00.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:44:59 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:13:49 +0530
Subject: [PATCH v3 6/6] arm64: dts: qcom: hamoa: add thermal hw-bin support
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
Message-Id: <20261113-thermal_bin-v3-6-878df6eef8bc@oss.qualcomm.com>
References: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
In-Reply-To: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559450; l=5534;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=HcVpcdcZzfHLlTRXvDjqWWHGSNDZWIS0xPcIBTiDguc=;
 b=hf+U5PczZx/kTtYo/BjrMS8HHButnfof4VbnSGNlrM131+LQsr9/hXS8vVqi6jXkQnX1L+s4c
 nDHP8vv/ABKDQyzlZCEv/Atdkpm8Ob9kdbJgvp1q81ahGw+aKgxS3xc
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfXwI2xqAtFsJ7m
 MHDjtGGUCm//UZwOzyN43yd5NhF1VJdeyWqQ/Nq7wTJYoyDmBJ2VucT3tpsgMlvPwNVYq1Z26hj
 LcVuvMXXXbatem3mWm/nYqbvO0G3+SfUJjIOUPuvID/KE9MwN+eEnii88ISwUDSf+WacsRwxrzP
 N0hwDjEIlBPX0/m1zHA1UhmPU+bCc8F6TZUuUyTiMjyhOcM2TWp7qQqgLF1C7ELa/FgpOZBejTA
 6rbX3VTUHjTkZn5AnzaIIHkkdkQvAPDLXLuKqShOY1NQSxViaec3idALlWIbWRWEdQYEYgdZZTm
 GwMr4/KaZk9dSittVyRdsMLtyzODJucqw2dhko+BF4EeDJzDRaQRfLJP7r+Xmx6xbdt0jKYV7i3
 Bsmqwt+xKArdQvdvF+2MzfIErVOLausHuXcqhVVfJSkxWMW6IsPX0Rsg6APpap2evmJ+rzBpye1
 Azi/dIhB8QKYtfdO2eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX30q3Kgn0LRVn
 7YBfZO/m960zP90IIbYJNBcD6SMSrNoSI/m5JqPn/WrmvWTg7DRi4CXqsowvQF2y48Tb6dId7wt
 cmQZbxjmtR92lGxZDfi0N1Q2GUQ7DvY=
X-Proofpoint-ORIG-GUID: BegePOSB7EJ2SDOD0tzLf7DAdKaT5pEH
X-Authority-Analysis: v=2.4 cv=Vqq2kO2n c=1 sm=1 tr=0 ts=6af6ce0d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=HHdy7Z-N7RtC6Qn240MA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: BegePOSB7EJ2SDOD0tzLf7DAdKaT5pEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034

From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>

hamoa-based SoCs expose their manufacturing bin in a single i-temp bit
of a qfprom fuse. Add the i-temp nvmem cell to the qfprom node
and wire the tsens controllers to it so the tsens driver can feed
the bin to the thermal core.

Use that bin for the GPU passive trip points so industrial-temp
parts keep the higher 105C threshold without a board-specific
override.

Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 66 ------------------------------
 arch/arm64/boot/dts/qcom/hamoa.dtsi        | 42 +++++++++++++++----
 2 files changed, 34 insertions(+), 74 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 484cb9ee18a2..1124da9817f4 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -1478,72 +1478,6 @@ &usb_mp_hsphy1 {
 	phys = <&eusb6_repeater>;
 };
 
-&thermal_zones {
-	gpuss-0-thermal {
-		trips {
-			trip-point0 {
-				temperature = <105000>;
-			};
-		};
-	};
-
-	gpuss-1-thermal {
-		trips {
-			trip-point0 {
-				temperature = <105000>;
-			};
-		};
-	};
-
-	gpuss-2-thermal {
-		trips {
-			trip-point0 {
-				temperature = <105000>;
-			};
-		};
-	};
-
-	gpuss-3-thermal {
-		trips {
-			trip-point0 {
-				temperature = <105000>;
-			};
-		};
-	};
-
-	gpuss-4-thermal {
-		trips {
-			trip-point0 {
-				temperature = <105000>;
-			};
-		};
-	};
-
-	gpuss-5-thermal {
-		trips {
-			trip-point0 {
-				temperature = <105000>;
-			};
-		};
-	};
-
-	gpuss-6-thermal {
-		trips {
-			trip-point0 {
-				temperature = <105000>;
-			};
-		};
-	};
-
-	gpuss-7-thermal {
-		trips {
-			trip-point0 {
-				temperature = <105000>;
-			};
-		};
-	};
-};
-
 &nsp0_alert0 {
 	temperature = <105000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 443c1a5c212d..e25729ff23c8 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -2767,6 +2767,9 @@ tsens0: thermal-sensor@c271000 {
 			interrupt-names = "uplow",
 					  "critical";
 
+			nvmem-cells = <&i_temp>;
+			nvmem-cell-names = "i-temp";
+
 			#qcom,sensors = <16>;
 
 			#thermal-sensor-cells = <1>;
@@ -2782,6 +2785,9 @@ tsens1: thermal-sensor@c272000 {
 			interrupt-names = "uplow",
 					  "critical";
 
+			nvmem-cells = <&i_temp>;
+			nvmem-cell-names = "i-temp";
+
 			#qcom,sensors = <16>;
 
 			#thermal-sensor-cells = <1>;
@@ -2797,6 +2803,9 @@ tsens2: thermal-sensor@c273000 {
 			interrupt-names = "uplow",
 					  "critical";
 
+			nvmem-cells = <&i_temp>;
+			nvmem-cell-names = "i-temp";
+
 			#qcom,sensors = <16>;
 
 			#thermal-sensor-cells = <1>;
@@ -2812,6 +2821,9 @@ tsens3: thermal-sensor@c274000 {
 			interrupt-names = "uplow",
 					  "critical";
 
+			nvmem-cells = <&i_temp>;
+			nvmem-cell-names = "i-temp";
+
 			#qcom,sensors = <16>;
 
 			#thermal-sensor-cells = <1>;
@@ -8829,6 +8841,12 @@ gpu_speed_bin: gpu-speed-bin@119 {
 				reg = <0x119 0x2>;
 				bits = <7 8>;
 			};
+
+			i_temp: i-temp@180 {
+				reg = <0x180 0x4>;
+				/* bits = <offset width>: 1 bit at offset 0 */
+				bits = <0 1>;
+			};
 		};
 
 		pmu@24091000 {
@@ -9751,7 +9769,8 @@ map0 {
 
 			trips {
 				gpuss0_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
@@ -9778,7 +9797,8 @@ map0 {
 
 			trips {
 				gpuss1_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
@@ -9805,7 +9825,8 @@ map0 {
 
 			trips {
 				gpuss2_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
@@ -9832,7 +9853,8 @@ map0 {
 
 			trips {
 				gpuss3_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
@@ -9859,7 +9881,8 @@ map0 {
 
 			trips {
 				gpuss4_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
@@ -9886,7 +9909,8 @@ map0 {
 
 			trips {
 				gpuss5_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
@@ -9913,7 +9937,8 @@ map0 {
 
 			trips {
 				gpuss6_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
@@ -9940,7 +9965,8 @@ map0 {
 
 			trips {
 				gpuss7_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <1000>;
 					type = "passive";
 				};

-- 
2.34.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE263AE187
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615413; cv=none; b=fLJAHWDcW4nInSRJXl0hHdPVpczVWBDqsVHmqm00UrxcZ07yAfPmmQ96O6cQXXXmHPkS6z5WEdgpn3UgTjEobf/2v9FrDYhmd/A7rKGl3fG0FmuIYDQiTAXSLulyqy7aqXHklfJG/wUlDS5COMyueJ0mla+EX+aho5tcQVhID4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615413; c=relaxed/simple;
	bh=8umcBmnbaWPKhT/bCG/xlVEirctwHTcqHHN3lc7dKzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2yr2dywAhiU/L+fp68fcWw85DiAfdCObXLqaheVov32/tbjQ+MNPbRShZZ54xDsVaQdaW2NcyqI9phFSND8W1XkahjDijFQcsR46Z9kWttYRoqqInaBQ2YJCIamgV8rmME0JtJv6RgYh6IHL3TkmRd2/2b39Cj2ma7jfBv0Sso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyI3pMRc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P3VzeQzu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyI3pMRc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P3VzeQzu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCboP3884154
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRIQaH4oh+X5ecber9l1165X794PX07S/SROCQzKFfo=; b=SyI3pMRcr5Zdxb5S
	RE1lIgZ2Gi0iYF2e8bNtSh+7abPp5iFao00BUlPL6HjrxVqelAQubcFkI6dnFQKP
	IGJUo7S0X8iHxLov1CV1AGPRDahZqSdZX1y6SGaodFt8qxFzIMAbQiywp4bC7c/P
	BUOjQdNgWT15Jw4XXWcTu0OgjJN1x/5pld5b673THARMkjtge0wsgm4C0vgRHM1J
	/pH1n5UvZkFmmKccK925RXQCsAtBVx8qCtjcj2o2Fd2oC2HvnJPu7I9Gh4+S/xi+
	YMPClwHzKjDR8t6BkmN2VVL0r9r8Qtn2g4LanCqZvOtXT2fTOwptDMCxFVztgGXY
	/BEjOg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvcarfu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:30:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc5faecf01so216824925ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784615409; x=1785220209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRIQaH4oh+X5ecber9l1165X794PX07S/SROCQzKFfo=;
        b=P3VzeQzuKANqS7yv4i0vT9ktY7tEaY9RmxZK/4GrUTIi5HfyZGWos9r98wBjQnOdYg
         2p1ZKZNPHmfYIWjXkJl0akllmXepDqdtZc0WQ0nKxO+725pDQgkDyg2q+XBxYTRpxt4p
         bl1lE4OThPXHK0ekhptBjE5i2Iuz5/WTnMIHhdWlqQmVOhjAT8yosmAQiQw/oUx2aEoX
         zW5DWhRQy5UHzevECod1tsql5JkNTHE8UtZhgm1lXlyfb7iHxlAqZQ5WKqqccz6jAcWR
         OAsyMdyORlQld3zWOp4znfTg2NzamSv93kp3yCK2ycQc9zVWmR9ZiGV1srwp/THQYTs+
         edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615409; x=1785220209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRIQaH4oh+X5ecber9l1165X794PX07S/SROCQzKFfo=;
        b=iya11emOODBtJhOJVPmd+pHU+KOArY8SJCcAO+GbUOWRV511s/rpCPeQ609Ragqvf2
         DgzNi1XxPoVYl7Dtuz1rWDBH0mOCFCVzBBdchdPjMoClEb4raeayPo4cAd1YSvOUo6Fc
         SUhBM9wf5xosE8AMFsw+BnuNH7SScMg0Zc8k0NxI4NI0YjJPBfXuABONYtE5d9LLXZL8
         7TLpVqAKhgXu4ZzWWVW0a/JroU10kGkND1334QQg0wzHTMH1S+eA9MqPWYfn8WjRk4EA
         SgM8O5izxqjxb5FcUXxcaqnPpzgGnwy4CBC9QiU6DuF+kds9PsyxzvOy7RQKiGVa9cr1
         lPRw==
X-Forwarded-Encrypted: i=1; AHgh+RogUxuGM0pqfAwHzar/ggcvc64G4If3fc7cC7GWfRp6fk5cAfOZVx9sHx/LWBkpZf42rv6PIq/YYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9W4XIxCqGLL7B/apUYDh4lxsG4zvBBHbpvH3y7gedI17TtMWk
	fZC4vEc1cA8EyY54SeNwxkyXeT3dKzZVhPCUFYOXGZTI5J655s/nXCn4WhoL1ZhmODqOqstupTY
	NfGI4NrXzxvT1fB+mvbN1PdxpT3WeZeJ0QOBkAabUA3q1FZPvutDsOynyjq/LkQ==
X-Gm-Gg: AR+sD13ptIlgOLqTZMpRHc7NPJUKzJKf8TGsi4KyK7NB65iDAI91+70dMp8/v4UD44V
	IclBQIgj+TX9vqd8SC0pLPvjl+A+QGCc2S4lVb/kQJAo32/yI8xmrGyFNXghPHtlVs83AGsDqAB
	CWR4DXaSdOOPXBwekevhuAUW1n3kCt2/wBw+nVIxO9xYNeWFrdXOPaZKe3ScW8xOy3ZQADZbcrE
	YxqunZ/e7NZ6XpBjTSexBAEC/2QEBKtKa2UcyZrJmSgdlmxc4qUBZtbXqSv/HqTomqrmejKzhYQ
	rw0nA5LY+Q/jk4FrvuXGRFVyViamMkncVNR7AwyjW9xB/RVNdPjiseRQXr9way2uPEARrMlikcc
	VuDV+XDhwUHA4CGW2Gn+dPlARaF7K1A==
X-Received: by 2002:a17:902:f689:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2cf3462c08amr192048305ad.0.1784615408514;
        Mon, 20 Jul 2026 23:30:08 -0700 (PDT)
X-Received: by 2002:a17:902:f689:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2cf3462c08amr192047835ad.0.1784615408049;
        Mon, 20 Jul 2026 23:30:08 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347a1201sm69376505ad.81.2026.07.20.23.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:30:07 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:59:04 +0530
Subject: [PATCH v5 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260721-b4-qmi-tmd-v5-7-99620e07f505@oss.qualcomm.com>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
In-Reply-To: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784615351; l=1868;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=8umcBmnbaWPKhT/bCG/xlVEirctwHTcqHHN3lc7dKzw=;
 b=NEITjm7oqR+Rh45ak+Iz8YUMOCtw/iYGUukbUqFDiWOiCZIe3dlEL5M+xkQw/uHW/BIvDd0dB
 dokIFQIDjqlBZwJdtsjzg61dqbvcuXo2uSVHCzGtbbOsbMfEd5bA5fq
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfXzNsavRrjq/GH
 J6PDyO+Wm9nEt8ArBe9D+578DQVb5XEWKLMK7/4txL8fMkXdW3WG4lru2Vv2cyfFSN+wTG39e2l
 xmEpMnrTWJ24Zjgj8ok+kMroDCMiKxU=
X-Proofpoint-GUID: b94nnk3Dj7AL_9ywazFQPoIn8hln5qIx
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5f11f1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ptpooaJMTZRctn2qr1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: b94nnk3Dj7AL_9ywazFQPoIn8hln5qIx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfX8LV39vsrJWUh
 7zsJC7/Ym8vhQuwIQ42f8vtylyzowHbAIsVnxYIUitUo9zi5LvrwH1u1J/HkjdFYceFm7qmXwXz
 G/sQDDnKnCAsZUNr4gCLDsHCRs15Bk4cfyXs6073P6FMvEAhWJYQZlIo5cjG8u6KaBaQXRDxoQk
 /LEe8XO+XwGtwGfSeNGIDIG73MxDM1oMs5kk9BRw5G7HIBLkgo5n/zZWY0+oUEFGE4TsHh2rh+s
 nC5a97c8kh/D94qwPeGzZAIW/X/jdyqSmu2FhQzYv2evB3t1TTqm928HUMEUfznsI4131p+9zYm
 Pwk0h8Ndffn1kU2TBBUOFZjLrnI9t0e1T3NE4bBmr/GcSyiJUnb9vlFg7dH+W1Higx60yZ44rfM
 PNVJ7KLwMQksx7i0WWnqpfKzU+UnO+bOa5XKIVHPIIfDAVbMR8ZZ9c1hDtMqb95y9sgDLVmQLFl
 lwGs0rc0vGaJ9Mn1FUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210065

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in talos.

Set up CDSP cooling by throttling the cdsp, when it reaches 105°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index bdfb70ca9740..5602448f0e42 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -21,6 +21,7 @@
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/qcom,qmi-tmd.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3840,6 +3841,8 @@ remoteproc_cdsp: remoteproc@8300000 {
 			qcom,smem-states = <&cdsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -5497,15 +5500,31 @@ map0 {
 		};
 
 		q6-hvx-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
+				q6_hvx_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				q6-hvx-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&q6_hvx_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		mdm-core-thermal {

-- 
2.34.1


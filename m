Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8D40099A
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756453; cv=none; b=cvvR5NoOiYgiXyzHHrL8TdKmowhcJG1/nE69wD0sDB/bN4xIJX63dyexff4N2ej6Gaar0hwoH05KjxEmacCZfprmN5sSzytlFbtVZgUNb58ek5VwmF+oCSYD3ffOfreeJaMWM236XEmopYEQVunNBQH2PkZZxB+5sfS8ck+O6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756453; c=relaxed/simple;
	bh=MpQ3RqfdD8RbKrgC+8eU6ZklRlgT3OcMBsr6ljHxb9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+SP4ieIaippgAxpj6HAFWcxspQQXFppNtYst+VfjS/nKoeZabT3mB8VVuuh7l480O1FUFDxSs3x44NE+LUSH/0HYhOX1cRbvImhQxXMEKOrWQvIdL43Bmxu29m1RS0wD1qurk7B92H/1M/UM7DuCZ2ZrAXg+bzP0cEaiMnPRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oE7DA2VA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H8/Injyx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oE7DA2VA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H8/Injyx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673AsZTn3957457
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 11:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qo5B/ZyPp57hJoXVEoU6RtV8yA5IEg/ctFOq7PMVsVc=; b=oE7DA2VAReO88w7B
	RX2xSQ1+P39cmRJW2HV/5vgJNoSASoBJtYCSQ+Rx9148Ysgy29GnYgHe/KzARUQH
	tKq+nbVOfScsF+9WKN6K9AQ6/haYZ/dpyPuVlTjZ1ThP7M4x2SiTWscPmDis1QAZ
	9bnxA1x1mlHhfNxDrAY+VlbYKdJtL1TnNGzhTUapVdzzxN2K6rfS1jlFbSUTHG/h
	XWSACZftHFw+D1PPvouElBgsHL1R7v+Sy3xakPgbrFxQfM1/y9FRhFmzf/o2d7a3
	3RwZLQJb/XxMLACVomp/Ev6Chqbhks9Lj3RVBf5okpvGEJwmpOGm3L1v97wPRTJy
	vsQxvA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnvnh837-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 11:27:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e6d253330so4013328a91.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785756450; x=1786361250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qo5B/ZyPp57hJoXVEoU6RtV8yA5IEg/ctFOq7PMVsVc=;
        b=H8/InjyxAVFf5KlINktIow0dbav8KefqD/jQfNF3dJUHXn9aWJqKVBQd4L6YegF7VA
         5CBCI6Yk+sp7+P3lcwAOdBZklki1sStA2pVBel/w3qYrpUghKkPhepFIRHrszQe8y+C5
         FmS7+5hRm+WDfcN+K51R60eMm9iUF5qgZDu4JpqfhX1BrDjMlRNnsATObku2D07ZY2BN
         dbOSDV944V/nXQ6DyRGS4Gdt/kCwSH1RIPLTlZ3SmcbEifLQ+chlHCd7tuxO5N2iJpmp
         6wBQrFwx1H1CN6yIj9t/GeN6GnxkwJ19KjK9eh0b2QHupnSZnZ/mCyhn4YMR0cGIyxmr
         LWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756450; x=1786361250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qo5B/ZyPp57hJoXVEoU6RtV8yA5IEg/ctFOq7PMVsVc=;
        b=GXind3E7oDbVO0HvlfI5XKDZzMM79HZvQs3STGifEMNnfnqmYFNXT6y5TtUhIpyu44
         +D0vOZky9EmEu9viQVcC0pRQdieLxMqSdTfkRj86YfFxgUW7zmaqx2GKdvbIF7u2rlhs
         aNv2kLGsatVwAj2g6pC0AIZ0Pyzu1GKfvDi7hinR0WpWuLszITt9eL6pSQzoBFpsIDwJ
         4ZqOBaeObpovk2TO24lv3UBHtKZi5svmlGWyEkv7s2fKxvW4+ugbSNSE5jIRKugY8iw+
         ApIenZEhHpmf70Nz2DLrw2am+C20QfGI1z8fvmAEB7RKN0+tfucH9iIQu/9lkA+QEIUD
         m0qQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5wKxxZbh4IN27VR6a4xahNq8h+jXk7bnAN59FfjK8BFbujtw0JoZcGoOYyEOF1jDAEsWmWjYCFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8W9hkMFPxnuMdTjf9tkyyVAnqYAT9XQ8b+8g/NytEZgvYBoho
	JxRiIbzVxgJ8c/Nb9ObiwKQ67J7tLhymbe3qfhYdjKJehM1A4/B0GeK9wB+fEyY7E7RgiV//AjA
	rk4yhHfKebAfM5js0wCN3kj0PyXTqaRxHy6bGiGfFYbygnddcSbsP4oaXbPHu+smwgdnlQg==
X-Gm-Gg: AR+sD118P62iKeNi73CzaZlzUss7yfh4UaOE466Ouq8XUbvpf8cwO4L14du1uiYJmYE
	Yeuj62NrZESeNIt6BbNSqjui/d1ruxMNLvxkuCBJAegfxyZ7C2TeKpz1HYOHcKO56JPasXlUs7t
	HPoejgg3qznyzzfN4xiinDmpEy+Ij71paIX3dQ+RbEBHxUpWfQZ1kw0Qwm0SHu2KOcJuYGhsiBr
	WhC0PFVRQWXUIZYSf4uLC/er6IR519PvPTWPHV88oz8K3uxQlLPhB9oC7+tERxVkM3fUxAI35op
	rXDqjbOhkVIynAfS6ZB3i1mIoH4pcMa2T5H6rSdqXIiYfRz0b4a2yr+UlxPD91aX77wS1MVgtI4
	96O+rJBd4/rop22w=
X-Received: by 2002:a17:90b:520d:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-38fb2409b7dmr11377661a91.3.1785756449577;
        Mon, 03 Aug 2026 04:27:29 -0700 (PDT)
X-Received: by 2002:a17:90b:520d:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-38fb2409b7dmr11377634a91.3.1785756449108;
        Mon, 03 Aug 2026 04:27:29 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29967043c88.2.2026.08.03.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:27:28 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:56:36 +0530
Subject: [PATCH RESEND v7 07/10] arm64: dts: qcom: shikra: Enable TSENS and
 thermal zones
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-shikra-dt-m1-v7-7-7fec8e777076@oss.qualcomm.com>
References: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
In-Reply-To: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756396; l=6381;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=dAQg2Aq4UZ5Zzn+ZshBkBCEgEHGs1OE4W0xXmo9svNs=;
 b=BWbYRO/B0g+6exLrwT/lgL0n4/d8DuGgM/+HelqraY7Xky/8cbA277o4qR09T4ger11j3Dkf7
 ampW1Sva1e2C2MX+sTTtlV9ZTu9mSKYH4q4OhXKPfzyX/w2bujwvQe6
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=aoaCzyZV c=1 sm=1 tr=0 ts=6a707b22 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fn5bFolYHyDWY0CUw3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Jo4viZeKUKv4Hi9F5C6TakeB9G8pK33U
X-Proofpoint-ORIG-GUID: Jo4viZeKUKv4Hi9F5C6TakeB9G8pK33U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX+ZLirpL6Bb7a
 OBq7P62nJXSrkx2wPo088Tg9Kqk7BqlSAshncKmAm+28wJuVMundSQOjMJm6mZQT0L3UZCLgo2G
 ewCFiZgjvx/NYj6JgfGwM6Ht7+IZs07/G059vNlvDCQxV411+ngnyiOENpKT/PK6Uoq/oWw9wQR
 Jw/Sd3tvsYWT0MQe1KiQz/OaeH2VFi4D10kD9GLaPlWR0m2Bf0f2th+5L2lbmuLVWfDZewtUbJB
 C/Lu5/tHZ6zDjcZxqVtWq6Brlk5JPbFrvXcBLsiOacYReksuWc7Ac/Po2skMgn7SCr7Awm8IZjX
 rYgr3EKY9P5+qoemXcmkNqUhslXasAcFh8mn3XfRAMGy0o8FKYf5OFLgPbSAKJq1wNz+w+tVAzd
 AjKmWVWKLP0lUTZErWZSaqTi28OMg3n0S6VLQx5jVmJ8iJ9aYJKSqFEWtad6ChMNZI5twL1/Vg3
 AhfLrxb+XyyL0gpP0BQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX8QokDKkfRjRi
 G5bnKoUTXA6Dz5YaMmQ7JO0pOuE/1T2TN2MmEKYyP5m5cRMZfdrGPftw6fVQbbn0Yvl+utJr7zV
 G1X1f4MP9BPLUNQLR0EMyH36izBQPb8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030102

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

The shikra includes one TSENS instance, with a total of 14 thermal
sensors distributed across various locations on the SoC.

The TSENS max/reset threshold is configured to 120°C in the hardware.
Enable all TSENS instances, and define the thermal zones with a hot trip
at 110°C and critical trip at 115°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 267 +++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 570505c927bb..fb0391bef460 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,shikra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -998,6 +999,18 @@ spmi_bus: spmi@1c40000 {
 			qcom,ee = <0>;
 		};
 
+		tsens0: thermal-sensor@4411000 {
+			compatible = "qcom,shikra-tsens", "qcom,tsens-v2";
+			reg = <0x0 0x04411000 0x0 0x1000>,
+			      <0x0 0x04410000 0x0 0x1000>;
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "uplow",
+					  "critical";
+			#qcom,sensors = <14>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
@@ -2195,6 +2208,260 @@ cpufreq_hw: cpufreq@fd91000 {
 		};
 	};
 
+	thermal_zones: thermal-zones {
+		aoss0-thermal {
+			thermal-sensors = <&tsens0 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-0-thermal {
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu00-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-1-thermal {
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu01-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-0-thermal {
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu10-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-1-thermal {
+			thermal-sensors = <&tsens0 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu11-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuss0-thermal {
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpuss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpuss-thermal {
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpuss-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsp-thermal {
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsp-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		mdmss0-thermal {
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				mdmss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		mdmss1-thermal {
+			thermal-sensors = <&tsens0 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				mdmss1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		camera-thermal {
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				camera-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		video-thermal {
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				video-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-2-thermal {
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu02-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuss1-thermal {
+			thermal-sensors = <&tsens0 13>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpuss1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 

-- 
2.34.1


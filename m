Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D41DED5B
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971480; cv=none; b=JyUTLQgSQ976spnpxPqksZp6h6LMEhgs0pwL7CV3b5m+i6chRNKQ7lb2AjZJH8HubWu6uEOOlIB38DSf9s9F6KhEJAYwDz0y/xhIjkpQGK2VsYghIqfoqtv/f30uns507RTh/Jwmt23HwWAoPPKY0zDzSZ/WVEmIE+Wctp+nhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971480; c=relaxed/simple;
	bh=DTChb5IJt941YLuPwOvT9s6H6kmZ9UZ3rgh//PZhp6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bT3IngVQ8TvVKL50psNhJqC3sC/am1hnMedY759Kp4wYfm6Zz67D/7O0YHp4RfFixNf0UIKAOktlGAt076YgR/U9C2VP1IHKMaqq/Cqqy5R6nwVQCcLscLsMpOVFULR4JJtVkEmifQL4GY5rECckP2AiJwM9+HSQnlFRLrbwnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J9GhMNYY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UgyZeLST; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9GhMNYY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UgyZeLST"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9X3t2389511
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	njo8S7KOyTAFfsibteCMNYMS81jSHIvrnNzHSL/N6Yw=; b=J9GhMNYYrGE0YkNz
	BaN6bWrZXr5tXZk0PZCX7/L2tz9O4n80QVpLnlPd5RlvBQXxv/FQZNflp1YtlMqb
	4/TtrsIEGv2x90eLwZij2awutwO/TGnZQhci++VSxuLJK+CEeCn2v9XjXjeSNBGU
	QxKTTG8D584psFrpKmp8U9gl1lPqtUSlNUyhTrHn58eN4PQfBKSwJjxnR8y+g9Fi
	EbzZs9fdmxXQICsyqPFBsykRU0GC3TBznvKLI9ra3wiripM5TFbkZhUjibKTBuF4
	rkz+YerrmHU0EZc680rOZCNCaYOZ+JOWSBjt3IBg27sPIlg+ilE4r9aR74MKx596
	Kppc4Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j0jjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88ab059052so288961a12.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971476; x=1784576276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=njo8S7KOyTAFfsibteCMNYMS81jSHIvrnNzHSL/N6Yw=;
        b=UgyZeLSTJHIewfsuwAKLCfhjQ7YS7xtuMy1o1jBqdaf7WkdZZcX49ybGG46b9/wvNK
         hb3Z7cPODexOw1OdloRmgFsLnUUvvP6g2MFD3uQcl40qCSsHAT0hjWxQNRiUritOiLh4
         OsLyamkDuWiznfzpXW1ZI3FYdEJsQ6W8mbLS5YU2B/q1iUtiwL3uHuyIMNGuEAUr/92b
         o7qylcSjVBN1fofpST2eb/Rm9JWiAvon5lTsEwlMRzPJg12vENp31TH/WilLoCKF8y4J
         KCuxKnZ0l/LEm3apiIXpGx+Xek+XETAhIB1ZLrTOki4ftCDCPWFFGUi0CqRaayvWDRzR
         v23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971476; x=1784576276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njo8S7KOyTAFfsibteCMNYMS81jSHIvrnNzHSL/N6Yw=;
        b=JGQsobcPN+xUMyE4A5ujX+zJCswuE8vWp7bxRVKCoQlWQiG/VO4JOWj5zrMgLDsdNQ
         cjH5Y8sxmLVK1xFcP4OkHLquRPoLO9y/sUo1bnx26xxbiIHDdwn6Vp9Q9R/NGCGsVzhE
         EKUxtLa5X5MK1PhuTj81KOuCEHAT509P2AWazvie7evxkOSAZZ3DZzRqYMuIXubvVzun
         dvVrzg0suExtq4ESsAxmUD7OCvVHgXN6MIopuywPVsvYejLbe9BOFM5cumklNFyzvbl4
         xC8Knm/WIvOAOy1tr8JAl3ClBQz53VY66105Xh7tu+8whR37PcpWFqkqgG9NjFOWf8jV
         K4cQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpv13l1CB2JjcKjPPOphVg8RbSh6jgoRlh96ByiODmCclnZRP5oD55IrxHrPwldHvVpHKKSq9Z/tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fzE6Bjo0Euqq8RiSQpzD1W8WeoYDlZqdcGjLuACWWo9oBtbj
	kat2SygGr9+vfmpobPDOeUMZVbbRXbXdJtpPrb2i/c6tOIgDnofPnTLQP1QGcYPrNQ2AXQ77t7u
	DL7ZaCbgktqOoE4RB7r7TQtNqhZWSKBNWa10lUmGAtU2oRSyM6Ipz6ge0N9f5iA==
X-Gm-Gg: AfdE7cmfLRXdosUXN5PN+lhq/qPn1B3Y1Gsk1MrqtXxjFFB+bHgjp75raJtyec4ChTw
	RPV4Jn9wUoKJg/KVN3WRTehfegJSCCeSBoHpQUXw/c/eacdcEuJg5rZ/V3++lgAkdHAJ0uIlP4W
	xzlkJg8sufzO4eFppCDB0b12BKoYHOKkixfNMOTllmb32gl+iFbkKse2uQSthju+BN6aNswu2+2
	H/MPEJMAbaKYsiUTJZX4+g7/A/hbU0Jfx0/0N/8MFnDG1HM3BLYtF3yLf2j+iAp87tJYaUzFJqp
	g2HHXGWqLJE4YiXr5zHZKXqFQ9hpzwXl10mM2HeIlwtKpL1ctD4qy17lWGMX4i1rUvLYKE89yGn
	Gq3yT9pAci8D5PguIFVixlJaUuA==
X-Received: by 2002:a05:6a21:a8e:b0:3bf:9e85:b423 with SMTP id adf61e73a8af0-3c0f0bf4341mr15371836637.34.1783971476527;
        Mon, 13 Jul 2026 12:37:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:a8e:b0:3bf:9e85:b423 with SMTP id adf61e73a8af0-3c0f0bf4341mr15371801637.34.1783971476032;
        Mon, 13 Jul 2026 12:37:56 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:55 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:57 +0530
Subject: [PATCH v6 08/11] arm64: dts: qcom: shikra: Enable TSENS and
 thermal zones
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-shikra-dt-m1-v6-8-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=6381;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=c7IkaekY6O5VmCRVXe8bHxUYf8Y4vnUM7egoEzFTAkY=;
 b=uaIPH469DMRU5z6DvbGQIs/Ubni5ag0PqHaIXSYESzFrV04R46zUEAkGhanwkCfcAhTx9uVS2
 ykoGyO1S0HaArL8+BJGrBAgK54yOhNxocUxKJWkzzeMTu0XD9J5Hmms
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX6CFNoyecAYYr
 iG/GGhcfbeycTuv9KiUcZG8REpdW8iRy7JvRDGFvAS+gxbcaan7JGT2XDlgwTmsd2HBP7ffWYbJ
 WKLcKEUUSHz7Qj9k0SM/0CqPIdEGjC0=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a553e95 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=dm7ITHKX8Gmtf3-juREA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 06LH7seg9CFPXyhIuNOMDW1XMnNxDkxm
X-Proofpoint-ORIG-GUID: 06LH7seg9CFPXyhIuNOMDW1XMnNxDkxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX1gtplN5Nbn2d
 ExBBVKcu9sJD1fh/LJnh/+ZMz78x8GvXa0l8IKReLZ4DXwZCcKnuTUp/1u4cyPz0u+JRByMJedu
 ihynJvkE+Qrs9rU4hgb4vMqJtlAyY5qToqTTeSLVG+2cqy0sPguNA3G1ffY6PidWXCVPRgtdA9w
 seU2+vk6W+4xldkKR+H1v3YyjWsMsqMMSZuvm4ed7R4g5A2o22Gs6q3xhkKZpwWiy4lVPFVokq2
 H0AQIAA++vOduuTvDzZGF5p3ggyauHeAqdkKCUPnTzMMUHIcbDApUOJQuPmhGv7MwLCsReqpHk5
 hGWZc0oXxGYxQYqZcyL4EBjS90HcJFElQVrb2kUkVfINZcWCu+tK/8gnsC4N9jMJ6QihOWCPjZt
 c2Z5MHeFQGGgX+t/k+gPtEovwy6GSyqBcl6NeNCZXTtBgKzbT25ABgN5FbxfMQ0LHnZTgbz62Gn
 G8ltH022cZUJFAUF3RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202

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
index 12e4281f7b35..3abd0a686d0e 100644
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


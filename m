Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0E379C48
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055088; cv=none; b=DrmDQdB6qqfSaAov6b453eIB3DLJ869fUk8R9CXvSsjCTcw9xn4DtX4BKqAYpvovT4B1W0QgAfVcp5xXyVxpQacAO32AtuolSrprYJV2kFAc3KkWnd/s4zxoiA07xaN74Clq6KN0OIIA2TScL1wJ5pO2GGbJl9SGoGTeV8a6Nnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055088; c=relaxed/simple;
	bh=HvKWO1iSiVkXlJ7yiMped7hdFwfIwSCsT/19XOKkVc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mv03BSTWY1fqkXkaoJoyprGn3efmeCLKZHxkp4wNE979g92Hp2kmDIUnkzEoC5qApbrEqZ5Okxu2XeNUK2ikH6SW44YOZNILjO7iZGoqPRXbz5784jo4BuNL7hMVfrz2u8fIjkGQlIk66LWqeR1mg/ixWa5ZKedBGDsRnvUlSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7ydZQRi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b52e8bej; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7ydZQRi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b52e8bej"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342Xgn2828879
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 05:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qx1jryt+w9ocrYJxHKnGXMAcyhNSVdStAa0R+2biL/4=; b=X7ydZQRigfUhah2V
	numTAi3U54CWSueCpcQ4HGTe86ghCLPFCH4ipTEBs63HmjHvd58GfYZio0dlRpwt
	6Y+hOSNrqcZgD5tFoj/2mefSGwp1Xl+YRgy52LoICv0o8vJ1EGpob7baSjOaAIQu
	Axank6orrEzIt/l/zRFCx1TDQhDF+aeOn3br1nNdanOdHLs9pHMCWF9gViXLLvtE
	vF7CTbUBESGpveoi61+9Tw4KqmcjWTYq9RreUuFETp94wRwatOdmgUc4IMxz1Fgr
	CjQyV2t+Nu3Bij7/HXikGOIgZtOTp0GAH1aSTOJXuojKMsbgeAKLf3w7pCHj35Qm
	ZVzA2Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b58hpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:04:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88fc985a65so358470a12.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 22:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055074; x=1783659874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx1jryt+w9ocrYJxHKnGXMAcyhNSVdStAa0R+2biL/4=;
        b=b52e8bejWwmHoZhWJcLp+oh8Azjp+fY/LPymbC1GrO5BOtfqDv6oIixqSD/6t+yH0z
         AAi6DXK2x1sUGfZbzptkExvmkRmDAeRXJmS6arhIQpDu6UnTu7jvYaOXE4LnbUFAksRL
         a7jxiwoFxYKfPPfSNZ2RWH4kTqg2kF+CYoKekBMKcMUvn9YHoWKpizx947Uo/6V7wOpz
         ulma8KDcoZ0WFWnrkfLN9hlrk0wxZxiR9jU8lfxkCKiUloT8Ss3VR9/ge2to5Up0XeVG
         nfSdwoI1fEvZwiWIk2Uhf4OJfrL3oJhEWQynyXK6WmDIUz04lLkYEVS1mFFSb1op2Fso
         3+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055074; x=1783659874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qx1jryt+w9ocrYJxHKnGXMAcyhNSVdStAa0R+2biL/4=;
        b=TwUp8euiH6jOh7Ry3MOK849p+8lJNMX6CZGaZO64QviOjlfKOB18AiNrGIf2JrDBNF
         YjMPiUZ16mEVs4jZ8qBWrXSMIl9Sa95toYoLqIza1rTPA9i+fu4804yW3sQw1C5qNm0q
         bEkKUZuqCYUfjYOyEYH3aAlz5eJ6I/PZMKPn2HqnFGybwKSoru0XZFF8vXOyE54CXZjP
         LllDS7e4KMDh4rXod9fbufRP/gtTWbgnmN0SKuyynMLCE5g2KJ26cAfTJ1iwywbb4OvL
         xPfUUHqcF62lSFuqaLBLTXKU5xNAo6l7fHf+Wp4OXy8ZU62hsGWslpCUBuI2IbcqmV+3
         A4KA==
X-Forwarded-Encrypted: i=1; AFNElJ+SXr/jmzUaq8qiGVfwTAGQ+/oRICISsU9kkCzeKNb1/9NhfmbSqqGVOU+ibzCcb6NBOjBAIGe1lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuiMRHxHr7xqJBov8uGNiXhbUMwtaU/5gc/aCFeHcUnekiYfC
	DfrZ9nOPWeHpKEJEnpR/I0Bq6+ESRqneboWj9Bv1awbbyppdZ55x50a+LtbQifK7IjEOsKXEpJt
	pO4rvVyCZx8CCvgpuGfyui95rQ0RR0F+kq3SeRlZKp8COz+ZAV3tBv07vfqG9OQ==
X-Gm-Gg: AfdE7ckkzTTBZwIdY+krJuPNLlE1iR3ljZLTzcwy5J7K3brsiSc/92zAl5SlGbgSIVC
	S0DfQB92y3s4KvNOwOyZhVAUTZige/v/KYKCcXp/rZFsLzzh1xiXBLjbU430Bbv1wTIn2Z1N2Zg
	dcfmDYdKsKNLd3EreJu5KNC9iVZTd/8ie5hQvI/YpDl9UWBAdkO6PpM3a//egnaT47D7rV9GDzP
	p4SY1/RqIUVrCtBgrZtZliJfjkGxZDDw2HgG2NNI7tpvKXQYMoRDcbgeX7smiueNRil5X5zgo2E
	TUvHWjGWlpDs1w3cecqioHMhTZGG1uIKCzEUoW7iI6U3LeuEC7JhCu6jXolJjtw5oH/9NgL5SyV
	gQrBU6Wk+YSHyXFGMEqMEVP0XSXDQRXl6oMXiUBuy
X-Received: by 2002:a05:6a20:7486:b0:3b4:65ac:e2e6 with SMTP id adf61e73a8af0-3bfed362212mr10432594637.36.1783055074225;
        Thu, 02 Jul 2026 22:04:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:7486:b0:3b4:65ac:e2e6 with SMTP id adf61e73a8af0-3bfed362212mr10432557637.36.1783055073786;
        Thu, 02 Jul 2026 22:04:33 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:04:33 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 10:33:11 +0530
Subject: [PATCH v4 08/10] arm64: dts: qcom: talos: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-qmi-tmd-v4-8-3882189c1f83@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=1807;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=HvKWO1iSiVkXlJ7yiMped7hdFwfIwSCsT/19XOKkVc4=;
 b=mpgwylrCzfev8iCIMy+dtQy4h0PQ7b3VjS7B/f/GTW3AL6vQTbNjflSonobtGCRYpLlOf9QdB
 qVA9XGzSulHCmBFFCi0vYFS1Fj5uFZRIV5cL95WFUdQHomuf2ppnUJn
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfXx6ViXQEjtC5m
 Y/ywXQPpV3lbpq6aOHr2FUGimPoIgkjK/MdP7atCbGA3+WPV5vnnseEOd88linyLN88IXLHyQSv
 1eo/C+12hVhgw3RY97vTx2TpjvHihNw=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a4742e3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=qVNQG-PK3-ppUqRZFeMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: eT9FnhXCn75Vp8jWCaC3D34x1GPdz5tj
X-Proofpoint-GUID: eT9FnhXCn75Vp8jWCaC3D34x1GPdz5tj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX9raR3QGgIISL
 6sYz1vg2SrZ5eC47r4wTbFpsIabOvLcv7OiVj4HL8me/1kbMM1Dj8jiv/5C3uvnRTNaZzBq0kYN
 M5E5IXXKIStvHACw1xliw7VTewEpwsA0xRjnK4zMcV/zJge7Nr6Wp3oSfC+ssNiiGClp1uS8rC0
 bStPc2AVsn+J0j1UTYUbEX7AB3EeKCO7Phswx9q529Til3EueOGYs71R3hvSZl8VEzWXyHMZ5aE
 eg4loWPcgUmJbNwmG9Ya1BUumECjvgqYsEeS3AQblrv+cX3GtxQEkJdc5Z/DahTK8s1ng0om6/K
 kWFiMfzCpFupRbgyWoORsYW9OnRN0ZavwGQ9uR1kUV+lJx39tQqNQZ+Xfe/N01peUIHU6H3KHf3
 SBaqH2dI2pp4Nj/dXKziMJbeN09+E9rT8EsMBhS3GX2Y+FmF7qtLSh8zTHeU4K1wcpyMJwDZbmx
 78SARB5d1VuxdfVhmjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030045

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in talos.

Set up CDSP cooling by throttling the cdsp, when it reaches 105°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index fb1bbc51bb8a..2c394fa65228 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,qcs615-videocc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,qmi-tmd.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,qcs615-rpmh.h>
@@ -3772,6 +3773,8 @@ remoteproc_cdsp: remoteproc@8300000 {
 			qcom,smem-states = <&cdsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -5425,15 +5428,31 @@ map0 {
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
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		mdm-core-thermal {

-- 
2.34.1


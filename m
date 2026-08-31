Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945C3D6CB4;
	Mon, 31 Aug 2026 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166902; cv=none; b=Zb9s9MUL3TZZ4SNlskIObWg0016lKaZtka7qiY7UvK7gTrqPQFI0RN7cDiQowcUAh5o2qTHoRsSLxHzmmxf2H4M71zzbjCUce6wnqvCGhs8W33m9wAioy8oqFCWgc06oLC7/3ciUVoRR8gnzHdLljYjCH571NlIHqXbjl/pLWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166902; c=relaxed/simple;
	bh=TadYoMYIPpm68Nqk9NBplSbRQWH2DBA/OYOnZ5p5WZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQuT5C+3h7puqVV97TBiwqyKfupNn8wNRuhDfeUrpCee+/IgU3POkdpq3vre/itt6sWxLzIQL+CBbMY8I4Dyd8hbL3MFxdaP/r3roLkh1NqlHcTBAJHI/DvY/IZ9V7de0lnSlcJqH2ibUNow4DGL5gk+RYM4Pa7oaEzkLoxkd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ct32zF23; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ct32zF23"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xFWb2332443;
	Mon, 31 Aug 2026 09:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=92V5VQRLcjeSpIfYeTmMI4JtBMhhlqcYj+x
	xaRF+C20=; b=Ct32zF23M4QLbJEiqKmBCbehAXVJKcKNB2N7pm4GahERAW+hJc0
	UBUlmsQSfEY0ZdgOdimGYRKZ3scMOZjNe7uYiU4zDLrXv+L6cYoAEtJbzUcihSqU
	92B60ug1WQEkhaej61we9HloM1jQ43X+lr5IEUwRV3G+DazpIWehiA5XJBI32aDJ
	5b3J8eAVdkp075/kU/Z3SImhr1iw8zcCfaq61YzOiMCrEVFdphB5PXv/azKV5ula
	VpCMKkJiCnGuqqyjJXL0ztWaLN4EEYEiklQsk40sW0GyFmnNaKp0hiSa1hDyEpFV
	kZ0vccj7khJcc3YdK3MhUB5ZKHDErCzR7bA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq85dd6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:01:39 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 67V91b3G2475097;
	Mon, 31 Aug 2026 09:01:37 GMT
Received: from ap-kernel-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 67V91bDR2475087
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:01:37 +0000 (GMT)
Received: by ap-kernel-sh03-lnx.qualcomm.com (Postfix, from userid 4851478)
	id 9A01E40C63; Mon, 31 Aug 2026 17:01:36 +0800 (CST)
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: add nord cpu-bwmon compatible
Date: Mon, 31 Aug 2026 17:01:34 +0800
Message-ID: <20260831090134.585588-1-zhangfei.gao@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: MWbGdliqyAbGgfYWbpdvtye9wIKgbYsD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3NyBTYWx0ZWRfXw0lBFkj42crO
 dueD0L+KFRyiGPsrnRPR94esd5sof0bopRRTRuJULLWLwTfhoNx08JDrnCEv1ajoRmrfinSvQ0G
 w7vTuCLtX/V+MtLRJc6W2uk3e1y5tPw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3NyBTYWx0ZWRfX22yCmAsilHgB
 uaEqfcKSMY7lUO3WUap3f7spNdAd7NXT9lnZBiFJqX4kvJms18p/YN6iw0i22pk/vvddQN2XDNX
 P2vX4WWQRl9XddbB1wwZcCsEcX3mOx02vV1IGEUxsi1y7re56AYZYhQlTDW9Fklb9hMfn43B47k
 FZ/+rX+v6F//eFwGOXvVVDDr3z7MyQBZmsdiR6j3S5fyxARS9U7EIdFyzmgu0chICdRGS2CuJqX
 7NMSaLpuF/LBDSJtmOn8u2ic860KMXWf1tetd1e/UQl8VOtj2kfTTCZsYuk/tvfohVNWQvMoT58
 x+VhdqNoRGLWhJ3msHC6L8fqXPw/eZpVPSOCUKeCKIc63hyYb9tAzdarVv7rFAOkCHzy82FHMQu
 hQNrMRyVinzVp7D1kg3l4brzTdrDHylKrWcWejuGNQ3x6da+y77etzhxMjE3VYc02zOzKWwM8ZV
 c5Tv9JapByZBfhwFzYA==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a9542f3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=NpbCX5yJWdky7Lhv6wUA:9
X-Proofpoint-ORIG-GUID: MWbGdliqyAbGgfYWbpdvtye9wIKgbYsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310077

Document the qcom,nord-cpu-bwmon fallback compatible used by the
CPU bandwidth monitors on Nord.

Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
---

This compatible will be consumed by the Nord bwmon device tree nodes,
sent separately by Shawn Guo.

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 21b4e04727de..8c82103fb86b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -30,6 +30,7 @@ properties:
               - qcom,hawi-cpu-bwmon
               - qcom,kaanapali-cpu-bwmon
               - qcom,maili-cpu-bwmon
+              - qcom,nord-cpu-bwmon
               - qcom,qcm2290-cpu-bwmon
               - qcom,qcs615-cpu-bwmon
               - qcom,qcs8300-cpu-bwmon
-- 
2.43.0


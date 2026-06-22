Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA721ABC9
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122561; cv=none; b=UnNsqvMUiagWFlCJzrNW7Z04wohJoO5AoZJOhDJlTWuBDgZ8TVWpkRQxGq4ycRF1GmCPjRRdPHH+MWNFzxM3W7KL7QKsj6mL1DDrgXLgGKsNMW9uQPfvlzf+Lfc2HhxqnfLO4UHgiC9dPBYwSRjvNfTQX7qB5U4O6pvPq2lRZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122561; c=relaxed/simple;
	bh=xiW40JPZwqsEYVD6cBQyY3iOM/mpdV4HTfqmrLGjM3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSyICimkQuAJGmne0eCRAaFlz2RQ7VaL2GPN3EXplbEoWY8/Mlk7KNNQ7m5TUusYPrj3eajhyqFBywdBSvLX6f0WeEPQ3jqHdy6nQx5by90m2iA50Qrcpl+qSy/fiQjg957lupB9V2lNGEdyOt68jP87Of38k8Usq4eQ2GQO6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=auXNUeID; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K/d6Rdx+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="auXNUeID";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/d6Rdx+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M6H3e4096037
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qXMoO+23Px0OwfrZvsqkySjzGHIOA5hqkO/
	MujvCbo0=; b=auXNUeIDYdIHlx9Unqu3NHw5IFBSQL2mz+WU4z62UD2oYLQ7vd3
	lRBwjujuM0FxxUws2MJh0nAvIXFCbCpRDb5mIoShtD9H5xofr3VSguQXqmsO8zJw
	WDdLkYAiwJ29RHxdQ6Yjb3lyGctimZfWxXdcjnkIwbkpKkVxK8gWUlSVT5RTz02/
	jAf/5IXDPEnvFcj6iOTnLKAcC8yEyUnxyK1b/vBaiRePmZa0lmrHhkirKzUEhW05
	nOU/XyFYIqLIJzCxKNx0lgEOj17I49AxXo6K+r+w6folxvfFA87TDHIAP1A2LGyX
	/TtBirUI2IVbCP7Fw7o1UgV2iRzMHky5V7g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1s044-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:02:39 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6c47a07f324so2328671137.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782122558; x=1782727358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXMoO+23Px0OwfrZvsqkySjzGHIOA5hqkO/MujvCbo0=;
        b=K/d6Rdx+xTEakb3yHs8CsmDgLjmC2RpOgPKaAGHD2arh/cjOIry5sWSC2vPRf7VTgo
         e77XyOOaz3ZJbcLjXGEIrgeTGrtUmZ80kzsgPG3T9rbhp6qeh+VaP1BPbimiIzaOgwL3
         xUEC0rM7fUCv9tL0lfGHCjedGRtt4/fetdg4T0rt4HBp8KLE5a3H41vDqES+Y7acv7g5
         /VKpBO2UYl+ECntRzqyeivnmZEOcsCoxZate9/Qqi72UeXsSyJuJPb4ZSN8UxD+pZNZ4
         jAHUA5wU1JrVV7k5qNIycNv/njy0swnhIQ2OwXK0T2yG95cycgz/3kes1Dpax/qPhqEP
         s8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122558; x=1782727358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXMoO+23Px0OwfrZvsqkySjzGHIOA5hqkO/MujvCbo0=;
        b=TtXwA1JhOmOp8Xnt8r0u7sLVqzPS7FC+MKWDpkF3pPqEa9kfo7qXeSHUjijX1t7gOV
         GvnfbfuVXyqCoJxsaVLNsw3efLkiGoZ4S+dq3pX2/GXl3fakMwDnK/DMnYGFwdrPO9m+
         z7Inx/m2irE+2wrXP7DvfvETbrTS8WVMi1YWHJ0XilwNe2HAauJr6WCoKrc9HfkWcU4s
         7t/ZWEzVRa3qjbE1IbopDU8jCrHJK41v5l3WWqP7I6bDSF7+7smZ8UXAlPRb4Rjco9D0
         XK+MI4vpzWQ3sVlEOhD+S1MN6BYlHyGhxJUV2zH+7m1Sabn9y94MTJWCCRoADpnK4GaD
         OxrA==
X-Forwarded-Encrypted: i=1; AFNElJ9ptv0lboawXRW/FZruO46THEq4y/XG23ftAKzLWnlO0Nov5y+chRdEDVbvoJT6e3SCfhd3nESCUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyShi7bWmMerMhWb/bGKV7e65QzGN+E1YO79mQMEbDmOPRfE0
	ymZXrmDaa0lG5IivK8YHOTdx/T2ZhX8bLhVuAJv3+/ig9dIwCPXwEjZdySTgqAsUreib4l0Dk+v
	zEtwgYioxLrSR/6d0KEOH0do1H7CXruw42zTRpjw1V1HcESXVb+t32UxJ7ufpIw==
X-Gm-Gg: AfdE7cn/TlTzhtC3XPjyjSRgGgHVNKOwocyEBey7aQyUVFm9H0laHuYoZcTh2oS0Ujg
	gpEFehn5pGv3t7+MVOClTQjSPdtzNZj8mP/6v9lyGrMJbs1yNJQrjm9nwRKL2hJakmRzgAfQgTx
	SZCmRa7Ey2gLH71ejQEaEpu76V4A1I5XuJthDr9vhFp8/zMx5GZbFKYpCEcczfPuOd9KOFp0eAg
	A5ecigEnEv9A/pNW0RVTeAIHzOvvYhhThSWFo2jad8qpc2FmdYtIP2ZgrDfGnMxuTi8OAwz384L
	ECy6MQflRG5xNszOom10FAqnLBXPZGXgoK/i1qQxOxGP+Y0QkydUeGnB0jVB5DXTPSF+VlSmimX
	M8qa+fgyhA9B8imF6ZUdAQ2Qz8z8=
X-Received: by 2002:a05:6102:5f0c:b0:728:572d:80a1 with SMTP id ada2fe7eead31-72a1f6ec03amr7010111137.21.1782122558212;
        Mon, 22 Jun 2026 03:02:38 -0700 (PDT)
X-Received: by 2002:a05:6102:5f0c:b0:728:572d:80a1 with SMTP id ada2fe7eead31-72a1f6ec03amr7010061137.21.1782122557663;
        Mon, 22 Jun 2026 03:02:37 -0700 (PDT)
Received: from quoll ([178.197.218.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e93sm26969074f8f.7.2026.06.22.03.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:02:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 1/2] dt-bindings: thermal: amlogic: Fix missing header in the example
Date: Mon, 22 Jun 2026 12:02:32 +0200
Message-ID: <20260622100231.438435-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=xiW40JPZwqsEYVD6cBQyY3iOM/mpdV4HTfqmrLGjM3A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqOQg303t1rJeTgKVro56ukNiv21q/Aqa0pd/vC
 Tn0HtAImzKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCajkINwAKCRDBN2bmhouD
 11hoD/9stQQ73qmlHQC4U3hP3M4KnL3mBj6o/LLYxvBvRNPMJX/vxou/V70zG5yHczZgw2bR34E
 9GuXUPAmu5Se62J8QNorNzrfteTZrFZEcFLliFkwm6K61a1Y3DCqWkiZSoQN2xKuqs4LyaFDKZh
 LZYpJbzdEvPWieSRin15LfmjZAIYAoRifoJjS6kZdy2pdWr4CEYb7ubO7DANy0vaLvHsgWlJksS
 KUGuqPjDa5QRo3QCgH7CrYii28rWdjmgQmmTElW/l190DlT/vupUikmqJWCPUqVXVMyhc58jhsT
 5bcvRRqn3S160hpCfBInFIcVg5p3B6sMdduaI0BQfc7szcpadCloosEyLmXT8JSiph8dGLHDrga
 XyI0bwS2bJyxFp1a09dH4W0GpnA+jVRxvM2SPhUGPlLROTa9j2wWTEWEvfO21oEPG6JjyuvbGIv
 t+pXVg+PXEbyn8Pta6pXXgxabphTLbMebdbNiwUllXk6mYLewcxgta4BOptzvlyEBJZpi8GbnVV
 t1CbxDmOc2JOVtJY/aHDVv2jhhN1WI3xpHZAKKHay/Cg0bQNUeE6ICxcmm3sQUP3k3YjDReR7FY
 XQeXmFzhy2WwFQU+e8pqCO0DcbK/uqR5MknGqtVzD1Gt5BQBSCyB/mRT9fh/WWdlUoBwEAwp5Nc hnsvPdYariZq6vg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8SKG_hcW_otXh-EduiVgo5qMje7se75f
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a39083f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=qMZSjPy+XpteAuilWfML4g==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=nNYyxOnhoC1xYqhD2HcA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5OCBTYWx0ZWRfX6LWedyu7f2DQ
 f1OugUt69NBqu5TIjpdBN8dp323HYMRd7WdV/ubXAar2fITc0Af3I+YdrJhjOvK6sXVJcyRrZty
 PS7oQh29HVhxGFDywpH5P01bIIhe7CM=
X-Proofpoint-ORIG-GUID: 8SKG_hcW_otXh-EduiVgo5qMje7se75f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5OCBTYWx0ZWRfX+ghzYCxeZuqU
 e7n+2KHNpRYQEYmzl2s0kCtnIHP6lNoIVYwaeKjA4dtBwFq8g4eoKe9Tx9xa9ozHS6tOUfjQv/w
 MKagxmE1ISfr+iN6/c1VoMJhwAmYVbd0pnVhaThp5btKCp0LtOjdL6MkXAJ+MXYNjBLMDC6sTFP
 mBudl7DOF8pVdXxFxpMcQK5OWlfICLOsPpwKDeA34ufRBBWbI1hUyoOEr8cI+eILP7XpaqP24fd
 KKAOF8rHU17yE78mnXB+75YQvasCoFc9L5D64/QaaDhQemZghTLID4ygdC6bwGCXNy5AWAoQZRx
 1DDCeu82hzTF5H+9ivwJjm+lMCRUWps/D4QHAfpXrbpqDQPybN9Hj+54spVmKP7fisM6bgsldt8
 7XE2SF6SAkhbv8gZGegX57fk+UnUL9q60DT1QY3qFZ6sdaJIgBSq20Vkrbe8Yos3UpWREbEVOjb
 piQqdu4ugA0hyhGntZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220098

Usage of defines from headers requires including relevant header,
otherwise dt_binding_check fails:

  Lexical error: Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dts:59.27-34 Unexpected 'GIC_SPI'
  Lexical error: Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dts:59.38-57 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
  Lexical error: Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dts:60.37-45 Unexpected 'CLKID_TS'

Fixes: b1c8ccdbd4e9 ("dt-bindings: thermal: amlogic: Add support for T7")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Fix for current RC - commit already pulled in merge window.

This should be applied fast to fix current RC, thus maybe Rob?
---
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index e28612510d67..d8f7f3eb7ae2 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -87,6 +87,9 @@ examples:
         amlogic,ao-secure = <&sec_AO>;
     };
   - |
+    #include <dt-bindings/clock/amlogic,t7-peripherals-clkc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     temperature-sensor@20000 {
         compatible = "amlogic,t7-thermal";
         reg = <0x0 0x20000 0x0 0x50>;
-- 
2.53.0


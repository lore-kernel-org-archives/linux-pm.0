Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC63A254C
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122563; cv=none; b=JTiswbIAe1o8YalymzF21efQDu30FammnSPLwRIaJU/a6OedZvx6ivay3cJ2oOSbkPH1EBeGgi6wYtEvC43CjkGJucpbZI9kZoDhOiLOECV/cwSDskP4sOL118eNRlWZHPlOpXyr2DE1Af62u/QSSUZTQfHfcE4yaeE56wJUm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122563; c=relaxed/simple;
	bh=jrr75z3xkwFfMtmeu+zIMvJs/ytHfPd20ml8wylasTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv/2F369rfdUhXOmdV6JvprD6ieEpJqDoErNQeFj62R7rRyoYJQeWeFRxlQ3fx3GY6yjsyiYbykPdrGv68wEe7PVQueS2JFDfnfeqAtUZtl/qB4QpZHGoUlkLBbhVrrjwDfOLRTcOUjz+6ytUtV4sFj9eMYPpOOY4uUlZBhO1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YA8pEFwa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cNi5QucF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YA8pEFwa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cNi5QucF"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5BXQJ4183480
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0sYMNzaE0WX
	yJdKP90e/gCaHJORjnNxy6zzXtaHf/7Q=; b=YA8pEFwaOmPxxU5UrMlI+ajv9DL
	YgftcUlWbo8PE9lNgX3uERMiTZaCazR5n0EG68U4g7lTDjJnHDSJNm5pxo+WWAzw
	zYy2y23Rr8tOgGYfMxZ7fpylElqiTEO3/22y6POt7PJZYGzGRZGnQHR1jcgojKj4
	7zBn8Ph8heaPMFnBGoGssXzNQljeolwhZnyXIglbjL++J7D14HpR6Mqy8eZUB6y1
	3f4fRDWypAWyQQjbfbBm76VwEz17PLrs9nzx1nvJtG4i5jsvLPOOxvhLml6V0Ifj
	WPxpXPWkcDDf1T46gIYJGm8GLTWXjDqbKUHqg7vaWGhVyF3Qc+pwijmr4Fw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewj6h619e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:02:41 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e93d7611beso4344812a34.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782122560; x=1782727360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sYMNzaE0WXyJdKP90e/gCaHJORjnNxy6zzXtaHf/7Q=;
        b=cNi5QucFsPtvHdx6sL4IeIWeCGJ2yGQR8XklbSel78JdjnBOymdlH0E3Fcs6/wSt20
         G8cbwSz69a3f0UPuyBoNFJ47Ri3voygxAiEH4M615CdTM0rY89rl4VumXdYofI2+dPCD
         uOrgVMyckDrH9pEUR4lShLRwgUtOTitEwZL/XJ1hGikC/8Gz7divFzVweek6g+QxS6kc
         xfcw35y8hpYqB12RasrDwrHIzw/350g1jzxHcVZ310fHgWT7snVsk0G9OhkRhIiwV+FY
         5seWwEYqjJudX5+ipaqvvvpUnh4k+mcFC1iIW8Ddstbie274P85PkjZBjuIPAMb4cE4b
         RzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122560; x=1782727360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0sYMNzaE0WXyJdKP90e/gCaHJORjnNxy6zzXtaHf/7Q=;
        b=kmt0beY3AhlDneH4SwkDlsv3eJnhySwHwF9fCEETWt6UrIKhQZltyAY8CKF+jcksuV
         Ghet3MUDSoPVh9maTpBZU73YG8wfftfAAuCOaVoGC/G/8Ukr4mV7b2LO5jsnOIPsOVIJ
         +6DPr/QjSsrYeKR+hRtgk8dDTiQypt7yObzX82C4iBm6yJQXYS+54t9Bin4DT+k6ggj2
         aM1gAsC2e6fSA/NocRXFpcazY/kHcSPFMCuFcNRbqoANX4C5j6tnJQYQU6wiqOWPrSQI
         DxXdGOEmspQKI/+WuGJOcGTn82pz4XHqql8Mpr3SAh80yV5pzg0L95hnbQke7eEYnjOk
         PYew==
X-Forwarded-Encrypted: i=1; AFNElJ8IG9UcTox4QIKCVKSognFsH1xpKpnB3M88q5OEzlWecqa5ZX+dgOmvM4QDaP89Uc3kASRlXVghSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4lYklit+Tu9hrF/K5EKS6RmfiXQWZOrsHsL096wK8D6xf6dr
	NVwEUaSxbTYDLMCWDJvFUkS5k81LWPvYwK6kqbxZC36eZy0xzV6SCC6EyQhjgTzYLFIdFXNxF3P
	beIeluy3oBDKYSneX8yCDL1ahGOIEMhQlgFYa1UTP+SSk7bIGyj4ycLrhDPyauQ==
X-Gm-Gg: AfdE7cnjeYvG4w7oEGvScS40JNW4u8+6+FjG/KNe1tBqR5vsmhAJ4z8zcaeI2wGDLfQ
	7Y42egtlhziybjtfF9xJpIBoef7kNHN+gmhHIT4Oc/s1L8Tq+UwmBapnEntA0cm+ZNzTNjcEAUK
	Vv82RWD6KxmnY/HM2GT40ZgccZsjfPqjU47AOnj4zH4cvZBPAFDK2G6H7Vy6n4KGwejued1mwCk
	ZLF06UrZiqmZixBgeqWonSKCPGMKimGXz/WcU8ynfaBgGbAAXOIuFvGruTxgRoaVGpnjnUHvMmF
	1EyE9GLrMV+EhoMZPJCeV/vDiqlSA0wDGvHTsN5dCjbS6pEnCCQMSQs2bF6Mu4xFhM1TQRAUCpZ
	YE+chSiZ264ZxY4HmBQaCybpvOZc=
X-Received: by 2002:a05:6830:640b:b0:7e6:deb1:485b with SMTP id 46e09a7af769-7e92d9c74camr12345330a34.16.1782122560498;
        Mon, 22 Jun 2026 03:02:40 -0700 (PDT)
X-Received: by 2002:a05:6830:640b:b0:7e6:deb1:485b with SMTP id 46e09a7af769-7e92d9c74camr12345302a34.16.1782122560130;
        Mon, 22 Jun 2026 03:02:40 -0700 (PDT)
Received: from quoll ([178.197.218.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e93sm26969074f8f.7.2026.06.22.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:02:39 -0700 (PDT)
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
Subject: [PATCH 2/2] dt-bindings: thermal: amlogic: Correct 'reg' in the example
Date: Mon, 22 Jun 2026 12:02:33 +0200
Message-ID: <20260622100231.438435-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622100231.438435-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260622100231.438435-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=jrr75z3xkwFfMtmeu+zIMvJs/ytHfPd20ml8wylasTo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqOQg4ygfRlLfcSEVBjglg2VauG9hcRR2aVageS
 CsxVfmm0ueJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCajkIOAAKCRDBN2bmhouD
 19RCD/4/GnAM75B/sN3PSowYPUr2PmRH0S053tH85DKbVynKh69/2umobq4B8rLav4o5bJMVTAj
 jNdo227SUa8yBFB/n8KSD8MlpcrGjIFMgXuuxeZGf+2mD53jApTsS8/9Y6nQuvPtHFS2kPzB1in
 wZBBGY+BT/vrsSsyJCiSWOOXiuZ3tfc5tISQk2wj8TmUGaTlxWhguQ7vQsXWp2WklWh5Codhj71
 dUbdNyOWsY7hGssZydqUvNPkU4lMMotQVHMf/4qi9SBEzJLJfGfQ7xJlFD4flUDgyQgOPvxgPRg
 /mDEen+bTlkBHRnWUD+dTbvgrXzWYHChrOoZiUrB+hRZ6LOLertNL+sJn1xo8Qu8a5p8/wN/lNi
 p4VV7sh5zgDxcZY1syh2nriKunYjd0aWVHgNXFYV9mXT7j49n6eCEETSZTtwUpbkzml48mRuR/Y
 EuPY2DQai1DA+wyzNQCn/FEZ96ZeJjTtClE9IZHYQKW30D8fXchKXKT7Jksd4/AYf4A2r6OHg6E
 qXU5hMvIhv+gLfBbWVdjvp+E2uow61LSdvs7i3LTUvLefyXH8KwxahSTnJrazBgtqbNepWk8o1P
 1xgHl2KfhK3vUFWNU5LjpLGXxU84mN/NBet/4FugqvE+HcXmaxMQfq6cvXYqDM+S/q5pJIV82x4 AZz7/Z4ctp3JJFQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5OCBTYWx0ZWRfX5HHFkJGSomya
 AXwIJjXOFxqhDhkINSWjyJLB+GpNPnJiNaKiusMe1KPu136OOMn2d7rlxNjtrcHa+j3PVjG2Dzw
 FL4BUiD4ejzjpZONlVzP0IcHQM+s7hHAEfEx88ygtL6APen+YUWo0KR4fYp4gEoMBs2dq1R5kVL
 W+AObJggt6VaB4lrsVA1jAEC/K/9o4siQwL0y3NkpcNA4brYiSfE7Vpq8+qd8HONDnomb3nMTte
 U/yEJTMPzetwYdMf77alc2kkRK1nnznbVCE78gE3dU68k1s1LXRVpheXHNlOw6DVo2PLsMVC4hj
 zrYoJtb/0mJpIdLy5lwPGhtSbz5A2QKjD5qfMlXCK3EtUeb73E4rtv6Jj6FZAsnu/wi2PlL/iuZ
 6KKnO8uqJ4/+BgYvtzpfWtyjya9emBp0Qmtnxt2zzakazaKOimFt/ebkcryVWq0tkDosvFsCpm+
 A8bMp0104vo0W2MkBaA==
X-Proofpoint-ORIG-GUID: UArkKLZgKC4y2YrzG7W_WC93_9_7BHmu
X-Authority-Analysis: v=2.4 cv=E7P9Y6dl c=1 sm=1 tr=0 ts=6a390841 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=qMZSjPy+XpteAuilWfML4g==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=wgRPBKK9NZbZ-O_S2bQA:9 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5OCBTYWx0ZWRfX6pZU+3TNg3oY
 tZ4gJmgOfCrm1hMBrNJrTj0/EDjRdzr+jddXYAapZ1exztmO21gqPkEycZpSjRs6C8LT9W7qZaX
 U2VVDzj4Qr+KHX/wrQV75Od3o+Fzsso=
X-Proofpoint-GUID: UArkKLZgKC4y2YrzG7W_WC93_9_7BHmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220098

The example DTS is tested in a wrapped node with address/size-cells=1,
thus reg had incorrect entry leading to dt_binding_check fails:

  thermal/amlogic,thermal.example.dtb: temperature-sensor@20000 (amlogic,t7-thermal): reg: [[0, 131072], [0, 80]] is too long

Fixes: b1c8ccdbd4e9 ("dt-bindings: thermal: amlogic: Add support for T7")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index d8f7f3eb7ae2..8cfa44dcda58 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -92,7 +92,7 @@ examples:
 
     temperature-sensor@20000 {
         compatible = "amlogic,t7-thermal";
-        reg = <0x0 0x20000 0x0 0x50>;
+        reg = <0x20000 0x50>;
         interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&clkc_periphs CLKID_TS>;
         #thermal-sensor-cells = <0>;
-- 
2.53.0


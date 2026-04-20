Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1837B00E
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668072; cv=none; b=YK4C+Y0AC+Q8TfxOmtWrd0pYLRkgZxDxKlpoGEkU7tVlenwBsVkAHTLiYWP8WIjYc2RS6P9OBYr366nvCF6RwLM7cWZTCGXXHTFPCScDBt5NlHkWvmbQVzk19OacRsKVBO9hWpYRqdFS6xRj6RYWd8akdCCdevCowoB1siogcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668072; c=relaxed/simple;
	bh=+gpiwd/uytI50Y+36bWOKFiJGYYLm13vxU2a9WScgiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWS0/qwIrohyNHP9bTBVX5BLNnowloDZOlH8GYhX63pU3oAcdyZJ7TluWtwjwGa1iGkcRDe26tQlLyNxEiaiw0UG42hVP6VCLtfFSeJ1S6cUE7dT3eo3JPbLwScW66JoLLU1eZLB5qMfFkdwtEeJDxBfFZvf2IpUwTFikDkH5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ayjc3QIc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HYghVbtU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ayjc3QIc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HYghVbtU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMA2Dt838778
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 06:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QQE4p3HA2XSX/yYP31R8chNUnw0g5gaO+Ji
	c8gI1HbE=; b=ayjc3QIciZ6OOJtlw401tejoQitFQnftE/H1Ut13l9BhqzKrQ52
	giLFxbn5VauO88ldBZBCZ/Lede7d89Hz/MJF8bh7nJs0RIRN6B0v6hmBJoHhKS+X
	aG6XAXEhVt5PHO4fhpHPUYV5T7lFlzpkQbWOwsShrMVn905+Vi1YLnfxe9KcJS6T
	vH4nwk0IOkvH17Imza9hKTAYgeXOZdUNL5RpWJtcGE6AqccbDdHtvlH/4EZGnoAK
	GKEnJvOuZe0QSOLwX0MUwbCezRM29kzWQu+k3HyBG4ckA38IjNJAECKz9b2TN7Tb
	xxef3cXVnSaGimsbKvf8VvbRuThUyST3haw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm1hx4hqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 06:54:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso3002364eec.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776668069; x=1777272869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQE4p3HA2XSX/yYP31R8chNUnw0g5gaO+Jic8gI1HbE=;
        b=HYghVbtUtFxbqU+5Jtx/CejWqg11AjHzqGcKZQpPb1pTP0FP0vwa98fSTuctaKzuWY
         //ysK2u7MA0ZLfhfitf9JZDmw7LyOKRtxV+aeMIv7njb0n/8P4xSuPJfiMAhimbsvhKt
         f+NOiqUjURHwhcS3kfXS/absdWxOGsj982PGVnAR1PHHbfYQ4wKBdgqsbs8/g/Gw08ze
         /F1yPPAiH9Rv/yaCA+dVyHVAmLuSF8LqAZYnSSTQgnODLwdm9w9C/uLGi9s6Gam5Ich6
         bPmPsbQIJh02pbPvzF56dYxBsXZpnA7PTPSKinEB7i/RFS0kpVJGSiPWyoS4wOzYUk2U
         H+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776668069; x=1777272869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQE4p3HA2XSX/yYP31R8chNUnw0g5gaO+Jic8gI1HbE=;
        b=KPfLGHLM6yVnQYLXTteRDd1DPV65rL9ukwgf7LWg3Z/rvvdvgMAjw3xr9k49hdo4sP
         x2RbCaLQmm02fDylGMc3C7S71Vmb5hfKFBR3Q9dfB4u+hoNnervud4RAFoRiINq/xA3y
         QzRhHQJkzPP7UadkUMMZagFHxRS6V+UlZCDmlgEvwMVdD/3agOqr6iS5OUHeMNKEKMwX
         wU802Tzbu8Y/iIZ5hQJSZofB+MYvt77xd1dHafvpqw0ddr47uF3iPHCPZQH5h0zm5Xck
         nl0pycp4hq7PMnyVC8wKCcTwtrXPgNoGU2Vuuf0oudKyMKNGhBPDAxb9yrmlZg4tuQB3
         ST9g==
X-Forwarded-Encrypted: i=1; AFNElJ8IbnBsQKGfb904bVgb8Lh0kDHxjyuwqnY5RgRYBPuL2RUbYQ2qisiksXcnx2v3GhPe9Q9e34JXNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLYCXD/vAMou1RK5S87+b7sZ80lk5FF1C8tKBqkwtFFx1zYS/
	S/Qvy4AUqz1OVzFnVSwLVFjPhVUv/Hs5idej956TzJGnCjxnmnWxj9LX/TzJIQpbgoDURvU9jNP
	04sqyvDPyyzUYKkFFeGhcxbKgTMk6qkIaO6aB2zeuoRMElv2n98ZaUGT7uUGOIw==
X-Gm-Gg: AeBDievzO6O0iIMdByP68HTzzbB9Mzu2rt+miBtqwXudYQwV/lLo4bXuAcFoZChbEUt
	PBRG1jt29kJ89MYQeyGrSF+0G81J3uhYqW9PeXT8Ve+YWbmkuxL4sHZC6fspLRwwEnkCfYMIPvZ
	XkDJ2pxEzUFcTzwvEbRO9FB8AMld5c9mnS9XX/mIaYNY4M6Ynalo1gAjICXWEXgsKoYB4qMpQln
	F3JGhWOKIlnAWghdLLhLLkgTkneo4qbW/+mbhrG6jJeyZCxMKxAIlU31et2Vpuk/DPkcLmcdocF
	bedAa9BB13S2CyW1yVD1bvw965QSmxYIrviW41nIlvna01/SHQJeDEx3ZeTGg4hUd8sWNVhD/sv
	3puubyxpAzC7KCUPKp2aSVJd7gLJYP+oJyciYF5lSKvSoTQevto42OOpYyRRNfe5WFA/nGHu0a6
	i2XQ7ScGsYnZiOfyga
X-Received: by 2002:a05:7300:72cc:b0:2be:7885:31df with SMTP id 5a478bee46e88-2e478839275mr7110406eec.17.1776668068745;
        Sun, 19 Apr 2026 23:54:28 -0700 (PDT)
X-Received: by 2002:a05:7300:72cc:b0:2be:7885:31df with SMTP id 5a478bee46e88-2e478839275mr7110381eec.17.1776668068202;
        Sun, 19 Apr 2026 23:54:28 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm16314442eec.8.2026.04.19.23.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:54:27 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: Document Nord Temperature Sensor
Date: Mon, 20 Apr 2026 14:54:09 +0800
Message-ID: <20260420065409.1249030-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TJJh6yl0yuEo1k63apxW0XOizxAx8-cC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA2NSBTYWx0ZWRfX/0u5w7W48KSx
 No3kNQ0ezaSQQVI8ypMdqyHGpvLK91eIY3g76Y10OMnKuNKzC6AC9VS4/WmM6fnRayr9dCpL09/
 LGxQweGxxBb3OmX0yWFRvanfBL5qi88bhz4zE92H+tLWDRLwR6Hykxa8OLmFo7cOutwJxuA4SHH
 C/cohS9kAnyD6caeFGnQR5tJT3AKLw8mmnues2PJE6AxUn/pcuoSIxilDvOJtoSIAi/yqnn7/PR
 rX9jcxoyg7C2N/BIxxD/GqzxoNx5Uo6FuWs4ikO3JL8JLm6tafAe2Bp+ki9RGxmxpVX+8kOMEqi
 BMTcILF2ivI5hBiWP6sS3dgBuoQEl//dmCAnoWACaL1K/9+ETc6LQdIs+EEo3ZWQB8xdg/qSi3c
 xt/wc3xbnqg2ADvTbbGrY+17+CaSuNAbUn9I/EvAcNwLwHtk8FGegx5o89nQQgiJoQuUqJdhtP4
 IA8zx0NDWpLNaiX8w4g==
X-Proofpoint-GUID: TJJh6yl0yuEo1k63apxW0XOizxAx8-cC
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=69e5cda5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=TcyPYtoLkGytR_Rpxo8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200065

From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>

Add compatible for Temperature Sensor (TSENS) of Nord SoC with
a fallback on qcom,tsens-v2.

Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 7d34ba00e684..e65ebc6f1698 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -58,6 +58,7 @@ properties:
               - qcom,glymur-tsens
               - qcom,kaanapali-tsens
               - qcom,milos-tsens
+              - qcom,nord-tsens
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
-- 
2.43.0


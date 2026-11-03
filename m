Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681352;
	b=zBWdEb9RK3MJWX6tVibqCie0vKS+7UNux3bm5lrAm//LH3KPAurY+YwKtCyvBMOrDoYc
	 4Y1V1oR2H+i5OtZD0eJ4TWQhAhugtAdkg+tWAVMA5Re/1PCOz/4s0JM8ijGyzPTgcPBsp
	 cKPs/zwYwPD7TONrFahHFNexvt6WS4MO4PPGPChAtWVRVPp0oFWFs/3nxFNunP9Z7m+YQ
	 4SnWslNwnxUEQxfoVRDs8KKHDN6JVuTemrT8PQZMiGfsDeZSp9mZLPhNzRRuvZpm1GVfH
	 IKuPoOuP0IB61RrhRLjM33vK2rHsnTFgU4Hpi08jIz6rcBv2rpuIjCeD/rjn8EqjgpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681352;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7upwgKb79Qwzvuf7T+5r1o67QI1wWo0sKlpFyeIZyUQ=;
	b=fltKhjwkSxWR/8RaZeO82HZxHYtmYwwBgF4eBtlwJ8JO/ls6jTws5ClCMSBZO4ZHs/5Q
	 OYvquticWdc01cg0dPXwGh+dxy2uhir9vjmP1Pboa/+73EcLbVNvU4d9GyxTWLaLaVztx
	 2GDIM7sDfyZ48QE2kYRatjF+lJYKU0kv3k4kmmxs0l2Ecf+DBSOOULkvY1P2ZFPeTJ874
	 u5Hc1BZUGP18byrQ3Q78ZQ3Xs4fC5AyS+AubF6BSq6ZdNZXkAA1+vcBdueV6xCg7cv+4r
	 i2P0ySlkX8pwJlxfBS6kAxRtjD6vm+gZ7M8I87yczvePOYDAJ1JNjvgi6bYM594PnOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JfuvBzZW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EL2PpGNL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85908606A32E
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 04:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85908606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JfuvBzZW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EL2PpGNL
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31ehHh2012468
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 04:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7upwgKb79Qw
	zvuf7T+5r1o67QI1wWo0sKlpFyeIZyUQ=; b=JfuvBzZWpOyroViKIwsL2V0fmIh
	acu0P2X29m1aWJ4Jn4qNnJ7CFIPHDvjKOYdDArJ/CUZ/N6E5m7SmANdcPtuqAEhl
	ISz2zgn2Zw7NlCkwQs99Nz44gIs5RsqyB0tSuU3Os+qpBdYF13XqyP0JtA5UR0ag
	KGf/IbuMnS687UXoGnKzrvp3fk9q1w83KUIr2i2mt+mKMw7ZrZQevV3h7UzgAIOR
	l3V1NZDP7LjGGCgdUfmAHlhhsxi8UGitR6COavU2yF3t674+GqOLSy5NUbcNVgGy
	6Tf7MsaxyO2Dy+9czyal4Eyz8gk2YO6zO7X8IFq6qJcemN+BnmZkPexn6oQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6uups-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 04:49:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c7b175e38so77995596d6.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 20:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793681350; x=1794286150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7upwgKb79Qwzvuf7T+5r1o67QI1wWo0sKlpFyeIZyUQ=;
        b=EL2PpGNLMomWVkm77zLSqYCXLbXhJRx9elW3dadE9iiW3c81fsi9/dji2uhphbIbq2
         UtMYBcDSzbb8zHdecax1giqNVCuuqNxGTf2p0lI0X0kMJHOoB7AGz7L3O2Y+Et5lTeh8
         961UuO5DYtuBY8Dq5rjLIng7+ZxYaajL2NdlHJZ7sux/XA/nvgfDtpkKPmXiFHgkdJde
         9fsTH2sTxI0Pg0MoKwqbdkuoChOOqWMbqXkrdfLdQ0YpPoE7x8X1f5+ld3zEckDAZzfW
         Doe4gI1xCAYB/lrE9t3/EzV4dX5VQLCdpz0rSZx/phfC9HzIjmQKm/xVjWdBURuHJCan
         JItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681350; x=1794286150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7upwgKb79Qwzvuf7T+5r1o67QI1wWo0sKlpFyeIZyUQ=;
        b=Fuj17Ixxsy1jZxNI10SGmoMFCqdxMLcBxlFKWvR/JUwIQaGDvCrShTvLTP6mHJz5gI
         4/8IJuGH7GWoV9oncMxzzZoDzzDbJ7BPHNU+EQ3dbXGNPPLwq377ljMMPbYvkSwRBSvK
         DBzKjIRUkrdZ/bojnG8XNbCdCDVz3k45oSvXt1Ar/XJqA86svub1Wm94iJPLBBT6Qh1H
         YD2cICnV3r70XpIfz3KpvtCGuLpimdbBVj7xzR0AcYW92C3haTV/sm6BEqwUGN7gt3d5
         UO+U4jQ6rUo+vqpAJKK606KZHHfrD75Nc169gsJlTPOpIkRKYU3odWpS8ViMnk1XZeVS
         /Ybw==
X-Forwarded-Encrypted: i=1; AKwUvBwTBIl+8C91pTPaoM9zMvyZH5rS11s7oZsm4s5BY7fZNvqKJbDFGWeyZfWyLEA4Lcq3GyAiGekj/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/CvuK4rSO2t8DJmY9KTyZjVYBB+xdtFAoRBmY9wDc0pYrPTVN3
	5NxQs3LYO7k2N+PZq8ki5v0Tj1D4w/TYJuAjVUx7Qm2uYT14qYD+L86Xheuba7NGt70859JnM1r
	KyH3K3JRDuLGMdgK/6OfGaRXK9E4cwRZDfXaYTh9Cx7vEz8pBXxMTdK3De9QALQ==
X-Gm-Gg: AYBFou0CzHE94MeKFz4H24EkHsAjwLOM8UKPLK7RlU5mibrC0gB2BoUSCQrfl6qXByZ
	O8yZNy1WkIJaOqGDiZ8rOPJX4Lrkhefq0xta05zWj1gInw2T1lrJ0G/H42o/koOGcNXWrUjPylh
	Ma77144CQOO+POSm7IknL1fGsmzOAWemoDVj7oryo683ClHRxCkIwA3LcnYMjCknkrVFpEkA0C6
	fa3h6HrKowKs3fC8Df6BNpWVdXzNYen+3gQRKHunMu2y8H5DXynwlVA4aQmnxkSx7bi4f+lpnBO
	yrFrZuAlIZY/crvJ+5wUwlXnvXEaQFBnjRGzza3CpQ6Jc/LFaGj9BhcK+Wcs6hnnf1SAuZy2a4z
	+V0xdiEKUwSq/vAJz8/KdIGmD4OafSnGTW9Ra5wn6m/U9Ot3ht2FOLlSrswb22WRwUoYr3hfP67
	9f
X-Received: by 2002:a05:620a:6844:b0:93e:c12c:4400 with SMTP id af79cd13be357-9442172bcecmr1859912985a.77.1793681349891;
        Mon, 02 Nov 2026 20:49:09 -0800 (PST)
X-Received: by 2002:a05:620a:6844:b0:93e:c12c:4400 with SMTP id af79cd13be357-9442172bcecmr1859911485a.77.1793681349430;
        Mon, 02 Nov 2026 20:49:09 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8b9e:7797:dd05:11cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a879fb29sm25685445e9.4.2026.11.02.20.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:49:08 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 5/6] powercap: dtpm: Rename Rockchip virtual node descriptor
Date: Tue,  3 Nov 2026 05:48:19 +0100
Message-ID: <d58bc47b95fad310cb506ca01b59cbc54f0d8c75.1793666444.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAxOCBTYWx0ZWRfX0xWvW58Ih4o9
 DExed/LtYHnAeBJBm0ZY5iX0HNRMl97jrP1eb2M5Xy+KD3kgodlsgByX0tLOAbYfBdtEKReTJtj
 fmfq15oeLu61mLixICC5hKhruknhilLxprzIzr6jG18Je4jTOyyNX8ijuFQOJvF01bN/xXd9azH
 FTeqeGMnwf+QnEn+3eZAQoPGsPAh2m6LblOV40jn2ymCGUGVeORpClLe2w0Jc3VuS5BS6ouWSCO
 yVIhtzn6/fzu65sOpbi3hsWdoS5i6jX2SnXoK9p3t3RD8wIRWnzIf6M1wDfvDnPx4uSYU7Rq6J4
 XGa7BH5I7YVVxn5FJYpwsqqWByFe4qhSCIsmG8gOflZtLceXRSoZGr4jHrPEn2C+i6UHa7cU/lg
 EO6mq0QNbqOe7NOZhEpDTPNeVlAzQHNoRRGi3UpzJHOAAzefy/Hyk6dRokyvfm0MD2MeAmo5uSe
 Wdojcr8vyaGTJ5dMhNg==
X-Proofpoint-GUID: KdBW8fy7JxobRcw-WFqHaQlEdxwRGQJ7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAxOCBTYWx0ZWRfX2ZVg0jP5/y46
 QzZAfrB1Zn0dpa68RXrk9MMbNZ274/aYHh6Zaxhm5KeBIMjI3ecMT1kh390FxspTj7zBdSs0qbV
 Qc2pxmOScDFrz7CmRlJQAipRSIWWLW4=
X-Proofpoint-ORIG-GUID: KdBW8fy7JxobRcw-WFqHaQlEdxwRGQJ7
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae967c6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=_NZqlvP9bvTAGtRSC3sA:9 a=1HOtulTD9v-eNWfpl4qZ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030018

The virtual DTPM node descriptor is named after the RK3399 even though
it does not contain any SoC-specific information.

Rename it to rockchip_virtual so it can be reused by other Rockchip SoC
hierarchies.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
Changes in v5 (since v4):
- Add Reviewed-by from Lukasz Luba; no code changes.

Changes in v4 (since v3):
- Rebase on v7.3; no code or commit-description changes.

Changes in v3 (since v2):
- Rebase on v7.3-rc7 and refresh context after patch 4 style cleanup.
- No functional changes.

 drivers/soc/rockchip/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index 222d9098cc98..5ae00680602f 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -11,7 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-static struct dtpm_node rk3399_virtual = {
+static struct dtpm_node rockchip_virtual = {
 	.type = DTPM_NODE_VIRTUAL,
 };
 
@@ -33,12 +33,12 @@ static struct dtpm_node rk3399_gpu = {
 static struct powercap_node rk3399_nodes[] __initdata = {
 	[0] = {
 		.name = "rk3399",
-		.data = &rk3399_virtual,
+		.data = &rockchip_virtual,
 	},
 	[1] = {
 		.name = "package",
 		.parent = &rk3399_nodes[0],
-		.data = &rk3399_virtual,
+		.data = &rockchip_virtual,
 	},
 	[2] = {
 		.name = "cpu0-cpufreq",
-- 
2.43.0


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FC277C9E
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344968; cv=none; b=lCLxp9raUaytKJr3+I57Lww0yujCeCQ1kBsSV5rCs9jpiDhGJ5vtHW+REhiXK5tKV1mLquWAE0W5h/0u4ksbFsVZ2O6sivMKal2yii6rGnuzjKRaHbYDvqoFV+SdY0uVq6wKJNE+xU13U3F1DrCB1HMl1CMlTtGnu8PhlSU7trA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344968; c=relaxed/simple;
	bh=lqEP00pbTEdpQoMYmkPwXjxu5YiNpaO/f4tQ1JU2KXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhWyJ5zNMb76C7JuKvYtoEntnSF2CSADm9A/8mIqVUlcLJs5l2BtaxveEu/KsaWJGKxqtl3PIzoc2yyUMd/wLkP0fD7GzjkQ3Pm1wqhRHU1IVKTdCF842DJIGvCwDzYyZ4FXAw1XtTGPBxK56asjj1wgVE+cVdmg3aWRIauo02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVgB5+15; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mnxk7VqN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVgB5+15";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mnxk7VqN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GAY1rP1245194
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iGpPEZxRsSnSMxjXVi6oC3GF2of1hK1gE7u
	5gJ7wYfA=; b=kVgB5+15FMpuFTjX9UKLEiuEhIpC9+Q8NrICj6OELnk2mKr3kHw
	FjuA8y3oC46DD8c3KGOdE2pw+3BmsQ8k3p4ejACYAq3RZgh2/D4lXu4FIwuIzafR
	eZFjhO0HpAyzu4ViaJ411bGACWcK9LSgSnAnQSZjTxNHsxruWuQdaV4ptpLRxsgf
	1e+N8Wxq1xU8wNrmHbh1p+SMPtdQf/2r6sFDOru+XxL5J15hiSgk6GGl5B2poFZi
	825NDiOg6ZUbrYMrd4Emuz0KVr6huWG+qHDpdDYoTdkxCLtmyjhI6w4tKdm3DmXE
	lkGsl8PZRXACqjpS/2OvOPK/vPsUVYoIiHw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djx4k8ev7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:09:26 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-68d7d187379so12014262eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776344965; x=1776949765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGpPEZxRsSnSMxjXVi6oC3GF2of1hK1gE7u5gJ7wYfA=;
        b=Mnxk7VqNaGezZDDIOBKoZpBNZjTh1kz7MsGeCXGYy5l0tXkkLXqcexWel9AMLEs3PO
         6+iwv5z3U/jaVf7eTTk04NCoiZt5UYgkINvzE7lHX9G50DKYNt+GE5e+zRlMXT4qNbwK
         vfKURrlDtdX7F1/a2/yHLjVJ2OrfjQvncMgVXvUDZDs5ORBGOdLtctEnKTfFfm45QFsV
         FFKDCIe/09yXu9HNg5FvtCKOGozPbbRgnLUdRyFjol0DbW1XRPO8rVdshuK9u0NdAH96
         VUzPgn9F8vvtd8WBvArTupqGa59F1n9eANU5Ui//NcFBaE2D9OyBSSuTV0rD8+cGAD2H
         K10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344965; x=1776949765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGpPEZxRsSnSMxjXVi6oC3GF2of1hK1gE7u5gJ7wYfA=;
        b=j/6ZPGNz0tTXMz6McUrJMw2JqzgzEAvZepzm6jkBIdz0QiY3vj23Vrs7hgnSl4VQwC
         xJyjwfKECOFLQdjWwD8isFvvRbVDG6AiEl1CTnwsfOl7+QE7qvXnpy7ZLQ1bFvmfGoAL
         Rv7UuoohxCrRMXEX1FsNRrnvuzPLvUp4r1dLSLowCXie6zJBjygfKS4657vqudvWPa2v
         FSKG0K/nadB4tLY8eRbw+PhUoycYPjx5ISWOdsiR72PoUoC1Cpg6KWiLm/eXlTBHt1u0
         DnCSh2ssD6gOJ2FPSzCW7FqTGgCQ30AJBIGRlcRlQ7m0+oIG9o3Mm/sTogFJ+vv0LTR5
         qIdA==
X-Forwarded-Encrypted: i=1; AFNElJ9gjy/qLYfm9mMOHz84NOOJm9zplGER9TFLOTqjwtM0FjCYcwy42Gh6MhXrBmbvMAJQv1n012k66g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/jTD10ZE2JzZLyF/ef82AJ6b56+HAczRvFSEhS34ojASTQwI
	Fl+7iHe736lxqWw3AOvki3yA1J3j3hCBprfYcY6QVhAASh09gxziO1CunYhJxyh7OfwAvDKUSul
	2f0Amiu0jmZ9QwS2QxVOxr1/ymOJQzrYHvX2yi+RstbkcmWmeVGWJ3B6D+SyQbOYTGK4wyw==
X-Gm-Gg: AeBDiet927gaEGH5jLCJRg59VQO1sIs6Y9XimUhzNKMNe9d5gt4w/KkCR3wYiQnd4hi
	ALExEB3pYzdDaCwpXFyM9rhxUN1Zyh0X/r6ufZ0Um4l3z09fwfztVhX3wir1No8sFaSa847GqRi
	dE/WdtD8Y5lhnB28XWaNrXfWfZxPAN5Tj/8HUBcvyK1D0G2R+J9dBTanVwYezD4rDc1lEq9uEvu
	/gNUFw7FaSuPviT2VM7GBc7OD07gE5MS3/45KtD8RdAJtU3WYGtSp+BVjvswKmyRf58VEvFWCDM
	lHTaT9+c+6XoWlbt32P7Q9txs2Hh69OAAwH9Nv/w0rMhHxVqTbHk9pCPZzy6MnG2/G4Pa+sXBvE
	jzwJieCy88jNtE+kcZPee6GkS966hOAskExpT
X-Received: by 2002:a05:6820:1348:b0:691:f0b8:fd99 with SMTP id 006d021491bc7-691f0b909e4mr5555972eaf.45.1776344965039;
        Thu, 16 Apr 2026 06:09:25 -0700 (PDT)
X-Received: by 2002:a05:6820:1348:b0:691:f0b8:fd99 with SMTP id 006d021491bc7-691f0b909e4mr5555953eaf.45.1776344964585;
        Thu, 16 Apr 2026 06:09:24 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f08bdadbsm50370825e9.0.2026.04.16.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:09:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] interconnect: Do not create empty devres on missing interconnects
Date: Thu, 16 Apr 2026 15:09:13 +0200
Message-ID: <20260416130912.375013-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=lqEP00pbTEdpQoMYmkPwXjxu5YiNpaO/f4tQ1JU2KXA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp4N941awvgDdQ/TB26yzGfmJjjQHa+KzRL6aQD
 4HbCZDHyGWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaeDfeAAKCRDBN2bmhouD
 19kfEACG556rBUaV0iKYbrKjvem5ofqt1MkSwxv30IOIQn6id2frIKfC42YrnrMOMynL43Z5VsX
 iEpN8+fN3EIY9R5XzXuCSL8a8b8dulUf+eDiIh5yIHxuWoNQZpfYUQOSlsf+T2Sp+GMuJn+/AZG
 pcR5NSMMAQZwK9/dbd+IRIams68//w4dydhluU2fHUzaLiHaxQk+gUDr0+qYd+N5ogO3wdKUXOC
 dOCX4RFPHymLq++jJTS0bD4a1ulNMhluAMdwiUwf9ynha3rfzpPc9+tKwz9nO0JJsZn3ESfT2Ac
 JVi6gMJ3uTH65XSJVj6IoT70H4xCTiJ9g4MV29VvMnKtMCF+Z7KyVNkOQ43z4XRG7WxMRzAu8BX
 nBLndWKbrzjMtfP4lU2lhAKy2PST/u0uxiAZO93LwtiM1kOedknFbKRlZou7CxFz2g4GrKpVDio
 8sKDLEq5gq5dfi60GUcz30POoLFV+MNwLIKrvnNHPBbnYUw4eGGizAx0TSmYXNvGM5Z/ce3Wu/n
 Ox9bvkDRCERDik7siZJgfkssC74/P3tWvTlYx0lBVPYUAlqHLYF5tg7Xcvz0UDNdkRPiSuugoE6
 r+0YEnr4beRk5v7YnEbvo1zLLkD6GtAKiSg12+IJNJ430WbGZ9IRIHjHKt+8GbWdbQASQ2hnSwM m4DYGnLjJxovwLg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GyjM058kik5WM00fryworUofEO93OLOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNSBTYWx0ZWRfXybLTVyvPsM4S
 TJidUacf/SQqn/fASNwkkecS5awUmGkNZRhjxpKP24PbYNlZD3tyDfD7KruDIdh+J3S9s6uWLjk
 0NQ/9dYRDXPNx2AQYxI76u5M7xVlmXYagXEyOLgbmqDeN0xskYHU3J0M6t+rIJxIz7ZWTc4KOEV
 KVj8vP4rMQoZMsgOuNKRqC7g/4Xj3M9cFjW9ihvX8z8glJfFB58q2FyV/1J1ud8OAz/NSpwGGJX
 6JQgO8QtgPtmP3Ik+mIISXZLp0kTF1/iB9qRfpp5+lLY7ucOEcZWGCPkvKoGIINmnY+Kll2rEEn
 Ohcn8odo8SzXKcF6OTkV/20ZflOIILUS3kGqlk/ixt9odskTB7Vr++odbeMa3oBVGflpx80vVgh
 uC7LZ5un58WoIAPiW2thNg/WdU9zU9eCOTzh++kkB6tIUAVEtEwcfAqRRG+d8MdUciHO9H9ETTI
 0KDxV+rmI31h2exUmEw==
X-Authority-Analysis: v=2.4 cv=H47rBeYi c=1 sm=1 tr=0 ts=69e0df86 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=E_IaXGz9Cgm36txEtSUA:9 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: GyjM058kik5WM00fryworUofEO93OLOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160125

of_icc_get() returns NULL on valid case - no interconnects - but no
need to create devres for that, because it just wastes memory without
any use/benefits.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8569b78a1851..ce572c62f58f 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -432,7 +432,7 @@ struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
 		return ERR_PTR(-ENOMEM);
 
 	path = of_icc_get(dev, name);
-	if (!IS_ERR(path)) {
+	if (!IS_ERR_OR_NULL(path)) {
 		*ptr = path;
 		devres_add(dev, ptr);
 	} else {
-- 
2.51.0


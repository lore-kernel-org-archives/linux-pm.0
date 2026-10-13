Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA14F93D8
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895762; cv=none; b=LPL7MvRwt2vn81RJvk05eM4GH/gGbHvEstecSrCTdskk57nEn3ouJsw9d50nw92PcIqQqLMqH8n/dQkLpN1gNprSm6+Z5THR0YXz6csKp1Nkg2okMTydo5LZb1YBg2kI1cHJAp5EFK8hxL4gDKBXB6s3zb6JKS2sUqKWIUKaRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895762; c=relaxed/simple;
	bh=RI3F12SevTkxJPN9goh6IWbxPxV0Q0zeA5ZFx8o4kIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7TMklFONRKiMkmOMlN7u2baEjMn7RPTlsSzrjUYg48zLfZEcPHrxmj9oO4h/eduGqzWnIP5cQ3kKFXkCkoTJqhwZR/pXeWdklEvDAMlfIImuY9wauTBnWCP5AB/Ige20tl1lnsfr4GNjulVq6xGhUyaGEax3lYSrtr36HqxDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eNYC5f1K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MV0rLHis; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eNYC5f1K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MV0rLHis"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8WbDv923065
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6EkGSQB5G4xh3Cu3jcLEoid3Ki9D2Jc+PUbM+vx44pY=; b=eNYC5f1Kg7QIVs8v
	w5a62JIXXQcX4Dzp4yDic6HGdWiF2tNg3Q8ywXmkv0ZejxTm3QDcJxyexWMHhU75
	iXsJa/CiJ9zxXmBNMVljZ4ElEjp/94vXfLBGENf3GFvg1+eTs+7Qu+yXtXF4nrOu
	V4VAXysKCKfGv/8nJHDJsa9vQ8Vk+grbUWEqHJVlSAjJf9QG7gruY65ADjh7Lhh8
	ygMr0Vq3Uavgmi2rAs8NTD7S0J+6sSm0+8x+8qTnn6JXtuuHkjme3Lyp7Y85tZmi
	YzF9p7+n/lVQrBvFQT/abwV7LWYm7IZZdRputTvbbCESQT4iFAWz7FDVUpZ4BQNo
	dX4xYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1u08b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e46c120dfso311686985a.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 05:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791895760; x=1792500560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6EkGSQB5G4xh3Cu3jcLEoid3Ki9D2Jc+PUbM+vx44pY=;
        b=MV0rLHisPico5rc0n6fRQLGsLYWNIhmEyN9gf5MXiSptZpMaBMru1A5zgblbqFJzms
         02gA1aDyKilzbtJebjMr7xfxn1Csd8WnID2LDh6vqdS/s/3wykFFXUc4P+qJZdGqGOIL
         OM/W2P1PwxOJ3p1afMJ2VG7I89HOny6xt10RNTaXJxFSbBMEPYUv2PrRXfyO/lgcLop1
         OjMoPI45RDaKDH1NDimlT6onjqVUksC5COLDLCPWkEiICvv5Jv411kQtsR/MqNYGx/GP
         FZ/Pxph6TRQ2sCMBhnmZtTQyvw3Z6LC5d6SHFusGhQ3e7wmhzSOXvT5RUPxyeAHIltbm
         JY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895760; x=1792500560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EkGSQB5G4xh3Cu3jcLEoid3Ki9D2Jc+PUbM+vx44pY=;
        b=VKMFqrefCYyyhenHrUBPZ35WWn46R0o8S1aJWopwsUNFCjIzzHmCugJyO1jYIcTVAY
         CyMF4g0XLJyM9e9tYnzNTMeP9m4R04aatWAzPi3csQHvqceUk6XNieh0IB9sZMdZB3Fq
         CP3/ERE2PdpbgG56auHwQoCUh1j2NJooUZ7oV7JigFhQPkaVm9EGb09ZzTIg5aw/FbDS
         9bbhjh1zXiJVo9qE4+oZX0s1R9aNst29Nxhtd7NAKnUCwcCC5u6Wb5FrA5v+43OCccTR
         /0U2o4d/qDIjcqfpMH42BCS81T8RWtylbq4J0fxy3WKhwPZ2/o14+bRu0TMZgt01SAIa
         /Q+g==
X-Gm-Message-State: AFq9FYK3Ouuf1mpPS2pfR8ICXiUl9yMEBz/Zp7ZyZ0ASpbKnKRNp+GJH
	N37oD8IoBmy+QEn79LArDkf35zqBQXE63ifZzjwhmGMgxxH7k9iGLOoxS5KWuD61kCSIl8Dg6Aw
	QATT/BJ9r8BjMXMA50KMOptRJLy439PJ8F8ARGOPZHg44rF2DV0WShA5Z5UlDeA==
X-Gm-Gg: AYBFou2EbobQwFA7zfoLRhPk8E75wSnD2QSd8PFMaixxziBXHssvkwR8MXo9UAIPZIL
	LwPn2XcgbeukXQPCd89hDP0jhvKQj901msZQA0gTlwtC0mHjvn0CkDU15ksUMG0CrFs2Rn9qnj+
	rAy9LUVrg/YBT7sMQlDmWsV0Q0nd6cgB46T6Xp63F2TD8WyGOxKyI+PxBqzqOF3cVpJ5+09CauE
	I3LeTLHYDWp2rBszk8vShH+iNZgNLfC1OxNZnq9EEnuPnSBXeo3PAHxwtls3ifZM/xjbcv9de5Y
	xxoOklUMtOplehtof8bViSu4edTjkpWwHrsyvAh9ELzzGOut+UVzEUIUqZf629LdxCwc+IVyUIj
	oki/WmX28
X-Received: by 2002:a05:620a:6186:b0:939:2d77:d6a8 with SMTP id af79cd13be357-93ebd248378mr2006159085a.34.1791895759263;
        Tue, 13 Oct 2026 05:49:19 -0700 (PDT)
X-Received: by 2002:a05:620a:6186:b0:939:2d77:d6a8 with SMTP id af79cd13be357-93ebd248378mr2006153185a.34.1791895758460;
        Tue, 13 Oct 2026 05:49:18 -0700 (PDT)
Received: from [127.0.1.1] ([86.121.170.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab6361sm4351081f8f.32.2026.10.13.05.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:49:17 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:48:39 +0300
Subject: [PATCH 1/4] pmdomain: core: Support a boot performance floor until
 sync_state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-genpd-boot-performance-floor-v1-1-a765dc83e6d7@oss.qualcomm.com>
References: <20261013-genpd-boot-performance-floor-v1-0-a765dc83e6d7@oss.qualcomm.com>
In-Reply-To: <20261013-genpd-boot-performance-floor-v1-0-a765dc83e6d7@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5761;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=RI3F12SevTkxJPN9goh6IWbxPxV0Q0zeA5ZFx8o4kIM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqzijG9sOIIh2to6kmnPpHcN9UXyPBObu2TfRIt
 WIbSVfctGSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCas4oxgAKCRAbX0TJAJUV
 VrXsD/9duWy7N2cDcEqY7GrL1szQvGWBdpdQqObeK5qRkIH+2ZejBBiEV+TVdY4FpkUr+uKZByl
 vZZYwpbaMptFWvRIFhy3d5lAFN+kPlWRkqmlf8bKdvvl28QwZfL7R4bsWuHoBmT6NBkmcrjFFmD
 8TbWsLXx5Zmm6KgKhjG7UgS7smnSTNH4bDaGfOeIHKLD4K9C/oo7u3VhfDfpv+ShU/kFQE+3Dfw
 5xSZ/TVFNmVZGOVG4T9Ta9VbVAnpzQ8j4V/NsffS/ylxwSE6aHdTEWeKSXjEOLGMzvBx8pUcW0z
 VsSnEsR0PZ6UF3F1mId793uHavFdozD8IuHWe5v1HJ+fxaglcIoLN7CQ46XdIAxDtAeOFNguv5k
 hNK+MnDercTwIeBYzkOlOdp5+iLzEFHcsDs9O7PXkLIqP6kOpXLYzsSemUIVC7/NfBogdqh3uYI
 PYx2VgwxxJ47ZaRQkFpUSxoWXBBYpyRow5tlvNzW6wyC62MGpeKAfBl0VNNwyHUckkhpHcIi433
 cdnM7BQeG4cOXxmPTd/YAYU0OQzyJ6/+aRgCBiq0tm1CmR5ruqCKeXZ4rGZqoErPFJ6EdfTWJ0f
 cF5apkkam0QAG6GvfsC5/F8vw0P1vk9KBc+OrOsqUY/AZ3NTbOmGcA0jAdrvNz4VCaN5SuR4X3V
 GKMwGOIlG/17HGg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace28d0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=F9_3u8r9BEeauM6hPIwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: TUt1TnQAJd6COReen2aD4AWNUo3ssfrl
X-Proofpoint-ORIG-GUID: TUt1TnQAJd6COReen2aD4AWNUo3ssfrl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX8Q/L7EUnrAh1
 tjFMvWGdVc5CG1kQwikOBUHdzOwIajm+tjSdrVtGTV7FHd57KY9QV6JPWCz28scvQjiAG46TpSl
 7Axsmf+ABmsZ8UgWZcjkWV6Jh1KVbr0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX+uZH4zAF15zb
 fWxKaFiaquAqMY+E9MGvzddO6l+2B45bX/A5N+8qpRxM5PHZce4BXVTbBxyLNMhNMu9XNVh4b9w
 rLaFx1c6+iLAxNHdnzLzLN9I4cdG0irayj+LuwAfSF+l8fWtDCrI2fshDFGYe5cC2vc1cEbjDlo
 E2gw31hjPA4K3g+VOX8M01wZ7dDJHzBLite4hkLJQXD3UkX3p4hQXpr+WuElBeuzGDBYGAweI33
 IxKVLjfnJY7lkE/Qj33xB6/IOEtyCFb5MDPnq7K7poWcE3qzahSKqEKI9wrAHEzCXLC6IzfCn4s
 UZvVnfq9Z/C+6ou3DuBso90gW+8efJa/xztvmXEnRQQUAR51M49CLXSxcG2iBnPJuPzCS4tQKVW
 EwK5+BfJa0pr3fyf7muQBeQKa1hFjJ9ePOnyZZ+aElCj5AN70uQHgdq3KSM7nBvv3okkeG2Q3wD
 zvMTTu2d4pwUFcrKasA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130050

Some providers retain conservative performance votes until their
sync_state() callbacks run to accommodate hardware configured by
firmware. Enforcing this policy inside the provider hides the floor
from genpd when aggregating performance requirements towards parents.

Add a provider-specified boot_performance_state for domains using
GENPD_FLAG_POWER_UNKNOWN. Clamp the effective domain vote without
changing individual consumer requests, and reaggregate those requests
when sync_state releases the floor. Zero imposes no additional floor.

Apply the floor before runtime power-on even without a preceding
performance request. Do not skip an unchanged consumer request if the
boot performance floor has yet to be applied.

Report sync-time performance errors and continue the normal power-off
attempt. Leave the provider sync callbacks and existing performance
error handling in place, without introducing retries or a new recovery
policy.

Assisted-by: LLM
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/core.c   | 45 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/pm_domain.h |  6 ++++++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 964e44c2f78f..6f2b406ce049 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -512,6 +512,10 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 	struct gpd_link *link = NULL;
 	int ret;
 
+	/* Keep consumer votes intact; clamp only the effective domain vote. */
+	if (genpd_is_power_unknown(genpd) && genpd->stay_on)
+		state = max(state, genpd->boot_performance_state);
+
 	if (state == genpd->performance_state)
 		return 0;
 
@@ -555,6 +559,12 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 	return ret;
 }
 
+static bool genpd_needs_boot_performance_state(struct generic_pm_domain *genpd)
+{
+	return genpd_is_power_unknown(genpd) && genpd->stay_on &&
+		genpd->performance_state < genpd->boot_performance_state;
+}
+
 static int genpd_set_performance_state(struct device *dev, unsigned int state)
 {
 	struct generic_pm_domain *genpd = dev_to_genpd(dev);
@@ -563,7 +573,7 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
 	int ret;
 
 	prev_state = gpd_data->performance_state;
-	if (prev_state == state)
+	if (prev_state == state && !genpd_needs_boot_performance_state(genpd))
 		return 0;
 
 	gpd_data->performance_state = state;
@@ -1180,6 +1190,14 @@ static int genpd_power_on(struct generic_pm_domain *genpd, struct device *dev,
 		}
 	}
 
+	/* A consumer may enable a domain without first requesting an OPP. */
+	if (genpd_needs_boot_performance_state(genpd)) {
+		ret = _genpd_set_performance_state(genpd,
+						 genpd->performance_state, depth);
+		if (ret)
+			goto err;
+	}
+
 	ret = _genpd_power_on(genpd, true);
 	if (ret)
 		goto err;
@@ -3794,6 +3812,25 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+/* Called with the domain lock held. */
+static void genpd_sync_boot_state(struct generic_pm_domain *genpd)
+{
+	unsigned int state;
+	int ret;
+
+	genpd->stay_on = false;
+	if (genpd_is_power_unknown(genpd) && genpd->boot_performance_state) {
+		/* Reaggregate real votes, excluding the boot performance floor. */
+		state = _genpd_reeval_performance_state(genpd, 0);
+		ret = _genpd_set_performance_state(genpd, state, 0);
+		if (ret)
+			pr_err("%s: Failed to sync boot performance state: %d\n",
+			       genpd->name, ret);
+	}
+
+	genpd_power_off(genpd, false, 0);
+}
+
 /**
  * of_genpd_sync_state() - A common sync_state function for genpd providers
  * @np: The device node the genpd provider is associated with.
@@ -3813,8 +3850,7 @@ void of_genpd_sync_state(struct device_node *np)
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
 		if (genpd->provider == of_fwnode_handle(np)) {
 			genpd_lock(genpd);
-			genpd->stay_on = false;
-			genpd_power_off(genpd, false, 0);
+			genpd_sync_boot_state(genpd);
 			genpd_unlock(genpd);
 		}
 	}
@@ -3841,8 +3877,7 @@ static void genpd_provider_sync_state(struct device *dev)
 
 	case GENPD_SYNC_STATE_SIMPLE:
 		genpd_lock(genpd);
-		genpd->stay_on = false;
-		genpd_power_off(genpd, false, 0);
+		genpd_sync_boot_state(genpd);
 		genpd_unlock(genpd);
 		break;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 14e0e346c610..5927d9485054 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -129,6 +129,11 @@ struct dev_pm_domain_list {
  *				powered on during boot, genpd will prevent it
  *				from being powered off until the ->sync_state
  *				callback is invoked for it.
+ *				Providers may also set boot_performance_state
+ *				before pm_genpd_init() to specify a performance
+ *				floor until sync_state. This must be a valid
+ *				provider performance level, not a corner index.
+ *				Zero disables the boot performance floor.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -221,6 +226,7 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
+	unsigned int boot_performance_state; /* Provider-specified boot floor */
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	bool synced_poweroff;		/* A consumer needs a synced poweroff */
 	bool stay_on;			/* Stay powered-on during boot. */

-- 
2.54.0


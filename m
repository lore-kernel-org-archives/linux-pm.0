Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598604FC8ED
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895767; cv=none; b=MsSwhcFsXmcsbCZfWJuziSgG41VLivIGYBqaqMFcIM8OQT3kc+8KJg33VEq66jD6hoP8fAVBDKZCWKJiQFaXBNpYM6xKNltIxqJNe2Xd1hi/qx/Z7l954kuVrHqMDgnVigdvyuZhhkDMSk/Hm0+bfDmOsQx1udDR29yYQVBNdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895767; c=relaxed/simple;
	bh=XLXwfViUfDWAspkrHSdPqlbAhU/5RfYWoAz0hqUTlSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnlqqqQQqPj7yQEo4lfzPC8Ver3QtVyObavi6Y/UgxvpvXIY1UUPhLsqfuYqAwlA7axgqBczWpf7MVbe+lXjthcOUTD9hK9hDOp0jTr3fEQ2R6GyD4ZQy9PsJwjotZCCZ/4OS+a+dFTZBDdvuys8PaNgVwgcW2FS5MZ6/7QpHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YLbN5dPc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kzf41q76; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YLbN5dPc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kzf41q76"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Q5bl988763
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0y7scvxChVo6RRNrssGjrzZEjKITFhDkhHHby/JvJBk=; b=YLbN5dPcVg1i/t2A
	hWlcQrSj7y1J8Csyffp3lBYrC8VbxR+JywIPOffmXc39y3BN6sHZD9gKVJc72Ybg
	NtvcdAAXYDMzOPqtMuKsvW1HF3D4iCIT+jJEER37o2pRyxjbrt3blRnVmCnscnRf
	QXi2hk5BSI0OjRRsZG8xGknPiwn30yrVoSNgfPBWIB04UYYHFS3yg9EArxQOaZOx
	A5Tdvd9NVY1Xxgo7SjBJfRoFMyo8vMX/qPlSrFsIXCzTTURtDFgb2jhMATo1Zgu9
	S7qqZC63AB1AaISK7pzhWY5K/BRAgJxxTNDtKT9PEcHVOf2WhQ4YBnlMyVYVTVRB
	fGFs8Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hcaynp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf7856ffso591687285a.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791895762; x=1792500562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0y7scvxChVo6RRNrssGjrzZEjKITFhDkhHHby/JvJBk=;
        b=Kzf41q76imhluHy7koAsIKX5erndJ7lc7McQiLXLjffSJrV0ENw+cGhzZsCXACXhxH
         QuVTAHDS+upJG9v4IdJRQlrGCz8mTr+hokQRyf0vdJygBf2fSlqDI4/WFQxBp6UF7ine
         C/NqOiCvoozQcqaEty8PG0jlS7Kx/wIGIPfFktw2M42WMrdvcBkofpRcEgL4N3N+HevI
         omMLPaBiDergoTCqeJZVGP3ft5fsvIeuvX2zDcS0yh8H/ZR3dM+BBoDzhQCgnBekePfk
         YoxdeI2dO502S2I22BgrEz9UujHsE6bnxOmfndPOY3xaoN5PbOBJkaLoofmhraxbTzKr
         Cyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895762; x=1792500562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0y7scvxChVo6RRNrssGjrzZEjKITFhDkhHHby/JvJBk=;
        b=NMaDY3rmmA3iGsbCpYyMF1Bu146g9Z6Wa1sRpqy6xHAqalusPu3q7guHq93nw0n/Wq
         sIatd6EMB3Kl3V6776vwCQJj9nXy58ZzVpB9E/kadTAWVr906j1/t80VC+ukxlrEkOmw
         lZh99F4CLr944s8PC5MIDmRDXCkIbJzWB1XJSGmoIpadM4UG+XCaKzHmG1y2+Lwqinx8
         LDcawx2aRwvUvyj5BFryZP92/UFoBgc4kEmr78c/xikrgzGA6HN/4XHot7XnHAPaZSsN
         29m8hzO0Z9nGQOAkd2wQP73gYm0JUhWaJJWGLmhK2hI0VwH9nL6Ed0irXuOS5xZOhln/
         2Rbg==
X-Gm-Message-State: AFq9FYKDhCjcZK/v81jiBs+vT5kxc4pwTCJXsnGo5IAB2om2uLnsRrTo
	QDRjsox78ofvsqBFt8M7V0q6ZVhrLY8QrWm89g/1Ymgot1eeuzmlHUxrkg2FoE80aaspEe//CWr
	PSJcn+V/LcXPkG+rpbmeec8M3sQHKCQ1DdsCT2NOCVAN1Vw7QUOaBbgwXoDvLhg==
X-Gm-Gg: AYBFou3TwBzHdrkWI5MEQpMWRc87UddFG/IhYgH7mqOTiMd1RABVxrxINoLPbkZzLSx
	vfk5PTawy8jt/BFjXvbwE2D6SYqxIhy1xOF/gDCSGZkbsFKjOnmm4SIKzNp58tU9q8lOf7+DbYW
	Cne6GWhsx0BoPODXyhSa6BGH0eCraNiWn88eJGjTxeQZ+UDFH4+NfHKhjybx7rqn6AG6X42Vuvn
	TE06jDBV30R+q9Eakxz3FtqACmcKb+76akNVqUcPqwzpWz+ZzPRElThL4ocHmUFwquSGUh695Y2
	bLmKUKMNJ3vW6iRCaxCOnPHsKFlFapIt/yHahEkxc/q0FZkcyZ+COOnuRObDdOxCRBOztX1xpab
	azKHRg6hR
X-Received: by 2002:a05:620a:3728:b0:93e:c12c:f119 with SMTP id af79cd13be357-93ec12d0576mr2086594285a.69.1791895762116;
        Tue, 13 Oct 2026 05:49:22 -0700 (PDT)
X-Received: by 2002:a05:620a:3728:b0:93e:c12c:f119 with SMTP id af79cd13be357-93ec12d0576mr2086589085a.69.1791895761476;
        Tue, 13 Oct 2026 05:49:21 -0700 (PDT)
Received: from [127.0.1.1] ([86.121.170.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab6361sm4351081f8f.32.2026.10.13.05.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:49:20 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:48:41 +0300
Subject: [PATCH 3/4] pmdomain: qcom: rpmhpd: Let genpd enforce the boot
 performance floor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-genpd-boot-performance-floor-v1-3-a765dc83e6d7@oss.qualcomm.com>
References: <20261013-genpd-boot-performance-floor-v1-0-a765dc83e6d7@oss.qualcomm.com>
In-Reply-To: <20261013-genpd-boot-performance-floor-v1-0-a765dc83e6d7@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3231;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=XLXwfViUfDWAspkrHSdPqlbAhU/5RfYWoAz0hqUTlSc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqzijIQ10km5MzeRf/uVcsrjfKrKLByYOgQxE3h
 ftVEQUKZnOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCas4oyAAKCRAbX0TJAJUV
 VhSdD/9DWwpOR++ysfc00ex8AYNzdLpWgjdnkJl8wds96VS9RyDHc4W5ViwS3ZvE+siWQKcC+1w
 SlJGkv2QK2GtmXpugCMmqu33lPnjm7TGHOUK0mUn8JO+rYeLAjxite7+cvJ8kvYwbFyjLYXUgab
 FB9WjizNIBfS+wy4+UiEfMZ48vinnp460B7uyS9tjM0w5WmS5VUcs6LLFKe/yQcFW1jIIFVEJDh
 hJbOhw8wXFxIpK40Q0oE/KfY+MqeHv1CkbjQoc76PO52fsT8PC2tfMKE42E8u/gL6/mcNeaQTWD
 pKOoUQO7xCcdogWEHvObWKpjM42BZMO2K/1IUGWNTYK8+t1+VCeb/HUmcakAHTsyU9aOpLsXcOf
 n0Fuav8/jqmByP6dECp5YGLnFGVuYsSefuyr1i+tLD+yYTUPYR5TA4Tw2cFicxw+gsVdsXM0GqN
 az+8rX4HDBQV+yxP1WDmR11mVrfcgi8giGFGZ6Ys6vUis+O6V039gpz25o1+JBjfQX5LpKSWihI
 bopJFT1DhnD5L4oSS8ueAdBWBMTbisV9Gpi4RIJDw6lkPWympWWLtrtg2nrNxRYAsqy4p1tO+R/
 CKK+1Lq4HMlobawtyClQ4t27wWgM65MMxpMyFIGMAuB4MjIGNxqQIS3LMcw+6hHNb+piAeGs4bG
 o9AKCEV2jNIaWEw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX8PiZXxH6MI56
 TTePjMWqZmXzq0QJSTSJMSMPL7CbWYt3wCz0TECrEAJB9AmEoAKII37y2fu20y9QcfcoFbPiruK
 Yjyl6G9WCujtJnsSbZwHas1AzzAsYtmFuVxSqnH21qyB0kPvbgwRjUxGutVGlphsDlF1kX5Fvva
 +eC5xy9d2jHtddyk6hvMIikNLx4oMXldfcSDzCh9LpMNfMpDQtO/xA+jeQ2LYq2NsNf4TWuBisl
 fT4AMBsxfj10YPjxKjAmD9D2uy42vvhheKPQZXy3MYBRiiBlLU3vtL0bd5Nbo8TQZS2Dfu/SEWv
 XNeeSXK5+uDuANLVM3IAv2sA81nt+vl8KaN08PRghVmT5IY7xpI69u54HMfc4Pz5DfwN2QMhkzv
 Ul9mMCps3i51rzBp3cIBaR2unJNDgF1VAgFWTg5HPcf0Yl3LOCNPGjmfaC0BE8uXf/6Ny1vnMoL
 cZHZXlHCOF0enhEDGtA==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6ace28d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=renc-JzB1xFNw8Zc7nsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: jCzw_Y3o2BrBKC4uLrtK7DAzuCsjVqwu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX/RzVTQPZX0xb
 l4iWVZrMzrYe7B/uUVbkqFdhHO8mKXl0nefwM0nBEu3+/Pi8ih/Lut8ibgeg0OdiUFVRrmqSjs9
 vTCZNDPko/OjpBXmMRrR1a+dR1Qd98E=
X-Proofpoint-GUID: jCzw_Y3o2BrBKC4uLrtK7DAzuCsjVqwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130050

RPMh power domains are registered as powered off without knowing their
initial hardware state. Until the provider's sync_state() callback runs,
rpmhpd_aggregate_corner() replaces requests with the highest supported
corner, leaving genpd unaware of this boot performance constraint.

Set GENPD_FLAG_POWER_UNKNOWN and provide the highest mapped performance
level as boot_performance_state. Reject an empty mapping before indexing
its last entry. Let genpd enforce the floor and retain consumer-enabled
domains while boot protection is active, instead of clamping corners
inside the provider.

Retain state_synced for the hardware-specific sleep-vote policy. Include
the supplied corner in sleep votes for active-only domains until the
provider's sync_state() callback releases that protection. This also
applies when translating an enabled peer's vote. Keep the existing sync
callback to reconcile votes for domains left software-OFF by genpd.

Assisted-by: LLM
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index fa8fed5bd3e5..1488f31bcdda 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -40,7 +40,7 @@
  * @res_name:		Resource name used for cmd-db lookup
  * @addr:		Resource address as looped up using resource name from
  *			cmd-db
- * @state_synced:	Indicator that sync_state has been invoked for the rpmhpd resource
+ * @state_synced:	Whether boot protection of sleep votes has been released
  */
 struct rpmhpd {
 	struct device	*dev;
@@ -982,7 +982,7 @@ static void to_active_sleep(struct rpmhpd *pd, unsigned int corner,
 {
 	*active = corner;
 
-	if (pd->active_only)
+	if (pd->active_only && pd->state_synced)
 		*sleep = 0;
 	else
 		*sleep = *active;
@@ -1006,13 +1006,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
 	unsigned int peer_enabled_corner;
 
-	if (pd->state_synced) {
-		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
-	} else {
-		/* Clamp to highest corner if sync_state hasn't happened */
-		this_active_corner = pd->level_count - 1;
-		this_sleep_corner = pd->level_count - 1;
-	}
+	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
 
 	if (peer && peer->enabled) {
 		peer_enabled_corner = max(peer->corner, peer->enable_corner);
@@ -1210,10 +1204,15 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		ret = rpmhpd_update_level_mapping(rpmhpds[i]);
 		if (ret)
 			return ret;
+		if (!rpmhpds[i]->level_count)
+			return -EINVAL;
 
 		rpmhpds[i]->pd.power_off = rpmhpd_power_off;
 		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
 		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
+		rpmhpds[i]->pd.flags |= GENPD_FLAG_POWER_UNKNOWN;
+		rpmhpds[i]->pd.boot_performance_state =
+			rpmhpds[i]->level[rpmhpds[i]->level_count - 1];
 		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmhpds[i]->pd;

-- 
2.54.0


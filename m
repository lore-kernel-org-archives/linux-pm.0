Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081657;
	b=GbzT9YNVXuNchFrbJrkZ3V7hyOPy3vvgzZg4An5w5ZO+RrQ0G8OcW/4EIMKWyyNW4cs7
	 bRi5rTZuL5AX5jCEPXiFEX8mZv8cNESA1KbGGRgVVsiNnpuoigKALv1ZYMKBrTnJWAk6m
	 Mj/Y5MquR237xhvGMigvMlU6PcqcyfyPFkZQhIsydviFsiwi6d8epccn+PbZGQliMYAU0
	 8qH46MWolk7Z9iTRGuMYqh9rei8bjp3aHbbGe88KolvSlmEO1yeKeazWdPBMu9Qmkpt3j
	 DdhWtZmP6yWHnR0h3NzqcGYyr1AioRQ57RnIAB5pq6HiVx3PHzL5bQ9BZUOYNvllprQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081657;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uSCd7dBC5jEtFPlOY+CVFRj6hYzNdBZ42EnWAER4Ji8=;
	b=yfM0HK9VhuA36A6wJ8e1NRvgk3THIj/YxwfOj+9u3zHVrRfdxAV0+LRsffjJbqYZl/rS
	 wSKGvrfDwQ9LpEwFPgDyaJOxtrGNkKkGHLSpQPSd8sgu6tgLMZ6nkzSo+lAje26EWeSfu
	 A5RsLGfrE88V9mMGPV0dOFub8hFv6K30O1CFlADJ9jm6Ztfix/iZMH6ukuIhg97n3gB3A
	 6AxV1PcV0JsrUqkxFpVGx8scl6YxprYRaaduQ4YLatqWvNvqPpr0LKtdJRvpgN36pSwXn
	 FKigaEsM6mmJiguAGZqyxv/zyOIzF2juMXKN/Wv1nSYFGjENhnDahzB8194Ka+6HKbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nqLuxsi8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MlECI4dy;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A2606A32A
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D1A2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nqLuxsi8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MlECI4dy
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6vFtV1681179
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uSCd7dBC5jE
	tFPlOY+CVFRj6hYzNdBZ42EnWAER4Ji8=; b=nqLuxsi8n0DqRruq7YhpA2Q3EGh
	2VY8TiXhckNhOhy/SX5wvoTGUyk6IzWa413OF9TyJHuMTO+AtSBax4a41Uyz57vl
	J/6HV2biiVWmvg3Cs4D1NvY9uJihuEEyS0UG46sU9LimfHgQ8LrKAUMXLHVxMOSt
	SuBAiWzHBXk8LmIx3sNZhG6lOskz0BxnWTbEEcjs9LZSaHIzrlKKelG/40xerJe5
	QZVzF7/Yvw0wyaT7EnveeSUIAlU6N1v8Y6FRPRN/Wo8OqcuzCQdWBPf43lagyCzK
	NLyxAuhWdnPJzxFyfUPxluUw2olylqqBBbOo2InonE7LRSkf4U6GXc6fWDw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdct5j5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-944138ed63fso245800685a.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081655; x=1795686455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uSCd7dBC5jEtFPlOY+CVFRj6hYzNdBZ42EnWAER4Ji8=;
        b=MlECI4dy5kaUWImku2CZ2CE4d4iRVtjsp0fMqiCCijoyYuK7st1mLWUOaSjOZewCzS
         T1FyDdnOtdQRLNHrNSie26HhFy76aHO/QF/tJjWGBPVVsHPAUszIgg0N4LKuJjzkaC/A
         +MNYiYYWC5cF7pOyX9jYtu4ToF/UsHVLZjYYzgsbf+ft6C6QHGAPAtS+DO9Dp6ZtqmNP
         ZkSu4SVdRkIlKTCmbqwiJhb5ir1PwNa3lfBgEMWFdee9FzLd9E5ryF5lk31AbZYTL6Tx
         tQBbk5MsAtvSVR0NLKQe1Sb5ZGLmd7F7ExbEDPq143Q3L3OWAClfKO7eMfm+yL0RGY6Y
         wHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081655; x=1795686455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uSCd7dBC5jEtFPlOY+CVFRj6hYzNdBZ42EnWAER4Ji8=;
        b=He4rlQ1LjvrZWqnIokJCGgQp1fM8FNRRv0rbxxGuTnFfOJe+lhJHxfHynaJ9qT3RJP
         dXDh8rM4L+R0cJo7EfB0LrQOi2h5qRsybKJeLFmoBYdmLBGXxPHUzHyJzO6G4fSomVLC
         4LbpYpQfpLPbp4rv99ELTgZireAAoXMtZtsRehuN40CTQeUkgmb5jFu/pWq6Ct8QXeVf
         wtczICdXZwU9j2NjNzRYs3gvzkqTwNuBRCrxAn88zibE/UhrV9qqFG5SXvkvL1hXuMGW
         52UTT+LIvJGhZpxwxxw3OHLB6I9MAOKceA2ex/tAphIRpesICJhF5o4mAzfSMj7WXNIA
         q+gw==
X-Forwarded-Encrypted: i=1; AL+hErHPRkSNmh34AE/WUoaQt3926ThB0ow8AkwKvtsNoK5NuQIS66f3o+6oDoWEsqWWcbwMUAsTOp4QXA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/TDuykNK8xHFUWH9qQHElnii/xlT5MTRsyPKP/vq+XQWp1bh7S
	R2b2eURDGlqrxRtxHD9o5+mL3HAElcqWBor7e+sCvOcT1JE/90Ej/2rf8O3iM29Tf257Lmuwv7O
	YwtStADmBTbz3UCN8TXE15N9Fm63rvYvgfkQlA6zRZjQ5bBg3zRwJEUfqji01CQ==
X-Gm-Gg: AYBFou2lR6DoWjU2fOMtWo7J8SqXsNh+V5CwV77RrpRPvJWssImNfjGcTsoM7FRHAxL
	cbtfDRdl3LFGvmyFZw4gVZf1v9Z3Xfa6AlZbNFe5n4BtnPQon8C9hqKD2UdOenOqDFu+mRStSrJ
	vs7M+vrs8PPwcBh3OwxGRyDW2rTzrGUcXDhqDgivFIa50tpjtHgD4IaybsPwz/s2mPjddLapP2/
	fQ3LVdgIN0fc3uWgXWaeE8ZY9LT8+h0WqvEUnPWone7jNRIISHZEPpXvFUPwhh9dQm89RZJUFEf
	FuvjxzqNDf61bIOKwvX6WcfSYiG52KPKfe1neN4k0VcH343skUQ2n+YauCSxBXKVWVXsGhpwwLU
	mE6pDYl8I2wleQYvCClXv9H8AFZ3+tfsopQwaTkT9rXW0ma4oRWcw6S7O8MNeTKmYupVyCstnby
	XV
X-Received: by 2002:a05:620a:4802:b0:949:5e8a:313a with SMTP id af79cd13be357-9499965c3d3mr996314485a.13.1795081654569;
        Thu, 19 Nov 2026 01:47:34 -0800 (PST)
X-Received: by 2002:a05:620a:4802:b0:949:5e8a:313a with SMTP id af79cd13be357-9499965c3d3mr996312385a.13.1795081654110;
        Thu, 19 Nov 2026 01:47:34 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:33 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 01/12] thermal: core: Add thermal zone device reference helpers
Date: Thu, 19 Nov 2026 10:46:43 +0100
Message-ID: <20261119094706.3439040-2-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
References: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: p7Tv_sZQ37UgIp5EZ4Z-GToFT9YHZD9q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX5/7zv46gQH1E
 PDQNFB4CgodFq3B9ef2Cbq1BDOe0X5mfUGMrJk8E4NS3izu3mc62vUmG4fdFvVgLSwO83dKObBv
 1DSo2Eg/CA1PfZyPZnQu1hUcaKnXaKg=
X-Proofpoint-GUID: p7Tv_sZQ37UgIp5EZ4Z-GToFT9YHZD9q
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afec5b7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=rLMGhVG854pRqHrHMbsA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX8vMwP6PwqTic
 DlYnS47tr50HE8u5nfr+cIQzDoGYZ3+1me5nV1iniV68rwR4QPTqsw3Pf1jxy73xAD8uG06LgO4
 Fm07jiECOpTEjs7z+X5pa78OE19e7WcfqENpQ55jJMzQlcxD1m0+jXOib0yH3CVax2xZZVW1rTu
 6O9Jiia9H8GYwl3mLm40aUuNQEJ4cRfiSNEcnGZ5+kGn4JTn8H5+UL/yUnNbOYPSCWOfUmx2k8Y
 b2fkP7l1bEL9qorUnUPPdFvT1upL/83tIVPBHPQTpXFvUMLlRDkUDs0Fnv2PYr71D/0+/nM4y8q
 8nwH4IZGi4SPkwplAXOt0gvOdX8iSdGAVXtgeuLcqYkQv4rT3IGseuhVZiJURGvuU1/1KSdd6mL
 fu/x1gxBJmLH7/ZSiiQK5ouOASXZ+V0PGkOoKQg/d2FE44XspbCpvy8tDGmob6o9dOAgQhmrO8N
 S9CeGoB1FdFMzty70bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Add private thermal_zone_device_get() and thermal_zone_device_put()
helpers around the embedded device reference count. Document that callers
must protect the zone pointer when acquiring a reference and that a
reference protects lifetime, not operational availability.

Use the helpers in thermal_zone_get_by_id() and its scoped cleanup class
to keep reference acquisition and release within the thermal core
abstraction. Preserve the existing reference ownership and teardown
behavior.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 35 ++++++++++++++++++++++++++++++----
 drivers/thermal/thermal_core.h |  5 ++++-
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e8d4da0aeac3..02c2c08077bf 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -698,6 +698,35 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
 	return 0;
 }
 
+/**
+ * thermal_zone_device_get() - acquire a thermal zone device reference
+ * @tz: thermal zone device, or NULL
+ *
+ * The caller must protect @tz against concurrent destruction, for example
+ * by holding an existing reference or thermal_list_lock. The reference
+ * protects the zone's lifetime, not its operational availability.
+ *
+ * Return: @tz, or NULL if @tz is NULL.
+ */
+struct thermal_zone_device *
+thermal_zone_device_get(struct thermal_zone_device *tz)
+{
+	if (tz)
+		get_device(&tz->device);
+
+	return tz;
+}
+
+/**
+ * thermal_zone_device_put() - release a thermal zone device reference
+ * @tz: thermal zone device, or NULL
+ */
+void thermal_zone_device_put(struct thermal_zone_device *tz)
+{
+	if (tz)
+		put_device(&tz->device);
+}
+
 struct thermal_zone_device *thermal_zone_get_by_id(int id)
 {
 	struct thermal_zone_device *tz;
@@ -705,10 +734,8 @@ struct thermal_zone_device *thermal_zone_get_by_id(int id)
 	guard(mutex)(&thermal_list_lock);
 
 	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (tz->id == id) {
-			get_device(&tz->device);
-			return tz;
-		}
+		if (tz->id == id)
+			return thermal_zone_device_get(tz);
 	}
 
 	return NULL;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7ef7c6cab437..7b91717d9d74 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -211,10 +211,13 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *thermal_governor);
 
+struct thermal_zone_device *thermal_zone_device_get(struct thermal_zone_device *tz);
+void thermal_zone_device_put(struct thermal_zone_device *tz);
+
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
 DEFINE_CLASS(thermal_zone_get_by_id, struct thermal_zone_device *,
-	     if (_T) put_device(&_T->device), thermal_zone_get_by_id(id), int id)
+	     thermal_zone_device_put(_T), thermal_zone_get_by_id(id), int id)
 
 static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 {

base-commit: 0dd55073c872df387d28480d1197c013423d1705
-- 
2.43.0


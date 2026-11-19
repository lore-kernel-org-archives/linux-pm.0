Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081663;
	b=R1dOk4sBSzQJAqViriafqDnGqBxw9AnKp6w0r334xRX0fEjvnd+B2dLIdhvVwVdG1Dro
	 TKZW1RFXJRHEanmIby9wVqXy4wiDdinVWia6viNFO26ciM0JZjfIDJk2Rz2WjCcaYON48
	 PHcMb+Sc6l5FVRLJKiBo0B9OdZ5EUaHJ+Scgyg11zO2YgdtxxmxMOGe2SYbxb3PV4RfoV
	 myorlUEnHtSFSvZtNo0P185P6eP1hQx8Y4U/vjf0XkcihmOZcAARm25bcY9pghAznH8Wr
	 B8Q7EQPTWUxJ1dFZpsqVvfjzxUgWju1UhPN/87L5hyX1VzwVJb7OwFtIn69RmLPKeLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081663;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8NZEltlec9d7ZhQdO2+fHcLBekWxvb0kuhP3dKfx698=;
	b=2SftEpcDNkBIp4686DhlqMhU8SkZkEoeGNX6+esP51V3mRDfB3iszrPJ9xYplYZKl/8f
	 RGxllzTrlp8OOd4sMVAQ8xyVQ8kpVkpY7PNoNLD9h9p4EDPzCufUjxznDyqrSG7KZRgv0
	 pBF5+G4bRX7GkPRkyu0nu7NaEgA9/FPSsOrAAhaipHWe46us/dKb6VGk0f3qvhFPqRikG
	 W2vxoCuyrg/zyvMLyZ0M855YgyWBFJMWYCHzmhcLcxdUhVHLAtb3nxW4Rnlb+H4C3kUfh
	 03Tc9pa8/dy3miLybYwAXph9+RV0xCrIJu6RRIRJl5FYDAvd6sPQYlgRtR3dFTZjRyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Trkjp49X;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XkAIrEe+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18144606A33A
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18144606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Trkjp49X;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XkAIrEe+
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6vFOr1681193
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8NZEltlec9d
	7ZhQdO2+fHcLBekWxvb0kuhP3dKfx698=; b=Trkjp49XTMHaiAGrK7DlP6Mqrhq
	q0V76QgySrxHPOsyQmJy09HubyYcr1aP+R9G0TiH6P44ty+2tGYoUhdLy5nXYfGs
	8bEowsZQUP3kGPlRu/WBeBebQ2eblR/iIcK31yGoH/yJLxqWSeUX2+nDTYBYJ/VJ
	GT6HKSak/MPXpY80v1kd5KCGu6RwsR8eBho7gib9fx5E3pnqP8nkOqKrTwAmeAQs
	YROD3oh6VY+Q7I/7aVBLZBHC62OU5Io+bco2vaNrKoVuSwjv+78qc/FunbCMK0jZ
	g4R606S9p5MOx1V46AA3fICJc/IEDsrH9XIi13rwGBYiRiM2PfQIZhSgYhw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdct5k2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9496ff065bcso302374785a.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081661; x=1795686461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8NZEltlec9d7ZhQdO2+fHcLBekWxvb0kuhP3dKfx698=;
        b=XkAIrEe++HOas8pWoKgIDBrLAOerfj57AjEUH0H10qz+22n7IwIXWygpHvi+NmCR3F
         HNdD51z3yQaeR4UOEtcVP6B+KBdkgxbidnzoOZuIMsMniMeDmFsc21XQcAb72qPlxlcn
         6B3C7BKBHLjpItKZ/xx7587Wre3OWRlOH8biwPJkLXUQW7oz4ZopKOzg4gDTMMk3GV9G
         27o/+2Gp1NUzCG+tLESGvUaeNb28GN5okSehB3yiwWdocA4WR/TocZC74RG32COkiuko
         aHZs7dcqb0ClTh69/RuTF+kufbptWq3Bd2nWRTN/GZH/qTPDrpGcQ5hkhNaD7CAfPdby
         fiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081661; x=1795686461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8NZEltlec9d7ZhQdO2+fHcLBekWxvb0kuhP3dKfx698=;
        b=bbXtdKppOsRUyrQcJ5Fmk3Svx05VOsCzB9dej+h5POSNGoHcuwcGSTq0zOLrg4I2Jh
         bjV1iREphQlIN8FWqxVB1eHCb7a4K35xDx9e4eeLsu0StbuNU+IQ+gMJKWOgx0Olw60M
         6UysCVtNsVPFpJm2V2AqArhJWtC/x2yo9rqS1tHIJiLW0QzbFY/YHiDo9Cu4nUmZRQl1
         X1+rj5/m/HjV7Ph0WHUL5IUH4Ho56ftDoNgLHOG7v3QmyQmkIexrFoLk/+FFp+zYA265
         VziWcUTiTkaPMfAix5FkwEdvuc+ilQ1qDOm49aAx7z6jXkmWGkVvADiV2k/jbykYRrJB
         8/tA==
X-Forwarded-Encrypted: i=1; AL+hErFOkcairPy0uWuVAOSA45BsMK+c0E4ikUTLeXWBFvmjE2+64/CF3kbbUr9/Ih9DeRE9ZQjRXY7s2w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+R76LLwvczXd530YQ9EIusFc7DHrrCqkmq+H5NN6ezHP4/SlA
	u0d2pA2wQlBgtEoITXfBoz6k296G34PeukcWirxMnMPzCTLi5NlMHL9Gj0r3RPI6+5fk91lDhkX
	xCsvUWa56fSYAXDEaFyYisU1ELL37RjUQ6n/fQCOsEP+8mMyDHRPd8ihGD9+8CQ==
X-Gm-Gg: AYBFou0R4Szcf9CVbKzj35w8MlilU37iEcvRsLl4kiNHof+6XCvys4KrndKiVVWq5QC
	D9hEYUKKu/1WTeh9ABBsj68rCfxVCeIDYC/DFh/QPSkDxu9b+GGSnkm+PcRP0O1UK+BDgoP8ZDV
	rj1m9Rq9AYeqYFsTPBuf+6XOGLJaU4eOZBv9Hs7qu9PWt4s8VZtIXDd9uDMWMuxUCgYiwranQWx
	VN/tV7tGq0LesQzTUpTDYuffCd1b/PrEByDLFPW5sxvS6m4woofiqOofBK1lWo17lL3ty4QYJqC
	v37+jivxfIahlLVvHGL/MLvFwvPYEJgWffU1ib1bMyBTbSu2Qa4pwYCr3G7AaPnN6Js6KRlP+Ah
	vwCHfAMSrUNlEGgXTUYbqFoYJPuVukuF6/U7GbbEy5AK5wafo7kbRItw7W9sEecf+43ClOg4zhU
	NK
X-Received: by 2002:a05:620a:370f:b0:93e:623d:99ec with SMTP id af79cd13be357-9499957ea7fmr1103452685a.13.1795081660850;
        Thu, 19 Nov 2026 01:47:40 -0800 (PST)
X-Received: by 2002:a05:620a:370f:b0:93e:623d:99ec with SMTP id af79cd13be357-9499957ea7fmr1103450185a.13.1795081660419;
        Thu, 19 Nov 2026 01:47:40 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:39 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 05/12] thermal: core: Dispatch aggregate temperature reads
Date: Thu, 19 Nov 2026 10:46:47 +0100
Message-ID: <20261119094706.3439040-6-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: fuH3wLElqmQ6UPsDORtzAWvNyFDm2wcd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX4BP5iTXypxKy
 UlZm0+Y5d6YHXuWJgdyDXIAcZ/h1pMobgbNJJCgcwRskXwEXGaA6teO21/XIpQCpuVUPIU2zvf2
 dwsOXAPLGsXbc23RON7FfwqvSLyFOds=
X-Proofpoint-GUID: fuH3wLElqmQ6UPsDORtzAWvNyFDm2wcd
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afec5bd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=L_484BTU7vCjdW36McwA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX6xSFEUtkdOcB
 liQBGlW7HmMyo1OddVTNn9+ExqJyYQ0a5wjTghk/KKbkw3mxF50wORVL4YD3wUFz2yRfnsd6Mdh
 +BIOCamvTGZeJwssdhrexk+PS9v6FGSb7uyJH1wC5LwQHHM+asc++MFOUoOZOWl4SiQXU3J0KL/
 P1PvB+Ptd8V7YdS4GQ2elhyzMA5Fw0vuQ+ia5rUBoq09QcsvDWXlytMHWI2CBjM70IfqD12qE68
 uH6tm4RDUEuM0SEEowmeGkU40DLQd6ka0KfhYlrFp2zV/u0/WbUGOn2gn6b20NYcXgiuJykR5rn
 alsbERSWFdfWLPqtEstGqqc3jVXgVpOvwjzD9xR+bTKf8aFxAJ9KIlCFp7SDKaWjorvh1oiKamf
 8b8qR8cgNqnE+C9NNhG+V5waJtyKNI/t0i3XQG0DRxm65mSkn08wmQhxKXKsYO7Z0QQ4Bw0HE8N
 7VBlQv6t7uhn94u4Tig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Select a private aggregate temperature helper in __thermal_zone_get_temp()
when the zone parameters contain an aggregation description. Retain the
existing driver callback for non-aggregated zones and the common emulation
and error handling for both paths.

Add the aggregate temperature helper in thermal_aggregation.c and declare
it in the private thermal core header. Keep temperature dispatch in
thermal_helpers.c.

Leave the aggregate helper as a placeholder returning -EOPNOTSUPP until
the calculation is implemented, avoiding a successful return with an
uninitialized temperature.

Provide a private stub returning -EOPNOTSUPP when thermal aggregation
is disabled, preserving the ordinary thermal zone path.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_aggregation.c | 5 +++++
 drivers/thermal/thermal_core.h        | 8 ++++++++
 drivers/thermal/thermal_helpers.c     | 7 +++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_aggregation.c b/drivers/thermal/thermal_aggregation.c
index 8b503fab25bc..fa6cfb8669b3 100644
--- a/drivers/thermal/thermal_aggregation.c
+++ b/drivers/thermal/thermal_aggregation.c
@@ -154,3 +154,8 @@ thermal_zone_aggregate_validate(struct thermal_zone_aggregate *aggregate,
 
 	return 0;
 }
+
+int thermal_zone_get_temp_aggregate(struct thermal_zone_device *tz, int *temp)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 365704584966..34903cfeec33 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -313,6 +313,14 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
+#ifdef CONFIG_THERMAL_AGGREGATION
+int thermal_zone_get_temp_aggregate(struct thermal_zone_device *tz, int *temp);
+#else
+static inline int thermal_zone_get_temp_aggregate(struct thermal_zone_device *tz, int *temp)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int hyst);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index b1152ad7acc9..cf84d4c1ef65 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -74,7 +74,7 @@ EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
  * temperature and fill @temp.
  *
  * Both tz and tz->ops must be valid pointers when calling this function,
- * and the tz->ops.get_temp callback must be provided.
+ * and the tz->ops.get_temp callback must be provided for non-aggregated zones.
  * The function must be called under tz->lock.
  *
  * Return: On success returns 0, an error code otherwise
@@ -87,7 +87,10 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	lockdep_assert_held(&tz->lock);
 
-	ret = tz->ops.get_temp(tz, temp);
+	if (tz->tzp && tz->tzp->aggregate)
+		ret = thermal_zone_get_temp_aggregate(tz, temp);
+	else
+		ret = tz->ops.get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
 		for_each_trip_desc(tz, td) {
-- 
2.43.0


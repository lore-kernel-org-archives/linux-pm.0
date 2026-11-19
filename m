Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081664;
	b=LyOyRB88cNcVGm/N61Qg2K/gOFUljYD5PkYKtQAoOqJdFRGrRzny1JmibhvrK7f9+vcm
	 16DEzB/8M3EYKUb2a7rfdJzSYfNYgzkCnDNxVmBzostO8zqlMgeFdxUsMLEdZx/E5VPST
	 QRQJ+QRV0Zzh/a3FA27Utrkw8uD8u7Ns3hMXWwbER6cwPjeD2ry4UNU8BjGjCe6O/zVir
	 N6wAHLcXMcCsLT1UoUZd1vNIsgOV3Mijps2v2YhrlJvyWu/RF/RaU5CHZRBuRFt1dD9A8
	 CUSqkSKFIaAJ4oZSBTX+NyInkwJUvttragvERV5Sr4Xogf4YdbhZQlRdepZw/4hDtQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081664;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cT2liv4kTmglSbixSH4Uoj37vZy3d2fO7AfDgWz/bo4=;
	b=DaYgw51+fUCHHUhy4ZQDlBHYUSdS9G/KdopfYoAfEuvz0tmhHoZDU179TXTnzkCdEYQU
	 ws/V6ElN/3gJDruI+WKLYzr5gILrinDQHiyQCx/o+ArDd8JHflsbwNuZgXhbHnB9Brtr/
	 jUaS2jLudchnmuLnR65z8yISyaoAlgL4vPKM+nYfNsk3TEcCZ4RGksHOLl1itO8NBSEkM
	 IyHthCahbxojAzSl/YgC3so/o3GVQ2APTj/jCXdpXJKe0wo11u68zX4OYUKYxtnpxSCwz
	 xYOgCVN9GHCQU1GKIHLrMChEds+aCOvlWkF3HpSKWQSqbdNhtz1RQnVkbby7llcxrnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dm8rttFZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKzFxJlC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89A60A2604
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B89A60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dm8rttFZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKzFxJlC
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6vRh02671943
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cT2liv4kTmg
	lSbixSH4Uoj37vZy3d2fO7AfDgWz/bo4=; b=dm8rttFZGwPkGYTlAQnG8SHGbkf
	BtvrkOihZnRY2T20CIswHL5hc59y+aNpzLrb9r2n4Ts3x8DjdKzSzmSD5KXf/f+w
	l+d/OxUA0ALhYp192I+6CWiFvRI5zZzGSQ9aQJwSsXP1HPZaylx9Aw5E02u45Oos
	NGCOKjR0pFHTF8+qYEzh4yIW3KQmotdyuK0SPSp3Jah0a5Ow0qXQeli4Huoe7vXp
	5J3qIe6BrNtEoVBa2KJ4aUslkfN9grGxCXDL/dxd2qxezcFStC5ePMznEv3I3WDq
	UmTO8VuORDTk9z+P8quov60ZKgjPFuNjhTgzqn7Bta6aQmZ7k0qTwCBkqcA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9p3v4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9495a1f5e47so344816085a.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081662; x=1795686462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cT2liv4kTmglSbixSH4Uoj37vZy3d2fO7AfDgWz/bo4=;
        b=FKzFxJlCVHpf2MiXCqMr4dNeY08Zsstd8Sj6auVL0Q8Q0e8r5qgLtMZWaqHssAe+1d
         +M4/KiK01Ko9iFPMA4ZxkC1/65nwOxxfoT6meOSWclIjzRzUzJ7NNdJ9lFyXMN7gm76Z
         FziF/lQ16RSfHiu1nuzS/lAI3mm6K56WvP6QEBGg6PAXXX9M9f7zJjAEYZNvXD6vJZau
         pc+cJ+7bDYu1LUJMSGgQdA2+Np4Ck3BSjKNXHqarsS0TzfdTMepssBlTQ3QeeBqeA+QJ
         LaucUNJs0FiGlA4APe6xeRFQqf035ALtb1XiZn08r4IQKcDnKqhhrGF59cH+7r/Jbzxx
         XF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081662; x=1795686462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cT2liv4kTmglSbixSH4Uoj37vZy3d2fO7AfDgWz/bo4=;
        b=axqiwuHcwzcBusK8tYaIg411hFQBisU32Ebge8v0y8YCe04sUU3s2dennqOfl9vcwk
         LYjSglU9jhP17Z0Dx279bizrifo4osKvhdG6P7myJf7v8ujGl/GAbIWYgs/AXuQ490Bv
         3EwKTTxfLFXxeHrgLBayikljd5/20U6yUsFhoYb4mr7UhaFKZNyQYTWYpO+K/8WWjHYV
         V4yHfEpWzw3TbU61q52Q2Eww5+ttwvQjOHnNdrFVW/C4wqYEsd/LCdbgVU+3l8Bou2mI
         C7JNLyEUIa8ZFxDtLlj1tfJktv7UpyfLVAIdC3Ms8IUBYTXYhAMQl60X5/G/nUIt1unB
         9LyA==
X-Forwarded-Encrypted: i=1; AL+hErHbSNvn/+8vXipCERCi4/i9FE9fQyyhiDn0kwLcSYVRK360cQkyl8ss3OdzK306yObQCVErKtlyDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/E8h2wwrV2dLB9R+WXUNat3Rm6cjxdXGkSdbIdaSZNsKjV898Q
	HKAkHYDCSXjyWYCezXaf1BDHrBSeWECiPcBpTU6/gfvZWggI3HHPU0aI3lwzUrf5LRjthjyTcRZ
	aFeG2pRNksO/pqLhzmLrCACU9onK/ig8FmdCUAf1CYtP0W/ICCv0PBC6OazZQZg==
X-Gm-Gg: AYBFou1OMlyjPoNgo87JFc9sQzcOlD5qlwLNCgP+UeXn8JzuorHsEojKU4Gc0cVY8Xq
	K5SRMqmZMOamSVYf7OzFcIiDhJFGC6no4JOl1jIgxvv4QnpC3Z8bnFNCnZdhDT/acn7QsdM/dLY
	/4QsVCQqIGbEwfqJbQU6bXZ46XZIfC4c4vjTvlmahFZuBKhktmDyTcpX7YGvtJrgapmtVk6m34J
	ayIHryl9N2yemjH1+E82nXCPSkFQvfYcMMtP1AMeamcLpvU0qeOGyXgOXuy0sj+/pE5QXHgU205
	3QpMYUlt+YCIEvv3M8CPeduPofJC8WbZA89tecggv867CxJOO/+E8Y3cgdi8zCjquVAOrq8DGFN
	ljupF/CiYDEPohsELJf1p/rF+kYPpq2I+4hlJ8JakuqI+ASbX/Vb2w4RLw91jNoatHfLZr8ZHXs
	bT
X-Received: by 2002:a05:620a:801a:b0:93c:5f3c:f485 with SMTP id af79cd13be357-949995dbe4cmr1014350285a.53.1795081662334;
        Thu, 19 Nov 2026 01:47:42 -0800 (PST)
X-Received: by 2002:a05:620a:801a:b0:93c:5f3c:f485 with SMTP id af79cd13be357-949995dbe4cmr1014347685a.53.1795081661741;
        Thu, 19 Nov 2026 01:47:41 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:41 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 06/12] thermal: core: Calculate aggregated thermal zone temperatures
Date: Thu, 19 Nov 2026 10:46:48 +0100
Message-ID: <20261119094706.3439040-7-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: dIoho6LdVQjJt2iLlAafepSbeklAjjHP
X-Authority-Analysis: v=2.4 cv=LooHWXdc c=1 sm=1 tr=0 ts=6afec5bf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=NYCfaO3OmnaZ00BUEjkA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX5AJesfGyQaoi
 zdIvYPSRotPZO/2omII5oqkVhhEYAQUJMmVY2UKmeVHY01GMcHPvT9JzeEhl4xa693S4IThqlfQ
 Oyb6++jIHFcX7PnFGOwG0+U3Hb6SbZhEIoZMfNgU3GiZF6gBABZ9W1DOPrHqu+hzL7M4P2f0jhS
 si40thbqSLtQTPMlb8FXm997ZuXo+lvx8sLqMgvedQC5bxe/0n8xoHa/mDqghp+8M9qy2yQ8VvY
 3xcINcHHHVv8DyKZbQUyozDHe/Bgo3pXdKy14q/zDBqCY3PJ82luaaY3F9nL0eYtWDZUA9AGQzq
 4JmAGM34YU3V/tVUYyHEN6S7bGfm5tFKtAJbD7Nxn6RhKqRcu5aZuoQtNI6LhZPx5Lb3WaiieNt
 elkoiztD5SZ5mUDHdbEMl5duQe27w58DSO40WYYfzMwOLGQ2OhzwCaFlNdrO+KsztWn3JdYm+Am
 gwhqjtpyFkfdLRdrNNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX9Dtb0hmNMVmX
 ltlVlN16AZG20tiBdXGdSpW/Ywy7f+tsp1vGP7S6Lg15GdseLvHpdDPVrRZ1HcHYUMJYepHXpGC
 Z+oV6rm/dNUQg0YRdi78BOSByh6HaXU=
X-Proofpoint-GUID: dIoho6LdVQjJt2iLlAafepSbeklAjjHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Replace the aggregate temperature placeholder with a signed fixed-point
affine calculation. Accumulate source temperatures multiplied by their
coefficients using checked 64-bit arithmetic, divide once by the scale
of 1000, and add the existing offset from thermal_zone_params. Reject
arithmetic overflow and results outside the int range without modifying
the output on failure.

Read each source under its zone lock and preserve temperature emulation
and error handling. Use nonblocking lock acquisition to return -EAGAIN
rather than wait for another zone lock while holding the aggregate lock.
Reject exiting sources and invalid temperature readings.

Keep initialization-time checks in the aggregation validator. Require
validated, initialized entries and stable source references
throughout each read. Aggregations of aggregated zones are not supported
yet; source lifetime and detachment synchronization will be integrated
in subsequent changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_aggregation.c | 67 ++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_aggregation.c b/drivers/thermal/thermal_aggregation.c
index fa6cfb8669b3..05668e53fed8 100644
--- a/drivers/thermal/thermal_aggregation.c
+++ b/drivers/thermal/thermal_aggregation.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/errno.h>
+#include <linux/math64.h>
+#include <linux/overflow.h>
 #include <linux/units.h>
 
 #include "thermal_core.h"
@@ -155,7 +157,70 @@ thermal_zone_aggregate_validate(struct thermal_zone_aggregate *aggregate,
 	return 0;
 }
 
+/**
+ * thermal_zone_get_temp_aggregate() - read an aggregated zone temperature
+ * @tz: aggregate zone with a previously validated aggregation description
+ * @temp: output temperature in millicelsius, unchanged on failure
+ *
+ * The caller must hold @tz->lock and keep the aggregation description and each
+ * source zone alive and stable throughout the call. Source references must be
+ * acquired under appropriate lifetime protection before publishing the entries;
+ * the aggregate lock alone does not protect source lifetime or detachment.
+ * The description must have passed thermal_zone_aggregate_validate() before
+ * publication. Aggregations of aggregated zones are not supported yet, and
+ * sources must remain non-aggregated. The destination cannot be a source.
+ *
+ * Source readings are acquired sequentially, not as a simultaneous snapshot.
+ * Each source callback runs under its zone lock, including the usual emulation
+ * handling. Source callbacks must not re-enter a held thermal zone lock.
+ *
+ * Return: 0 on success, a source read error, -EAGAIN for a busy source, -ENODEV
+ * for an exiting source, -ENODATA for an invalid source temperature, or -ERANGE
+ * for arithmetic overflow or a result outside the int range.
+ */
 int thermal_zone_get_temp_aggregate(struct thermal_zone_device *tz, int *temp)
 {
-	return -EOPNOTSUPP;
+	struct thermal_zone_aggregate *aggregate = tz->tzp->aggregate;
+	s64 sum = 0, product;
+	unsigned int i;
+	int source_temp, ret;
+
+	lockdep_assert_held(&tz->lock);
+
+	for (i = 0; i < aggregate->num_entries; i++) {
+		const struct thermal_zone_aggregate_entry *entry = &aggregate->entries[i];
+		struct thermal_zone_device *source = entry->tz;
+
+		/*
+		 * The aggregate lock is already held. Do not wait for another
+		 * zone lock: return -EAGAIN so the normal update path can retry.
+		 */
+		if (!mutex_trylock(&source->lock))
+			return -EAGAIN;
+
+		if (source->state & TZ_STATE_FLAG_EXIT)
+			ret = -ENODEV;
+		else
+			ret = __thermal_zone_get_temp(source, &source_temp);
+
+		mutex_unlock(&source->lock);
+		if (ret)
+			return ret;
+		if (source_temp <= THERMAL_TEMP_INVALID)
+			return -ENODATA;
+
+		/* Cast before multiplying and retain fractional terms until summation. */
+		if (check_mul_overflow((s64)entry->coefficient, (s64)source_temp, &product) ||
+		    check_add_overflow(sum, product, &sum))
+			return -ERANGE;
+	}
+
+	/* Divide once, truncating toward zero, then apply the unscaled offset. */
+	sum = div_s64(sum, PERMILLE);
+	if (check_add_overflow(sum, (s64)tz->tzp->offset, &sum) ||
+	    sum < INT_MIN || sum > INT_MAX)
+		return -ERANGE;
+
+	*temp = sum;
+	return 0;
 }
-- 
2.43.0


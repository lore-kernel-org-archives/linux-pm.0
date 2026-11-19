Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081661;
	b=z6P8EALSlhVPGsZc1huEVzFppjBhaokyq0XOQNXfbUe+3oH7ZHLEsNEPN9Z7RxiC0jwK
	 TX0YROfY3GxccU0wdE1RUZgGbSms3oVoilptn4MGJYQKazEOY690kPj+nGsnOo2EVrqyz
	 pDqeBTMgn2J2dODMBIKLR8t4QpOMGwATbvBF7qclcg+/DWt56nBIkPOLpdvASUlPZ3yJC
	 lXqXz76dP5LHbgUCKj9NPI/9yDP9NsQiN1fJZ6VoPeAkmYztgUmLyih+bdPqmir76RyWR
	 bclHhq3nlxHGb5hYNwXfx2iblNCnS+xClfws06Wx5Aty+tlwehyts8AZTDh2PSbn9cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081661;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fnzwcG7xJkc/sAp2/tfrEnXsUc2BNjd9dZ0Wp7EUvIE=;
	b=d9fubX3SRTkZwWVGt7OJ+bcW3kVjnmJ99Z9vkkONM6gPXi76m+cgfwWySWGrffT4yyYU
	 pywS3z9TF4jOqC7KcNlGv2NYACGeSmGLVgjD4SPsJxeTM54Hz5/C8Rz3lUMzLRZjuewUG
	 5fsxHQtQGFuUd3SWyQ5R5g5HZprlbOPZRl3b+8RWYUQQoKZxgRqh/q3De6T0wO+17dod8
	 eAxTTAiwxlUaL/98pkOgksL4/kpZbSxdsztj8T4+UtL5dFf8MtcuV4oanymkaW830lMSg
	 unQGQI+G8ryKo79U3wqBg8lMSu/psCqflFBkRnvx043tHSEOGrzXUffCBa8OSmeMtxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="fGJgZ/n3";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YWzrH+bL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91360A260F
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E91360A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fGJgZ/n3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YWzrH+bL
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6v5Xn1962388
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fnzwcG7xJkc
	/sAp2/tfrEnXsUc2BNjd9dZ0Wp7EUvIE=; b=fGJgZ/n3VkXQV3sT2qZHx4h7jpN
	hs9YRdijIUjcUP1Qr0NhBDgZLOb0jG881HblMvh7ILdTEjTnbHtbbnNH5VxeCox8
	bp5b6pWHsri2DBoqYEvkB/JwqWO4P0PqtNFpkJMgGoK+sloKNiaSbSVXzyI8ydOW
	vQ+ba/+9bq0PoRif3xpS/4QHGQHJbYai/7tVU6nRnt1vpuQqerQ/WRz+pbhkyq7y
	TBukzKtTLSHAoI928G4W0A/Xg85JlvYwKL3/NxH+YZ+FuHCLCsaJ7pWUJmHq8bI/
	o8HYIoUrusZzigbDHy0x1w/TiePw/spl87HY+HGzkGV7q42NmdpT/hquQOQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1gxcundp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93909014c85so435217385a.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081660; x=1795686460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnzwcG7xJkc/sAp2/tfrEnXsUc2BNjd9dZ0Wp7EUvIE=;
        b=YWzrH+bLctG5Bhmbk2mz8dX1Mm4k4QC8zZuUfCBG/T4zusDua8fYX48P5WSpTurufS
         r+M95sSgyiXt/64gGVDNy+6/rVlvZA24UEK2QwYtNlEQufAKnafJjoVVqiFnW6Q2/Uzy
         XE74bSVENbtSHEQlEW6xpEXG/+g2YOAMpseXBZ3C7WtxU59cIRRCOdsNARZ/2FXfbXQ5
         tc0aUvblqclU46PUZw0/5NkV3ifU6b8o9L2W+oWQp+s4znG2HvbddoQuPzbSP0LUVO5a
         nvFew6CcA7PQ07kSqyVLM5IEbUGar7O2qakYUsTZAE/enKmjNJ10cfJyQnD8zQsVxcAm
         /AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081660; x=1795686460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnzwcG7xJkc/sAp2/tfrEnXsUc2BNjd9dZ0Wp7EUvIE=;
        b=2vU0rr6b4AwTDLYtm6Ht4em1MrSQbF7qOnG2Uf+SS6FEOqRwZb1wQqwNUl7B5S+g0O
         +IXoT05l/y8u9w+A0kcq/fl15H9na9dzOHsN0nF1PcQYgeCh9EXSD65FwGvkgvRnuqas
         sWALkhP3xQvPSqv7KKsXbuvUrMT6WNj9aBLUcxyMJ2SJsBzJZDEE1K1PGrjK/QziRW07
         GyNUc9st/1mVk3Xi5A80G3FqIkLYEkUn0VtLg0Nfr/KpArhi/QbQ6cjDBINfZiUmPR5n
         Vmn6Fx4SsyXlWQMLGz3gesvR+2owcMuET5qBnU2A8YvV60UiAcKXLxH8XvcrJYKGP/dt
         TOkg==
X-Forwarded-Encrypted: i=1; AL+hErGsp+EwegKausdLLAUGD8rr3MoZR6ChrpNLFpsuUfmY80dnbwkiYkyDtEjsvsqYirjRJZl0V1nxBA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+714enGVO5HHCCTXn46pBIs7leO0CPBFu2FGenHoqDDzP8FkOL
	wrtROVf1aakvoc8oLgQClTsEqdCwv5aPN9F1AOLGYjtXmpAAT6jJzdpwm8Xa+NDmlhrnXckixTe
	uVagITZMTD2HiaPbJUbuI3mlJyfU90+3v+bK9SJ4cfff4G90troMnFCjZiAcRqQ==
X-Gm-Gg: AYBFou11pEiubvL/vgr97ak14iMjAXS/J/pZK3qOv5Rd1HL20WQEKR0D1ojPIi21WJc
	0T770LX+u8vIxIURaATxkPmmI7TuFH9dsWWZvwHQnAa3SQPR3hgrx2WWGvQyi5G7tek4f2mjfjI
	y2+14HmMjqtzXaOfaATazmDY77U2SIBdKMKlrwq22OjCN9OEpTjEejQhvH2MKoWvuhJJ+YOCdhF
	6Uwl01/rpec1KUr4ISNBJz4/3eunhndL+oPBoy2idVX/DFazIW26q5ggRgWwP8flGSpQZZB3tBs
	OZ5UfCoZ3nnVHMuctIox6GBWjMxJWpfxyJYO80ptNN113YQ8yTTo9Z3ktRqjN2dOW+FW3uPrQmj
	zjum+yv2XeW5D02k5K0+Nhr+/iZrXkdRZNOdO224XqvhxCgOAWPEjbqdiceB22NeFIt60FhGvFe
	RK
X-Received: by 2002:a05:620a:1d0b:b0:949:6e15:e1d7 with SMTP id af79cd13be357-9499957e788mr874228685a.25.1795081659695;
        Thu, 19 Nov 2026 01:47:39 -0800 (PST)
X-Received: by 2002:a05:620a:1d0b:b0:949:6e15:e1d7 with SMTP id af79cd13be357-9499957e788mr874226885a.25.1795081658996;
        Thu, 19 Nov 2026 01:47:38 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:38 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 04/12] thermal: core: Initialize thermal zone aggregation coefficients
Date: Thu, 19 Nov 2026 10:46:46 +0100
Message-ID: <20261119094706.3439040-5-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=LZapeTfi c=1 sm=1 tr=0 ts=6afec5bc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=xDQTT8aqjRtnOBEH3IgA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: M1Vdwg916NlQG-IbvLGH9DUGmz8erMOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX5jBtyLiPaMpH
 jgi2dDguPDRK3Kp+Agu56SxGd5/QBk61g7l6oO3wk6SkKajcjZx2asoQj0LAV5mQN9GLELutsMt
 GUlnH7Y4OmUyu6E5KiriXRgDLSuhpdMrU9fvRkhRZAKdRaFXHsbC48tR/YVU7vz3gUvdT9839gY
 bhezzqqeTBwFkBgsmB2z2b6eTsKApjxkr3jobWxKf4FyYS7h6lGUsfr4ZcQMuMGf8MVt+px53W/
 RvuMJn1hqj9ZTVzS9z2cZeDNo1UtPqRrkkQFNTQK1rrY0RPpavnm6I72QX4CNIveq4H3GCBjY0c
 KAj6nNrk3Wwd8BDiGmnr/20o5V3x3ayXl4xWmsgGOypjAjJl5AMXscIosS+iXYETladovICK0t4
 kMTgBMxt6u9U9LKvR0Y8SsBijWBbDqa/tgorqgfhDKyP6bS2tsQagwbKdMWhqjDVCJ4DFz6svoh
 E06BNI8SKCjHSJYMcsQ==
X-Proofpoint-GUID: M1Vdwg916NlQG-IbvLGH9DUGmz8erMOe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX/14D6ISUF43Q
 gmtyVCzY4bFuY4SQwsShrtj1a3VrxVu2NoUMK5D8yB1hRdjoH9RMpM+F91L6HXuLtvRqlE1WyHq
 lCDGO1bKjjEE6BrXNTquxWAYK+91L/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Use PERMILLE from linux/units.h for coefficients in thousandths and
add a helper in thermal_aggregation.c to initialize them directly in the
aggregation entries before publication.

Treat zero as an unspecified coefficient before initialization. Preserve
supplied coefficient sets without normalization. Require validation of
the description before initialization; partial specification is rejected
by thermal_zone_aggregate_validate().
When all coefficients are uninitialized, distribute a total of 1000 as
evenly as possible, assigning the remainder in source order to approximate
the arithmetic mean.

Reject default generation for more sources than the coefficient scale
because it would produce zero coefficients. Leave source pointers and
the offset in thermal_zone_params unchanged.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_aggregation.c | 80 +++++++++++++++++++++++++++
 drivers/thermal/thermal_core.h        |  5 +-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_aggregation.c b/drivers/thermal/thermal_aggregation.c
index f85f5a487d60..8b503fab25bc 100644
--- a/drivers/thermal/thermal_aggregation.c
+++ b/drivers/thermal/thermal_aggregation.c
@@ -1,9 +1,89 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/errno.h>
+#include <linux/units.h>
 
 #include "thermal_core.h"
 
+/**
+ * thermal_zone_aggregate_init_coefficients() - initialize aggregation multipliers
+ * @aggregate: aggregation description to initialize before publication
+ *
+ * The description must be validated before calling this helper. Before
+ * initialization, zero denotes an unspecified coefficient. If all are zero,
+ * generate approximately equal contributions summing to
+ * PERMILLE, distributing the remainder in source order.
+ * If all coefficients are nonzero, leave them unchanged without normalization.
+ * Partial specification is rejected by thermal_zone_aggregate_validate().
+ *
+ * The zone parameters' offset and source pointers are not modified.
+ *
+ * Return: 0 on success or -EINVAL for invalid arguments. Entries are unchanged
+ * on failure.
+ */
+static int __maybe_unused
+thermal_zone_aggregate_init_coefficients(struct thermal_zone_aggregate *aggregate)
+{
+	unsigned int initialized = 0;
+	unsigned int base, remainder, i;
+
+	if (!aggregate || !aggregate->entries || !aggregate->num_entries)
+		return -EINVAL;
+
+	for (i = 0; i < aggregate->num_entries; i++)
+		initialized += aggregate->entries[i].coefficient != 0;
+
+	/*
+	 * Validation has rejected partial specification. If coefficients are
+	 * supplied, preserve the explicit affine combination without normalization.
+	 */
+	if (initialized)
+		return 0;
+
+	/*
+	 * Current systems are far from aggregating 1000 sources, but enforce
+	 * this limit for unlikely yet possible configurations. More sources
+	 * than the scale would produce zero default coefficients, which denote
+	 * uninitialized entries.
+	 */
+	if (aggregate->num_entries > PERMILLE)
+		return -EINVAL;
+
+	/*
+	 * With no coefficients supplied, approximate the arithmetic mean of
+	 * the source temperatures:
+	 *
+	 *     T = sum(coefficient[i] * temperature[i]) / 1000 + offset
+	 *
+	 * Each source should contribute equally, so its ideal coefficient is
+	 * PERMILLE / num_entries. Integer division rounds this
+	 * down, leaving a remainder that must be distributed to keep the total
+	 * coefficient sum exactly equal to PERMILLE.
+	 *
+	 * Assign one additional unit to each of the first 'remainder' sources.
+	 * This makes the distribution deterministic in source order, with any
+	 * two coefficients differing by at most one. For example:
+	 *
+	 *     2 sources: 500, 500
+	 *     3 sources: 334, 333, 333
+	 *     6 sources: 167, 167, 167, 167, 166, 166
+	 *
+	 * Equal source temperatures therefore retain unity gain. For unequal
+	 * temperatures, the result approximates their arithmetic mean with a
+	 * small bias from coefficient rounding. The signed offset in the zone
+	 * parameters remains independent and is applied after division.
+	 *
+	 * These defaults apply only when every coefficient is uninitialized;
+	 * explicitly supplied coefficients are never normalized.
+	 */
+	base = PERMILLE / aggregate->num_entries;
+	remainder = PERMILLE % aggregate->num_entries;
+	for (i = 0; i < aggregate->num_entries; i++)
+		aggregate->entries[i].coefficient = base + (i < remainder);
+
+	return 0;
+}
+
 /**
  * thermal_zone_aggregate_validate() - check an aggregation before initialization
  * @aggregate: aggregation description to validate before coefficient initialization
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index a5fdf5c24b6c..365704584966 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -66,7 +66,7 @@ struct thermal_governor {
 /**
  * struct thermal_zone_aggregate_entry - source zone and its coefficient
  * @tz: source thermal zone
- * @coefficient: signed multiplier for the source zone temperature
+ * @coefficient: signed multiplier in thousandths, zero when uninitialized
  */
 struct thermal_zone_aggregate_entry {
 	struct thermal_zone_device *tz;
@@ -79,7 +79,8 @@ struct thermal_zone_aggregate_entry {
  * @num_entries: number of entries in the array
  *
  * Represents the sum of each source zone temperature multiplied by its
- * coefficient. The constant offset is stored in struct thermal_zone_params.
+ * coefficient in thousandths, divided by 1000. The constant offset is
+ * stored in struct thermal_zone_params.
  */
 struct thermal_zone_aggregate {
 	struct thermal_zone_aggregate_entry *entries;
-- 
2.43.0


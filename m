Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081670;
	b=o++uKLwIi9sROKksz6biaH+kSEZs/ROlfhF3QkjgwDtY9KDjtAygqRs8UVR7Es0Ivfmf
	 EJIGKANnvDHWwuq4PUYGJL7ozCjIWVJVT37Blx8d0zM7gyMeHNbn25q/l8YjKB8ZaT4si
	 mlQbSkr4uXGmP0ylqmI8tCMdAT6RjyaLJyHvGtQL9LR31eGR/IB9TM0ifUI24VYKU37YN
	 sTyfH5CH1oM5MTi6p3AB9NZ9eOl9sdpy6Zhjri0XI+DBegvzDCTNdX3E2wpk/1ZXjNk2P
	 i76aq+saL7EYuPkR5X4amASO4W4GqSiL0BfNNddVDQS8Tw5z9En+3hkjNTEw3GPm+Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081670;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=I+K/G9rf1j6ujCjlzjLkHsDb7XAOz1QQWRc2U3cC5xc=;
	b=nKVTVFmmVSb2KFUKty5goVQO66xtq8yaBs3ISxFhF7SrwU3m5XpHZG6MMY5iBAspd2Pk
	 D1isZar631E2krhHrmcz4oVTBe3E07Ybhj2cN1Xaln8Kb+cCZMZhqv6K+Jy+rJpT4HW7A
	 NkPIdnj0iUsATE7LweF0YlKLwxG47cid611uk6bkGuGPuJCtVEtfeUwh9a2s4lnpwIoyN
	 b8QgjlNKnA0xS+lSqSMIh/P4pUnBTj60jy1Rbi6ZZmV0H5A9I0htrjHWy3h6JYTi3SrOK
	 dq5hRfWUn4tbNLlMR6wuGkC7rKlcyUdJoUCXAsI0qZb0pvZyDvH/H4nifZ56J/BbdNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NBSjH5rb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="D4pNsd/2";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBF60A261A
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCBF60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NBSjH5rb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D4pNsd/2
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6vFJo1681162
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I+K/G9rf1j6
	ujCjlzjLkHsDb7XAOz1QQWRc2U3cC5xc=; b=NBSjH5rbFq70DxYPxBOboHkZdbA
	ySDKXOywUmpOQ2MIa0yr2eRTw+319j9nNmaxXdcD1WrPZ8f8DxGPW6ihX4rNvfN6
	18p8JoFe7SaysyZwLbw5Bl4pz2j8UxuAcCVkcETuQPWMGkvlYP4TIJPGc3+2AmzC
	jzxHpX9qQJoxwImXoRQYjJab319jQEBpiiHpa4/nnN0h1kZeZr0bkfj152t1vK2g
	xvGayLU/rxRaGI5PumnT2M5uY3P2XI95HEF7T1e6EaXPIvXDm7HkVbvikKwan+df
	t81ahxasfR2bQLhoS+50W0X0QxtXunOHztW16hPlCopsUykOzCxyH3XGsKQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdct5km-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f20addba1so369835985a.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081668; x=1795686468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+K/G9rf1j6ujCjlzjLkHsDb7XAOz1QQWRc2U3cC5xc=;
        b=D4pNsd/2+m1yzMTyRxuiD/ouYjE2drHR/dAIdN14yZw1AMxnhXp/Bfcv5o3W1O/zG7
         zShNKTpYAEr5XeerScKy6oXHfKM1sw0yN76QuXc8LbrX1zAT6XaCJ2+h6cFNQFvF0ycS
         44CanBJpwJC4gtJqYm42xn7D4rEWFNNYim/rCSkOnq/bhNCI+B+fc3TD49DNvt1UUrsI
         VWSp7iijuUD2hpyz06YN2wcRYJ0W4ORWtHTEubiyc/nQCSJK2XQoW66ZyYKx6LzGVvMn
         WEKSUI1ZA69p/YKjPBca6V/UBM4G4eXFh4MpODErFVnyDIhbVWHxIoBLgwJ6sMpsVweL
         j/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081668; x=1795686468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+K/G9rf1j6ujCjlzjLkHsDb7XAOz1QQWRc2U3cC5xc=;
        b=aw0zRwAXNAnarE+B7vn6kdaE1ivy/PJhEfz8S5oTWVl9JP5D30UhWusXJ11rq4REPY
         ZS6Q6sPMj25HUEje62ednitGJVeBSwELfxtnlL2W3V0Yc8pcRDJpLqnzrV9MsxZnSTfb
         dg+lUscE+/2AlRcfklr1CJ487DRAH70U+5u0WW+FPLOoQBne4SkJIeFNuPjJjZoVj5PN
         BbFy8V4bi1cFFuDtzlJuMwFKf9+ZhDuiLrr//OA9w/W9LOG0zstkOHFCypoIZ6YScbMH
         g+9tGrtFl7KBpRmVv8VqT2mbEhTQJjP0GImkWIuUpYDP9Zz3+tb3Rk93g5Fi0EHrcZ2z
         Vb+w==
X-Forwarded-Encrypted: i=1; AL+hErF4fNTp7+2QIHl7b8I2u5/rC9HG69w3B7uKyGh6LRRIgggHwtkOKoNA6jjzEmtXHawFvnzBvFH3Jw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ASw1r7serJb8JPiR+9T+66in1J8d2vhRk0/WOunGhIC4/Jjuo
	K4K89an3G9oRbnQ/g/qyNKIfdjDxB4w/nYPyq9BKl3IDPGEZ7e+YZPDr6QaQ2d2pXJ4bzgWV4PT
	H2zLXi4YsYGf7T+noXe7letZS3YSas1+vQR1zDn1RiME9noUky7THO+25XVvBvg==
X-Gm-Gg: AYBFou14gIxVbCO1MUNNCRJjXeiZQt1vPN5Eh6mkM++hA79naGLLyORsOrmK1cgC/m7
	lJ6ECoMdOCVl9zQ+JUbHuFm49t5uItgewdfUdF0a5UD1HOc63k1HYGtYa2C7wmE3MKvbZRg3MHt
	OajqyON5QJFaEloPEbJp+n17rUq6y4668kGCxvgLc1+akZ2U2F5h/9mL6oc/sIDHuRKmhUtVCve
	1gsWCkO/4Hf2SWF0HbiY4w8BSV0gXF92aKfg4hkUXcnMMbyDpOPkPiMAeulJygsTint0T2uRCrt
	Mt16uIV3H0B0xjiChGiMpMucxlTMlWCir2mKkozJZfaeIlgmGqok6/eJxbxaDHW6DMZRr4bN/e/
	eVd4OtsR9Cs1opz2UEFjeQfeLnU92sPiDtj2WDZtMvHmdJl/08ftAnC9SpN54eGmrteSUcZXmi/
	Sh
X-Received: by 2002:a05:620a:2615:b0:93f:3863:268a with SMTP id af79cd13be357-9499972b105mr914523685a.37.1795081667985;
        Thu, 19 Nov 2026 01:47:47 -0800 (PST)
X-Received: by 2002:a05:620a:2615:b0:93f:3863:268a with SMTP id af79cd13be357-9499972b105mr914521685a.37.1795081667496;
        Thu, 19 Nov 2026 01:47:47 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:46 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 10/12] thermal: of: Instantiate aggregates after their source zones
Date: Thu, 19 Nov 2026 10:46:52 +0100
Message-ID: <20261119094706.3439040-11-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 2bwF3ICMGxvBe3fD4p-SG8xAKqItMcdq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX3wcnSU0KcH6e
 klWT6DqKtExUxc7YcQxFgaM/K2hCnw9U7OpYD9OxoNO6uNdtNYaH2WTmR4YE0MGQ/QQJBLjfx3j
 74rkbB1R+RjFjIgrT1aFKUtUPYQxGQ8=
X-Proofpoint-GUID: 2bwF3ICMGxvBe3fD4p-SG8xAKqItMcdq
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afec5c4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=Z7QjB-FQypT2Tdk3yCwA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX+LBk4kMXXo/M
 QU3qpsXNLvSOYQwF+pVYqikZJxVrFK5UvZ7/8/JxsjtwOTrrCWtfzZCsN/69gWn/4fltNBFUNp2
 G0RvYT9oIzsqMOrkNjFFFRcqScFWRu5UwaYulId9eH0kRrWqu4wRDlWtOg+9m83j1eFuq721xJu
 NdSfkYnEsJXp0vNVDnukf1T1FlJRUSjXTQwJshbSc1a9tE5zEesJsc/QHzV986AI1ZBazRya7Mg
 vVkSFh2mPwnfPo7W5jldwxb8NVtoL82h1nUMtKBQZjxrPm9TtDm4YvTyqStOO9Ji4KOaaVoDIvY
 uh3ICgA70D8wzik4CI1FUPeYUlvy4gTy3aXSLp1hMi9Fj0mo6XrmOcqk7sMR30lZM5FmEsfy2dd
 oZBVbobwJNy2dkJYNJ7p7+zvRyTJWAxAgDzaTfeExlEUwlqOgSBtT/0nRfpMcD/diklzq4MFabf
 tPb6AtLg8fVtb/DwKpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Discover multi-source thermal zones at late init and resolve their
hardware provider and sensor ID references to registered source zones.
Retry pending descriptions synchronously after successful source
publication, without workqueues or changes to sensor driver APIs.

Serialize creation and removal with the OF lifecycle mutex. Acquire
source references while filling aggregation entries, unregister dependent
aggregates before source teardown, and release references and allocations
on failure or removal. Keep descriptions pending for source module reload.

Use the shared node parser with core aggregation operations. Preserve
legacy single-source slope and offset calibration. Missing multi-source
coefficients request averaging defaults; explicit integer multipliers are
converted to thousandths with overflow checks and the offset is unscaled.
Reject partial arrays and explicit zero multipliers, which cannot encode
presence under the current aggregation initialization contract.

Skip multi-source nodes during ordinary hardware zone lookup so they
cannot be bound directly to an individual sensor callback.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 217 ++++++++++++++++++++++++++++++++++-
 1 file changed, 216 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1fa7e29f5bc8..64ae7769edcb 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -10,8 +10,11 @@
 
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
+#include <linux/units.h>
 #include <linux/thermal.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -31,6 +34,14 @@ struct thermal_of_source {
 	struct thermal_zone_device *tz;
 };
 
+struct thermal_of_aggregate {
+	struct list_head node;
+	struct device_node *np;
+	struct thermal_zone_aggregate aggregate;
+	struct thermal_zone_device *tz;
+	bool failed;
+};
+
 /*
  * OF lifecycle operations are serialized outside thermal zone locks. Thermal
  * callbacks must not acquire this mutex. Source removal holds it until all OF
@@ -38,6 +49,11 @@ struct thermal_of_source {
  */
 static DEFINE_MUTEX(thermal_of_lock);
 static LIST_HEAD(thermal_of_sources);
+static LIST_HEAD(thermal_of_aggregates);
+static bool thermal_of_aggregates_ready;
+
+static void thermal_of_aggregate_retry(void);
+static void thermal_of_aggregate_release(struct thermal_of_aggregate *aggregate);
 
 static int thermal_of_source_add(struct device_node *provider, int id,
 				 struct thermal_zone_device *tz)
@@ -59,18 +75,29 @@ static int thermal_of_source_add(struct device_node *provider, int id,
 	source->id = id;
 	source->tz = tz;
 	list_add_tail(&source->node, &thermal_of_sources);
+	thermal_of_aggregate_retry();
 	return 0;
 }
 
 static void thermal_of_source_remove(struct thermal_zone_device *tz)
 {
 	struct thermal_of_source *source;
+	struct thermal_of_aggregate *aggregate;
+	unsigned int i;
 
 	guard(mutex)(&thermal_of_lock);
 	list_for_each_entry(source, &thermal_of_sources, node) {
 		if (source->tz != tz)
 			continue;
 		list_del(&source->node);
+		list_for_each_entry(aggregate, &thermal_of_aggregates, node) {
+			for (i = 0; i < aggregate->aggregate.num_entries; i++) {
+				if (aggregate->aggregate.entries[i].tz == tz) {
+					thermal_of_aggregate_release(aggregate);
+					break;
+				}
+			}
+		}
 		of_node_put(source->provider);
 		kfree(source);
 		break;
@@ -217,6 +244,9 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 			pr_err("%pOFP: missing thermal sensor\n", child);
 			return ERR_PTR(-EINVAL);
 		}
+		/* Multi-source nodes are instantiated by the OF aggregate manager. */
+		if (count > 1)
+			continue;
 
 		for (i = 0; i < count; i++) {
 
@@ -486,7 +516,8 @@ thermal_of_zone_register_node(struct device_node *np, void *data,
 	if (ret) {
 		pr_err("Failed to enable thermal zone '%s', id=%d: %d\n",
 		       tz->type, tz->id, ret);
-		thermal_of_zone_unregister(tz);
+		thermal_zone_device_disable(tz);
+		thermal_zone_device_unregister(tz);
 		return ERR_PTR(ret);
 	}
 
@@ -528,6 +559,190 @@ thermal_of_zone_register(struct device_node *sensor, int id, void *data,
 	return tz;
 }
 
+#ifdef CONFIG_THERMAL_AGGREGATION
+/* All aggregate construction and destruction runs under thermal_of_lock. */
+static void thermal_of_aggregate_release(struct thermal_of_aggregate *aggregate)
+{
+	unsigned int i;
+
+	lockdep_assert_held(&thermal_of_lock);
+	if (aggregate->tz) {
+		/* Do not recurse into OF source removal while holding the OF mutex. */
+		thermal_zone_device_disable(aggregate->tz);
+		thermal_zone_device_unregister(aggregate->tz);
+		aggregate->tz = NULL;
+	}
+	for (i = 0; i < aggregate->aggregate.num_entries; i++)
+		thermal_zone_device_put(aggregate->aggregate.entries[i].tz);
+	kfree(aggregate->aggregate.entries);
+	aggregate->aggregate.entries = NULL;
+	aggregate->aggregate.num_entries = 0;
+}
+
+static struct thermal_zone_device *
+thermal_of_source_get(const struct of_phandle_args *spec)
+{
+	struct thermal_of_source *source;
+	int id = spec->args_count ? spec->args[0] : 0;
+
+	lockdep_assert_held(&thermal_of_lock);
+	/* The existing OF source registration API identifies sensors by one ID. */
+	if (spec->args_count > 1)
+		return ERR_PTR(-EINVAL);
+
+	list_for_each_entry(source, &thermal_of_sources, node)
+		if (source->provider == spec->np && source->id == id)
+			return thermal_zone_device_get(source->tz);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int thermal_of_aggregate_create(struct thermal_of_aggregate *aggregate)
+{
+	struct thermal_zone_device_ops ops = {};
+	struct thermal_zone_params tzp = { .no_hwmon = true };
+	struct device_node *np = aggregate->np;
+	struct thermal_zone_aggregate *desc = &aggregate->aggregate;
+	int count, ncoef, ret, i;
+
+	lockdep_assert_held(&thermal_of_lock);
+	count = of_count_phandle_with_args(np, "thermal-sensors", "#thermal-sensor-cells");
+	if (count < 2)
+		return -EINVAL;
+
+	desc->entries = kcalloc(count, sizeof(*desc->entries), GFP_KERNEL);
+	if (!desc->entries)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		struct of_phandle_args spec;
+		struct thermal_zone_device *source;
+
+		ret = of_parse_phandle_with_args(np, "thermal-sensors", "#thermal-sensor-cells",
+						 i, &spec);
+		if (ret)
+			goto release;
+		source = thermal_of_source_get(&spec);
+		of_node_put(spec.np);
+		if (IS_ERR(source)) {
+			ret = PTR_ERR(source);
+			goto release;
+		}
+		desc->entries[i].tz = source;
+		desc->num_entries++;
+	}
+
+	/*
+	 * Missing multipliers request the core's averaging defaults. Explicit DT
+	 * multipliers retain their unscaled integer meaning: convert to internal
+	 * thousandths, checking overflow, and leave the final offset unscaled.
+	 * Legacy single-source calibration never passes through this path.
+	 */
+	if (of_find_property(np, "coefficients", NULL)) {
+		ncoef = of_property_count_u32_elems(np, "coefficients");
+		if (ncoef != count && ncoef != count + 1) {
+			ret = -EINVAL;
+			goto release;
+		}
+		for (i = 0; i < count; i++) {
+			u32 raw;
+
+			ret = of_property_read_u32_index(np, "coefficients", i, &raw);
+			if (ret)
+				goto release;
+			if (check_mul_overflow((s32)raw, (s32)PERMILLE,
+					       &desc->entries[i].coefficient)) {
+				ret = -ERANGE;
+				goto release;
+			}
+			/* Zero cannot encode presence in the core initializer. */
+			if (!desc->entries[i].coefficient) {
+				ret = -EINVAL;
+				goto release;
+			}
+		}
+		if (ncoef == count + 1) {
+			u32 raw;
+
+			ret = of_property_read_u32_index(np, "coefficients", count, &raw);
+			if (ret)
+				goto release;
+			tzp.offset = (s32)raw;
+		}
+	}
+	of_property_read_u32(np, "sustainable-power", &tzp.sustainable_power);
+	tzp.aggregate = desc;
+	aggregate->tz = thermal_of_zone_register_node(np, NULL, &ops, &tzp);
+	if (IS_ERR(aggregate->tz)) {
+		ret = PTR_ERR(aggregate->tz);
+		aggregate->tz = NULL;
+		goto release;
+	}
+	return 0;
+
+release:
+	thermal_of_aggregate_release(aggregate);
+	return ret;
+}
+
+static void thermal_of_aggregate_retry(void)
+{
+	struct thermal_of_aggregate *aggregate;
+
+	lockdep_assert_held(&thermal_of_lock);
+	if (!thermal_of_aggregates_ready)
+		return;
+
+	list_for_each_entry(aggregate, &thermal_of_aggregates, node) {
+		int ret;
+
+		if (aggregate->tz || aggregate->failed)
+			continue;
+		ret = thermal_of_aggregate_create(aggregate);
+		if (ret && ret != -EPROBE_DEFER && ret != -ENOMEM) {
+			pr_err("%pOF: failed to create aggregate: %d\n", aggregate->np, ret);
+			aggregate->failed = true;
+		}
+	}
+}
+
+static int __init thermal_of_aggregate_init(void)
+{
+	struct device_node *np __free(device_node) = of_find_node_by_name(NULL, "thermal-zones");
+
+	if (!np)
+		return 0;
+
+	guard(mutex)(&thermal_of_lock);
+	for_each_available_child_of_node_scoped(np, child) {
+		struct thermal_of_aggregate *aggregate;
+		int count;
+
+		count = of_count_phandle_with_args(child, "thermal-sensors",
+						   "#thermal-sensor-cells");
+		if (count <= 1)
+			continue;
+		aggregate = kzalloc_obj(*aggregate);
+		if (!aggregate) {
+			struct thermal_of_aggregate *pos, *next;
+
+			list_for_each_entry_safe(pos, next, &thermal_of_aggregates, node) {
+				list_del(&pos->node);
+				of_node_put(pos->np);
+				kfree(pos);
+			}
+			return -ENOMEM;
+		}
+		aggregate->np = of_node_get(child);
+		list_add_tail(&aggregate->node, &thermal_of_aggregates);
+	}
+	thermal_of_aggregates_ready = true;
+	thermal_of_aggregate_retry();
+	return 0;
+}
+late_initcall(thermal_of_aggregate_init);
+#endif /* CONFIG_THERMAL_AGGREGATION */
+
 static void devm_thermal_of_zone_release(struct device *dev, void *res)
 {
 	thermal_of_zone_unregister(*(struct thermal_zone_device **)res);
-- 
2.43.0


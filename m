Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081668;
	b=Kic+Mo90Raqt8azdOFbMf93X5rVPQx4MZqeB7HA5n0eiNUmx61lNCFkx+gUe39/MXfK4
	 d16y+c1f5HzHjuiUbCGpLrMvxHHC8v5N1cOfzq1+kNIhDk0GRky62CWMw438HZcdIh38e
	 CogC1u7FPHS7t8gU3QMiA1Lhtv+w+4nEnAcHrB8tXl5kzxqwHRIztLpSAQyhCvAV9eZkd
	 cLGOs6g2KpQSx80OOKjKrspU2PmHhc3Lh4jeadTLEDWfM6YxenjTXkRkE5mwz5lbt9B7y
	 9Opzlr99jrBbthUeg+3A5MsvpCaK/Vc5LBctfl7zqAoLamiwQrvekrYkiqWIl+VNqpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081668;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0piZuT8O17sCzBuMxolM1mTBSJ9b8cd8dmW/GEv2Rts=;
	b=MIMhvgbfjQaUGmmYMDLAy6zc8eHkuUyyNkI2FKVUfKOe53IYRiYpI8UdRYihMXToIDiK
	 xzX6/4NIEHF5iLnxSQZu07RAq9qKBXy4WfMzN4MvoKceshUXhIY3fnuBlvpXisT24tbj+
	 0YM740KJOEwSEdLJ5B+b58jiJR7u+rRvl69PmbG1jHdUBEcLR8EBnK06PB7Eo8mqHp0Cp
	 428BTTqltpgfmiAk4etHB7A7Uj4e526H2Wrc+FhI2lhSivQ5dXEWv1Mrf08EFb0Q0vSZl
	 tWUuP6aNi584WNxnLcdeRJ6RAtdjE1Dkez5QLA2MOvHq35RkDKZi8AzNx/F+ybesosg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d80D7KrX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HcJ2BbWK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7EA60A2633
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E7EA60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d80D7KrX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HcJ2BbWK
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6vE9a2935530
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0piZuT8O17s
	CzBuMxolM1mTBSJ9b8cd8dmW/GEv2Rts=; b=d80D7KrXhh1h0R1ZvKPOVnoGHHj
	FcZgp0veL5+qJRCVZA193rw3uOrOThAgZjdsbgWKl4LUBR6jjNddUBnkEYx79ZoL
	EhvKrwSUvZZF2bSIgy3Pm+PvhIgPcDq/Li/Kk1tN+0io1XYhL3cKf7KZr8eIhw9G
	BMwxWh6BxEPrQqhzU3fzeVJUCvNVKtSbnR6rHzvxtBs+RiuxcXsyvMDPTCawjUau
	vKhGhlwNiexPTm4jrptzR0edYSRGX6kLKO7xirT6P5c48RkWCoSn0DkGLOerP3Xr
	CCQiT3Pnv2xF1TH0byfT3ceiKv7k1EZAM8wGxsbSm+Udsl4KupWcpk81ntQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9ekrqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f6f4fe531so331399985a.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081665; x=1795686465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0piZuT8O17sCzBuMxolM1mTBSJ9b8cd8dmW/GEv2Rts=;
        b=HcJ2BbWKzetvTYlP/kG7E/Xaojgu5VF7o9S3YNToRFm6FEZ4dta9vvPgJ36JxZEw5R
         caGRtsrFoEZHuVEHc7NhMAt6RkqgJaqx/5uxNcEuaaUhysi1LiPjGx9Hm2iobcXpTTLn
         GO9s/PTspaDqJdfN120Ds6pDtzGoUTCPXp3Xpo2bue4x2EgZ5Orpyk9W8gT+Tb9fpPsz
         //uz8OwweqBi2c5aOFxTuVhYqoeHufLPw7cYH+EoBHE/X+D0DkoKj6YBTtE6kGYragJg
         ou5gSo0xXCYoVFDdpzG/ccEeYqXX3c33BFRDLUEF4akdjRK93Do2d9zXLG9FMHRkC2Mk
         sdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081665; x=1795686465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0piZuT8O17sCzBuMxolM1mTBSJ9b8cd8dmW/GEv2Rts=;
        b=DpXvhYLRmzmGAW324UqmvEBx2rFiw3lZ+rzRDMIVYTAPWrMsLOxn3JHJE8VPVrFU30
         +n26HVdCoVbW3SjwIKgjEXpmaEOEwxOG7Zpp+5eDuYw2izhAeMRwdzwVhc5rOeq7BmF5
         /Si+E8/2WvHERJevSuJhdBU3BDr2t/UbKpkoA0fjbzPrKsgAUquvEqalgbC1FyxoxR1s
         Ghhwu4XgAnclbbxERtCxeXcTV6bmUpbAnsBevFBLZ0oOVxwkAtmCQcfnDxUxEFmnA3WJ
         TTV/3M3JZRddcBjkzOQ67F8c83j7I8q1R+rJBCS62zHJR49FuQt01N4biN8aC+ntDriL
         xwxg==
X-Forwarded-Encrypted: i=1; AL+hErEbOk750HoOF73l+VnPGnjgQ8At73ouEOpgcrvroTF+/B6+oU/q/l1coIqRclXSjUhNGTGi0N0O8A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8tt2+nO1DS4YKgt3q3YkpUYR7rGXp669RZf8m/eySiYvAXI+d1
	1ej280QcxYb0VlELUpFlRODXvp7QV+q7LNH+szLPqdNa5bYZYqT6cFEdSdxH9GNaSFcpyX+gvXh
	uKzYlSHlScahrA2TPKIK0QTpdjsPu6xzKrBUB0gO7VqpUQs3xSmXOP04dAtyghn9a0h0wKA==
X-Gm-Gg: AYBFou2A03hmR2IxaJCIn7yM8wpgSNKe59XQ2YcpSnnAr2ptaCCDPcgtd+aMQIV5ejI
	Odmo9jkXUcxWCsoKKcgOFjyUlTrSXo8egKf58HSTTvaeJhvUo709yxlU1Ob26tqC6GZRp6HVh8s
	wtQt6TYfbM1hPh2ovHEpLm2+2D50F2dcMxw/BUYcClS3VY1srlrtBW9zB0hjWIF1BuIqo7816Yt
	54dsxdyVKrJQ+DdqLwfUkIfk7wjYQSonbFkYaoLCqNSlwIP/QIHQqenDoRkcIGwz/9S7K0vKTVj
	AzAP3V+FWEMPNUTy2MlJSKFPihWpuyBtLECKE+ZHWn/prnvO22vVKobi5yUPpwRd+smGNTwsWxO
	5M7rW2ZKNjru6HAm+5ZVKVuP5EsLS5C2r6CxseOtECmioVUsvbMUZUiiVB+/CHuCVT6wDfauWOF
	js
X-Received: by 2002:a05:620a:8710:20b0:949:99e1:42d7 with SMTP id af79cd13be357-94999e14369mr685328585a.73.1795081665175;
        Thu, 19 Nov 2026 01:47:45 -0800 (PST)
X-Received: by 2002:a05:620a:8710:20b0:949:99e1:42d7 with SMTP id af79cd13be357-94999e14369mr685326785a.73.1795081664652;
        Thu, 19 Nov 2026 01:47:44 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:43 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 08/12] thermal: of: Separate zone parsing from sensor lookup
Date: Thu, 19 Nov 2026 10:46:50 +0100
Message-ID: <20261119094706.3439040-9-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX0kmFZMUyGJO5
 I2R6uDWFVJWK5OfDvf+65fNCLPUqVsN4kWDDsI17URV3uTKBqNg+EjHlHYyGpTkH5P1cmeJWfZ7
 btQ4FAzQD4xUOKM422IP7BrvfQ3IYys6ylRiV7hXi0UnOtaTd34F1zEBJioBHGs0xzH2QdLTAVC
 xTrv/oNUzPMWrVnyHhvNjKtNJ0JTbTuSNX47/kxQgqAPtw6+5t6qL9W0kgJxJHYNVWQe0O21MCE
 biUWcf6sFZqlnswQykvJHu5HEItGsNFBuZnk/UQMxr37fmGq0tE5G4ymT1E2GV+GcKRR121c7pV
 qY/583yYwsRmjVH/anwnjccblhPNlnCigWXxKjhnRvdRNy55IbGg7PonBorEyQckeHCdbNOjm1j
 gcMAxUv9n8TGp1vCTQBP+HMSou6Wrz8n31H9TS2Tvd4o28G/YJ8jddHn5DscLsn7LPnr0MyeW/X
 l3imXIzvN/C6jcG1bvw==
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6afec5c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=p39lXgXYR0dHnsPWrG8A:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: F7BBCsiKPXoSVnhc812eBu7njNex2Htq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfXzX/8YAA1lTzI
 GwDXcG4AvgTkVuw6ZuLRIR/GiA6SR/0129xIbVqzTEAxpYSNLfP8ptx/ubdYJiPnuFCz0KSe5s9
 ccQY0EDXHE/xCTw2mbNummBaaxCYQJg=
X-Proofpoint-GUID: F7BBCsiKPXoSVnhc812eBu7njNex2Htq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Extract node-based thermal zone registration so subsequent aggregation
support can reuse trip, monitoring, cooling-map and critical-action
handling. Pass initialized zone parameters into the shared helper and
keep legacy slope and offset parsing in the hardware sensor path.

Keep device node ownership in the lookup wrapper and preserve existing
source registration and enablement behavior.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 70 +++++++++++++++---------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 9e96fb1b033e..710ff25140e7 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -363,55 +363,27 @@ static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 	thermal_zone_device_unregister(tz);
 }
 
-/**
- * thermal_of_zone_register - Register a thermal zone with device node
- * sensor
- *
- * The thermal_of_zone_register() parses a device tree given a device
- * node sensor and identifier. It searches for the thermal zone
- * associated to the couple sensor/id and retrieves all the thermal
- * zone properties and registers new thermal zone with those
- * properties.
- *
- * @sensor: A device node pointer corresponding to the sensor in the device tree
- * @id: An integer as sensor identifier
- * @data: A private data to be stored in the thermal zone dedicated private area
- * @ops: A set of thermal sensor ops
- *
- * Return: a valid thermal zone structure pointer on success.
- *	- EINVAL: if the device tree thermal description is malformed
- *	- ENOMEM: if one structure can not be allocated
- *	- Other negative errors are returned by the underlying called functions
- */
-static struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-							    const struct thermal_zone_device_ops *ops)
+static struct thermal_zone_device *
+thermal_of_zone_register_node(struct device_node *np, void *data,
+			      const struct thermal_zone_device_ops *ops,
+			      const struct thermal_zone_params *params)
 {
 	struct thermal_zone_device_ops of_ops = *ops;
 	struct thermal_zone_device *tz;
 	struct thermal_trip *trips;
-	struct thermal_zone_params tzp = {};
-	struct device_node *np;
 	const char *action;
 	int delay, pdelay;
 	int ntrips;
 	int ret;
 
-	np = of_thermal_zone_find(sensor, id);
-	if (IS_ERR(np)) {
-		if (PTR_ERR(np) != -ENODEV)
-			pr_err("Failed to find thermal zone for %pOFP id=%d\n", sensor, id);
-		return ERR_CAST(np);
-	}
-
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
-		pr_err("Failed to parse trip points for %pOFP id=%d\n", sensor, id);
-		ret = PTR_ERR(trips);
-		goto out_of_node_put;
+		pr_err("Failed to parse trip points for %pOFP\n", np);
+		return ERR_CAST(trips);
 	}
 
 	if (!trips)
-		pr_info("No trip points found for %pOFP id=%d\n", sensor, id);
+		pr_info("No trip points found for %pOFP\n", np);
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
 	if (ret) {
@@ -419,8 +391,6 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
-	thermal_of_parameters_init(np, &tzp);
-
 	of_ops.should_bind = thermal_of_should_bind;
 
 	ret = of_property_read_string(np, "critical-action", &action);
@@ -432,7 +402,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	}
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     data, &of_ops, &tzp,
+						     data, &of_ops, params,
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
@@ -440,7 +410,6 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
-	of_node_put(np);
 	kfree(trips);
 
 	ret = thermal_zone_device_enable(tz);
@@ -455,10 +424,29 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 out_kfree_trips:
 	kfree(trips);
-out_of_node_put:
+	return ERR_PTR(ret);
+}
+
+static struct thermal_zone_device *
+thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+			 const struct thermal_zone_device_ops *ops)
+{
+	struct thermal_zone_params tzp = {};
+	struct thermal_zone_device *tz;
+	struct device_node *np;
+
+	np = of_thermal_zone_find(sensor, id);
+	if (IS_ERR(np)) {
+		if (PTR_ERR(np) != -ENODEV)
+			pr_err("Failed to find thermal zone for %pOFP id=%d\n", sensor, id);
+		return ERR_CAST(np);
+	}
+
+	thermal_of_parameters_init(np, &tzp);
+	tz = thermal_of_zone_register_node(np, data, ops, &tzp);
 	of_node_put(np);
 
-	return ERR_PTR(ret);
+	return tz;
 }
 
 static void devm_thermal_of_zone_release(struct device *dev, void *res)
-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A00481650
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112213; cv=none; b=YCeW0nOABhTwExrfjQvwXvSMK4yg1Xf7yN1VMBdUGKVRySZ58G/HXzNJLbnrn+HZCzhWWOG+WZGcCGnfYHZtQkgZKEXNKLERbjN5Xzd70FQJG2dDb9tuAv6pQNlKDqmbuaBbATRtCrkUGQn0YepvTdrwPmSaQRuyiJub14fYhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112213; c=relaxed/simple;
	bh=1aO9ExS/iJmtGN9nCkni7bF7YETFRBmThZL8SJD8tuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fA0yoZ8uQrvcQ0A+JabVROhVn97Qz9DWHqQQyvtxK2JHbxx76jSllPg4xv7eirqhfHBtuAwHpCQLXRIVhtPB0aIyzd/VGQa5uNUjLCjb8zfkqrB7Kf6dWZ0Zb6AdhS9uaVG6xweaZS2hYcOxdD3ciB8raujNVEka/pHWlA8ihYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kT0LVwrS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LDVs8GKd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kT0LVwrS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LDVs8GKd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICFxD22701098
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vy1Q1E39uQDwPqLscloGcfc9TxMS8pJ/zjTeEJF4xLo=; b=kT0LVwrSN+sVtjuw
	28QFrVHnMNMveyFVSKGzXd0gLwOm+VTXOm5TLFPFynXGAwVAc7jEY+6UbiP0DeZB
	izyR/W3KZtGHH2Y9jZnFYQyUATk1WEQ7EmuebFIp8sF7UWhYUrm9MioVS6m9Y+ge
	IfflbPt2vf3o0cE+lUIxDDTScy7DxdAYeAq9pDwWwl+eLHO3+KP5d4z4B9ou/cQK
	Ev2/ThgIZKCoxp8dtCzNIcwT8wCJQ9b/ksDqpCxX6MNnkcablJuq70zh+aN6FKk3
	4vypXy32zYRlK8r4IxrpTqU3aObOi3gXp2FSmx0CB3CA38z5ytAD79d3oRiabVBj
	A182lg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82megb21-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36641bb3d97so1354628a91.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112210; x=1779717010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vy1Q1E39uQDwPqLscloGcfc9TxMS8pJ/zjTeEJF4xLo=;
        b=LDVs8GKdUetFADE0ONQ+jk373MP9TdTMHbIPphkWa04CR5J3z3r6Kv0Mo54zGa8+QF
         1Nrybj9CKHhzFGEFExAt2w1l2mIWYbcCIO4qUAnVbtx5IsffxZAFdUt5mmf8w6ABLVt5
         bipSvIfOez1CjbiliiQbfPZv6XgXBu+xH2FjCl28Y5L6xwaJXFBEzxxBpHdW0LBSTVeL
         TpTSuCEVhXlOFShaLXnTzSJT4E2k6+5vhZ7h2dR3MWJ2Ag+Lnf4VCrigymGnez755OSz
         7a8/d+pUh0pR4amAtZ0T+ENMZ4FxTyfgzEafjCzJ3qCEsroETPX7jZg6Nqq30HmTiFao
         Nvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112210; x=1779717010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vy1Q1E39uQDwPqLscloGcfc9TxMS8pJ/zjTeEJF4xLo=;
        b=qvBA8aRuhKaMGphSAT93y4u0+gX1qab5Y3oqDTdVB8gMvBYckZV9IdG3SxzY/TxF83
         f2LgtaV8u/JPja99nisY5/HbP5v77O5ztM95yGXqVGqGv+wJ7QfY0naiGoAuPJCZfWgG
         W+RB1osq5ZqCWLCAu6p8RoF0XB41L5boN+f6/PP5/PSXLX4d+YcR3TpUrAFJbt10XhM0
         kD4hQM7XzcaLe7lB6GcIwxbZz0nkE65sK3IrYoV/oEjtM+vNAWIMOCQfITC/dspOoVHK
         w3SfjEWVdZyRULcqXBe+hvLgzwRs8Ki/f2eRe/CS6aHJ056kBR/CYKBRrBC0CJfXkhQ+
         hElQ==
X-Forwarded-Encrypted: i=1; AFNElJ+59VinX5e1oQr/yeDaZu8O2P3uLpRDccOYH7zkQ7T22+cvazvg6HnX9HLk4Q7nTQPbUOt8BPEEog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRBtQwd6aejwQWePqo0cvJUr+Kag3G7MJg1KjyX6ZmjYIczXY
	Tj/gL5lFoOWuIAaHmwbY93TttFtqQOjiv5S+Z/HqmmjDycrqD2ftjE3K9Vc3GqAXD6b5itwxhQW
	4KzJOVmXLWhN28hMOsbWdQ6CUh2PzA8wRwgoFG/VkzwrQXDn3dNUXMdAgLVTEk8N2mihv
X-Gm-Gg: Acq92OHqqrluFnWvisHHQWXVnp9+nm/PgqbuuvJeLXFjV8PhyOQjU3pscfXYTcZW3VH
	7oXqk+dDRo1uJ/NlZICKwBEmRUAL1ZCVE/zhcY1jB+Et7llvDvXaMJFQoLNOTN5O6H58tceT8rZ
	ZsUZxBeoO1BeFHFKw8yIau5lBJ8GFDb9BFXjXpu0Sf+A1pa+XxStZxZE5uMX6nKYQQkHf7YhMAk
	1PqowmuM4cX0js6U3FqEAaxOsJMl4opT8c9z9n/i84SfQJHi6XEaxgGsGQ+xBysa/aRs4pFjy7j
	UuUJnjtWUTwvCd01K7K6pg0AYWXZszK58SqgJayL6/+Xwqt/rfudbx8knSz+BmJ9C/gLWgzuNFl
	cqsP5oqwhitvzhHC0K5biTpqkGUY6uJZb7gUbuZCbO5YcpCIc6ac=
X-Received: by 2002:a17:90b:3f8c:b0:361:45df:102 with SMTP id 98e67ed59e1d1-36951b82f77mr14930691a91.17.1779112209656;
        Mon, 18 May 2026 06:50:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8c:b0:361:45df:102 with SMTP id 98e67ed59e1d1-36951b82f77mr14930656a91.17.1779112209139;
        Mon, 18 May 2026 06:50:09 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f36fsm185411275ad.21.2026.05.18.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:50:08 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 18 May 2026 19:19:40 +0530
Subject: [PATCH 2/2] power: supply: qcom_battmgr: Add support batteryless
 boards as MAINS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-add_dc_in_support-v1-2-31fbaa329879@oss.qualcomm.com>
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
In-Reply-To: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779112197; l=3154;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=1aO9ExS/iJmtGN9nCkni7bF7YETFRBmThZL8SJD8tuQ=;
 b=4U6y2t24JASec3FhMnbBc0UKbrhU17JX/1kC6ZyIjsBlbBhqAUOuuA/JLvK4zBv0uzCDOksk3
 UGxPCewnuF8CQWrCslsvgOwmJ96EW5GNU8mamapnOjooIqjJTfXg9Do
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Authority-Analysis: v=2.4 cv=Tr7WQjXh c=1 sm=1 tr=0 ts=6a0b1912 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=HqcgoWIX0-uhnNlxQ_IA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 0_oSAIjkFfeKr95CJAUuYS6XHsLibpBY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfXy4Mld4PVtY9t
 1suHIgUQzGvqEbWUcWSRA2P7P3mTT50XpIK1PB2XWUAV+RMZ0DZ4bl3FYh8IScb/YhLCQ9sVc2s
 G1HF8QViC1ikz2nsP4DgtkJZ3RbSl4T1NFjweFJVoC/sFZO+i/ZodaGh30tjPzYk3vZ/74P6C/n
 M650VvPMcjWMfXTjmtQUK+oHdIQYrs+PPlQihqFI0xME+XxAj1FgNZjns4/mS6wOwBSU8P6tFLx
 vXFKtyURzseCqaO2Jly9/WzmvI9qi20nVWM4pH3BUFX7lW9BW2568h2eeCIhaZlf1RMbta9kFN8
 G2tqLEe5Vo9Y15bN+2hfCBU+9/PbcMyfa2OevMTAeudjIkYSWc+ijQ2XlRqCAE5QU4ciZKoTHOO
 0VKddZv0hg4gVPJTZFwZAW1yaj/fWyRYqVSxImiqRbOJmjpxZDt+njta1Pj88y9LO0wlSms3uvM
 hZLQ+sFGEqWedK0R/8Q==
X-Proofpoint-ORIG-GUID: 0_oSAIjkFfeKr95CJAUuYS6XHsLibpBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180134

Add support for the "qcom,batteryless" device tree property.
When this boolean property is present, the driver registers the power
supply as POWER_SUPPLY_TYPE_MAINS instead of BATTERY. This prevents
userspace from triggering battery power-saving sequences when using
powered by 12V adapters.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a23d00e97a9e6ced21d1e66fe637db6c9d..35d266375d8c46b161a64f9c2a8c6054dc2211de 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -332,6 +332,7 @@ struct qcom_battmgr {
 	struct qcom_battmgr_wireless wireless;
 
 	struct work_struct enable_work;
+	bool batteryless;
 
 	/*
 	 * @lock is used to prevent concurrent power supply requests to the
@@ -930,6 +931,47 @@ static const struct power_supply_desc sm8550_bat_psy_desc = {
 	.property_is_writeable = qcom_battmgr_bat_is_writeable,
 };
 
+static int qcom_battmgr_dcin_get_property(struct power_supply *psy,
+					  enum power_supply_property psp,
+					  union power_supply_propval *val)
+{
+	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (!battmgr->service_up)
+		return -EAGAIN;
+
+	ret = qcom_battmgr_bat_sm8350_update(battmgr, psp);
+	if (ret < 0)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = battmgr->status.status;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = battmgr->info.present;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_property dcin_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc dcin_psy_desc = {
+	.name = "qcom-battmgr-dcin",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = dcin_props,
+	.num_properties = ARRAY_SIZE(dcin_props),
+	.get_property = qcom_battmgr_dcin_get_property,
+};
+
 static int qcom_battmgr_ac_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
@@ -1652,6 +1694,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	mutex_init(&battmgr->lock);
 	init_completion(&battmgr->ack);
 
+	battmgr->batteryless = device_property_read_bool(dev, "qcom,batteryless");
 	match = of_match_device(qcom_battmgr_of_variants, dev->parent);
 	if (match)
 		battmgr->variant = (unsigned long)match->data;
@@ -1690,7 +1733,9 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
 					     "failed to register wireless charing power supply\n");
 	} else {
-		if (battmgr->variant == QCOM_BATTMGR_SM8550)
+		if (battmgr->batteryless)
+			psy_desc = &dcin_psy_desc;
+		else if (battmgr->variant == QCOM_BATTMGR_SM8550)
 			psy_desc = &sm8550_bat_psy_desc;
 		else
 			psy_desc = &sm8350_bat_psy_desc;

-- 
2.34.1


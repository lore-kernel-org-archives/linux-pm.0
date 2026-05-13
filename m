Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E07496915
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690676; cv=none; b=boowX8abYD6tv4snl6YF/TnCq2MhkmYLmLHWb80XwvO8G5K+qX3p5q6uhjPV/sIDJk6DJRRmuP1QW0ORcg8STqW76rS+vO6QccQWN2RIekEE2N7aFhcYd2wAWqDHyeFyHHMh3bSIgESEWfKzTr4TcDAYe9qCR1o3Ad6jRMSGSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690676; c=relaxed/simple;
	bh=kkkJUN2duKjg2tEPhVJygQCN5sNnHuJItWMYlqkT/wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2j7HPCxvIgqDiQsb+Zcdqy0dWbZHu/DMbzD13za1VHFcsoVwJJyDnxf1f6Ic9NMhS8At8St2eEOUpvHAd2BYBqcJdZLH0TTTx0YBceXVgMtogW3z0nsDoWppJY8FjYnC/ElJI1yo0pZRXooe2xR7u0hsut4PXaf4emZ+xmh1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lt1bVYRo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dno95X+4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lt1bVYRo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dno95X+4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DCEpuW3324667
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6NGzEn4QHnOns3GVJPYdbSr45vl6CTrSg1yOeRmRags=; b=Lt1bVYRowP5qG43u
	feMZAugbkgbmaoauVWkYsoFwKUZc1ImdfR4eUSXuqzHTyyu/EfSO07EM+TgdnuNq
	eh//W5u9d9zIpGlcl89COws7rP5oCQIOpMvfV9W7xZ40al8bZE+4CHHqbWci1mJ4
	vvOgXrsNeI3wdPxsly0eDGDa5BAk5m3rgwJwQ56q3/3RZDeZSFnG6K1Ek7Hhth1O
	WfPURlDIy9MwSQNijroZCoQQsIn6o8fD5mHkRI5imwNG6nVclDfeH7uMGHE7PIfq
	P14RBWkDbTz8v86ehMAl0ecGaB8VtqZCD0lY4w6Mmu76EG6yMy7yQeZlVjghSVJz
	TenaQQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdafy6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1306c2f7037so7287843c88.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690671; x=1779295471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NGzEn4QHnOns3GVJPYdbSr45vl6CTrSg1yOeRmRags=;
        b=Dno95X+4dAAbAtOljpzbj1whuom2URdAHtFXndkbUbxPDQkvU6ABEbdvWEpta9/p+Y
         9ouGhYrpDFrxbyxXHhf7qq3WDvRTl+TJ07sKhiYtuChRelmKWXt6n0Sh+kgwI8G0Ui5R
         hsC3KnJKNR22r63s6VazhHmAIbJPQlSUoutc5896123sJjDuXTSpR1IciEFk4P9OVsPa
         Qk9+myo5Cdh4fEbxfGWQS9cwYfbJN90jeuAvPlXMc8VCMT8ygm6wlNeBs0Ew/R7vL9Ku
         YW8X/FBbsVr8fN0LADlf94jfcCO7wH2jiSp8pmvyewAj51r7rw0mHkqmhTZOuVGG6JRf
         fjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690671; x=1779295471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6NGzEn4QHnOns3GVJPYdbSr45vl6CTrSg1yOeRmRags=;
        b=fN/zbdUir3oNL0Ok7g3J9jxHwjDBcrZ5G9lLJqZCgUL+DDnm3/khdJVdO+aZZCr6WT
         O3XzU81XJn0DNTyytv5bRn7i4TMykz/3xaL6Zwcle4fDXbpM6A3GpiU8Z0CauaKX+xOo
         DPj5KJn2WgXhpUhsQ617Z0ouJzraOhghKaHGfHDgfKOHPgUAMFuzdI38PxnTcgGhO3Q5
         C0rof8s46ZoH34PKcE0Oeu6KrIxvpu7q3UiM85gCZpBkfK7bvm0nomSHVgMJuLJugWYQ
         CjkEdR5C01orRqCNcyo/+r6Pg1JtDAvKsu+bAE8iPUb8iX8IOnw2yQZINbFftnxFCn/r
         3ZDw==
X-Forwarded-Encrypted: i=1; AFNElJ+SlNp1FwbJWYN2zuBmLjBvHcq8hctX9H2/VSfbPccZ7r+22xbva1t56RGEPTV5+TQf/TdskCHIgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxPxFoUb4q3qb4kL0zV81f0DJaMn4kPM2okAvtEiPFKatjYEFd
	9wOJAHVYr8vdASYSp6mDhPy5Al2cnV5X7vswvJfyUuWILdF0PZlmqBDdpP1+1858Fg7XjL7vmjM
	8pXJI3WUXH0NcRO16/wrmv+yaHrfuzk4fberdch703o2rFUaeE4OOG3aHDtPdZw==
X-Gm-Gg: Acq92OGHxSZvtrzZAS4kVNgsXcYp5hZpH7wPScmwzBXz6PbPc7Leon/L4CYqJt0JxKH
	Hr6TH2RrqKBttfxTy1xEh3Y2iEfBrwBvViMcf3u1J8wgdE54N4a/4SB9M97ScJU1nVGU19yrXQa
	DRjWXuh2Pj6pIr8jUeHIfp+gcvDbi5GoWQW2l1/0Mk2ULSAwJKr2UXq+ePWaoRwXx+HbExCoWAY
	1txNPKbYuaseS6nTAH88aEFv07A2CDXuDsOdQqK7hnpzNmG7l3otb7lXlYNNrsPNSlsVC9SJp8X
	N77pBWqmzR78K57Jz2/kQn4CsWQHRrCOwDViNi6PczsuHAsb4aAddYjegVfW8G9nxzgNYJre6PO
	EvC9DtIbZ+MZjYg+Vp9/JY9UqSNcihWgeu/6yoB5hmhUFxdrOxrIERKBfHVGT/ePawC5UpZk=
X-Received: by 2002:a05:7022:ec88:b0:132:956b:3c6 with SMTP id a92af1059eb24-1349ad870cemr2111972c88.33.1778690671486;
        Wed, 13 May 2026 09:44:31 -0700 (PDT)
X-Received: by 2002:a05:7022:ec88:b0:132:956b:3c6 with SMTP id a92af1059eb24-1349ad870cemr2111944c88.33.1778690670855;
        Wed, 13 May 2026 09:44:30 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:30 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:44:22 -0700
Subject: [PATCH 4/5] reset: reset-scmi: Log number of reset domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v1-4-00b47b1be009@oss.qualcomm.com>
References: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
In-Reply-To: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690666; l=1391;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=kkkJUN2duKjg2tEPhVJygQCN5sNnHuJItWMYlqkT/wc=;
 b=+zDDnh3MxrImSIBbNC9dHdn17TxKkBrO3UxSfoKVDiRqAoPHX67PJnTILBR8G6xc1OVPmBa9v
 QzLeLBss5/3DRkX2f8GlrLsX4oJLNM+GlL2wId5D0DyBXYzzWOZZr6I
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-GUID: Iz_IKGruS6eN19wvAGfw24MfhOrRjSg3
X-Proofpoint-ORIG-GUID: Iz_IKGruS6eN19wvAGfw24MfhOrRjSg3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfXwgUxNC4fMj/O
 TK1v5ZFnAgdjnR8XpirYTJ+Zup1bLkPSoZ32U+N9/UoXLnpgbLu07vk5CDbDm5NZizR/HcBKS8X
 +AWmKbdT3c3lnxqkRjQDDMdM4HVE7AMiuYTkTvvkDc04GQK4w33j4cxUMkJnYbqRY1UrP6P/u1M
 pZVENT7voErQnr35kny8WugbZDue3SGGHlsJIMNR3TcNDa7fSkCRctaFeYXH3lmIspvQ63TAfxk
 n6lKXOLkAIbYKhs6sNkjR+DQuKX6i8om+hWXIZ67Oh4/MwJ8iqYcesBkPRwTaBG5Vl0i8qgiHKQ
 BDfRIndOXwBd8dVSs5TNzmMZn5tPfwpDGyxogr5kNujtl6Zw+btC8qR9vc/FrNNbf6hoF5yZzV4
 w3z66MYw2Zl7WV1CMfdhuBS9s66A44JvuClYP/fABEjZjxf4m5PWNRoGTs7ukZZwKXh/KFZNYI/
 AXaK77d5053nb+Y7fPg==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04aa70 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=wud5Z5ZUIjVBoUaN5zEA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130169

The SCMI reset driver does not currently report how many reset domains
were discovered from firmware during probe. This makes it harder to
confirm the firmware reset resources during debugging.

Log the reset domain count after a successful probe, aligning the driver
with the existing SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/reset/reset-scmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index 4335811e0cfa..f26fad0dc726 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -93,6 +93,7 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_protocol_handle *ph;
+	int ret;
 
 	if (!handle)
 		return -ENODEV;
@@ -111,7 +112,12 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	data->rcdev.nr_resets = reset_ops->num_domains_get(ph);
 	data->ph = ph;
 
-	return devm_reset_controller_register(dev, &data->rcdev);
+	ret = devm_reset_controller_register(dev, &data->rcdev);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Initialized %d reset domains\n", data->rcdev.nr_resets);
+	return 0;
 }
 
 static const struct scmi_device_id scmi_id_table[] = {

-- 
2.43.0


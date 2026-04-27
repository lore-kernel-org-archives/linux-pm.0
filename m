Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56930DEB2
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311397; cv=none; b=AkWXVoTp+leOVQSikXfpTJNK+fqj8Og4vVWTXWbUUiz80gTYH6kB998KObULn9HUNabw6+TyUnAGZPuRFGujDg0pwcQWtyl6yeufG5KsJ4GmkYtiKHyeGBZaJNIxOe9MvUbYEOakEuF9ZTkDDZsVvQCxAxj4ZBNGfXZkFPx/P1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311397; c=relaxed/simple;
	bh=fNH9qCYe4Y0NmzftG8HGe9p8tkk1iIJgMKEMMVyfJQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTHMyyJUskmroStjqPvgvvHVTxzIlMlFhGr2KFwo0hiDB4kjEn2zU+aP80Zz4nU6oufzIYci5SX/cJjeuLS2vDJ3QgbRUO9t/YlkJUwqpFNIMpcNtxCyRAVZ0fC1v/j0Q0ijeAIxBIXp4zlJKVT132Jseoh0C4k9DA4bQIFUzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T12Xypqn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JOWHG9GV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T12Xypqn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JOWHG9GV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RCpC132383072
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mTylmpgaZ0jhgYjEQvu43uNWIUtaitxie7wYdhQCPmM=; b=T12XypqnQnquQ8mC
	ng1tcHHYGf3IDDJ0HFnTlGkA0m4XQU3DRNKv8t+IFWYJJSaA8EYdx+pQKyJgIkkb
	QYb+aTcPHcmLzZMN/+saSCSmi8+bAa5wu//Xvpq6sECD4pgbLPw/zBavv6wc6AeQ
	gojy27n40JkkXRLDuqf/HBrVM3HGIntDvAeyAdTDXGF5OqEUSez/FB6nR/5oOGAA
	QEt5bTJ8XiTvoLLXBQ4sMF8QVFf+5tuL35rJF2OjSvM0jo0QDvJfPZ9q1o9VFnl/
	rt5RZYkzo2NJqlxK38YECYUl6WzlrGcYM3z7ESuPPl3YHQPUjDnqaaGUNg/jbFUU
	2WCB7Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt85xs4cw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2d83e7461so179373555ad.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311394; x=1777916194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTylmpgaZ0jhgYjEQvu43uNWIUtaitxie7wYdhQCPmM=;
        b=JOWHG9GVEQLyz41T7jjOsUpXyE5v24UbowPqvQca/XDDos2I0GLoobJCx2EEMdyk2y
         c9adcnSr2B7Osn3EuPjAkRb5owr47cHcclW00UwYkbB1PlaC/61YQLkHUeDVyBLXsWUC
         JdMKecoZqHHuc2Z4nBkwlVGDKCOZNvLvvdHm8NZwOc75+sUk9wARk9ZQxHMgx3Di6uai
         e3W4gNBpgyBmzTWHK1mhSWch75sO9fxfD++aG/GfQa8butlFITqVBwcfb8bd9wTYj77M
         L0djfrfYyHkdT/LozYfcx8gAkYhEG7evKevLPAdKRWr2xZp6018iCBsOmZE2SzkQnKYo
         rLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311394; x=1777916194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mTylmpgaZ0jhgYjEQvu43uNWIUtaitxie7wYdhQCPmM=;
        b=K3nDIYSaTrY1DOm7MeSkfCUvVfadhDSfASCGHK48sn7+fiWfBjvXezbWmfTJ0tcc83
         6s3G/oBY/USOBMDznTECoZ32ARD03pGqLk80pKPIWFhB/ESRRHvva6vSCyEUi+3O8Fbq
         TOKSJI3N31KEmS2hQ9BvncyrYg6VsrcOWJdisX9bPdlUg2uzLyq6/MaGebHbdte8a+ty
         C7kb+I7TyEzKAuuloMVrJSzubp6CCImEuDNnquioErbmDj66uaBqBk6H6Y/+mABWE2TZ
         p+bYykLl2O1Uuq1hqxErGMz25A/Fhng7pnoljjfHOTVfC0zTuqERf0BotnRjKgAAfIyJ
         fl5w==
X-Gm-Message-State: AOJu0YwDguDh3YplTNRFZcGn/Fds1QfKlZj0wFXqHh7a2f9dLvlUlZlt
	ODNEa07EJyxv6tpLHWqWEzfZjj0GhpuzicghzgDMgm7vh3HMcCpoo7uhQvuTfa3QJjxi/Gs0QH/
	ugw2rHEo/pdzyjr8e+dzEG41Riqh4ckylz5mPH2ffmnvo4465vyQEp/QuByszqw==
X-Gm-Gg: AeBDievjeEB7ZYMgTZUFwq6etenpB44XItZiG4ypLuOdJiO4ovs9KQlXK6SjnVXQ5wv
	6DRDSOeXOaasp7oeA5vYllio716jUw9jlfaJdWG0Vwq3956z+cvGX+BFrtjuj+yD9EfPI9J5TTj
	j9l6OiRVs9dxpEXAVlQ7bf62onD+fc6sAq+6vhRoEgVc0DeeY6t+pxJOIuC1j9aZ9hfHabMWm7T
	PX5NR+pGFhk2iF40UsCGb6r9STvnb4zl7x1tfDMr2fI90Z2Z9JtrCl64dVHmS8XkxkPbXsZweRg
	8gtghjQXasii0lab3BWyll+yxgeYiU7UE/UlEd74hftT76W17OZbGmBDErP53IEBiAI5i2vQFt6
	DV8ITMCpmzqYHCTXcB8alfH6We/KvLF3OkvyoNQghFhMfzwz8U9lgxlGUvL6ujoaS2Efe
X-Received: by 2002:a17:902:968a:b0:2b2:5091:1c0a with SMTP id d9443c01a7336-2b97a97d026mr1052495ad.41.1777311394476;
        Mon, 27 Apr 2026 10:36:34 -0700 (PDT)
X-Received: by 2002:a17:902:968a:b0:2b2:5091:1c0a with SMTP id d9443c01a7336-2b97a97d026mr1052025ad.41.1777311393841;
        Mon, 27 Apr 2026 10:36:33 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:36:33 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:48 +0530
Subject: [PATCH v21 08/13] mfd: core: Add firmware-node support to MFD
 cells
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-8-dcf937775e73@oss.qualcomm.com>
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=2427;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=fNH9qCYe4Y0NmzftG8HGe9p8tkk1iIJgMKEMMVyfJQY=;
 b=ZRQqaXwPk9eM6B4nM1bogpDoTT6JjboYi/afKdttQA9pSYuU0vd20Tg8Ykkl7Zc2sqmXOR127
 TjkQY84p39bA3wuq+0W6rtvlHbI8XeqZqvU4Lvz1j5Jn7/SwHMWXP5G
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=Zs3d7d7G c=1 sm=1 tr=0 ts=69ef9ea3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JnGLTex25XOQSkTSfOwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: y0soBeSj2Li8baAn2T-l8q94dZKa71C0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NyBTYWx0ZWRfX5DqpPHo91N2l
 8/u2RtpidZrJG6hxKruJF4McPgUof87Ouv1ruCXpUpxOrCfbqJURU4uFY5WXB/4ACw/8/nPmYRA
 C40pVREuiLS+yB9F13JdqpS+ijvXdPzCRxrFpNNi82G7vSdsCu/ky02qP+zUL5DhVcbp1IfkVh2
 zxCTgZjRG0sk3E+PIX0aOYXwx6xbUtVWI8PztEqLmFds85lKV1zOBOimYJc+ndsUVib6E2sitOk
 ldaYdM1+c42i1VUtft0/802Oi3GFYrQR07Hby4XcoUM/6orKMTHRNGAXzZ2xEkQdx7/5m9sK1+l
 Sd2Utz3Zx37RgiecogXtm6AajbjxCmV5svq4sM+esIBhfpohTpkqmsXQ5pO+Jd9apTllj9i7aqz
 GNscLI9gaBdNtTRNgfi2XjEivudquQVCp4IHCXVO2bH7c5GCxIJzEd3KEz/kJ5qlB/WvNdXwF/8
 QncE5OmzCeCtS7diYvw==
X-Proofpoint-GUID: y0soBeSj2Li8baAn2T-l8q94dZKa71C0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270187

MFD core has no way to register a child device using an explicit firmware
node. This prevents drivers from registering child nodes when those nodes
do not define a compatible string. One such example is the PSCI
"reboot-mode" node, which omits a compatible string as it describes
boot-states provided by the underlying firmware.

Extend struct mfd_cell with an optional fwnode pointer and attach it to the
child device during registration when no firmware node is already assigned.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/mfd/mfd-core.c   | 10 ++++++++++
 include/linux/mfd/core.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 7aa32b90cf1eb7fa0a05bf3dc506e60a262c9850..d2153d9b6dd75a5f55d232ba87bd9e4abc93c8be 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
+#include <linux/fwnode.h>
 #include <linux/list.h>
 #include <linux/property.h>
 #include <linux/mfd/core.h>
@@ -224,6 +225,15 @@ static int mfd_add_device(struct device *parent, int id,
 
 	mfd_acpi_add_device(cell, pdev);
 
+	/* Use explicit cell fwnode only when no firmware node has been assigned. */
+	if (!pdev->dev.fwnode && cell->fwnode) {
+		/* Get a refcount if fwnode is a device-tree node. */
+		if (is_of_node(cell->fwnode))
+			of_node_get(to_of_node(cell->fwnode));
+
+		device_set_node(&pdev->dev, cell->fwnode);
+	}
+
 	if (cell->pdata_size) {
 		ret = platform_device_add_data(pdev,
 					cell->platform_data, cell->pdata_size);
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index faeea7abd688f223fb0b31cde0a9b69dfe2a61ff..8a461b43fac360672a489ffffeb8d0e1acd193ac 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -50,6 +50,7 @@
 #define MFD_DEP_LEVEL_HIGH 1
 
 struct irq_domain;
+struct fwnode_handle;
 struct software_node;
 
 /* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
@@ -80,6 +81,11 @@ struct mfd_cell {
 
 	/* Software node for the device. */
 	const struct software_node *swnode;
+	/*
+	 * Firmware node for the device.
+	 * Caller owns the pointer; mfd-core takes an OF node reference.
+	 */
+	struct fwnode_handle *fwnode;
 
 	/*
 	 * Device Tree compatible string

-- 
2.34.1


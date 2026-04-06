Received: from outbound.mr.icloud.com (p-west2-cluster2-host6-snip4-6.eps.apple.com [57.103.68.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB04303A37
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509107; cv=none; b=uBPI1TQXo/66IaFf1D49OwUAAV/2ExI3y2hcV91ywO0saBRj+c4+nQUZ7pIwxQNtKNVzvcGhTeMG07l/SfrnCpHFepGT1cJdPkeg5qCgaCtSdZxDKil8gtSOiPn96sp+ZOkRoqcU8vjT2zbe42uQ//SxtO3+XIJU1uc6RJ8jJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509107; c=relaxed/simple;
	bh=NIdsf/+UlVU88X02JBQtH6zsr2WPK+T9TiBI1Ds9r+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8WzvVKNB4+SWZg8UZzHcQiqxBebxRk7xS69Z4w7pJNoRHb4JzfUhzRl5Szt+IPLDODnbr0KDeLX50Tf5hhpKsoctgGKoLByfdF0Xt9nU+eYi8Opco4+wPg0wHLU0uMdIubZj6FQiGrt2FuF3ZRZYuyrLlQvymHttO0iGzOmhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LRZwibZ3; arc=none smtp.client-ip=57.103.68.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LRZwibZ3"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id DD1DA18000B6;
	Mon, 06 Apr 2026 20:58:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509105; x=1778101105; bh=Bkg+YlbK3ciRSIn7lWu7NMbXCeb6k1ioPW3OqWnAHGI=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=LRZwibZ3GXHbU2IklG3YzzaDFwgZnTbxsXs8HhJdX9l3ruzdyaYJU0WfUZA8cP1f5XR0W9VkwunFyCZ2guYBwdZB3sSzteJy9PKJpfpfeqWZgtexLI7VMN/MXwizRXlUhmCRtau6rGPW2+J1Zoeb6hmbGIyiEn5kDqAnfPD/7Gx5BDagqZ4gdMyzVJngOc5fmCrEAbFdEA/0uylrCEM0qGkW3SPhQ1gfz002rzZZk/ZWxEPhEl1irLbiaXC8ELfkPVdPDnakXJ5ieEtpohKEVLDKlizQzTBWfy2CtTnXjyepN9oKLEOrsLgALWXOB25rbMseMSysSzYWtpGGwF2j/g==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 477C0180026C;
	Mon, 06 Apr 2026 20:58:21 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/9] power: supply: max17042_battery: Put LSB units into defines
Date: Mon,  6 Apr 2026 16:57:49 -0400
Message-ID: <20260406205759.493288-2-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406205759.493288-1-vincent.cloutier@icloud.com>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfXwsH6NEEC2u9y
 Xl/2REPjc4yz/n2gBoEuDnLyL0wv1tFiMEMmLcnq5szC1etqwq49dX6Qlwukm4Mjb6wuyYuZY4A
 XefeXnQcR2wxG2Bhv3UIBQEhyg4BRfT4q6efA6sf6Pty1Vmm1+VZtjFDY5PHK+liamMz4nBTPk5
 E2oaCatf1ua9bM1n+lX2GIK4VG9pDw/nhS8DRI7DU1Z1QLJgH+82c+HgvpcoKDjbqPvVlARjdUT
 OeTc0r2HgnoVO+8F8CZv6ylaaWozXhOX63DE+mQqMyDpHzPiidhe98zgYm8vG7o1NeroqEMeSfK
 v+o9YdrVomAHIUhpekzbXlKbKGmT/QEUYRJh49UOZ3Zz7enmYeokhN2aUEV6vQ=
X-Proofpoint-ORIG-GUID: DVcIh8YDvTTHGuzTgdrOiYIWQMQas62t
X-Proofpoint-GUID: DVcIh8YDvTTHGuzTgdrOiYIWQMQas62t
X-Authority-Info-Out: v=2.4 cv=HYgZjyE8 c=1 sm=1 tr=0 ts=69d41e6f
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W7wRznvd8wUDW1vWsjEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060206

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 36 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index acea176101fa..a6798b9a1c82 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -52,6 +52,13 @@
 
 #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
 
+#define MAX17042_CURRENT_LSB		1562500ll /* 1.5625µV/Rsense */
+#define MAX17042_CAPACITY_LSB		5000000ll /* 5.0µVH/Rsense */
+#define MAX17042_TIME_LSB		5625 / 1000 /* s */
+#define MAX17042_VOLTAGE_LSB		625 / 8 /* µV */
+#define MAX17042_RESISTANCE_LSB	1 / 4096 /* Ω */
+#define MAX17042_TEMPERATURE_LSB	1 / 256 /* °C */
+
 struct max17042_chip {
 	struct device *dev;
 	struct regmap *regmap;
@@ -105,8 +112,7 @@ static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
 
 	*temp = sign_extend32(data, 15);
 	/* The value is converted into deci-centigrade scale */
-	/* Units of LSB = 1 / 256 degree Celsius */
-	*temp = *temp * 10 / 256;
+	*temp = *temp * 10 * MAX17042_TEMPERATURE_LSB;
 	return 0;
 }
 
@@ -183,7 +189,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto health_error;
 
 	/* bits [0-3] unused */
-	vavg = val * 625 / 8;
+	vavg = val * MAX17042_VOLTAGE_LSB;
 	/* Convert to millivolts */
 	vavg /= 1000;
 
@@ -192,7 +198,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto health_error;
 
 	/* bits [0-3] unused */
-	vbatt = val * 625 / 8;
+	vbatt = val * MAX17042_VOLTAGE_LSB;
 	/* Convert to millivolts */
 	vbatt /= 1000;
 
@@ -299,21 +305,21 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 625 / 8;
+		val->intval = data * MAX17042_VOLTAGE_LSB;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		ret = regmap_read(map, MAX17042_AvgVCELL, &data);
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 625 / 8;
+		val->intval = data * MAX17042_VOLTAGE_LSB;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
 		ret = regmap_read(map, MAX17042_OCVInternal, &data);
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 625 / 8;
+		val->intval = data * MAX17042_VOLTAGE_LSB;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		if (chip->pdata->enable_current_sense)
@@ -330,7 +336,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = data * 5000000ll;
+		data64 = data * MAX17042_CAPACITY_LSB;
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -339,7 +345,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = data * 5000000ll;
+		data64 = data * MAX17042_CAPACITY_LSB;
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -348,7 +354,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = data * 5000000ll;
+		data64 = data * MAX17042_CAPACITY_LSB;
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -357,7 +363,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = sign_extend64(data, 15) * 5000000ll;
+		data64 = sign_extend64(data, 15) * MAX17042_CAPACITY_LSB;
 		val->intval = div_s64(data64, chip->pdata->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
@@ -399,7 +405,7 @@ static int max17042_get_property(struct power_supply *psy,
 			if (ret < 0)
 				return ret;
 
-			data64 = sign_extend64(data, 15) * 1562500ll;
+			data64 = sign_extend64(data, 15) * MAX17042_CURRENT_LSB;
 			val->intval = div_s64(data64, chip->pdata->r_sns);
 		} else {
 			return -EINVAL;
@@ -411,7 +417,7 @@ static int max17042_get_property(struct power_supply *psy,
 			if (ret < 0)
 				return ret;
 
-			data64 = sign_extend64(data, 15) * 1562500ll;
+			data64 = sign_extend64(data, 15) * MAX17042_CURRENT_LSB;
 			val->intval = div_s64(data64, chip->pdata->r_sns);
 		} else {
 			return -EINVAL;
@@ -422,7 +428,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = data * 1562500ll;
+		data64 = data * MAX17042_CURRENT_LSB;
 		val->intval = div_s64(data64, chip->pdata->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
@@ -430,7 +436,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 5625 / 1000;
+		val->intval = data * MAX17042_TIME_LSB;
 		break;
 	default:
 		return -EINVAL;
-- 
2.53.0

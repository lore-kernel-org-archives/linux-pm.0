Received: from outbound.mr.icloud.com (p-west2-cluster2-host9-snip4-2.eps.apple.com [57.103.68.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C0331211
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509108; cv=none; b=JOvt+/8E1TUCZ/A+suLkYUEU/Ubi2hJY2flSZHWRD4FrRjaShDkHJqChlw0CMN8IwRZ+EEq+DVjOe+yovPB5YN4y2r6B+gnlTBiiSjR1OT7if9bvDIl1jbmpft9/w03eJgPx1mLPthVkf9V0rWKY9NO87j8bph0AnqrBxSity7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509108; c=relaxed/simple;
	bh=myHEVijARbnp7nRMm+XiWNLpo5RW3o/BWlvp3zvsJz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jg0TZB7aORWKsUnD2H6ynULbvyYPs4c+JbailbGQogbuUiLxhWL8adX5PU2Y6PH6DhKOYQxzeTyAHWVjZvcS9V1rgbK7ds8Rgc8gb1/MqcirxQF22XASzJ7zNhM42DCqSYcVltl6YDGHB8CuPgwdTrCBswpHRtfADKrgw1M67Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tgO1MKKw; arc=none smtp.client-ip=57.103.68.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tgO1MKKw"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 9C5E01800136;
	Mon, 06 Apr 2026 20:58:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509106; x=1778101106; bh=BCnkB98xRcAiOAj3NRuaa+fDwY+UZhu1uE7YhN9ZvhU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=tgO1MKKwO5Kbcs5v+cPtyQffClswmXAmkqEjgH7CJfJqT+1AY0BmEG/NT9txscxQVa5AYlGRD8Zgh5XMWYRulUVEJJJH54PXVH+6XnJlUqI1ZqTSerREYPcaDc022lBZqPuDhlHrHCCR6JXofLVIXhuUzAkDbBUWOosB3Oc4HeBnsTlX6EvmZh/i7AbXhH3BeRvpfgtO+NYSnVafwrhrxTNLrN6rg3oebHcVYtwYNAde0QNIrVD0XQ+JSpQVNvjDu32eaSQlZuhcv5+N+OJRlmcOoyaX1qHSpYlcospzjsrHbYBLMQgbjLDgV7HP8v/j4MpFzTIFUR8NGk8xwtGp6g==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 8E9C9180024D;
	Mon, 06 Apr 2026 20:58:24 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/9] power: supply: max17042_battery: Use Current register in get_status
Date: Mon,  6 Apr 2026 16:57:50 -0400
Message-ID: <20260406205759.493288-3-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406205759.493288-1-vincent.cloutier@icloud.com>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=afdsXBot c=1 sm=1 tr=0 ts=69d41e71
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=2ivLaHuQe1mDuBazr-gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfX6ioobDb9VplX
 Ksgr7jbJXWhKpfNDmRYWIFM8ipSccMAl3BjwlY5TdO4hmiIiU/RVtokQmClo5fFpM/Kgbs4GkMA
 fR7nMvcBXGQ6RybGndJYpIdXXTdGBj+rEyLEYYXy0g8nBpwMWwaSct7OEuFzrCwUbSJWPz6ZVvg
 AUmITnGHH64hHVLLcjijx9XIHXyaa5htPgMKDjrOjELM6tLf6dIZs/zQJWgP4rzh/0kg/N8AOVI
 eq3g8G38uIpgfFgdBaQbGyndJ+4dI15Z3CtZebwBApCTEfxONxDv7eDVvTzu6CRmfthd8h/7dAy
 vdRuxef+73rEYxrlTtLMwZpnjbjhS099MZNu4DeC5Sv1IwAaO2EsZjW9Bv6CvE=
X-Proofpoint-GUID: xJFKb-wfqMqjVlMPbsNJO2kqmXBE3boa
X-Proofpoint-ORIG-GUID: xJFKb-wfqMqjVlMPbsNJO2kqmXBE3boa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060206

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

It can take a while for AvgCurrent to adjust after (un)plugging the charger. Use the instantaneous value in order to not confuse the userspace.

While at that, don't do unit conversion of the read value. The current code was prone to overflows and we only care about the sign anyway.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index a6798b9a1c82..ddeba965ab5b 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -119,7 +119,7 @@ static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
 static int max17042_get_status(struct max17042_chip *chip, int *status)
 {
 	int ret, charge_full, charge_now;
-	int avg_current;
+	int current_now;
 	u32 data;
 
 	ret = power_supply_am_i_supplied(chip->battery);
@@ -164,14 +164,13 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 		return 0;
 	}
 
-	ret = regmap_read(chip->regmap, MAX17042_AvgCurrent, &data);
+	ret = regmap_read(chip->regmap, MAX17042_Current, &data);
 	if (ret < 0)
 		return ret;
 
-	avg_current = sign_extend32(data, 15);
-	avg_current *= 1562500 / chip->pdata->r_sns;
+	current_now = sign_extend32(data, 15);
 
-	if (avg_current > 0)
+	if (current_now > 0)
 		*status = POWER_SUPPLY_STATUS_CHARGING;
 	else
 		*status = POWER_SUPPLY_STATUS_DISCHARGING;
-- 
2.53.0

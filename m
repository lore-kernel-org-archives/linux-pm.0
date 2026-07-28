Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56E153BE9;
	Tue, 28 Jul 2026 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206779; cv=none; b=duUuzopzaF+7Pmm54FG3f1pAW386XR9ABUqqXC8Gn4CtMdVM4S4+xmK6cjuVeokfykjpFsy51kD9OqBOVrVVDT/LjQ87/MTfPGIgpo+ky2XcNDna+UnUa6E33tqc9b5nyEi5yMLnzaLLXpcsAAo1b0Jz7c5TpmqUKHL1utKC7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206779; c=relaxed/simple;
	bh=uxYNviuNv8xDiggHOWL/Lw7LSSQ8hcOaMRm4WUCy/GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goeXovZBfttVGQwKjtUH66nc2W2R40edCnnDx4ZGLnVEjQP1Pi5xH0kN31T340fGQkY2xxvSm8Tzl1Wvk4lbw6yH5RHAy4SPI6qxiLv7dN4uCvOqr5GHDOBTp1YinwEZZzHaerrAegEw9WSuKKx/j+9VkhacAFMVEGt0brckWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7c6af6bc8a2e11f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:92870a9b-9878-4884-afcd-03e17741e21a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e785c7049938ccc3253ea488074da439,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7c6af6bc8a2e11f1aa26b74ffac11d73-20260728
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1378301874; Tue, 28 Jul 2026 10:46:08 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v2 2/2] power: supply: bq25630: Initialize hardware before exposing the power supply
Date: Tue, 28 Jul 2026 10:45:58 +0800
Message-Id: <20260728024558.3611522-3-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728024558.3611522-1-lilinmao@kylinos.cn>
References: <20260728024558.3611522-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bq25630_setup() resets the device, disables the watchdog and programs
the charge limits from the battery information. It runs at the end of
bq25630_probe(), that is after the power supply has been registered, so
the device is already exposed to the system while the hardware still
holds its power-on defaults.

power_supply_desc::init runs during registration, after the driver data
and the fwnode are available and before the device is added. Use it for
bq25630_setup() and drop the explicit call from bq25630_probe().

The callback is passed the power supply, so take the driver data from it
and use it for the battery information as well: data->psy is only
assigned once devm_power_supply_register() returns, which is after the
callback has run.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/power/supply/bq25630_charger.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/bq25630_charger.c
index 9b5f524505d3..2f6878ad0033 100644
--- a/drivers/power/supply/bq25630_charger.c
+++ b/drivers/power/supply/bq25630_charger.c
@@ -665,8 +665,9 @@ static int bq25630_reset(struct bq25630_data *data)
 	return 0;
 }
 
-static int bq25630_setup(struct bq25630_data *data)
+static int bq25630_setup(struct power_supply *psy)
 {
+	struct bq25630_data *data = power_supply_get_drvdata(psy);
 	struct power_supply_battery_info *batinfo;
 	int ret;
 
@@ -684,7 +685,7 @@ static int bq25630_setup(struct bq25630_data *data)
 		return ret;
 	}
 
-	ret = power_supply_get_battery_info(data->psy, &batinfo);
+	ret = power_supply_get_battery_info(psy, &batinfo);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
 				     "Could not get battery info\n");
@@ -752,7 +753,7 @@ static int bq25630_setup(struct bq25630_data *data)
 	}
 
 out_put_batinfo:
-	power_supply_put_battery_info(data->psy, batinfo);
+	power_supply_put_battery_info(psy, batinfo);
 
 	return ret;
 }
@@ -975,6 +976,7 @@ static const struct power_supply_desc bq25630_charger_psy_desc = {
 	.get_property = bq25630_charger_get_property,
 	.set_property = bq25630_charger_set_property,
 	.property_is_writeable = bq25630_charger_property_is_writeable,
+	.init = bq25630_setup,
 };
 
 static int bq25630_probe(struct i2c_client *client)
@@ -1047,10 +1049,6 @@ static int bq25630_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
 
-	ret = bq25630_setup(data);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.25.1


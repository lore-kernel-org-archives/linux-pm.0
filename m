Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC063EA97E
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145074; cv=none; b=jqK9GxpawCLd60HgwADM5fnx9zifHSIde8iEoA3wZUwTX9SgPkcnjZ/xFyrcHAnWv6lqJuccJmrqCMwB5dcaQB2wZlToqrejdJmqEe9H7QAR+YM4YWVsVtYj01IYNAe3fCRxMEncMYS5qdCpsaHgLmnzY2S5SDjXMshjsGJit+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145074; c=relaxed/simple;
	bh=HpZiVHx7omNO62mDT2XGc30Pta7dFub+R2iPn3/lkak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EwQYrq4jlqDupgMG34KINK/4iBYZZQXET2AGLJlBE5ImpWyEzaCsyUoMpG895VoOptPWVhfnFTlDGd7bU73LWkMpS0ofeQf9dV2GeuML4IiKS5sIapZ3aMG8w60vMaxmrOrOu51obLf/ned/S/sfQAY5leBEfl09snlTDqQBLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d136d868899e11f1aa26b74ffac11d73-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dc6ca292-4e80-4509-88e9-8ed912aa8bc0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e1e57063c3520f5b646a4c43f17d0fb7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d136d868899e11f1aa26b74ffac11d73-20260727
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1106183537; Mon, 27 Jul 2026 17:37:43 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	linux-pm@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] power: supply: bq25630: Release battery information after setup
Date: Mon, 27 Jul 2026 17:37:38 +0800
Message-Id: <20260727093738.2611185-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

data->batinfo is only used by bq25630_setup() to program the initial
charge limits, but power_supply_get_battery_info() allocates it on
psy->dev, so it stays around for the lifetime of the device. Nothing
else in the driver uses it. Release it right after setup, as bq256xx
and bq257xx do.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/power/supply/bq25630_charger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/bq25630_charger.c
index 165f8c67b4895..efcdb1f5bc351 100644
--- a/drivers/power/supply/bq25630_charger.c
+++ b/drivers/power/supply/bq25630_charger.c
@@ -1045,10 +1045,9 @@ static int bq25630_probe(struct i2c_client *client)
 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
 
 	ret = bq25630_setup(data);
-	if (ret)
-		return ret;
+	power_supply_put_battery_info(data->psy, data->batinfo);
 
-	return 0;
+	return ret;
 }
 
 static const struct of_device_id bq25630_of_match[] = {
-- 
2.25.1


Received: from outbound.ms.icloud.com (ms-2005c-snip4-1.eps.apple.com [57.103.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252925B0A6
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114884; cv=none; b=D3HOZ5RIL8skSjlUTiae4ltia0tbUY+ocARXZiudjUVFm5lh/vzrpbN9OrD7qt9GDe5cx0EXz8Qq/sPZOn6/qJLDsPAqK0OOY03k3luTHEHMyOofoxkbN4BSMzHQ+LmnXs+eS2Cnbepvg1VfK93taX+/3Ijw4kJE9d8kWSGxkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114884; c=relaxed/simple;
	bh=oIIKnhZPl/RxMTYgu5psiW2+0lBdf+ZYGF7Y+3I8gCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfxOopdAGXNy4gozYZsS6elNZWpwN3livlE2WenrU5TnEKUpr68oQfNgpHbz5LIOIedBm1/f+hk9b2jWPF26+L4jSvrzcG2T94CKAW6sQ/MfqFh2v95pXXZa4QWNSGefI7g8CyjpM3mo9Y5adYsHYzzmGo47oFjnhZDoGgPjTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vtDYT58f; arc=none smtp.client-ip=57.103.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vtDYT58f"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id 7C27118000E8;
	Mon, 27 Jul 2026 01:14:40 +0000 (UTC)
X-ICL-RepId: 019fa123-69c5-7915-9dd4-ea87b991aa40
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgddTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114882; x=1787706882; bh=ErlkeimelXWoIhx85h5keM9S4fkBfW7W0Ph0NXu0PTg=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=vtDYT58f8qw3Wk2ZgzY9UrjMHLuPVp5oqyPrxXk+okA9GyrmI0R2Ys7Yy23GPwXvspmKnbVOzeVo3iqwN9U6wEgB2uCKI8W96XEwl0bSRXVA0HlfGqS6zQFe1juSYrdPxPmVYEcyOAWekVztLi208vqoG58f+uE72FbP8r3YM7HSEs+1cPeurR6bJFPShL4gUpWmF/hYzjCAyzd9G+drEKUIbVWPokN87V6zVelCywo4zflCO5Vgcv8cilOzjqsIj+XmD8wE62fFYdnnh030e5CRDVwV5AMLhyLJySSMM5NKEE6OM6gwFvohvG3o40vgKPZA0e8E1KfcnqeE5mj+iw==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id D0BE51800109;
	Mon, 27 Jul 2026 01:14:38 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v4 04/11] power: supply: max17042_battery: Convert initialization to delayed work
Date: Sun, 26 Jul 2026 21:13:02 -0400
Message-ID: <20260727011319.621794-5-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX+OXUGVSt8R/w
 bTOqRwpAATOnWEb55Dii5qoRP0lDBKH4wvIXv3O2wJtk5WQNQW03AjuNrVDvzYIfmuzRUYWJVN9
 HSUnmqLbsJAZm5qlPIfOPTOPxUG/OwQQOpzKsyc8XfZ9TbeRc8TkEi2nMwhrilG9UdK3v7Fm0P8
 l8kLhFiJlG70hHfaA7foPKZHF/ftdCcT/dqFsNC8TwLGBTj8+hFHHyzvyG2MxcsWeGL2p0aLvqW
 FBhR8q+RELsntBqVG2OgsI8H6Tk237SgLhKKFZFwpG4Mxw/pteHCAc/l1PVvysTLi7xA7UL7i79
 QxoF54alg9uALW1hdfJafrczUNoWXYsJJMLugOtnzy7wG/CQ4hqIzFB7SQR2yQ=
X-Proofpoint-ORIG-GUID: u8LGNlm_acDd_65g7XAZPanHY6SZKgZm
X-Proofpoint-GUID: u8LGNlm_acDd_65g7XAZPanHY6SZKgZm
X-Authority-Info-Out: v=2.4 cv=L84QguT8 c=1 sm=1 tr=0 ts=6a66b101
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_5iOF8PHa8-pMg-IkmAA:9

From: Vincent Cloutier <vincent@cloutier.co>

Periodic MAX17055 retries need a delayed work item. Convert the existing
initialization work in advance without adding retries or changing when the
first attempt runs.

Use schedule_delayed_work() with a zero delay so the work continues to run
on system_wq, matching schedule_work() rather than introducing a separate
workqueue policy change.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index e11d73681a67..38abd3604643 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -68,7 +68,7 @@ struct max17042_chip {
 	struct power_supply *battery;
 	enum max170xx_chip_type chip_type;
 	struct max17042_config_data *config_data;
-	struct work_struct work;
+	struct delayed_work work;
 	int    irq;
 	int    task_period;
 	bool   enable_current_sense;
@@ -995,7 +995,7 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 
 static void max17042_init_worker(struct work_struct *work)
 {
-	struct max17042_chip *chip = container_of(work,
+	struct max17042_chip *chip = container_of(to_delayed_work(work),
 				struct max17042_chip, work);
 	int ret;
 
@@ -1250,11 +1250,11 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if (val & STATUS_POR_BIT) {
-		ret = devm_work_autocancel(dev, &chip->work,
-					   max17042_init_worker);
+		ret = devm_delayed_work_autocancel(dev, &chip->work,
+						   max17042_init_worker);
 		if (ret)
 			return ret;
-		schedule_work(&chip->work);
+		schedule_delayed_work(&chip->work, 0);
 	} else {
 		WRITE_ONCE(chip->init_complete, true);
 	}
-- 
2.55.0


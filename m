Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566715;
	b=SOjOuNBLpyNyo4B0V5+Q2gOWdFS5Rrg+0dDgTzKQEMyvyuXp73xoiGlmMYf6bVaYwqz3
	 UuNH/2rQ5fKRLzQtoG1Jnh5Ewlp/T4FlKwfLyuICVYihHceDXnRd8blphf/YwV/ujEp1k
	 M0cBvzeqRpScie0MLHH9nd0WzIBps/Qj0orSkV76+Cw2dPN6pSRlekHgAqJay1XtP3TP6
	 EtDx0bW8m3HWZNHNO/eL5HxUxogulRGmXXgf6cZ7n0R4M8aqYcRli9LvEC5S//jHkw3hV
	 /SoHk4zZ/mh2sgXmdtXRjXBf6GZdmvE9ycPPe92M20dgLKKfWgTxOdwkH7J/HGP9CwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566715;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=VK9bxQhdSqspELLcbPt/14tF1h7mZhXgW17jKq+1KU0=;
	b=m+1KnN0B4I6OwmkWz8MG8MmnEQn9G1ljub7+NdZ7QLT1ZkwtTw4umRuYe8zncq2qSDln
	 MpW3L83pdult632KnvnyRmf5WmlXQlCallqqKcEAnpuAt0CoPTrWkvouHykVGqOhRH4+d
	 xTOgYqKMl4XxV2kLx0U5jyGx5m1jXwZ3kpEKByj1ptKeEnWrrl2EP2DeQ05Cx7mbHn41D
	 RGP2jR5pEskN5+xGr88MvSERTR00CTmcyozbeMJF9vbZuBj+t+0OSCAgkqNS+hbSX4nZR
	 oD37W5LbkbufOntqvvg7YTnSnRN/jHqU50+u+KaAk/Q3yVwq9vaOHFoWFLHSq+YQmJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="YNkzrw/W";
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97F606A337;
	Fri, 13 Nov 2026 10:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A97F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=YNkzrw/W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794566715; x=1826102715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VK9bxQhdSqspELLcbPt/14tF1h7mZhXgW17jKq+1KU0=;
  b=YNkzrw/WrOAoUPNCzFbAZw9fahDxCJgSI9Q750KhagBe447mrXmCva1x
   XSmQYWN74Njxhl2pbNYdo+tMV2S9ovGmKnSXqCR8mwafKPZTyl1OUGrUg
   dW1Rq1YYFNX8MzgD24oU2ITf58tDttzDHc1hGnb4wBvWoldtcsDgDgKFt
   Qyo+FI81SFrqEqDVY5P4G2LNoh4SKdvrIXZphA7gbEnltK8CSls/gqA9d
   QJeyPX4wOEDz8+fbUbihy7qS8XLT46ZzJbP3C1Kvcwr8Zm5xgEudr6J6/
   65jO/ff0z3FgM9yFr3sNXjEipoFD4xiRsVWrp2E6AiegvPYGLDqpTCV3u
   A==;
X-CSE-ConnectionGUID: uucpmrglTv6Hetp2pVu3jw==
X-CSE-MsgGUID: vv/ND3lkTxa9M8ClFNT/eQ==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33688383"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:45:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:4186]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id f1e0572a-92eb-4723-b555-f882fb63fa92; Fri, 13 Nov 2026 10:45:12 +0000 (UTC)
X-Farcaster-Flow-ID: f1e0572a-92eb-4723-b555-f882fb63fa92
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 10:45:12 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 10:45:10 +0000
From: Eliav Farber <farbere@amazon.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf
	<W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Eliav Farber <farbere@amazon.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v6 7/7] power: supply: cros_pchg: use devm_blocking_notifier_chain_register()
Date: Fri, 13 Nov 2026 10:44:55 +0000
Message-ID: <20261113104459.35839-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113104459.35839-1-farbere@amazon.com>
References: <20261113104459.35839-1-farbere@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
cros_pchg_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
Changes in v6:
- New patch. cros_peripheral_charger.c grew the
  blocking_notifier_chain_register() + devm_add_action_or_reset()
  pattern in 631adfa03595 ("power: supply: cros_pchg: unregister EC
  notifier"), which reached mainline in v7.3-rc1 on 2026-08-21, five
  days after v5 was posted, so earlier revisions could not have
  covered it.

The conversion keeps the existing dev_err_probe() message, and removes
one asymmetry: the old code registered on
ec_dev->ec_dev->event_notifier but unregistered on
charger->ec_device->event_notifier. Those are the same chain -
charger->ec_device is assigned from ec_dev->ec_dev earlier in probe -
and there is now a single reference to it.

 drivers/power/supply/cros_peripheral_charger.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index fdfa510f0f2d..d171bd56f479 100644
--- a/drivers/power/supply/cros_peripheral_charger.c
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -258,14 +258,6 @@ static int cros_ec_notify(struct notifier_block *nb,
 	return cros_pchg_event(charger);
 }
 
-static void cros_pchg_unregister_notifier(void *data)
-{
-	struct charger_data *charger = data;
-
-	blocking_notifier_chain_unregister(&charger->ec_device->event_notifier,
-					   &charger->notifier);
-}
-
 static int cros_pchg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -350,13 +342,13 @@ static int cros_pchg_probe(struct platform_device *pdev)
 
 	nb = &charger->notifier;
 	nb->notifier_call = cros_ec_notify;
-	ret = blocking_notifier_chain_register(&ec_dev->ec_dev->event_notifier,
-					       nb);
+	ret = devm_blocking_notifier_chain_register(dev,
+						    &ec_dev->ec_dev->event_notifier,
+						    nb);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to register notifier\n");
 
-	return devm_add_action_or_reset(dev, cros_pchg_unregister_notifier,
-					charger);
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.3


Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B3400DFB;
	Tue,  9 Jun 2026 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005557; cv=none; b=uEGq+lO5Ze5Z0PtnXk9+LFGgCof/owzh3woaQNsvHdbLpyyfgvPok5aRIcemuBvwugcxSwsLpPhsy7rzrcUcHmQq52cF/bzJJZZcujkz1BHrc7xDcIwdvkco5GJ9U0FjiWFhT5nyYaN8TXrriEE113N2PpmBRphWXm0OpmQHbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005557; c=relaxed/simple;
	bh=aHAoABJ2hOr4jKOG0fMpyKkaV5cjeBo5c6+PtQdfKuk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qyi2ixYKk3Y9Xne4Hh9lz5VofNyW6B7pYqUwCU9w5o4vdpn2svS/hO7Sd7ESGEeDsYcUIhTTc9JJ2SX28egd8PZPJlJf7ahwzfv4L6s+gpbsIyeii0RFDNwS6KAPwi16VyG+wNPa98gXmF6lecnWI857dymD0zmIbr8PlY6dU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=qyvIbpWM; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="qyvIbpWM"
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1781005546;
	bh=ybazkTz7sL98AD1VQl1rS0oC07lxizg5vccQbpzODpA=; l=1443;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qyvIbpWM3Xm+OZegfjmt/KMEsBxH0RWsgSERr7rLauXS1sAuBnd0oEMexdaMOC+LG
	 djprb2QQ7KECG7K/ww6VI2N+93gxc/Zj8l8DcoPfFhKZDVZq/g8ZHs60fPWfwv+F9I
	 yeC9oPqIAZCKx5fF6zccUtiId0jOO0xeGMsgGvcxijxE72AYNLl2E87BdPLABumzEo
	 a6PROoEnmrqwuTY0aYbiGe1MwaIYun20/QQVUd2b30XodCqNncybX3DsidmdxUE3MS
	 MED18X6UYuMuDik0pVcL09tSLJWyTkm+geFCHV/3ecJGW+ub/YDdTadg1dyuHtP2nT
	 3MogU5JFGzszw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1227033:0:AUTH_RELAY)
	(envelope-from <lucas_tsai@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 09 Jun 2026 19:45:34 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 9 Jun
 2026 19:45:33 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 9 Jun 2026 19:45:33 +0800
From: <lucas_tsai@richtek.com>
To: <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ren_chen@richtek.com>, <kevin_hung@richtek.com>, <cy_huang@richtek.com>,
	<alan_lan@richtek.com>, Lucas Tsai <lucas_tsai@richtek.com>
Subject: [PATCH] power: supply: core: fix supplied_from allocations
Date: Tue, 9 Jun 2026 19:44:03 +0800
Message-ID: <20260609114403.3896073-1-lucas_tsai@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Lucas Tsai <lucas_tsai@richtek.com>

If dts property power-supplies has multiple values, then accessing to
psy->supplied_from[i-1] in __power_supply_populate_supplied_from will
overrun supplied_from array.

Signed-off-by: Lucas Tsai <lucas_tsai@richtek.com>
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48

 drivers/power/supply/power_supply_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a446d3d086fc..2532e221b2e1 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -292,18 +292,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
 	if (cnt == 1)
 		return 0;
 
-	/* All supplies found, allocate char ** array for filling */
-	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(*psy->supplied_from),
+	/* All supplies found, allocate char * array for filling */
+	psy->supplied_from = devm_kcalloc(&psy->dev,
+					  cnt - 1, sizeof(*psy->supplied_from),
 					  GFP_KERNEL);
 	if (!psy->supplied_from)
 		return -ENOMEM;
 
-	*psy->supplied_from = devm_kcalloc(&psy->dev,
-					   cnt - 1, sizeof(**psy->supplied_from),
-					   GFP_KERNEL);
-	if (!*psy->supplied_from)
-		return -ENOMEM;
-
 	return power_supply_populate_supplied_from(psy);
 }
 #else

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.43.0


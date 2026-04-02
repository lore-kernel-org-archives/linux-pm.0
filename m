Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED503F1660
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149031; cv=none; b=jUu0GS0wPQJ/8cymkpvZVDvcaTWbuPizh1hQWbCr4qTxwqAp4FRarnZ/XrYzKzdEjyAs85LykSuoQHZ929IVyI3wxZOetYJ4+n1J2gegWx4297xfxn+Svt+nma+SDV0PEr9E922KjgEwZ47jDrOsRC+RfNLAfnpdn6pJgLvnFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149031; c=relaxed/simple;
	bh=TE1aEBQME/LPSM0BPcXb8Dh4e+xxL84n+t5+RDaQR7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdnjodHAq0qqYwjK39YRRmk/k+NpoOxQLXwLwntT1fLNAX5VLoiF3y6kkuBaTN8eBXaBebYmls+Tf1O/3VZw+PsqEz37CWEOQuxPFtERkzx9ujl7wxFskZx8fFn0QrrWDqfcIyDLWPuoVk753qEeaMpMHan3uKfQp0+iyrINAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJftdmQi; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJftdmQi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775149013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+fL9n2jTiYjb2TnUsQWtFMCRrAem7LSQMh+WmdC022k=;
	b=vJftdmQic4VWzUsKGPrT8T6QYMBvkODNU+rNMbuogX5DPj3NIo7hKk8HN1F4WR2AiAX3Pa
	9zOfobf+ZYRQhUTIhrGTFrSH+ghye6DlMNXYTbnr7iL3nCiGYmREfXCXpRwaPvFIvX7bbe
	ErZPAj/irahI+yAytr7RFbakCeYVx4k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] thermal/drivers/brcmstb_thermal: Use max to simplify brcmstb_get_temp
Date: Thu,  2 Apr 2026 18:56:18 +0200
Message-ID: <20260402165616.895305-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=thorsten.blum@linux.dev; h=from:subject; bh=TE1aEBQME/LPSM0BPcXb8Dh4e+xxL84n+t5+RDaQR7g=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnn5m/Q8ehU3rBYxPVh5VwtY+XNXw/vlzi2LWyeAz/D4 R/LP4rndpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBETJYwMiw0mSDkfE1Vp3LV QrHPEk0Cj2Q6nJ/+8K5q5Lnzfu2+3A8M/5SrBA7MNFh033XXi8Luyu6vgqa7NNd/ureg5YVAYGH FJGYA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use max() to simplify brcmstb_get_temp() and improve its readability.
Since avs_tmon_code_to_temp() returns an int, change the data type of
the local variable 't' from long to int.  No functional changes.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index f46f2ddc174e..a9ffa596f7c0 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -16,6 +16,7 @@
 #include <linux/irqreturn.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -154,7 +155,7 @@ static int brcmstb_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct brcmstb_thermal_priv *priv = thermal_zone_device_priv(tz);
 	u32 val;
-	long t;
+	int t;
 
 	val = __raw_readl(priv->tmon_base + AVS_TMON_STATUS);
 
@@ -164,10 +165,7 @@ static int brcmstb_get_temp(struct thermal_zone_device *tz, int *temp)
 	val = (val & AVS_TMON_STATUS_data_msk) >> AVS_TMON_STATUS_data_shift;
 
 	t = avs_tmon_code_to_temp(priv, val);
-	if (t < 0)
-		*temp = 0;
-	else
-		*temp = t;
+	*temp = max(0, t);
 
 	return 0;
 }

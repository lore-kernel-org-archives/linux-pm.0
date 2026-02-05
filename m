Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E7288B8
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320781; cv=none; b=bEgRnNaSLJGWP1FtUZ+w3XHklh1iX5EA/cpzThCp4KFOaGsHWgkKSfEUgpJDa3VgIKAqq7smo933xT5IsE9SAdzhb+zWSQEZaLoDMcqPd/RQ7BKv2EjaeKVVWWe3n/glpZ8/gddohJWn7Jj6qg0n06D37pweYcXtXNgMNrUOsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320781; c=relaxed/simple;
	bh=u5OPuZMOac8rMUCqfVFVuHAGYPLRRl8Me9JB/haRe3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Za8eNlid/LjQaTYnHakTeqbAH0wVHFQ+eiT6YviU+Ofo/BnH0pe4XDE6N3G7ClIRc9ys/ZjKfD9b5N/8NVq/EzT/P1mxoVdxehGtQaQ1biHZGl1IqgiG3LtPRNHLuXGJL00k4764KjGRtSSealu33yae1Kbi48IqX2DJqJ57Xas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H3YWAR/S; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H3YWAR/S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770320768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IvBuOfpCo0+VIpkSQ9liw7TJLNLW+8V64cAq9/bRrgg=;
	b=H3YWAR/S9RPEGh/7LguThmHCT60hRqQ/k9epVaJRwWzwNo+1WC42aCwr/QOw2ldPhICFSh
	09rScjUbaRIdBTzkgkd3mhueMzIYyHegtXN78H8A1hJjV3l6GvTT/PJ4nuStZtjc+T+Ens
	uAvx/bTRBDgXUPc+tglUvs0D3SCLfmo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] thermal/drivers/brcmstb_thermal: Use max to simplify brcmstb_get_temp
Date: Thu,  5 Feb 2026 20:45:42 +0100
Message-ID: <20260205194542.1013198-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


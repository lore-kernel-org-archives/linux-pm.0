Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDC3B7B96;
	Wed, 15 Jul 2026 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100956; cv=none; b=Ov6n23Z78b/PUbJ0V6F/W70PmWbFAkAwfT3/PPwgShtIAA4gluoakgkQcz5/SWPEmBbDsi5xQEgAr0F214wP1jBDS7lP6ZUqkoXA6jYeocBVnDgm3L9YAfXOF34Gr1w0VjZ5LrJ1RH6tjSkP7ySxR5w31DDK2UU9YREvUCsV4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100956; c=relaxed/simple;
	bh=uqwYcNgJeD07knxrZsoTgpn0CTfJVTAyGKxK0wadyjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L0mOb93XBvwC0TkP2ewNxBNDOPYpW0EDKwWYUjpv3CdzbuIiuRv/mEBMicrUnVGbQa71QcC+Elb8IgPt4JKgK2JvmgF5htLJzo6Dv12ewro3egTKY10YADIB1PbrO7F4dPsUd3qDpfvqdoQDQEI3ar2L2b5tWIIWxhO3O69bJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MfPtRVPU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xLsStBKr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MfPtRVPU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xLsStBKr"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784100952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pyjgng7RzInbAdvKsOuka4VgJrPS7BbFK8B+jLko8hs=;
	b=MfPtRVPUXUQUhF375GQekw+8Jp2V5uKZuSoWqDCn9/k6XhwmJzli/4b52OYj8+noL79FJ0
	t54TbvFQOlYrVKklIj6YLEK8QMfv8oTBdUcFqgFiUlCtwLO37qhb9zC1rLU96XfF4M90Ij
	4ggrFal+C9Z0MoOm4VZHhswF1+qM2CBVd7Ef8eEvl5nEGBlF8mKepI3CbEAeEREoHJz4X0
	9SqoHOHT3pCiP14jciITVcnF46vaVZhbbnCt8bt9Zgo65J3o+twpTZYDfgatWVNlUwNNBS
	l4AQMFLUOFf4esP3Hc123XvivuJASexdZPuggTHNPyNjk5RRjfPzVedhEMjEIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784100952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pyjgng7RzInbAdvKsOuka4VgJrPS7BbFK8B+jLko8hs=;
	b=xLsStBKrF0nwJ4yKJrE9gmouyPFFVpNuCs/HbXfH/xhsPQODfubF+7tg2DTWk+fTpCzvPy
	A5/2ITMpBJYZgHDw==
Date: Wed, 15 Jul 2026 09:35:36 +0200
Subject: [PATCH] OPP: Fix cleanup ordering
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-opp-fix-v1-1-a3098d80afd8@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAEc4V2oC/yXMzQqAIBAE4FeJPSeo9P8q0SFrre2gohVB+O5ZH
 b9hZm4I6AkDdNkNHk8KZE2CyDOY1tEsyGhOBsllxWtRMusc03QxLFoteaNQKA2p7Tym+Hvqh9/
 hUBtO+zuHGB+YETlPawAAAA==
X-Change-ID: 20260715-opp-fix-e49f208be1bf
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784100952; l=2703;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=uqwYcNgJeD07knxrZsoTgpn0CTfJVTAyGKxK0wadyjY=;
 b=lukprd7sBC03TwrbWFfSKdlrg6sC1uYrSXh208HxzUIb61QB9N4u1bKp70fOe8hedExJuduux
 4FMx5pdJoPcAsR1xvEgfl5bxp6EH4ws5afDzEH0pDBb78PUMI9Dpl8p
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Commit 173e02d67494 ("OPP: Initialize scope-based pointers inline")
added initialization for all pointers. In some cases, the ordering was
changed so that *opp_table was initialized after *opp. This also changes
the order of the registered cleanup functions.

When the cleanup happens, this can cause use-after-free errors when the
last reference is released and the release function _opp_kref_release
tries to access the already freed opp->opp_table.

Initialize *opp_table before *opp again to fix this and ensure the
correct cleanup order.

Fixes: 173e02d67494 ("OPP: Initialize scope-based pointers inline")
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/opp/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ab0b0a2f85a17..b6966e509f7dd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1412,13 +1412,12 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
  */
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
+	struct opp_table *opp_table __free(put_opp_table) =
+		_find_opp_table(dev);
 	struct dev_pm_opp *opp __free(put_opp) = NULL;
 	unsigned long freq = 0, temp_freq;
 	bool forced = false;
 
-	struct opp_table *opp_table __free(put_opp_table) =
-		_find_opp_table(dev);
-
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device's opp table doesn't exist\n", __func__);
 		return PTR_ERR(opp_table);
@@ -2870,11 +2869,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_add_dynamic);
 static int _opp_set_availability(struct device *dev, unsigned long freq,
 				 bool availability_req)
 {
-	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
-
 	/* Find the opp_table */
 	struct opp_table *opp_table __free(put_opp_table) =
 		_find_opp_table(dev);
+	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
 
 	if (IS_ERR(opp_table)) {
 		dev_warn(dev, "%s: Device OPP not found (%ld)\n", __func__,
@@ -2932,12 +2930,11 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 			      unsigned long u_volt_max)
 
 {
-	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
-	int r;
-
 	/* Find the opp_table */
 	struct opp_table *opp_table __free(put_opp_table) =
 		_find_opp_table(dev);
+	struct dev_pm_opp *opp __free(put_opp) = ERR_PTR(-ENODEV), *tmp_opp;
+	int r;
 
 	if (IS_ERR(opp_table)) {
 		r = PTR_ERR(opp_table);

---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
change-id: 20260715-opp-fix-e49f208be1bf

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>


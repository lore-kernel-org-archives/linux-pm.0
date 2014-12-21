From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] thermal: ti-soc-thermal: ti-bandgap.c:  Remove unused function
Date: Sun, 21 Dec 2014 18:43:43 +0100
Message-ID: <1419183823-10787-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:55971 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbaLURk5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Dec 2014 12:40:57 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so5072172wgh.23
        for <linux-pm@vger.kernel.org>; Sun, 21 Dec 2014 09:40:56 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Remove the function ti_bandgap_write_thot() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c |   13 -------------
 drivers/thermal/ti-soc-thermal/ti-bandgap.h |    1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 634b6ce..cbb6a5f 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -611,19 +611,6 @@ int ti_bandgap_read_thot(struct ti_bandgap *bgp, int id, int *thot)
 }
 
 /**
- * ti_bandgap_write_thot() - sets sensor current thot
- * @bgp: pointer to bandgap instance
- * @id: sensor id
- * @val: desired thot value
- *
- * Return: 0 on success or the proper error code
- */
-int ti_bandgap_write_thot(struct ti_bandgap *bgp, int id, int val)
-{
-	return _ti_bandgap_write_threshold(bgp, id, val, true);
-}
-
-/**
  * ti_bandgap_read_tcold() - reads sensor current tcold
  * @bgp: pointer to bandgap instance
  * @id: sensor id
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index b3adf72..976afc0 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -371,7 +371,6 @@ struct ti_bandgap_data {
 };
 
 int ti_bandgap_read_thot(struct ti_bandgap *bgp, int id, int *thot);
-int ti_bandgap_write_thot(struct ti_bandgap *bgp, int id, int val);
 int ti_bandgap_read_tcold(struct ti_bandgap *bgp, int id, int *tcold);
 int ti_bandgap_write_tcold(struct ti_bandgap *bgp, int id, int val);
 int ti_bandgap_read_update_interval(struct ti_bandgap *bgp, int id,
-- 
1.7.10.4


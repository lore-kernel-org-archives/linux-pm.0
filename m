From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
Date: Sun, 03 Mar 2019 18:24:33 +0100
Message-ID: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

ath10k_mac_vif_chan() always returns an error for the given vif
during system-wide resume which reliably triggers two WARN_ON()s
in ath10k_bss_info_changed() and they are not particularly
useful in that code path, so drop them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/net/wireless/ath/ath10k/mac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/net/wireless/ath/ath10k/mac.c
===================================================================
--- linux-pm.orig/drivers/net/wireless/ath/ath10k/mac.c
+++ linux-pm/drivers/net/wireless/ath/ath10k/mac.c
@@ -5705,7 +5705,7 @@ static void ath10k_bss_info_changed(stru
 	}
 
 	if (changed & BSS_CHANGED_MCAST_RATE &&
-	    !WARN_ON(ath10k_mac_vif_chan(arvif->vif, &def))) {
+	    !ath10k_mac_vif_chan(arvif->vif, &def)) {
 		band = def.chan->band;
 		rateidx = vif->bss_conf.mcast_rate[band] - 1;
 
@@ -5743,7 +5743,7 @@ static void ath10k_bss_info_changed(stru
 	}
 
 	if (changed & BSS_CHANGED_BASIC_RATES) {
-		if (WARN_ON(ath10k_mac_vif_chan(vif, &def))) {
+		if (ath10k_mac_vif_chan(vif, &def)) {
 			mutex_unlock(&ar->conf_mutex);
 			return;
 		}

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system
 resume
Date: Fri, 01 Mar 2019 13:51:54 +0100
Message-ID: <3687330.FyvvPAkb64@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/ath10k/>
List-Post: <mailto:ath10k@lists.infradead.org>
List-Help: <mailto:ath10k-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=subscribe>
Sender: "ath10k" <ath10k-bounces@lists.infradead.org>
Errors-To: ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Todd Brandt <todd.e.brandt@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ath10k@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ath10k_mac_vif_chan() always returns an error for the given vif
during system-wide resume which reliably triggers two WARN_ON()s
in ath10k_bss_info_changed() and they are not particularly
useful in that code path, so drop them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

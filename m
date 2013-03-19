From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 11/12] staging: ti-soc-thermal: fix bitfield writing while updating thresholds
Date: Tue, 19 Mar 2013 10:54:27 -0400
Message-ID: <1363704868-11843-12-git-send-email-eduardo.valentin@ti.com>
References: <1363704868-11843-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1363704868-11843-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

Wrong threshold cold values may be written with current implementation.
This patch fixes the threshold update function by simplifying the
bitfield manipulation sequence.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-bandgap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.c b/drivers/staging/ti-soc-thermal/ti-bandgap.c
index d075186..5c946cd 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.c
@@ -418,10 +418,10 @@ static int ti_bandgap_update_alert_threshold(struct ti_bandgap *bgp, int id,
 	}
 
 	/* write the new threshold values */
-	reg_val = thresh_val & ~tsr->threshold_thot_mask;
-	reg_val |= (t_hot << __ffs(tsr->threshold_thot_mask));
-	reg_val |= thresh_val & ~tsr->threshold_tcold_mask;
-	reg_val |= (t_cold << __ffs(tsr->threshold_tcold_mask));
+	reg_val = thresh_val &
+		  ~(tsr->threshold_thot_mask | tsr->threshold_tcold_mask);
+	reg_val |= (t_hot << __ffs(tsr->threshold_thot_mask)) |
+		   (t_cold << __ffs(tsr->threshold_tcold_mask));
 	ti_bandgap_writel(bgp, reg_val, tsr->bgap_threshold);
 
 	if (err) {
-- 
1.7.7.1.488.ge8e1c


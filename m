From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 04/11] soc: renesas: rcar-sysc: Make rcar_sysc_power_is_off() static
Date: Wed, 20 Apr 2016 14:02:39 +0200
Message-ID: <1461153766-750-5-git-send-email-geert+renesas@glider.be>
References: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:56934 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149AbcDTMCo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 08:02:44 -0400
In-Reply-To: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As of commit b12ff41658171f53 ("ARM: shmobile: r8a7779: Remove legacy PM
Domain remainings"), rcar_sysc_power_is_off() is no longer used from
SoC-specific code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v6:
  - No changes,

v5:
  - No changes,

v4:
  - Add Reviewed-by,

v3:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c       | 2 +-
 include/linux/soc/renesas/rcar-sysc.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 95f2b59cbd76f777..4e760d63f2abd93f 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -152,7 +152,7 @@ int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
 	return rcar_sysc_power(sysc_ch, true);
 }
 
-bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
+static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	unsigned int st;
 
diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
index 96f30c2883881d97..92fc613ab23db091 100644
--- a/include/linux/soc/renesas/rcar-sysc.h
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -11,7 +11,6 @@ struct rcar_sysc_ch {
 
 int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
 int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
-bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch);
 void __iomem *rcar_sysc_init(phys_addr_t base);
 
 #endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1


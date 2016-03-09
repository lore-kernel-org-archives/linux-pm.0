From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 04/11] soc: renesas: rcar-sysc: Make rcar_sysc_power_is_off() static
Date: Wed,  9 Mar 2016 20:18:40 +0100
Message-ID: <1457551127-21934-5-git-send-email-geert+renesas@glider.be>
References: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

As of commit b12ff41658171f53 ("ARM: shmobile: r8a7779: Remove legacy PM
Domain remainings"), rcar_sysc_power_is_off() is no longer used from
SoC-specific code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c       | 2 +-
 include/linux/soc/renesas/rcar-sysc.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 6b21ea2a65bf59b9..28af0b704fc008d2 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -149,7 +149,7 @@ int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
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

From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 05/22] PM / AVS: SmartReflex: %pF is only for function pointers
Date: Wed, 11 Mar 2015 22:13:40 -0500
Message-ID: <1426130037-17956-5-git-send-email-scottwood@freescale.com>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, linux-kernel@vger.kernel.org
Cc: Scott Wood <scottwood@freescale.com>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

Use %pS for actual addresses, otherwise you'll get bad output
on arches like ppc64 where %pF expects a function descriptor.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
---
 drivers/power/avs/smartreflex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index db9973b..76d6a12 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -356,7 +356,7 @@ int sr_configure_errgen(struct omap_sr *sr)
 	u8 senp_shift, senn_shift;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
+		pr_warn("%s: NULL omap_sr from %pS\n", __func__,
 			(void *)_RET_IP_);
 		return -EINVAL;
 	}
@@ -423,7 +423,7 @@ int sr_disable_errgen(struct omap_sr *sr)
 	u32 vpboundint_en, vpboundint_st;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
+		pr_warn("%s: NULL omap_sr from %pS\n", __func__,
 			(void *)_RET_IP_);
 		return -EINVAL;
 	}
@@ -478,7 +478,7 @@ int sr_configure_minmax(struct omap_sr *sr)
 	u8 senp_shift, senn_shift;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
+		pr_warn("%s: NULL omap_sr from %pS\n", __func__,
 			(void *)_RET_IP_);
 		return -EINVAL;
 	}
@@ -563,7 +563,7 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 	int ret;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
+		pr_warn("%s: NULL omap_sr from %pS\n", __func__,
 			(void *)_RET_IP_);
 		return -EINVAL;
 	}
@@ -615,7 +615,7 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 void sr_disable(struct omap_sr *sr)
 {
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
+		pr_warn("%s: NULL omap_sr from %pS\n", __func__,
 			(void *)_RET_IP_);
 		return;
 	}
-- 
2.1.0

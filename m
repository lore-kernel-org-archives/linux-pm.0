Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794766234;
	b=4EPWVr9PMTO/hgtXuwcLp7W3XgeMDbv6/RtMAJ5SZwDQCKGOH5XErVp6wIbALcL451+7
	 qbD0MkDbI7IAaA8KzuZ1NB4gP9w6hpOdeh66HxOG3/tAOwBqkGaKAUeh+Vmo+nXfD0CXR
	 LMwF7BJNQbuiAoPsd0LB1jwJmzAL1ZZ62XwR4C+mFd7BPZxmiTCz9k9dP+CUlePxk53We
	 1TVh2IF00vPCxsbuvEs49ofBXAzXdDqNokbbPO7sSPaHJC1/wzwyHHsUHFNMhN2GdfEJS
	 yJzZR7y5ZYy8cgKN534Cz6ZByjzqVf7KdwJwOE1TzaFAK+xYfc1DCxGG9GLRoKnZwOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794766234;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=oRUWJuYUdcnMydAoLlo9QJ+Mlot2+ydrhYYhuU+km0U=;
	b=YVtT8HRIeN/s6Rn0k3J7/GmCKuuhHld2x94EEMAgnOkDMIeTqEpAfRcMa6O9djEMLsQS
	 r8NrIRzuZG4h4vvVlAiwy/Xo4eaNeYNp7+EAwxeq1MdUoxjqjbR9gBkF3eAzEvBqxhtTM
	 jhM1/wexZXY7Q2fF2xaIuukZXPttN3Nrst94sesotkHmhFR3X91MjWRfMc858wkonpi7/
	 CFPEESpHpEA5hmP9Pt+73iw8wSsylXqTVmRDg9u+jsLb8LRlH681spat1TK4tfaRwBDPw
	 ZD01KU/Mu9GiGsSUr1xpK2CVr7PDYIcl9wsjet/eniaN2uyHtVjpAaqP9Sr0Eb+u/IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nC9ucYjC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70540606A333;
	Sun, 15 Nov 2026 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nC9ucYjC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533D91F000C9;
	Sun, 15 Nov 2026 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794766234;
	bh=oRUWJuYUdcnMydAoLlo9QJ+Mlot2+ydrhYYhuU+km0U=;
	h=From:Date:Subject:To:Cc;
	b=nC9ucYjCQd7zHssPAL9i8kDCNiFXuxub4Ti5OWI02xXauE2VobgT8XpAB7PHvLfOU
	 Klr43CgXwUcQpGMAn97rEHJa8t1ccj7ZuzN5BoiOrDV+D1mPsbw3XEP/WhNizigo+W
	 OhAcHk1y1K8nqg5pvtAF7ZK5teCkZYjXwlNa3v0YHpCZ5IlqpUD1FzKHHJsrIfSvz1
	 TR4WrJcLAwePZl8zIhDgXce2BV4i/C0OtX3oIZJTOmt43Ezjr8o8Kb8cB9gfrSzGyH
	 cK8LvYK3mynNOzUkS78qhJ3US+IIS5YZX5fSHSFXn63ZGaCe7oymJ7U4lg5YotOzFk
	 WPPt5lFGkg6IQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 15 Nov 2026 19:10:29 +0100
Subject: [PATCH] drm/mcde: Use power domain for display power
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-ux500-drm-mcde-powerdomain-v1-1-afdc326cceb7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MUQrDIAwA0KuEfDegRUfnVcY+xKRbPtQS2VYov
 fug7wDvwCGmMjDBgSZfHdobJvATYHnn9hJSxgQ4u/nmvY/02aNzxFapFhba+k+Me83aaMkL3zm
 UmEPACXAzWXW/8sfzPP86AZVZbAAAAA==
X-Change-ID: 20261115-ux500-drm-mcde-powerdomain-8a8d9d4c5a44
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Replace explicit EPOD regulator handling with runtime PM, including the
power cycle used to reset the display hardware. Treat only negative
pm_runtime_put_sync_suspend() return values as errors.

Keep the separate VANA regulator enabled while the driver is bound:
the AB8500 CSI/DSI analog supply is not controlled by the MCDE power
domain. Preserve its probe failure and removal cleanup.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
The Ux500 genpd prerequisites have been merged into the powerdomain tree.
Please take this conversion through DRM; the companion bindings and DTS
changes will be submitted separately.
---
 drivers/gpu/drm/mcde/mcde_clk_div.c |  4 +--
 drivers/gpu/drm/mcde/mcde_display.c | 13 ++++-----
 drivers/gpu/drm/mcde/mcde_drm.h     |  1 -
 drivers/gpu/drm/mcde/mcde_drv.c     | 56 +++++++++++++++++--------------------
 drivers/gpu/drm/mcde/mcde_dsi.c     |  1 -
 5 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_clk_div.c b/drivers/gpu/drm/mcde/mcde_clk_div.c
index 8c5af2677357..1a22e6233946 100644
--- a/drivers/gpu/drm/mcde/mcde_clk_div.c
+++ b/drivers/gpu/drm/mcde/mcde_clk_div.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 
 #include "mcde_drm.h"
 #include "mcde_display_regs.h"
@@ -95,7 +95,7 @@ static unsigned long mcde_clk_div_recalc_rate(struct clk_hw *hw,
 	 * It will come up with 0 in the divider register bits, which
 	 * means "divide by 2".
 	 */
-	if (!regulator_is_enabled(mcde->epod))
+	if (!pm_runtime_active(mcde->dev))
 		return DIV_ROUND_UP_ULL(prate, 2);
 
 	cr = readl(mcde->regs + cdiv->cr);
diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 281f5b3274bd..57305fdbcdcc 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -7,7 +7,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
-#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/media-bus-format.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -1187,16 +1187,15 @@ static void mcde_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 	int ret;
 
 	/* This powers up the entire MCDE block and the DSI hardware */
-	ret = regulator_enable(mcde->epod);
+	ret = pm_runtime_resume_and_get(mcde->dev);
 	if (ret) {
-		dev_err(drm->dev, "can't re-enable EPOD regulator\n");
+		dev_err(drm->dev, "can't enable MCDE power domain\n");
 		return;
 	}
 
 	dev_info(drm->dev, "enable MCDE, %d x %d format %p4cc\n",
 		 mode->hdisplay, mode->vdisplay, &format);
 
-
 	/* Clear any pending interrupts */
 	mcde_display_disable_irqs(mcde);
 	writel(0, mcde->regs + MCDE_IMSCERR);
@@ -1347,9 +1346,9 @@ static void mcde_crtc_helper_atomic_disable(struct drm_crtc *crtc,
 		spin_unlock_irq(&crtc->dev->event_lock);
 	}
 
-	ret = regulator_disable(mcde->epod);
-	if (ret)
-		dev_err(drm->dev, "can't disable EPOD regulator\n");
+	ret = pm_runtime_put_sync_suspend(mcde->dev);
+	if (ret < 0)
+		dev_err(drm->dev, "can't disable MCDE power domain\n");
 	/* Make sure we are powered down (before we may power up again) */
 	usleep_range(50000, 70000);
 
diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
index edbb4580a7d8..296edf9ebef4 100644
--- a/drivers/gpu/drm/mcde/mcde_drm.h
+++ b/drivers/gpu/drm/mcde/mcde_drm.h
@@ -93,7 +93,6 @@ struct mcde {
 	/* Locks the MCDE FIFO control register A and B */
 	spinlock_t fifo_crx1_lock;
 
-	struct regulator *epod;
 	struct regulator *vana;
 };
 
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 759e279b645a..af26ac5a4455 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -61,6 +61,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -283,33 +284,26 @@ static int mcde_probe(struct platform_device *pdev)
 	mcde->dev = dev;
 	platform_set_drvdata(pdev, drm);
 
-	/* First obtain and turn on the main power */
-	mcde->epod = devm_regulator_get(dev, "epod");
-	if (IS_ERR(mcde->epod)) {
-		ret = PTR_ERR(mcde->epod);
-		dev_err(dev, "can't get EPOD regulator\n");
-		return ret;
-	}
-	ret = regulator_enable(mcde->epod);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
-		dev_err(dev, "can't enable EPOD regulator\n");
+		dev_err(dev, "can't enable MCDE power domain\n");
+		pm_runtime_disable(dev);
 		return ret;
 	}
+
+	/* The CSI/DSI analog supply is separate from the MCDE power domain. */
 	mcde->vana = devm_regulator_get(dev, "vana");
 	if (IS_ERR(mcde->vana)) {
 		ret = PTR_ERR(mcde->vana);
 		dev_err(dev, "can't get VANA regulator\n");
-		goto regulator_epod_off;
+		goto pm_runtime_put;
 	}
 	ret = regulator_enable(mcde->vana);
 	if (ret) {
 		dev_err(dev, "can't enable VANA regulator\n");
-		goto regulator_epod_off;
+		goto pm_runtime_put;
 	}
-	/*
-	 * The vendor code uses ESRAM (onchip RAM) and need to activate
-	 * the v-esram34 regulator, but we don't use that yet
-	 */
 
 	/* Clock the silicon so we can access the registers */
 	mcde->mcde_clk = devm_clk_get(dev, "mcde");
@@ -412,14 +406,15 @@ static int mcde_probe(struct platform_device *pdev)
 
 	/*
 	 * Perform an invasive reset of the MCDE and all blocks by
-	 * cutting the power to the subsystem, then bring it back up
+	 * powering down the subsystem, then bring it back up
 	 * later when we enable the display as a result of
 	 * component_master_add_with_match().
 	 */
-	ret = regulator_disable(mcde->epod);
-	if (ret) {
-		dev_err(dev, "can't disable EPOD regulator\n");
-		return ret;
+	ret = pm_runtime_put_sync_suspend(dev);
+	if (ret < 0) {
+		dev_err(dev, "can't disable MCDE power domain\n");
+		pm_runtime_get_noresume(dev);
+		goto clk_disable;
 	}
 	/* Wait 50 ms so we are sure we cut the power */
 	usleep_range(50000, 70000);
@@ -428,13 +423,7 @@ static int mcde_probe(struct platform_device *pdev)
 					      match);
 	if (ret) {
 		dev_err(dev, "failed to add component master\n");
-		/*
-		 * The EPOD regulator is already disabled at this point so some
-		 * special errorpath code is needed
-		 */
-		clk_disable_unprepare(mcde->mcde_clk);
-		regulator_disable(mcde->vana);
-		return ret;
+		goto clk_disable_pm_disabled;
 	}
 
 	return 0;
@@ -443,10 +432,15 @@ static int mcde_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mcde->mcde_clk);
 regulator_off:
 	regulator_disable(mcde->vana);
-regulator_epod_off:
-	regulator_disable(mcde->epod);
+pm_runtime_put:
+	pm_runtime_put_sync_suspend(dev);
+	goto pm_runtime_disable;
+clk_disable_pm_disabled:
+	clk_disable_unprepare(mcde->mcde_clk);
+	regulator_disable(mcde->vana);
+pm_runtime_disable:
+	pm_runtime_disable(dev);
 	return ret;
-
 }
 
 static void mcde_remove(struct platform_device *pdev)
@@ -457,7 +451,7 @@ static void mcde_remove(struct platform_device *pdev)
 	component_master_del(&pdev->dev, &mcde_drm_comp_ops);
 	clk_disable_unprepare(mcde->mcde_clk);
 	regulator_disable(mcde->vana);
-	regulator_disable(mcde->epod);
+	pm_runtime_disable(&pdev->dev);
 }
 
 static void mcde_shutdown(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index daac8d67913d..86ae23894cda 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -8,7 +8,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 #include <video/mipi_display.h>
 
 #include <drm/drm_atomic_state_helper.h>

---
base-commit: 9ae477db090b44816741fd9c49a3c459fc7d407b
change-id: 20261115-ux500-drm-mcde-powerdomain-8a8d9d4c5a44

Best regards,
--  
Linus Walleij <linusw@kernel.org>


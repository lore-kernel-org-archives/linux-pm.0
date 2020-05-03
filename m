Return-Path: <SRS0=xEwV=6R=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A91FC47258
	for <linux-pm@archiver.kernel.org>; Sun,  3 May 2020 15:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1952721655
	for <linux-pm@archiver.kernel.org>; Sun,  3 May 2020 15:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="AhbzeEWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgECPVw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 3 May 2020 11:21:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:1610 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbgECPVO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:14 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7W4f4xzMP;
        Sun,  3 May 2020 17:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519271; bh=Ol/Fy27tVQcocJtHbCOujmzZ2avDxeNSc4gh5D0opQs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=AhbzeEWDyU93vzm/jrmI/+GefArk8AWvjpxxTK2j9ftGLqJo1SZUUiWQWzkByoULW
         UK0iQWN04Yl6xkLTXAcyFHe2S0ms90xOaBmhKNo6+mdoRR4WRO6L2i9coC7q9PqNIH
         IhsA7CkTy+fUoOcgdIiwU/efn8jpy/fWkiTknmm1Bp+n21y/VUxfhqCoxMrfkj3RjW
         C8ZW08kvYLfyBJwnG9XMufPxMRDz9kaEprm4wBlLGiZ6CeuQeEPoys9JRQlRB8GOwE
         piuwAUlsaX05/SoQLvJxAda52pUTaWsA1tJJJyJn3ZY0blFVsfGFOqFsun39RY9xhe
         DFrO2eGVlOj8g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:11 +0200
Message-Id: <3291ca81bf8eb1b0401579ae08e7835e71dfc1ff.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 04/11] power: bq25890: protect view of the chip's state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend bq->lock over whole updating of the chip's state. Might get
useful later for switching ADC modes correctly.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 82 ++++++++------------------
 1 file changed, 26 insertions(+), 56 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index c4a69fd69f34..9339e216651f 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -510,74 +510,50 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 	return 0;
 }
 
-static bool bq25890_state_changed(struct bq25890_device *bq,
-				  struct bq25890_state *new_state)
-{
-	struct bq25890_state old_state;
-
-	mutex_lock(&bq->lock);
-	old_state = bq->state;
-	mutex_unlock(&bq->lock);
-
-	return (old_state.chrg_status != new_state->chrg_status ||
-		old_state.chrg_fault != new_state->chrg_fault	||
-		old_state.online != new_state->online		||
-		old_state.bat_fault != new_state->bat_fault	||
-		old_state.boost_fault != new_state->boost_fault ||
-		old_state.vsys_status != new_state->vsys_status);
-}
-
-static void bq25890_handle_state_change(struct bq25890_device *bq,
-					struct bq25890_state *new_state)
+static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
 {
+	struct bq25890_state new_state;
 	int ret;
-	struct bq25890_state old_state;
 
-	mutex_lock(&bq->lock);
-	old_state = bq->state;
-	mutex_unlock(&bq->lock);
+	ret = bq25890_get_chip_state(bq, &new_state);
+	if (ret < 0)
+		return IRQ_NONE;
 
-	if (!new_state->online) {			     /* power removed */
+	if (!memcmp(&bq->state, &new_state, sizeof(new_state)))
+		return IRQ_NONE;
+
+	if (!new_state.online && bq->state.online) {	    /* power removed */
 		/* disable ADC */
 		ret = bq25890_field_write(bq, F_CONV_START, 0);
 		if (ret < 0)
 			goto error;
-	} else if (!old_state.online) {			    /* power inserted */
+	} else if (new_state.online && !bq->state.online) { /* power inserted */
 		/* enable ADC, to have control of charge current/voltage */
 		ret = bq25890_field_write(bq, F_CONV_START, 1);
 		if (ret < 0)
 			goto error;
 	}
 
-	return;
+	bq->state = new_state;
+	power_supply_changed(bq->charger);
 
+	return IRQ_HANDLED;
 error:
-	dev_err(bq->dev, "Error communicating with the chip.\n");
+	dev_err(bq->dev, "Error communicating with the chip: %pe\n",
+		ERR_PTR(ret));
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t bq25890_irq_handler_thread(int irq, void *private)
 {
 	struct bq25890_device *bq = private;
-	int ret;
-	struct bq25890_state state;
-
-	ret = bq25890_get_chip_state(bq, &state);
-	if (ret < 0)
-		goto handled;
-
-	if (!bq25890_state_changed(bq, &state))
-		goto handled;
-
-	bq25890_handle_state_change(bq, &state);
+	irqreturn_t ret;
 
 	mutex_lock(&bq->lock);
-	bq->state = state;
+	ret = __bq25890_handle_irq(bq);
 	mutex_unlock(&bq->lock);
 
-	power_supply_changed(bq->charger);
-
-handled:
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int bq25890_chip_reset(struct bq25890_device *bq)
@@ -607,7 +583,6 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 {
 	int ret;
 	int i;
-	struct bq25890_state state;
 
 	const struct {
 		enum bq25890_fields id;
@@ -655,16 +630,12 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		return ret;
 	}
 
-	ret = bq25890_get_chip_state(bq, &state);
+	ret = bq25890_get_chip_state(bq, &bq->state);
 	if (ret < 0) {
 		dev_dbg(bq->dev, "Get state failed %d\n", ret);
 		return ret;
 	}
 
-	mutex_lock(&bq->lock);
-	bq->state = state;
-	mutex_unlock(&bq->lock);
-
 	return 0;
 }
 
@@ -1001,19 +972,16 @@ static int bq25890_suspend(struct device *dev)
 static int bq25890_resume(struct device *dev)
 {
 	int ret;
-	struct bq25890_state state;
 	struct bq25890_device *bq = dev_get_drvdata(dev);
 
-	ret = bq25890_get_chip_state(bq, &state);
+	mutex_lock(&bq->lock);
+
+	ret = bq25890_get_chip_state(bq, &bq->state);
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&bq->lock);
-	bq->state = state;
-	mutex_unlock(&bq->lock);
-
 	/* Re-enable ADC only if charger is plugged in. */
-	if (state.online) {
+	if (bq->state.online) {
 		ret = bq25890_field_write(bq, F_CONV_START, 1);
 		if (ret < 0)
 			return ret;
@@ -1022,6 +990,8 @@ static int bq25890_resume(struct device *dev)
 	/* signal userspace, maybe state changed while suspended */
 	power_supply_changed(bq->charger);
 
+	mutex_unlock(&bq->lock);
+
 	return 0;
 }
 #endif
-- 
2.20.1


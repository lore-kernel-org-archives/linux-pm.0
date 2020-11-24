Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F5AC63798
	for <linux-pm@archiver.kernel.org>; Tue, 24 Nov 2020 09:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629552076B
	for <linux-pm@archiver.kernel.org>; Tue, 24 Nov 2020 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvRa/6Hh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xn2MJd7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbgKXJgr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:36:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbgKXJgn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:43 -0500
Date:   Tue, 24 Nov 2020 09:36:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lO5ZHbUqgy1e13Nn2VWdTq6xUECl0QZzesxWrbNE0ZI=;
        b=kvRa/6Hh66YWS0ih6/elYdU6XYvvuUHVeBhwxOssJWfhmkRMQe8kuKtCOlGvY2OYBINP8o
        hakP5H84/2jK/PoxWyVeZcxMzHWP7JmGjUukeKcBvcWIQOoK3Ilx0QTIVK9/+aVwUORd0A
        veGPiavCRf47grxAyy/UTCsOCOZsvzWIPhUclhRYq0qo+XHdRo7V0ZP7X8Mop7dR7yzeH6
        lNq/mh9LHtd9w3RK8wwktYHd+MpijJzAdyYdwKjpYvNTze/mpJmQfnMhTvWiPDjB2NmKtN
        IKM8JvvS20yjxiuKSkugrunptRHaUeX9Ul0QnO+Dfpg+rrElejX1FEJp0dtGqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lO5ZHbUqgy1e13Nn2VWdTq6xUECl0QZzesxWrbNE0ZI=;
        b=Xn2MJd7ONi21UbQXu5PZ8QQPpM65l6GapavGnuRBoywFY//pob8sleVdSYfsByeadiWcgl
        z35sAtW5vfRZbNAA==
From:   "thermal-bot for Fabien Parent" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: mediatek: add
 documentation for MT8516 SoC
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201021164231.3029956-2-fparent@baylibre.com>
References: <20201021164231.3029956-2-fparent@baylibre.com>
MIME-Version: 1.0
Message-ID: <160621060070.11115.15664259225956658366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c707f973df1706020f4a4669b5f1932e90c0f29c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c707f973df1706020f4a4669b5f1932e90c0f29c
Author:        Fabien Parent <fparent@baylibre.com>
AuthorDate:    Wed, 21 Oct 2020 18:42:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Oct 2020 11:18:54 +01:00

dt-bindings: thermal: mediatek: add documentation for MT8516 SoC

Add binding documentation for the MediaTek MT8516 SoC.
The SoC thermal IP is similar to MT2701.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201021164231.3029956-2-fparent@baylibre.com
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 2d20f6b..5c7e7bd 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -14,6 +14,7 @@ Required properties:
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
   - "mediatek,mt7622-thermal" : For MT7622 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
+  - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required

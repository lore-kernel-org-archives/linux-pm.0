Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B9FC433DB
	for <linux-pm@archiver.kernel.org>; Fri, 12 Mar 2021 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F0064FD6
	for <linux-pm@archiver.kernel.org>; Fri, 12 Mar 2021 14:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhCLOLY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:11:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhCLOKy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 09:10:54 -0500
Date:   Fri, 12 Mar 2021 15:10:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615558252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5f8x45jxGl7s0DT21TsJmSIpoEO8IDZPuPrqwMR+bvM=;
        b=GQvqoWytzznL9uy9m/W7mXqiHPqdkE17JJ/FQ7++bHomZCYlPhERpR7mITIfq2oTNRQvD0
        v0RNFZYouTJcuBuWnCrAtkpjIpNKKKLRiU4oSKJC4rIZoSRe7FZgBUkfPOdS6XHrFBirrS
        XCtEWgyCop/mg8EpnzpGD1PK2gYh4QIK4oJM0Hc1GXQIRuBqvNcGk+S6FwVEnUnjqKTOP7
        NIj0bHRRAdeltdybt7MU9t53GvBNFR5/tXevnQ+tOEbTJQma5G4EgHwpaM3dh1XX79Z3tO
        MWZlOtojsAa8H5GZtXoWe2NeX8nxVqw+zKuinvXrNftDY9EaubZk17LJc93Xbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615558252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5f8x45jxGl7s0DT21TsJmSIpoEO8IDZPuPrqwMR+bvM=;
        b=97M3MzjqtVhQ1LltDvJ28VPUGqlbdEOLGn9sS+mzP8m82V3ON1Ly11I1BhB+2ksk4O6Bgi
        FVmkxbdbNpZ8e5BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Timon Baetz <timon.baetz@protonmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        sebastian.reichel@collabora.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] extcon: Provide *extcon_*_notifier_all() stubs for
 !CONFIG_EXTCON
Message-ID: <20210312141051.blqkm2v2yx6psild@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CHARGER_MAX8997 fails to compile without CONFIG_EXTCON. There are stubs
already present for *extcon_*_notifier() but are missing for the _all()
variant.

Add *extcon_*_notifier_all() stubs for !CONFIG_EXTCON.

Fixes: f384989e88d44 ("power: supply: max8997_charger: Set CHARGER current limit")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/extcon.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index fd183fb9c20f7..8246307f9ed38 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -276,6 +276,30 @@ static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline int extcon_register_notifier_all(struct extcon_dev *edev,
+					       struct notifier_block *nb)
+{
+	return -EINVAL;
+}
+
+static inline int extcon_unregister_notifier_all(struct extcon_dev *edev,
+						 struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int devm_extcon_register_notifier_all(struct device *dev,
+						    struct extcon_dev *edev,
+						    struct notifier_block *nb)
+{
+	return -EINVAL;
+}
+
+static inline void devm_extcon_unregister_notifier_all(struct device *dev,
+						       struct extcon_dev *edev,
+						       struct notifier_block *nb)
+{ }
+
 static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.30.2


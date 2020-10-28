Return-Path: <SRS0=Ui8E=ED=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A0C388F7
	for <linux-pm@archiver.kernel.org>; Wed, 28 Oct 2020 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F4C20714
	for <linux-pm@archiver.kernel.org>; Wed, 28 Oct 2020 22:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgJ1W2d (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:28:33 -0400
Received: from foss.arm.com ([217.140.110.172]:40032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733218AbgJ1W1P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0BB177F;
        Wed, 28 Oct 2020 07:09:20 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 133353F66E;
        Wed, 28 Oct 2020 07:09:16 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com
Subject: [PATCH 1/4] dt-bindings: opp: Introduce opp-sustainable bindings
Date:   Wed, 28 Oct 2020 14:08:44 +0000
Message-Id: <20201028140847.1018-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028140847.1018-1-lukasz.luba@arm.com>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add opp-sustainable as an additional property in the OPP node to describe
the sustainable performance level of the device. This will help to
estimate the sustainable performance of the whole system.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/devicetree/bindings/opp/opp.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 9847dfeeffcb..cd01028de305 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -154,6 +154,10 @@ Optional properties:
 - opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
   in the table have this, the OPP with highest opp-hz will be used.
 
+- opp-sustainable: Marks the OPP as sustainable. This property can be used for
+  estimating sustainable performance of the whole system. If multiple OPPs in
+  the table have this, the OPP with highest opp-hz will be used.
+
 - opp-supported-hw: This property allows a platform to enable only a subset of
   the OPPs from the larger set present in the OPP table, based on the current
   version of the hardware (already known to the operating system).
-- 
2.17.1


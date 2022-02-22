Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80D8C433FE
	for <linux-pm@archiver.kernel.org>; Tue, 22 Feb 2022 14:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiBVOJU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiBVOJT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Feb 2022 09:09:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36B2215F09A;
        Tue, 22 Feb 2022 06:08:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 033D4106F;
        Tue, 22 Feb 2022 06:08:54 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B91C93F5A1;
        Tue, 22 Feb 2022 06:08:51 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [[PATCH v2 1/2] dt-bindings: opp: Add 'opp-microwatt' entry in the OPP
Date:   Tue, 22 Feb 2022 14:07:45 +0000
Message-Id: <20220222140746.12293-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222140746.12293-1-lukasz.luba@arm.com>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new entry for the OPP which provides information about power
expressed in micro-Watts. It is useful for the Energy Model framework.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 15a76bcd6d42..3f07a279ed2a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -93,6 +93,13 @@ patternProperties:
         minItems: 1
         maxItems: 8   # Should be enough regulators
 
+      opp-microwatt:
+        description:
+          Power for the OPP
+
+          A value representing power for the OPP in micro-Watts.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
       opp-level:
         description:
           A value representing the performance level of the device.
-- 
2.17.1


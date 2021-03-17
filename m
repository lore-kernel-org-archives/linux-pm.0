Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37ABC4646C
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA9C64E86
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 13:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhCQNt4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:49:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhCQNtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 317941F44AA2
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2805548011E; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 36/38] dt-bindings: power: supply: sbs-battery: Fix dtbs_check
Date:   Wed, 17 Mar 2021 14:49:02 +0100
Message-Id: <20210317134904.80737-37-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Existing in-tree users make use of '"ti,bq20z45", "sbs,sbs-battery"', so
add it to the list of known compatible strings.

Also add missing support for the generic 'power-supplies' property by
importing power-supply.yaml and setting unevaluatedProperties instead
of additionalProperties.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/power/supply/sbs,sbs-battery.yaml  | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
index a90b3601e695..90b9d3d882a4 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
@@ -12,12 +12,15 @@ maintainers:
 description: |
   Battery compatible with the smart battery system specifications
 
-properties:
+allOf:
+  - $ref: power-supply.yaml#
 
+properties:
   compatible:
     oneOf:
       - items:
           - enum:
+              - ti,bq20z45
               - ti,bq20z65
               - ti,bq20z75
           - enum:
@@ -60,7 +63,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.30.2


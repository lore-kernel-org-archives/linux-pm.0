Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7346AF3D;
	Tue, 14 Jul 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036615; cv=none; b=jKfQ1QmbMAJUI4sxbNQUEWSmHncNQRkziAMzy9Rn4j74p9iWjq5mQJ1MEgtvuX+58DMe8HJQQ04YRBzQfRJOQgXYHiv91UIPdC6UNonemqNmN789Wo1GG5fSte1rmWDOpcGdrBeRschN1oY3vy/eb4R7Azz/lmCioNEWx/YgPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036615; c=relaxed/simple;
	bh=1U9eKn3e1R9WRTPL80rdKx+5CvBlv+RphrbjVBJDHf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLgraC2SvPCoRWT18jqIemYOtLNL8A32gtzDrq8WmyYK6hQpzK8kM8He7duipknjnRQUi+iGz5hhmn3TWKh/OkF24uw3sfgQLI4AMgL4HVNXM1Iuga1Zt1YFY8lVpbbeIJ0ROK25Mrg1/wmpqGzcgyQT41H6NZ7mpXzgBDkNPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9+8if/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9+8if/l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2364C2BCF5;
	Tue, 14 Jul 2026 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784036614;
	bh=1U9eKn3e1R9WRTPL80rdKx+5CvBlv+RphrbjVBJDHf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l9+8if/lVDP0LPPFH/EhKNUjGjT6VkzjCMfIrjSMDSFnqYoL+avo+N3sCMOe8QnLV
	 ZDalSnQvBPVLNVMV/gxk9pWnrljz6LkRjnTOAMz6h8qLWUAfkwBeBIeYTft5bBmNoR
	 Jo45qCTmoe1bIBWohkbu+Lb7Zp/bsaW4nuJv2CZvijg9rSBTZWyh68XOjpp9TGiV4H
	 JQfDbDAEmCX7TnL+mbTllssk/ga2F9knrHFwqm/5KweccQwQJBDDEQWLYjrgEuPib/
	 HL7+y76Wra+zviUXs74Ku7LydyWjkdBZXP5WIeJWIyRWvrkkVERBmuSrNWS+2VhE1q
	 U1aTa/7vUrbyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1505C44501;
	Tue, 14 Jul 2026 13:43:34 +0000 (UTC)
From: Nikolai Burov via B4 Relay <devnull+nikolai.burov.jolla.com@kernel.org>
Date: Tue, 14 Jul 2026 16:43:06 +0300
Subject: [PATCH 1/3] dt-bindings: power: Add MediaTek MT6858 power domain
 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-mt6858-pmdomain-v1-1-4f09bbb822e0@jolla.com>
References: <20260714-mt6858-pmdomain-v1-0-4f09bbb822e0@jolla.com>
In-Reply-To: <20260714-mt6858-pmdomain-v1-0-4f09bbb822e0@jolla.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nikolai Burov <nikolai.burov@jolla.com>, 
 Nikolai Burov <nikolai.burov+review@abscue.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784036613; l=3755;
 i=nikolai.burov@jolla.com; s=20260707; h=from:subject:message-id;
 bh=M36MUmRAHEZNXG90DN7tPnz03tT5Y9VoFLmKPFkVkP4=;
 b=wM2fWQoT8Ccssr8ffuVD5ftJk22I+VOYVRWZRRVHtAOCTVrr0seRTmsovJQOqo7HJD6ougUBH
 1v6OoAFbyGADxyPQR3+VUtKT9S/KFCVfkUQUYoDlaSHOSnrkJbwyev/
X-Developer-Key: i=nikolai.burov@jolla.com; a=ed25519;
 pk=yzpa+PD+ovHUFMIOBA9o2QqGwI110jM6hdGHLc7jtoQ=
X-Endpoint-Received: by B4 Relay for nikolai.burov@jolla.com/20260707 with
 auth_id=859
X-Original-From: Nikolai Burov <nikolai.burov@jolla.com>
Reply-To: nikolai.burov@jolla.com

From: Nikolai Burov <nikolai.burov@jolla.com>

Add a new compatible and document bindings for the power domain
controller of the MT6858 SoC.

Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>
---
 .../bindings/power/mediatek,power-controller.yaml  | 21 +++++++++++++++++++-
 include/dt-bindings/power/mediatek,mt6858-power.h  | 23 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 07f046277f8a..eecb95323bfb 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -25,6 +25,7 @@ properties:
     enum:
       - mediatek,mt6735-power-controller
       - mediatek,mt6795-power-controller
+      - mediatek,mt6858-power-controller
       - mediatek,mt6893-power-controller
       - mediatek,mt8167-power-controller
       - mediatek,mt8173-power-controller
@@ -55,7 +56,7 @@ properties:
       faults while enabling or disabling a power domain.
       For example, this may hold phandles to INFRACFG and SMI.
     minItems: 1
-    maxItems: 3
+    maxItems: 6
 
 patternProperties:
   "^power-domain@[0-9a-f]+$":
@@ -102,6 +103,7 @@ $defs:
         description: |
           Power domain index. Valid values are defined in:
               "include/dt-bindings/power/mt6795-power.h" - for MT8167 type power domain.
+              "include/dt-bindings/power/mediatek,mt6858-power.h" - for MT6858 type power domain.
               "include/dt-bindings/power/mediatek,mt6893-power.h" - for MT6893 type power domain.
               "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
@@ -155,6 +157,23 @@ required:
   - compatible
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt6858-power-controller
+    then:
+      properties:
+        access-controllers:
+          items:
+            - description: handle to INFRACFG register block
+            - description: handle to IMG_SUB0 register block
+            - description: handle to CAM_SUB1 register block
+            - description: handle to CAM_SUB0 register block
+            - description: handle to IPE_SUB0 register block
+            - description: handle to VLPCFG register block
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/power/mediatek,mt6858-power.h b/include/dt-bindings/power/mediatek,mt6858-power.h
new file mode 100644
index 000000000000..6ed9e82d4ad3
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt6858-power.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_MT6858_POWER_H
+#define _DT_BINDINGS_POWER_MT6858_POWER_H
+
+#define MT6858_POWER_DOMAIN_MD				0
+#define MT6858_POWER_DOMAIN_CONN			1
+#define MT6858_POWER_DOMAIN_AUDIO			2
+#define MT6858_POWER_DOMAIN_MM_INFRA			3
+#define MT6858_POWER_DOMAIN_ISP_IMG1			4
+#define MT6858_POWER_DOMAIN_ISP_IMG2			5
+#define MT6858_POWER_DOMAIN_ISP_IPE			6
+#define MT6858_POWER_DOMAIN_VDE0			7
+#define MT6858_POWER_DOMAIN_VEN0			8
+#define MT6858_POWER_DOMAIN_CAM_MAIN			9
+#define MT6858_POWER_DOMAIN_CAM_SUBA			10
+#define MT6858_POWER_DOMAIN_CAM_SUBB			11
+#define MT6858_POWER_DOMAIN_DIS0			12
+#define MT6858_POWER_DOMAIN_MM_PROC_DORMANT		13
+#define MT6858_POWER_DOMAIN_CSI_RX			14
+#define MT6858_POWER_DOMAIN_SSUSB			15
+
+#endif /* _DT_BINDINGS_POWER_MT6858_POWER_H */

-- 
2.54.0



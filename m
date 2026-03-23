Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE93BE626;
	Mon, 23 Mar 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281857; cv=none; b=J+nEZnY5jCQGINerQLbbKUL7MYP6tEGOcr9MzmNM4aBWHYaderqnMSLEMp/XWklwgOAfHD2F163BLO3z6sNkigJzrS2ePKkxNZAu1huqnVKxY3+2KltLIezcrOQ/LF8BCKATgLy14AplXFBZp4nv8qmzYiipia4YOLwfkYlIkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281857; c=relaxed/simple;
	bh=VHMopsrG6Xi22dXMAyiAPvlaIWJqNW9MggRaSuIfstI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg8/HWQnnw8G6PfioTc70PNcSLu3xVRmb0JH6RCerve0/hVR5VlOrJmv/KgdISCIjLQ5WqFk5/IKsIZGM5xzwBCM7eHxmWtcKOyLiwq95luTPzkGhnTPK89K4Mvloy3ntB7NpmWgnHvf7krtQtv9Z7GGNO845Zkz4IZQ5YqNm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrF8fe1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrF8fe1X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 877DEC2BCB4;
	Mon, 23 Mar 2026 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281856;
	bh=VHMopsrG6Xi22dXMAyiAPvlaIWJqNW9MggRaSuIfstI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KrF8fe1XsxH7ARV7e521gkWrr1ji9P12SsvtABaLHNEN3Wf4AZjCQHRyh+5xdsuIl
	 31M2XmXgZGn2bZVVAekdjdtEF2H6Jacn40HS0MUbf3eNNQUblWPrNvS/kZwfRNTheL
	 bpX6rlLMtN0MNvHj+/A7LbGml+MIyzEbyroD64QhU2KIbVxqnbdW1iR2/KGQbPjQhL
	 xxK/PW1Gs06xcFT4N9MjkNV/NAhEDXr8fKG1INTN42hBWaLwbdNYj4B65foidd2wqo
	 d7b6uOAQlHjz2MyeNFXQRnZJq3oW8Lyr4wwgkex+fWa5FvHmvMFtb+7EVUV0cz5Gdv
	 HXh9DaWdbfygw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D5F483C1;
	Mon, 23 Mar 2026 16:04:16 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 23 Mar 2026 17:04:06 +0100
Subject: [PATCH v3 1/2] dt-bindings: power: supply: gpio-charger: add
 support for fast-charge timer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-gpio-charger-timer-v3-1-885796d681a5@liebherr.com>
References: <20260323-gpio-charger-timer-v3-0-885796d681a5@liebherr.com>
In-Reply-To: <20260323-gpio-charger-timer-v3-0-885796d681a5@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774281855; l=1976;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=qVR6Vlf2NNZxUIBX8M/euAC/Z+4KL1Wd23n+lTvvOvU=;
 b=qRmAOLjR6UzvKW8cPZJQ3T9OJVvl50z8wxEwmvMLqS2Dra+xb0jUNQ24eg3yq4GfoOvy9EuaO
 cTTFvIKcLkPB1A0Kp3mTsggf0o+4pM3FwQz8WGQ2qhpA1MEOXC22u8g
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

On some devices like TIs BQ24081 battery charger it is possible to activate
or deactivate a fast-charge timer that provides a backup safety for charge
termination via GPIO. In case of the BQ24081 it is a fixed 7-hour timer.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../bindings/power/supply/gpio-charger.yaml        | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
index 25826bfc289c1c00c338fd0cee2ae6932529cfc3..fefa09cb24ec2f501099f486c9a4eb77e64cda67 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: gpio-charger
+    oneOf:
+      - const: gpio-charger
+      - items:
+          - enum:
+              - ti,bq24081
+          - const: gpio-charger
 
   charger-type:
     enum:
@@ -62,6 +67,10 @@ properties:
     description: Default charge current limit. Must be listed in
       charge-current-limit-mapping.
 
+  fast-charge-timer-gpios:
+    maxItems: 1
+    description: GPIO used for enabling/disabling the fast-charge timer
+
 required:
   - compatible
 
@@ -98,3 +107,14 @@ examples:
                                      <0 0x02>; // 0 mA => GPIO A.11 high
       charge-current-limit-default-microamp = <700000>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    charger {
+      compatible = "ti,bq24081", "gpio-charger";
+      charger-type = "battery";
+      charge-status-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+      charge-current-limit-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+      charge-current-limit-mapping = <206000 0x1>, <0 0x0>;
+      fast-charge-timer-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+    };

-- 
2.39.5



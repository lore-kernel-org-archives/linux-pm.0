Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1BE30594F;
	Fri, 10 Apr 2026 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860637; cv=none; b=uIHsoNYd8t5xNpBEL2iWZ6DaqtNnYpc1t3kkoCH4FGBECki5hiG947+BmvgLeI+2JofhFZs8vAgio4BR9/MKTMjqcXmxkSCcEnF2UQ7r0W9HJcLdDvXg3j6JOestETtt8ePb3T/nvq23KhrReRnnBOwJQ9zxxDHH2LUFjyWcn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860637; c=relaxed/simple;
	bh=lJj67wYZ6fVbv7zuL2jgwZkUkCKxjwZ7kqlC4rIFACE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLtOTb2rI099BI2J79V0117LEssF7lFlMACNHtepd5pqcCJJ6byDSNl8cNCnRpKGm9L+v0/kqiKsUGdJ7o8HG/ERYeEtF5MUsXSIS3eG/TvLcxwgpuGuXmDttGIg45CeKE9tO7v2vb4Tyw5PmDIE8k1bTTLL6ME9/2mvY2MT++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSi+c8aa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSi+c8aa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A865BC19421;
	Fri, 10 Apr 2026 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860636;
	bh=lJj67wYZ6fVbv7zuL2jgwZkUkCKxjwZ7kqlC4rIFACE=;
	h=From:To:Cc:Subject:Date:From;
	b=PSi+c8aa0D2nSfHBsZWYoIKfMpefTai+mQxa8gbW5ue0w6OtIhBUwsGHAn1yEK16X
	 3s1Moy+SYZixivFpKESNJaXi2JEFNUDP8HpPqfRShwnClsgUF0ytV6hmmfd77dE8Eq
	 GHVnqIAaLyQgjozGf8A1GItLpAiPlOS/LZ700sR5Pty5rxkq6MZtnTndCP6ff02n/J
	 EmZYnKmNPUEkQ9Hc/KAcU1/RAbNpGkVoX92Mev63/tgczZSSLlNwpHj9WqvTOQxn8Q
	 cU2oBRDACAQEVgwpfA6Z7gvTR2+9aOGD7qarAg+yAAI2CWP10iHqk3KPn6meaQndG0
	 q0VnIPGJaz1fw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: Fix false warning with 'phandle' in trips nodes
Date: Fri, 10 Apr 2026 17:36:00 -0500
Message-ID: <20260410223601.1487473-2-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A pattern property matching essentially anything doesn't work if there
are implicit properties such as 'phandle' which can occur on any node.
One such example popped up recently:

arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: thermal-zones: gpuss0-thermal:trips:phandle: 531 is not of type 'object'
        from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml

Instead of a pattern property, use an "additionalProperties" schema
instead which is the fallback in case of no matching property.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Daniel, Please pick this up for v7.1 as the above warning is in next. Or 
if you prefer, I can take it.

 .../bindings/thermal/thermal-zones.yaml       | 111 +++++++++---------
 1 file changed, 54 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 0de0a9757ccc..07d9f576ffe7 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -129,63 +129,60 @@ patternProperties:
           which the thermal framework needs to take action. The actions to
           be taken are defined in another node called cooling-maps.
 
-        patternProperties:
-          "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$":
-            type: object
-
-            properties:
-              temperature:
-                $ref: /schemas/types.yaml#/definitions/int32
-                minimum: -273000
-                maximum: 200000
-                description:
-                  An integer expressing the trip temperature in millicelsius.
-
-              hysteresis:
-                $ref: /schemas/types.yaml#/definitions/uint32
-                description:
-                  An unsigned integer expressing the hysteresis delta with
-                  respect to the trip temperature property above, also in
-                  millicelsius. Any cooling action initiated by the framework is
-                  maintained until the temperature falls below
-                  (trip temperature - hysteresis). This potentially prevents a
-                  situation where the trip gets constantly triggered soon after
-                  cooling action is removed.
-
-              type:
-                $ref: /schemas/types.yaml#/definitions/string
-                enum:
-                  - active   # enable active cooling e.g. fans
-                  - passive  # enable passive cooling e.g. throttling cpu
-                  - hot      # send notification to driver
-                  - critical # send notification to driver, trigger shutdown
-                description: |
-                  There are four valid trip types: active, passive, hot,
-                  critical.
-
-                  The critical trip type is used to set the maximum
-                  temperature threshold above which the HW becomes
-                  unstable and underlying firmware might even trigger a
-                  reboot. Hitting the critical threshold triggers a system
-                  shutdown.
-
-                  The hot trip type can be used to send a notification to
-                  the thermal driver (if a .notify callback is registered).
-                  The action to be taken is left to the driver.
-
-                  The passive trip type can be used to slow down HW e.g. run
-                  the CPU, GPU, bus at a lower frequency.
-
-                  The active trip type can be used to control other HW to
-                  help in cooling e.g. fans can be sped up or slowed down
-
-            required:
-              - temperature
-              - hysteresis
-              - type
-            additionalProperties: false
-
-        additionalProperties: false
+        additionalProperties:
+          type: object
+          additionalProperties: false
+
+          properties:
+            temperature:
+              $ref: /schemas/types.yaml#/definitions/int32
+              minimum: -273000
+              maximum: 200000
+              description:
+                An integer expressing the trip temperature in millicelsius.
+
+            hysteresis:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                An unsigned integer expressing the hysteresis delta with
+                respect to the trip temperature property above, also in
+                millicelsius. Any cooling action initiated by the framework is
+                maintained until the temperature falls below
+                (trip temperature - hysteresis). This potentially prevents a
+                situation where the trip gets constantly triggered soon after
+                cooling action is removed.
+
+            type:
+              $ref: /schemas/types.yaml#/definitions/string
+              enum:
+                - active   # enable active cooling e.g. fans
+                - passive  # enable passive cooling e.g. throttling cpu
+                - hot      # send notification to driver
+                - critical # send notification to driver, trigger shutdown
+              description: |
+                There are four valid trip types: active, passive, hot,
+                critical.
+
+                The critical trip type is used to set the maximum
+                temperature threshold above which the HW becomes
+                unstable and underlying firmware might even trigger a
+                reboot. Hitting the critical threshold triggers a system
+                shutdown.
+
+                The hot trip type can be used to send a notification to
+                the thermal driver (if a .notify callback is registered).
+                The action to be taken is left to the driver.
+
+                The passive trip type can be used to slow down HW e.g. run
+                the CPU, GPU, bus at a lower frequency.
+
+                The active trip type can be used to control other HW to
+                help in cooling e.g. fans can be sped up or slowed down
+
+          required:
+            - temperature
+            - hysteresis
+            - type
 
       cooling-maps:
         type: object
-- 
2.53.0


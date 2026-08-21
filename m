Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E039C657;
	Fri, 21 Aug 2026 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298631; cv=none; b=QMO3ZlgAburc8NtKTh+PnH9Vrrvkkfww94zJYwJRSh+ynbRzqRKuJ5U6GyBEH/AYFLP6kPJFtn08thX8JXnYwXESfC5mYKGAyYotZtofH6LUvsQZLnxailbn4up8fS5xnpiyudxjNh1uW0leaOVvf4hAbfGqMg6dLK5X5YKvfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298631; c=relaxed/simple;
	bh=JcXE3R7736uYlQTb71bVCCgfnJkKqAagN9FLzPZ4bzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+Tm9W8jR/BkIEaa7hwqxTym9uo6oDiyGeeklgEpaIQx20eSdkU9wUhiKE8YjasElC/SgsNfe7e1rvJeJkyQ90q8VN6/4+mNkIfkuUGgzdSD3YX2+SqJAaUqbqnvyZGIEpvItdE4ITyQwPusILKOqpHVOMyo4hHhWXtnZp12HlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv1hYRbj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv1hYRbj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB273C2BCF4;
	Fri, 21 Aug 2026 07:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787298631;
	bh=JcXE3R7736uYlQTb71bVCCgfnJkKqAagN9FLzPZ4bzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bv1hYRbjaRbpPql6CZziofmWVwrE07kkm5mzs8sdTNxNdeog/ow6lAiHCMg9bdVO4
	 6S9SdT9eggXw63LBL6VOoDvTV5KmW36pFBwG7ePepHfd6amnCHhgKziOdWtkPd+lB+
	 Pp1vuNdGU8anD1eblWWFJ6cRiR0N+clilNsrCFYajPEvqhJEF6NvKeOpZMC9nVSJL2
	 2a2ZA7LzIVkxheTi6pbapsef40Gp1llilcIaf49Eel6PmiZS7gMxAFniAzO6c+3YDU
	 0ICyg1l12eGDUmYgriFfVh8qOJwb2CQK5hoDT8Kqt2MhBaDOQrPymRsc51VWPWESLP
	 1wR/w3lMJM5xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5FEC5DF7D;
	Fri, 21 Aug 2026 07:50:30 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 21 Aug 2026 07:50:22 +0000
Subject: [PATCH v3 1/2] dt-bindings: thermal: amlogic: Add A9 thermal
 bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-a9-thermal-v3-1-0e7abf3941e3@amlogic.com>
References: <20260821-a9-thermal-v3-0-0e7abf3941e3@amlogic.com>
In-Reply-To: <20260821-a9-thermal-v3-0-0e7abf3941e3@amlogic.com>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787298628; l=1648;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=RACRXv6wox/b/kJrRZQpbFDTY/mpoFOjI3DgG70KeU0=;
 b=7K5Yu3F5VC+UwdiQX9syws7dn2XX2Xqermn/j9RhUU6zfOwZhKz+4rpBKHUg2PCzRDaTJR9J6
 HGYssEp3iRRCK+iNgWKomzc8Yk4pM4xg2MvnYmOUrmjFQLoXZixvZYB
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the thermal controller compatibles for the Amlogic A9 SoC.

Describe the required "core" and "plck" clocks, and update the schema
constraints for A9-specific thermal controllers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 8cfa44dcda58..1b02404d67d5 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -23,6 +23,7 @@ properties:
           - const: amlogic,g12a-thermal
       - enum:
           - amlogic,a1-cpu-thermal
+          - amlogic,a9-thermal
           - amlogic,t7-thermal
 
   reg:
@@ -32,7 +33,13 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: pclk
 
   power-domains:
     maxItems: 1
@@ -73,6 +80,24 @@ allOf:
       required:
         - amlogic,secure-monitor
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,a9-thermal
+    then:
+      properties:
+        clocks:
+          minItems: 2
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.52.0



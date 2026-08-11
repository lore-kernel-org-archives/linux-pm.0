Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E7439359;
	Tue, 11 Aug 2026 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492658; cv=none; b=F2lMcW9wrRdiVJQB+tZwIj2dFSI2QO6KAdMtKpeflF9mKhLMrKIx3B/kAeQhn3+ZgTvjXnmnblpMqTFxM+vuF1X6NUcW8IIhm9+vIo5fpPoyuzMZ1PMQRL75dQpzMW8PIEcC8P8OdCPJj4MmdDwqQonrhOCbu8Xs+KzXeBcm5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492658; c=relaxed/simple;
	bh=bi7+AMfBXaYyNTvrjzrTqimxyEN70um5fPfg6a9aJvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VD32oqv2kEOvk0xzRoJPTFEv6ZFWXp3s8BKQqKrgKTC5+5kmLtsFKEidS3tT9QuBGA1R09BGi0ANJHtCaHofREGTOESLEBpPj/wGnWR/Q5RRh31leS7nK/HUQnoHw89ldAmA2nSKfcg7uyDhGFCepT3y3sjTOfXV6ueSzmEc7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPdYlNeA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPdYlNeA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D988C2BCF7;
	Tue, 11 Aug 2026 23:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786492658;
	bh=bi7+AMfBXaYyNTvrjzrTqimxyEN70um5fPfg6a9aJvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UPdYlNeAiOnI7TkVCpNBeGyLD4k8jRwKJSKkNUiLYOJGcOgW5ywkLJLb3zLksRlPA
	 2TR3BxbSx5qdxlnofqI4IjzR1ogqvrjZCcVMEwcsxDVXepOe/PA2tQlCIn4dMlnSlh
	 MAd476yT0tX5KvBRPSYeK4iyz9FtA6jSuw+p9qwY4s8HpXXtwDZsXMOEkJqbbZ+9Gp
	 Aebazos7EWrOB2l13P/qU6IGP1YQx/K979jBDYhj4rAYV2GE65kkeVtNkm7XGRMwBh
	 0ggNL6qKMytQ/p9fZSieIcUOJRzk4UmPxYX6btSDCWQUMslbpS9bnzdMet/mzBUAE0
	 mWvl0VMrE9h3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3748AC5AC67;
	Tue, 11 Aug 2026 23:57:38 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Wed, 12 Aug 2026 01:56:59 +0200
Subject: [PATCH v2 1/2] dt-bindings: power: supply: qcom,pmi8998-charger:
 add SMB5 PMICs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-submit-qcom-smbx-send-v1-v2-1-f504b8f9bfad@snyders.xyz>
References: <20260812-submit-qcom-smbx-send-v1-v2-0-f504b8f9bfad@snyders.xyz>
In-Reply-To: <20260812-submit-qcom-smbx-send-v1-v2-0-f504b8f9bfad@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786492653; l=2055;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=dbA6J4pyEhKqtE5cFdJw1mjwn3vo7LHk/ON/7cmUiY8=;
 b=oNDrBKKRzA3d+ClM5J/nzWYKUJTNbIl8E6KKzYABNjOa2iuKV7MLeGImkYiXxKCAO9iLt+uK4
 sVnoA0aEXx8AKQSMkd6YxxpFuVIxs8f+gObC4anf5Bb82LLnkM+v/Ol
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

From: Casey Connolly <casey.connolly@linaro.org>

Add compatible strings for PM7250B and PM8150B, which contain the SMB5
generation of the Qualcomm switch-mode battery charger. PM7250B uses the
same charger interface and parameters as PM8150B, so require the PM8150B
compatible as its fallback.

Clarify the IIO channel descriptions because SMB5 exposes a USB current-
sense voltage while SMB2 exposes an already-converted current.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
 .../bindings/power/supply/qcom,pmi8998-charger.yaml     | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
index 70f5cd6eaeabe..25511e2e33691 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -4,16 +4,21 @@
 $id: http://devicetree.org/schemas/power/supply/qcom,pmi8998-charger.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
+title: Qualcomm SMB2 and SMB5 Switch-Mode Battery Charger
 
 maintainers:
   - Casey Connolly <casey.connolly@linaro.org>
 
 properties:
   compatible:
-    enum:
-      - qcom,pmi8998-charger
-      - qcom,pm660-charger
+    oneOf:
+      - enum:
+          - qcom,pmi8998-charger
+          - qcom,pm660-charger
+          - qcom,pm8150b-charger
+      - items:
+          - const: qcom,pm7250b-charger
+          - const: qcom,pm8150b-charger
 
   reg:
     maxItems: 1
@@ -30,8 +35,8 @@ properties:
 
   io-channels:
     items:
-      - description: USB in current in uA
-      - description: USB in voltage in uV
+      - description: USB input current or current-sense voltage measurement
+      - description: USB input voltage measurement
 
   io-channel-names:
     items:

-- 
2.54.0



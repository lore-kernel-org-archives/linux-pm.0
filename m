Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B6267B89;
	Thu, 13 Aug 2026 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617978; cv=none; b=Q3WIhV2yJzV/r1pN3oxkxqIuao4waIEMQXCNjTB+tL8zH6z6Tom59qzYEQ0F+tpI3QsCVPxAikv8D2ANfI0hYXKxMV7UJWzwwaA6iysyWOW/lHZI3u8UkDJZMCCDJmQPM/EJFH9bwjZG/C+igO1Db7Ft07qgYqG0zOUs8vn3GZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617978; c=relaxed/simple;
	bh=Fds5UbBmCipZ8N0vv0DCOyQx8tD4HuIpz8GLtrhKgxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfsAirPsesBj+BLyt7A/G/UvQcbMk8ZwmI8wlHVwuViy9NL8V+m1c2paLcRust0heFqj/Jk+aKONNvq/5OSloLtUp99wfR1m/n01MMQaG619Sa4RxZ5W1NrfuvVbzI9BdAHGRMdZ/XkVWyliquH2kEcdRc22ky1URsaw1fzy9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCAG+5eE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCAG+5eE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A70D3C2BCF5;
	Thu, 13 Aug 2026 10:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786617977;
	bh=Fds5UbBmCipZ8N0vv0DCOyQx8tD4HuIpz8GLtrhKgxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NCAG+5eE9iK65K4FEc7hup1/DPvCGaWYb2XWBZmUUCUguTWy3qR2ikynL1RSAuNMq
	 3YuCCg2s/goA6u8aY4wgdkrBylrrqCdjkKbIhPEMkwi9Gpuqd4z8mObZNBUNXyorti
	 LN13f4Phyx2Z4llaSXJfNIVjwnS0P4JuH1CzIoqSkMMqHEz19bYhGkm1jISA4KbqZu
	 KUt2xMCOSHQ2C4Iukn36FM1G1QbvRAQjAL7JngBgu5m2sbvd0eFlhrDvQRAOc60lZl
	 I46IYYXBNVZcpMooN1FyuEn2bKhhAvQavfdH/XHa0Isu7eWLeSj6xxfv6NB4Bm3OE6
	 FzhZyuKlWFmNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B531C5CFEB;
	Thu, 13 Aug 2026 10:46:17 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Thu, 13 Aug 2026 12:45:41 +0200
Subject: [PATCH v3 1/2] dt-bindings: power: supply: qcom,pmi8998-charger:
 add SMB5 PMICs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-qcom-smbx-send-v1-v3-1-27be0091d7c7@snyders.xyz>
References: <20260813-submit-qcom-smbx-send-v1-v3-0-27be0091d7c7@snyders.xyz>
In-Reply-To: <20260813-submit-qcom-smbx-send-v1-v3-0-27be0091d7c7@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786617973; l=2126;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=Qrmj6D1SWDvnIOdgQCKRDYGJ64appwKwuieBTEfpb3c=;
 b=DDSmo4uCV13PLfRS+ALPz1ygZvv689DMRxsm9IE+T7A0g+Ar3ymYtvTT4g1Fx7Hk/PWxxoH+a
 jPuyvUR5cK3AfjehkvX0jSQKjUzWY3dV1LwZdj2p92qqqZxderkyk1+
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
 .../bindings/power/supply/qcom,pmi8998-charger.yaml     | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
index 70f5cd6eaeab..25511e2e3369 100644
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



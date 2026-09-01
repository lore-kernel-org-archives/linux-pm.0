Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90643E08F;
	Tue,  1 Sep 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279019; cv=none; b=ZI9qxWIdiKkfSt6f+uOzWc96G3U/5FQs5SXjB1BQhv6hnztsra6nA8jRi7CnO7e9fWNTpuI6s7HFvfuOfCaby6Hem6dIBreB3P1PlO1K6IQtV4ECoLUfxDwFa3VIGW1vyZqya8KTGSu/M2BHhvoFUNd8xVyi3L6Pily9mGDw2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279019; c=relaxed/simple;
	bh=RptdQtxcU1Eg50Azmm07aVpdDaygsib90ALDYffTF2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSFWgmxaSIGfzvwjyBVEv5ZaKaGA8yb0mUIBrW1yqUODdUXeNIF7hF964ZOLrEqGtKqzTnpm/akkS7vVLvGK4e35XMjwugEeodZKvl5JppnxfBzLRxaKwKe296tTXp58P4tGkyZ4zsMFucq8bQFArm2I36KBhnX+ccdFxMxvpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Thym7g1p; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Thym7g1p"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7436211CA04;
	Tue, 01 Sep 2026 18:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788279010; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=hLMiBrwrw4ZktLKOCsjz3SvVWtKYhJvOAOl5VBM+fkY=;
	b=Thym7g1pqhFHVBTs9XwnjleAtUiFmK2bcV+aJtdpmxjSq33Eukk0cSMit+4lVobxQf+fEs
	g0Hxt90GxlNcUI4qmJJ3zGc1+ApR8dhVlPta7B356SmlxLS8Dq0Wiz4zALRZdB6vwBMgZM
	U+uEU+BDClCY+iSQuIOlnbpSIPCTll/n1ALTkjiTUg3+ylcwucSX/SjQwhEixXXyyWW70d
	bNpzJjGBe/EP2ZDDeqicATP8ZXVPHqumWz4Eiqj/xNZib6fQDi1fbqKuKENoVENpSqOqXh
	ozGO4zNqMzMc/lJpKh3i96ro4AOmx1N/AW0BpJ1CZjV+9XqFg7SNO/vfJB+JEw==
From: Marek Vasut <marex@nabladev.com>
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: hwmon: tmp102: Document TMP113
Date: Tue,  1 Sep 2026 18:09:20 +0200
Message-ID: <20260901161008.46948-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The TMP113 temperature sensor part is register compatible with TMP102,
document it using a fallback compatible. Unlike TMP102 and TMP110, the
TMP113 does have additional unique ID registers, it is up to the driver
to handle those.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
V2: Rebase on current next and resend, resolve a conflict with commit
    d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml")
    Note that the TMP102,110,113 are backward compatible, therefore the
    valid compatible strings are:
    - "ti,tmp110", "ti,tmp102"
    - "ti,tmp113", "ti,tmp102"
    - "ti,tmp102"
    The TMP103 is not backward compatible, it only shares bindings now,
    therefore the only valid compatible string for the TMP103 should be:
    - "ti,tmp103"
    And that is all, no other compatible strings are acceptable here.
---
 .../devicetree/bindings/hwmon/ti,tmp102.yaml          | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
index 55d9f106465d7..c0b747a9ce0de 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/hwmon/ti,tmp102.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TMP102/TMP103/TMP110 temperature sensor
+title: TMP102/TMP103/TMP110/TMP113 temperature sensor
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
@@ -13,11 +13,12 @@ properties:
   compatible:
     oneOf:
       - items:
+          - enum:
+              - ti,tmp110
+              - ti,tmp113
           - const: ti,tmp102
-          - const: ti,tmp103
-          - const: ti,tmp110
-      - enum:
-          - ti,tmp102
+      - const: ti,tmp102
+      - const: ti,tmp103
 
   interrupts:
     maxItems: 1
-- 
2.53.0


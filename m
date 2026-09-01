Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3248EBF1;
	Tue,  1 Sep 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284942; cv=none; b=ILw9rWCIWMho+pqr5TaefrICg7kxPFN7a+lvw54n/0QEiQol7KKlEnuao44mq6TIb/ahdw7D6/1r2+EA2dYN2SLTcoWCMLoAh2yl5hPRSahmloiCFDngol1+2eOtp1jUEEQT5j9DKCCPZQhPShya5yLnhC3pnO4SIt2pSJviyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284942; c=relaxed/simple;
	bh=PHoy9DBUjt+sql2oZyedXEDDK1/+8UUfq8ZZII/K0y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QivCtOJqZMvyj+h2tJi5AYKO97tkW3eVpc6dzWHzPWarGz01BzFjpTOxu73olCbfpOQplbNk6j8qKJgw72ldgaso9jOQwNmYJIQee2tptNSbCR+NhiZPAO5Xz3lHtbb7GO1wSHQPHvEbl9dW8PdhFMjmd02T2UQea2ukRn/rL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=g9DxJ5DN; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="g9DxJ5DN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FE6E11D490;
	Tue, 01 Sep 2026 19:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788284934; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZnjhyMpDCLEt3ReNz5uWtZLidaGrMvkbYQHHrznNMNk=;
	b=g9DxJ5DNBBFjoFOQufvzYaKweR+3aP3bzbrwDRJPARiQKAQOt9jPF2O4FYEnBJdiX8D4ha
	yvQl6KdxLqcCxV1CbVJh0E4J1CorImL68v64XhNsws7Cb9O5qwR3QcN05POeLa5aCoaQ3g
	JvzxPni1N1YLpbkD+yGM9HA6hXeY64Gr820Vt0KhRT3mYJcZARnGOx6n1fGZkANTDVHDFb
	9vlXA+efDzquQlnBrKZEh/4cZqD7nHE7uVUs54z9aPN/5rB48WaQlVyo9/tmsmpHnYwheF
	yKHLw5Xn0b+Lhkp2fMMH++X/rglCr4TaGs8dLfBtztvm+08dEn7joQ1ujmdGOQ==
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
Subject: [PATCH v3 2/2] dt-bindings: hwmon: tmp102: Document TMP113
Date: Tue,  1 Sep 2026 19:47:55 +0200
Message-ID: <20260901174847.97261-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901174847.97261-1-marex@nabladev.com>
References: <20260901174847.97261-1-marex@nabladev.com>
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
V3: Rebase on top of 1/2 dt-bindings: hwmon: tmp102: Fix up TMP103 bindings
---
 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
index 477f478b9dd0f..c0b747a9ce0de 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/hwmon/ti,tmp102.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TMP102/TMP103/TMP110 temperature sensor
+title: TMP102/TMP103/TMP110/TMP113 temperature sensor
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
@@ -13,7 +13,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: ti,tmp110
+          - enum:
+              - ti,tmp110
+              - ti,tmp113
           - const: ti,tmp102
       - const: ti,tmp102
       - const: ti,tmp103
-- 
2.53.0


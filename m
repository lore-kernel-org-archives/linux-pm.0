Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19848C8A3;
	Tue,  1 Sep 2026 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284937; cv=none; b=Xd5UoedIYV91WtfrdrHoFQ54V24EI+T0dc2KIqrII6a09xHJsDKT6w+L5KSu32u20uB1koxkbNXv0h6J6Gr2j/ckYRTvUUCv/16zDwYankSyoWsWl9Xp9Jfr1Er9iRjsfqsFcGaViWWfwNuhh+AtRZmrfwwPlX8iwCrl9WU8Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284937; c=relaxed/simple;
	bh=+NN+737C+zeCVWm4bVihSnMUWkRbWrgTckBmzgCxemw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJERhNelMUCXriq2KbuSCh6v+oK1Q/kuo0xF8KvQzC1kylsrMzc9vpFUZwcN2L09QqNRV4oo1dawVG938R0VfgLSQEcRd+HKMLiIGYSbiLRBNMfFBMGgGptu2dZ7ttuTEhIM1pmsgMVGGaK0SRHv0+fsAfJ6DtOha9buCVQMFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=biSIBo/O; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="biSIBo/O"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3850E11D496;
	Tue, 01 Sep 2026 19:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788284929; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=SpO0b7aLeLZ17aDo36lr7XvOc3vBg678O1R+0Eo+0jo=;
	b=biSIBo/O8am2pbW77uXBNbqEpO8TLoge5us/xMx0iwEincbUTGYnBXU7OA79sqSAWbHh50
	xZMcFYKNgogTeH65wxsbf5tHHVK5nJ64cLqRsOCzatoIdaQBwl7tibrTgOybRZLz8orEO9
	ykU0Cd3oOGYfPPI1MuHQ521vvMWhJCNllsYc8qdSleK67ij99K48aSBPSsAwgfh8qaLvXJ
	E/g4ZNQNJ/JY/rYtHVxx/JWXtWHmgjcK12JjkWZ8+dgSIT4QkMlQHRZZOA24mtuIhl74V/
	2ISi1FAL6rVvuAMsqGpcAFfXzNIIEhkUtkt2Mw4PAttEtAF0MVD5xaOMXZE0Sw==
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
Subject: [PATCH v3 1/2] dt-bindings: hwmon: tmp102: Fix up TMP103 bindings
Date: Tue,  1 Sep 2026 19:47:54 +0200
Message-ID: <20260901174847.97261-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The TMP102 and TMP110 are backward compatible, therefore the valid
compatible strings are "ti,tmp110", "ti,tmp102" and "ti,tmp102" .

The TMP103 is not backward compatible with TMP102, but it does share a
schema now, therefore the only valid compatible string for the TMP103
should be "ti,tmp103" .

Make exactly those three compatible strings valid and everything else
rejected.

Fixes: d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml")
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
V3: New patch
---
 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
index 55d9f106465d7..477f478b9dd0f 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
@@ -13,11 +13,10 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: ti,tmp102
-          - const: ti,tmp103
           - const: ti,tmp110
-      - enum:
-          - ti,tmp102
+          - const: ti,tmp102
+      - const: ti,tmp102
+      - const: ti,tmp103
 
   interrupts:
     maxItems: 1
-- 
2.53.0


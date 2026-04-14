Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ADB2FDC27;
	Tue, 14 Apr 2026 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148396; cv=none; b=B4qaUEDtJ9noAe71CYn0uau9J9s9PgPDMco1yCxFmawQqT1zSOioyjvKxKGtOA9QQYxh+lFYq086qkjSJSTypclWBo4t1qeSoWlNiIBCd4KUbejhgg3z1nT7UqbDqsXs5KD4TEUOxDrvNvpquKgQdcjMwwbvmjpaD0xrAaurtew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148396; c=relaxed/simple;
	bh=yhg5gVajDM6Da2FgjY3mvjRRBtWbHEv5TqLXfC/zzJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAUAjIHjqUCUqjc8pT0Xgv4j2ODKoBdwGBQscUwUC42MKuJM6yhvdOKuqX+0SxaH9q2Nbkz3DLwbD4fkl6If2vY27y7qGtbSEhjvG+m1boFqbmRGqJrnE+Z5bUpJqM3xgT4seRooGYrI7WtNIZ2xkuVR7p14UwS9qn9L7bnmN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KoCd2V9z; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KoCd2V9z"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3DC6626626;
	Tue, 14 Apr 2026 08:33:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IjYjTBrWW-8O; Tue, 14 Apr 2026 08:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776148392; bh=yhg5gVajDM6Da2FgjY3mvjRRBtWbHEv5TqLXfC/zzJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KoCd2V9zOuQWQmIYi8CV1/Z5Cxx4G42ZQdCftbNKGu75jc5xHz8gCYT3cOBH0wnv7
	 pCQPAXEZ0TevG84oScfVWXQiyPg30m1lr52/Spnc4hY740kNU1evpsO8aJ2Oveovni
	 2ZXSyfX21zbtnTGRGHIyTodZ32OGBvneCDEtQlOGhe36r3Ih4rFBP+dzkOCV+60Yh2
	 raywzMyOMC64B/ZnrAdDSb8280r86dPc/Bk8+ams/VXJicGhNR5c7F1myWob/xyWCp
	 7tPDVDl7OZxe3uVB+N4HLb71MSElz+LHZSOsZpq8M+3dMqDM24OF701IXeaekW/rYt
	 ozOgrGcaei+lQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 14 Apr 2026 12:02:53 +0530
Subject: [PATCH v4 01/13] dt-bindings: leds: document Samsung S2M series
 PMIC flash LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-s2mu005-pmic-v4-1-7fe7480577e6@disroot.org>
References: <20260414-s2mu005-pmic-v4-0-7fe7480577e6@disroot.org>
In-Reply-To: <20260414-s2mu005-pmic-v4-0-7fe7480577e6@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>, 
 =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Conor Dooley <conor.dooley@microchip.com>

Certain Samsung S2M series PMICs have a flash LED controller with
two LED channels, and with torch and flash control modes. Document the
devicetree schema for the device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/leds/samsung,s2mu005-flash.yaml       | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml
new file mode 100644
index 0000000000000..36051ab20509f
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/samsung,s2mu005-flash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash and Torch LED Controller for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC flash LED has two led channels (typically
+  as back and front camera flashes), with support for both torch and
+  flash modes.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-flash
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false

-- 
2.53.0


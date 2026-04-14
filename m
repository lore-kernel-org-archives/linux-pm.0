Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397630215A;
	Tue, 14 Apr 2026 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148405; cv=none; b=eW57W/4n78r1OunwqqZg2Jd8u+z9saswzWpOvxiciS32LduF/z/IXQ9F8dq5Mc7QSjJaf3BwQvMja5m2utqG1yM2eZb4mZgmyqzrbCbiJDIx8LImavGfKWg3HRMC3HeaS61RNBAgW7Z+zOrMXMVY+49pxLOaK1oulstJCIaxXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148405; c=relaxed/simple;
	bh=8T95U2NjfpE9/lMDbO20IOthIFirorsSd/sZcss4e7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7R0pgg+e7eNUoTW2xBtSWtA3F5Rx5I6KEvJZiAVqvZ5tR33qWTuqI/+PkUYji9aVBbbYAskEQXdJTHnbPNvZg8GpnJIHexsfXhrOP34S2ZrGee7uvBe9Ru7wiFeP8+WeOugssSwcbmRhF9FrcGSDkpxPOuF3oqkUXMfoc0USw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NnCGT8SD; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NnCGT8SD"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A4B4725F15;
	Tue, 14 Apr 2026 08:33:21 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7L5axfLCGBP7; Tue, 14 Apr 2026 08:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776148400; bh=8T95U2NjfpE9/lMDbO20IOthIFirorsSd/sZcss4e7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NnCGT8SDOd+ejUEU8fmmuB1eg9QJh/IJgAKYOAY8b5xdL6MTIElr+uHfqLOL9aRgA
	 e81rr9GO/QEgDqjPxvKKH/TQRH6KE1RTE5CgbkWk1SHG2vRish+YgmJB8CQPlVVCP7
	 3LYmkOf8sLrWjEUlyWAsHiAqmDB3zdW3wkjnemGMJPU/7YKVYFKbY+NpbI4z1iqHzs
	 MEe2d5xkCLVv+ArIT+sDxrHVTDSYZEKNM47yET85pf5LA/qA9tHgzwokolYhS9K+VY
	 ucG0bOO1s5c+MIxQJD1dp0i/HUTALTZ5AQIOt8G9zytAtZnXMSwmEiJzpLeoEpf1xC
	 wa7bgtY6cOL/g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 14 Apr 2026 12:02:54 +0530
Subject: [PATCH v4 02/13] dt-bindings: leds: document Samsung S2M series
 PMIC RGB LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-s2mu005-pmic-v4-2-7fe7480577e6@disroot.org>
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
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>

Certain Samsung S2M series PMICs have a three-channel LED device with
independent brightness control for each channel, typically used as
status indicators in mobile phones. Document the devicetree schema for
this device.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/leds/samsung,s2mu005-rgb.yaml         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
new file mode 100644
index 0000000000000..6806b6d869ff7
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/samsung,s2mu005-rgb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RGB LED Controller for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC RGB LED is a three-channel LED device with
+  8-bit brightness control for each channel, typically used as status
+  indicators in mobile phones.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-rgb
+
+required:
+  - compatible
+
+unevaluatedProperties: false

-- 
2.53.0


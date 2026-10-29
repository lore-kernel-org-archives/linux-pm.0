Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296585;
	b=f0m9VqrkEIhO8SIvwTDmW5b029ia9J3mhKTDtVBJ6Qthk/znPg2oTEJhhFuWdLcSjAuk
	 q2FRvApdgFSkJV5G8JyNm2d+izzf+bUBzSgNkJem2FyPWYfdIXnNlyE9QrLwyJBQGU62D
	 lbGA9aJ3E3K9MOAb+cF11xmYzIDEyTsSWgENmSYTjwmszBC36q+BIv860qUD5MfF2wP4r
	 M8KvRcgvYUm26oCUuHtlJJ/Vgi6MbarEsnxZ7ffreZH7CGUWsE4TcWZaAdFyRsARwvXP3
	 0cTYxHl77HLxwSd37rG8kFeU8158iCs5qGqwyQJ0GjUbUi3SP1IBbz8JeeeRcscqvSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296585;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=0/O+WkT5yZ/SiY5eXiRnShrS3xo8ikcY3TBBE1YNSxc=;
	b=Kan4ETSwSv5UkMCANkUIiG4yhemytjXMkNSsyEbrBBkn67a2fg9ZLAs68vA5+5Teg94V
	 eOsWvdOmSCale9GXOPiu/PnvckB+iGKovyiwOZXoqM6m2gyAbb0mmO7Pft9RzMk+NaJYZ
	 qPGnBpKO58ywam/gTNNzZpTU86tVXepDfn5kWg/kMDeMPXmpCEcBokJtPyKHaLn1MTEjr
	 WIX3OwTxSSpENHlXs4oQnpvrfhOiYFV9EjZpqwAC8UGO4MtQCB4VpTVgoghwTzbJAz2Th
	 B2EXmmRJSCT5YGJkqg3UbopeGbNeCkzZlbfbnPAcOfp31eQF92TY/F309Lbw9hWUXZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=YoaQ5XG0;
	arc=none smtp.remote-ip=31.44.14.16
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [31.44.14.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C5606A322;
	Thu, 29 Oct 2026 17:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 244C5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=YoaQ5XG0
Received: from mail-nwsmtp-smtp-production-main-38 (mail-nwsmtp-smtp-production-main-38.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:4d01:0:640:e9ac:0])
	by forward500d.mail.yandex.net (postfix) with ESMTPS id DFD4C8077B;
	Thu, 29 Oct 2026 20:56:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38 with ESMTPSA id itnBq5Sg9Sw0-pJpPCqK2;
	Thu, 29 Oct 2026 20:56:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1793296573; bh=0/O+WkT5yZ/SiY5eXiRnShrS3xo8ikcY3TBBE1YNSxc=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=YoaQ5XG0yhP8ftYdv3IzGthIAPvTktL2v9ZKadoI+LoczCMhpaydK098RgQZqeAiL
	 AkgY5oUe9ZXvoMT57t4R6qQZ4AVVzywS9oygPhK7IYNvFNEA9SJrwzAoN35sbbekl+
	 Uf1AfzMkhLl6ul1W8JzuICBPdWeT7Sn4MK+JwsoQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-38; dkim=pass header.i=@yandex.ru
From: Kupreenko Danila <keckerz@yandex.ru>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] dt-bindings: power: supply: add CellWise CW2017 fuel gauge
Date: Thu, 29 Oct 2026 20:53:16 +0300
Message-ID: <179329639684.489944.5633074738687761900.cw2017-first-public-rfc-1@yandex.ru>
In-Reply-To: <179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru>
References: <179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: CW2017 public RFC via Python smtplib

Describe the CW2017 at its fixed I2C address. The battery-specific
profile must match both the battery and its temperature input. Do not
introduce a profile upload property for the read-only monitor.

Add the author's explicitly agreed local maintenance commitment.

Assisted-by: LLM
Signed-off-by: Kupreenko Danila <keckerz@yandex.ru>
---
 .../power/supply/cellwise,cw2017.yaml         | 52 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cellwise,cw2017.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/cellwise,cw2017.yaml b/Documentation/devicetree/bindings/power/supply/cellwise,cw2017.yaml
new file mode 100644
index 000000000..a8404f150
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cellwise,cw2017.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/cellwise,cw2017.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CellWise CW2017 battery fuel gauge
+
+maintainers:
+  - Kupreenko Danila <Keckerz@yandex.ru>
+
+description: |
+  The CW2017 estimates the state of charge of a battery using its voltage,
+  temperature and a battery-specific characterization profile. It has a fixed
+  I2C address of 0x63. The CW2017 is not register compatible with the CW2015.
+
+  The battery profile also configures the temperature input. It must match
+  the connected battery and temperature sensing circuit. A profile selecting
+  host-reported temperature requires an external provider to keep that input
+  up to date. The public datasheet does not describe the profile encoding.
+
+  Datasheet:
+  https://uploadcdn.oneyac.com/upload/document/1737612108523_8373.pdf
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: cellwise,cw2017
+
+  reg:
+    items:
+      - const: 0x63
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fuel-gauge@63 {
+            compatible = "cellwise,cw2017";
+            reg = <0x63>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 748ce4d1c..27124fd02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6154,6 +6154,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
 F:	drivers/power/supply/cw2015_battery.c
 
+CELLWISE CW2017 BATTERY DRIVER
+M:	Kupreenko Danila <Keckerz@yandex.ru>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/cellwise,cw2017.yaml
+
 CEPH COMMON CODE (LIBCEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
 M:	Alex Markuze <amarkuze@redhat.com>
-- 
2.56.0


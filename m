Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.174.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302495;
	b=R5eW+9yOJL6Ry1rytzd/vd2DNKKh1l88PonRa1+uqJNZzSYfP3Up8y4d5wLSu4VP+l3I
	 3KhQr4Ktxy9r3BTILleT9T3G5gqa5pU4VndVrf42mlSjUtB7VreMVkbzk2uA0XxDQpjPY
	 DQ6SS52KuPNgLmCIULlL3zVufVU0BstpGr/CZfRpphgPNB13F+KWhtyExoU7N094evqv1
	 I5M7Cvce02ao1MsWrpTtL9dRLTadvgCIfG5Xjgfoe9ZhjcWulKAEvqj5RHOAWBi9nr2rk
	 r9cJYDcO43d5aJtLKU/L+TfXd+6f3exDBMrqgdcwYb7Dsj6MWMkIj5WGEFk1GscRJFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302495;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nTzr8Sm4p2iVpwceNj/Qu1Hpk/aeZWQJzTOXwmEWg1I=;
	b=VrCBxpZJQLBzmQoVod38P/WoaNURWWHUM4RFOOT+iP+PXtKRxWonxRP9JCIAefpe1bKO
	 ltLU9Ue7gRjtn90yLAxQVSLFY3t6cJAmkUQhNiqKoEMQV5uuedRwPGWw5EH9efSKbcFEn
	 fjSOaLbTyd8QB3DkpU3T3i6AgD0vgWJyIa2ykd5vccVFVp845+Mnfw7VE53QzEwAb7IzJ
	 y5BJVtNLxf4G8cgk4Y/oXyTrfgWQnDF3njWVvDIVfud+mXu87TZ3z0ulRee+OB2iTKDSB
	 fM1WJItZStbho4jAgd8naR9z364MopTpkkFgWQKJVndMEKoGdh25FxB+nZU2OF6FqfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=A41s749m;
	arc=none smtp.remote-ip=37.230.174.41
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [37.230.174.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39566606A31E;
	Thu, 29 Oct 2026 19:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39566606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=A41s749m
Received: from mail-nwsmtp-smtp-production-main-34 (mail-nwsmtp-smtp-production-main-34.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2499:0:640:3812:0])
	by forward501a.mail.yandex.net (postfix) with ESMTPS id 3399B805EB;
	Thu, 29 Oct 2026 22:34:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-34 with ESMTPSA id NYpk4nSh00U0-x17ILxOH;
	Thu, 29 Oct 2026 22:34:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1793302484; bh=nTzr8Sm4p2iVpwceNj/Qu1Hpk/aeZWQJzTOXwmEWg1I=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=A41s749m7lHa868KGYzimiORqAeB5G6HJt8WQKkC3cGJ3UEY536mGeo3ZFTHCmMI3
	 JDqh7GXDDzmn6OBzHJHxCcAoDxJmAALYOC04bj20QEgE3rv79qsBrQLTwh0o3Cgn05
	 40sxCCzlv9c8JNuWybcatIhHPIvfOKOijRbQWGOw=
Authentication-Results: mail-nwsmtp-smtp-production-main-34; dkim=pass header.i=@yandex.ru
From: Kupreenko Danila <keckerz@yandex.ru>
To: sre@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/3] dt-bindings: power: supply: add CellWise CW2017 fuel gauge
Date: Thu, 29 Oct 2026 22:34:15 +0300
Message-ID: <20261029193417.551058-2-keckerz@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029193417.551058-1-keckerz@yandex.ru>
References: <20261029193417.551058-1-keckerz@yandex.ru>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kupreenko Danila <Keckerz@yandex.ru>

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


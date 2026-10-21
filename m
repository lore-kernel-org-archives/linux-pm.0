Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792611225;
	b=pxM0VSBevEJlERKm4TYACneuZfA3OYsSUOZ8g1DUkT1hqBTc9vObg+eVOt4RnImlFxDP
	 8SsM4ufzxe02QVffugiUURiTuIO0UPFXYOj9k4KZGHuE1POunvtmqiiDz0XI6xR8IAzeE
	 mmWtpujXYMRhEJg07rkCAy74pHryUm+AhGuhBA0qvfuQSafxVXIsOLcM75PS6TjLz+VYO
	 ANKyJNmmPTboXoYPAeC1Av5Q41N1vSDSmVnKcmC3SUFEm6WNtdHYSpWIPH9uPa0IqXOZd
	 whWb867gQ1yxzdudQgEHDe2MoxHWNmmzo/bww2yQYLRu/KB9wSqbo+DqsXDuqmHpuZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611225;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LD6GhpQUC6PBN6sViET/Wa/GPLLRuDAVHQjCNHuKbKw=;
	b=z5SNszEp/xRhULOxB7t0/f161lQX9Yirf9vAYJ6uj0+dl/S6QcXrgiWuQRWMlTcmWzDk
	 v28GsIgKeEuGm/xyv2cGaeHoiOckig/tNkXfJgBd47eFBoFd4OVsLEDspmEH7DYdkkBBO
	 6vbrX1lzjM+iDV40RvO4slN8tbSfBNLR6WIsWXgF59gT9EORO6CoseyEAbpbyNeLTLusd
	 GkB5vEtsJ0zUEbIrQmk1EQFW2IE0HDX02UpyvOplHNYqQYw56CW1DhkbjTsMmfh1E6YeE
	 brhszUB6TaZj2oDW17mfTPy4V0650XGpimCkZtkeivjTvz0vsTv/crMzQ0Db5a5tpXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbpqMvkc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC77606A319;
	Wed, 21 Oct 2026 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbpqMvkc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792611224;
	b=VYeYlsTsMCOgOdNFIPf7Loy045+ZibYZ+pzqOU44cGiLCNyJu1xtSP/aQhhfzULtfdlq
	 gWf7Y2rwTzx5Jm6lFMKB2DcTz0jSIPei+I+aBMBUtfHH9Rw0L8y9opM0+CSeyCiFV0oeo
	 ScGXEwBPzPNlWarTYY3gE+Q8zAsCP7Oa/rPQm9nxCrUgO1ptifQIPaZCyO2VOngTeweFx
	 /S+UiMmUqjRJ9QNNMhz1t2+RrLVkele7NbnBoOTcx2nfS0AyGPCW5xyEFaIU3JWVOZT/p
	 TcQ8vENtGZqDMeryTNVm54kq00+47QIWAF5SzO+bh18d0G9jKtW/ACc7SKuHDiWUDpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792611224;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LD6GhpQUC6PBN6sViET/Wa/GPLLRuDAVHQjCNHuKbKw=;
	b=aUtNgkTWVbyicho1oRIwRN+2Dzyp7n0XPEbSyN2Cu4LBGlyH6N+nk37FRBfIP3xyH+sk
	 Y1Zmu5hoWo5zRm917msml2qE3wGul1q83krOvmXFDGpRcenKUI6s8FgVHM7zRImzdv9Qy
	 0TchuqbdkWJlmXlQnGdkJLwT1Ksb/Tx98pVXuMkW4nGXkogl0Kt15mR4GgC75fEy99tNU
	 +8UNeP/3rUiWtnXYsVZVRy/1eJZteBmEVa94Fc878xrg6R4wv3qU6xH+93NV1Iz6oW8PN
	 l4iyq9OZ3CMOlvJOIpApL7CuObcTBPrl0tsv+nWLTCQTxEGXsjyyQEaw6K/VXnID45Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 401AD1F000C2;
	Wed, 21 Oct 2026 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792611224;
	bh=LD6GhpQUC6PBN6sViET/Wa/GPLLRuDAVHQjCNHuKbKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KbpqMvkclUJ3HOE+AAts6FkNWJXvPzD5BVeyAp6UP9qgRHiVPpyCNbLXBXuieq6Rc
	 +tcw3pnOpOzmza5H8rJZ6gOEU1ofrZ8LkS6qNRXaX0xHwqM0BLp0c0CEhXH1q3cPic
	 SWpERv/8ZELbpQIPFXvBjcBPwI5TDY6mjTB5Q56aLPr/9Q97ncxxgrFlL2wGciLUWe
	 AoDh3e2Inu6imyXrpzh13L3KkbzGv8mFcNVZls4oEzuZQAWoNMDpNrL+QBhVBYVarp
	 FuZMbUYSzu3Pw6nWNpRQMYfv/SJl3EAsD64PIf0lR3V1FSsQy1BVtyj1R+5fJuYWHw
	 p95i9baDCEylQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9E2C9433E2;
	Wed, 21 Oct 2026 19:33:43 +0000 (UTC)
From: Serv Pol via B4 Relay <devnull+servpol.tuta.io@kernel.org>
Date: Wed, 21 Oct 2026 19:33:43 +0000
Subject: [PATCH v2 1/2] dt-bindings: power: supply: Add GL.iNet GL-E750 MCU
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
Message-Id: <20261021-gl-e750-mcu-v2-1-9bd7e7c2e0e1@tuta.io>
References: <20261021-gl-e750-mcu-v2-0-9bd7e7c2e0e1@tuta.io>
In-Reply-To: <20261021-gl-e750-mcu-v2-0-9bd7e7c2e0e1@tuta.io>
To: Serv Pol <servpol@tuta.io>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792611222; l=2333;
 i=servpol@tuta.io; s=20261005; h=from:subject:message-id;
 bh=NV3B8WNtquyc/QmniTSXc3WtCmSQvbnSES0fh7ui05g=;
 b=sw8n4tb9dg9MNaNTOTpmjGGaSxYOUo3FmWMI8cY6WY5pfXvlSyqW/d1lmcDuA9ni3Ggp7FNIy
 NMjdgkKyas7AtHg5k+RpqcADz/GA0tMiQGAd02BrJfk9F/dAKKoVBYy
X-Developer-Key: i=servpol@tuta.io; a=ed25519;
 pk=2HCjaqYjXxgwTYu30Nem9DOHT8mtKgjitt1vEXKpwrE=
X-Endpoint-Received: by B4 Relay for servpol@tuta.io/20261005 with
 auth_id=1120
X-Original-From: Serv Pol <servpol@tuta.io>
Reply-To: servpol@tuta.io
Content-Transfer-Encoding: 7bit

From: Serv Pol <servpol@tuta.io>

The GL.iNet GL-E750 (Mudi) travel router has a microcontroller on the SoC
UART. It drives the OLED status screen, monitors the battery and reports
when the power switch is turned off, a few seconds before it cuts the
power. Add a binding for it.

Assisted-by: Claude:claude-opus-5-5
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Serv Pol <servpol@tuta.io>
---
 .../bindings/power/supply/glinet,gl-e750-mcu.yaml  | 37 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml b/Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml
new file mode 100644
index 000000000..a7ea4dde8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/glinet,gl-e750-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GL.iNet GL-E750 status MCU
+
+maintainers:
+  - Serv Pol <servpol@tuta.io>
+
+description:
+  The GL.iNet GL-E750 (Mudi) travel router has a microcontroller connected
+  to the SoC UART. It drives the OLED status screen, monitors the battery
+  and reports when the power switch is turned off, a few seconds before it
+  cuts the power.
+
+allOf:
+  - $ref: power-supply.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: glinet,gl-e750-mcu
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        mcu {
+            compatible = "glinet,gl-e750-mcu";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d..247432449 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11105,6 +11105,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/gigabyte-wmi.c
 
+GL.INET GL-E750 MCU BATTERY DRIVER
+M:	Serv Pol <servpol@tuta.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml
+
 GNSS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 S:	Maintained

-- 
2.47.3



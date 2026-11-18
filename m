Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993110;
	b=JS3FaoBBDFVpAqDQNROpQsK95EYPxcYAM38naZs1IfLLqLFeIgT/pEpcpJlsJy4EJmRX
	 H7fjRXjvVNZY1Su9a9S1SO/jQq5Fflk+Pi9GMZk081cKYd+2jfabnsXZIuQP6qY5FAVCd
	 AWD6CSQ2vRzVPXvCFZmJnRHrEv9iQAnPMiChU8kaBlo/sjQu/1Oj2tG/A/iGt0dCGjoOm
	 5MjS0F3BCbvkJ0zN6P8edBNPK2s6E945EDw8jtMXYDdi4CGNR9wVp+6MDakNhJd3OErNk
	 3f6XLSYzR4lKK//6dLgzwHT2DACt+yBqIDq4QgOjkJ0xF6kT5OCN/L2KaaxYlMkdDLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993110;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=EsWY/yTZXFYVprtWvUf3XnhiSXDepU5aallNWHc59Og=;
	b=F3tq/ft62Uy9yuzQvDdpBYNsCKJwEmNe0vOUHKatSSySs2Eqve0y9trUOi27Cw3lcoRK
	 m2I8YafAfAbdqtTGb6pdfFUDdqbUUUn1bBVPHAcjJGtGb9v3f1ArbudZZHsbtrsSOEgey
	 YJoSkUHOWS4bzpWApCMx5O5VqnIYTSJd5taMNvXQiDO1Wr06+wabVRBUHX0vgouG8VSRE
	 8u4pkuG7/vUqjp83kg6NhhoIkOiIpjnGn5Klc3nTRQWSVep5yqH4iAGfIagfOhlHc73k3
	 JApu7RX3MWG7+eUjMvXI/oEljg6wx4Jve3UIBnYfJNX7WRHtpwJ2zcXphDsmE1Ke0aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cg8UQOSf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB3606A31C;
	Wed, 18 Nov 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cg8UQOSf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794993110;
	b=zN5rWGonFWd3P3XPvsGyPRC6h+EKlKywBOTCBCIMCIPOSFK8+d0uI74WLQveJO2cz+EM
	 R679MQWE7w37q4Iu9Agw2Rm2wsIqMko7DjF8Ra7saBAJrPWaqNOFdK7H76ySPJ2rzzTnw
	 dEcIfuYpwPZiChmNXzzom/sAzy4FQKdKiPc2akkI1zw/mjaTZEMtFKTM+bcisvOrabIRq
	 LBhE58GmRljfyiZTKCFZ5h/aY54wCKGfpAL//mfoJgA4q98ubob04F+8RHvXUKeESa1X6
	 lGay6CdbXuFL53V5BOTqY2Cpo8TSaqiHYuGKgVwnUnbHdrW6M+luNqAxYGaZJOkIxzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794993110;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=EsWY/yTZXFYVprtWvUf3XnhiSXDepU5aallNWHc59Og=;
	b=RJcTHQKXMqCfiO7YbfQAdUrVQ/kFxTQIOWAyQUcEbGin9+UwJCA2BL34Lo1NEpV3uVoj
	 j8BAw3Feo5cv6u+d4cfrxdh7FFfZQb0qJScBmTfCkZumlZIqKLGhlu5NrDA1l1Tw4z6/p
	 CHdCIvyhkEJ8kOxxG+RVfMCwRe01ga3V8gWxsUhWRJgLKRAOoOUC72mpOWL+UNudfMDh6
	 IW6LZ6tP3TMJ5zJRlopVd5HkFHy8BINpAb63pI7PX+n6gyJp7sygyoUTVTHDmcKBgX8z5
	 SupOSgd9nfqQBuPC/du2krFYnFm9VuEZV6gy3PL5b1t2Mv8PLdH2w/WoNxM7TIsMQzA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 33C661F000C6;
	Wed, 18 Nov 2026 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993110;
	bh=EsWY/yTZXFYVprtWvUf3XnhiSXDepU5aallNWHc59Og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cg8UQOSff/gt1lIkTG6qaorIXz8eypzeWSXjxbZYP4Il+XxkiGf62fVjq0hGNvgLZ
	 pxarXkR/8UBkIgyPXA+28SZOu8m+tY/xbGzuLC7z4uZDMUvySfsN5qvb5d6mWgXd5M
	 /+E8VnwDLXvPIqFSL3ClLub3eHSmYFCJR5axIxOcB3ciwiP2t4Sk4olRxXua1cS+s2
	 izkl2YNX4qqzegTh+SlGEha7DSH+XYOrJQgtt9Vrh97z2mEqRppPVgSTWGs5oICyrv
	 Rp5yvPf9aWnPze0LTntqIZ74Suag2Zr9eh8R9ENC6hLl5s9WRM6cx5GWQFvqnVH3Uc
	 c56KdmdRSjgGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B49D34ACB7;
	Wed, 18 Nov 2026 09:11:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 18 Nov 2026 17:11:39 +0800
Subject: [PATCH v5 1/2] dt-bindings: power: rockchip: Add RK3572 power
 domains
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
Message-Id: <20261118-add-board-ok3572-c-pmdomain-v5-1-f1af919dd434@qq.com>
References: <20261118-add-board-ok3572-c-pmdomain-v5-0-f1af919dd434@qq.com>
In-Reply-To: <20261118-add-board-ok3572-c-pmdomain-v5-0-f1af919dd434@qq.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Cunhao Lu <1579567540@qq.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Finley Xiao <finley.xiao@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794993108; l=2834;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=oyvMUU7R4CjKJ/p4yd/DxcdPfUMgGd3L5BZrnlpZr8A=;
 b=n9oUdGknt5UXzLgbxGOnuZrN2DYIPg7Zf3SerWTzsMreq06AqsfiFnxINufChqBTDqW5kxwRR
 Dy0WqcIzUJXBLfzo3b2ItgK/LEJ45SvTLNHMccAsa/fk0rlpB8wD8Xz
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

From: Finley Xiao <finley.xiao@rock-chips.com>

Describe the RK3572 power controller and define its 14 power-domain IDs.
Require the system GRF phandle used to check firmware shift-ready status.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v4:
- Describe the system GRF register as firmware shift-ready status.
---
 .../bindings/power/rockchip,power-controller.yaml  | 17 ++++++++++++
 .../power/rockchip,rk3572-power-controller.h       | 30 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f95d..fbf3e0ab4cd9 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -43,6 +43,7 @@ properties:
       - rockchip,rk3528-power-controller
       - rockchip,rk3562-power-controller
       - rockchip,rk3568-power-controller
+      - rockchip,rk3572-power-controller
       - rockchip,rk3576-power-controller
       - rockchip,rk3588-power-controller
       - rockchip,rv1126-power-controller
@@ -57,6 +58,22 @@ properties:
   "#size-cells":
     const: 0
 
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: System GRF with firmware shift-ready status.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: rockchip,rk3572-power-controller
+    then:
+      required:
+        - rockchip,grf
+    else:
+      properties:
+        rockchip,grf: false
+
 required:
   - compatible
   - "#power-domain-cells"
diff --git a/include/dt-bindings/power/rockchip,rk3572-power-controller.h b/include/dt-bindings/power/rockchip,rk3572-power-controller.h
new file mode 100644
index 000000000000..c2316fa859df
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rk3572-power-controller.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2026 Rockchip Electronics Co., Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#ifndef __DT_BINDINGS_POWER_RK3572_POWER_CONTROLLER_H__
+#define __DT_BINDINGS_POWER_RK3572_POWER_CONTROLLER_H__
+
+/* VD_NPU */
+#define RK3572_PD_NPU		0
+
+/* VD_GPU */
+#define RK3572_PD_GPU		1
+
+/* VD_LOGIC */
+#define RK3572_PD_NVM0		2
+#define RK3572_PD_NVM1		3
+#define RK3572_PD_DSMC		4
+#define RK3572_PD_PHP		5
+#define RK3572_PD_AUDIO		6
+#define RK3572_PD_IMG		7
+#define RK3572_PD_VDEC		8
+#define RK3572_PD_VI		9
+#define RK3572_PD_VENC		10
+#define RK3572_PD_VO		11
+#define RK3572_PD_VOP		12
+#define RK3572_PD_VOP_PRE	13
+
+#endif

-- 
2.34.1



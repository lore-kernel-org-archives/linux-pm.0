Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792984922;
	b=Kc6uM7jka0PjzNP5vpMjuviO+fIcby128KFh//OvFom696zESetHdyhJDsH0PZ/9YXA/
	 7pimTu4kYu3xj5lRLaecGjRrsxUcgeaS/BFA37ddz4vLTcwto37KrVxXaBbs5u2D8Iko2
	 xhtkq3pUCncwlL7zM2Gn1rxE1hkQO/rcIX1Om1t5BsvtWuK4+2OcW2QB5WV1So56QOkwG
	 BhKXcBDxERpYUFUGC6tcQ6zEYn5MTbTl5JLFc9jHAtI7fay0MwxMWHvIFjDVohL/yU0oV
	 zW2AyHMSe5ewevAg/lgLMKD/W8zLPEtgnHgS8d2IsM3S78kmirk/LX5NgCxBOqHN14Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984922;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=NbQy+6FvGK6X5jKByFItZyE1kW62PV6QqwJIAZ4DL7g=;
	b=AMsAl5KkZg0MWGXslhDKn9LxIdoOHh9Tp1zDKWPKA1c3YczS2lebgG81nPqNqWp463du
	 ABQ3HRFqLL7u4LASgDFJM895SXPq7d8QpQXYH3bgZbx+phV8qvzIRdyy7ORIvSkK3IT1p
	 r7KEQkvspKAyHUmDcUDWKRfYtA1h+MSWttd/2UP8KL4uBjyFmP+k2fD+EelbWOhzx5Fxi
	 pT0pPxmHHVsF2QJ0Dh4q4VSyh4CHs7y37Bsov2U8wHJRXdmMwrcTbI+X4Cj6/nOXd5wQQ
	 ZL+l1Rs4uILsn29Xm8B+EBTVUD3vcawnZSMoiaSE5DoU54sznOszS0Q8r2CwM5N2KRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBCFuc9M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1096606A31B;
	Mon, 26 Oct 2026 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBCFuc9M
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792984921;
	b=eE/OeYxDuGKr584QVRX/xn10jZmI5hxejyVkl9e+hDpNsmt1MAZBV/Rysg2U1HgWtqzb
	 25PztK3tBTvR4/yz28p6MtH3KdEtnrpT3deD/+jX+RxTJrPpjGU/B916EVcp+CvxMJp6M
	 g/K2VIM3TyXYGQktRo39YtVDH+lGo7Yimlvr68SMDb0HQLvneZPNSAFzo5RVTOdBl+bUP
	 V2VyK3y1Vz0WLmnJXkpwI1mYcw8IWvRw9NqK0SbtYsz/RNNRaCS4e/Ec51dErDt+46Olh
	 dDb50ZVcABHjjS3mL9Up+K0zvfqiJKF3LRnNFf7Ezjfd+r/RohjvHDUNX3I9H0XP6lQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792984921;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=NbQy+6FvGK6X5jKByFItZyE1kW62PV6QqwJIAZ4DL7g=;
	b=lIK9TksCDHIMg7u0tnJQRh+ymDh1cFnO5p9DBIs3kjZBxMci+q2QDci2kMh17dzvtlIR
	 UIBmRbtLJkAACJ9M8uMdLAvPeM/KKPOGbXRQ7uZGEPUKn5eWh+iphAYazJ7/yrrgZdM7z
	 tWjAq5P/QyxQm1yBB5Qt6456mMTmEFwnnSk/tMyeQlV/eKpN3/IvZDF25h+NIoRRH2a94
	 opD6kO9rblKTDtrlAswXKqJ2waOoOVXFsmGniL6u8kZF7kRkU7Y/H5RHczqU3hd2TGTMl
	 iLQsqzgMzyH7t2pg8JwVoU5nBV5GqLCm1qTvf92Y4xW2EiEC3nbraEW+13av6Mp13ZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E99791F01829;
	Mon, 26 Oct 2026 03:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984921;
	bh=NbQy+6FvGK6X5jKByFItZyE1kW62PV6QqwJIAZ4DL7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CBCFuc9MC7EV3WVfl8fzef9Y18+T18rHMSAZTUHirHLILXfGO8kVCe5uTUoe3DFs0
	 uvz6tBc+fdjQ6CuDS5ouiKltg4iVTJOc4mw/nwSASEx6m8k2jxFRF6/C8mgUcJuvi8
	 3qB9S2yYWlZfEnCUTcrBzHQHHnEf1ISzkQSYq/xj3R9/Fv6eDJsV1yXmpyhdYNS3wk
	 UaYmT9lA7+ZFxtQ1fXeNzrF5K7B/aIkw1NlcGWMxTeruf0qCo6u/lUA8z9siEkL1OT
	 UJnfjUSParJptrZgbx4gwq+b8/DaAXxuJfWaJ4hZuTMDzVUAkBZzGVnD8vMLAWsyt3
	 yezn1MZRI2VgQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6321A44BD9;
	Mon, 26 Oct 2026 03:22:00 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Mon, 26 Oct 2026 11:21:38 +0800
Subject: [PATCH v3 1/2] dt-bindings: power: rockchip: Add RK3572 power
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
Message-Id: <20261026-add-board-ok3572-c-pmdomain-v3-1-70d614d3d921@qq.com>
References: <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
In-Reply-To: <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Cunhao Lu <1579567540@qq.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Finley Xiao <finley.xiao@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792984919; l=2764;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=cT6JHEpcZjaM7LJOx2D1IVr8V7su8PuGOgyEm3QbaTA=;
 b=PR4yWhGC+yRazQh3xN3KSarwGtayjUbgLTImTpA0t3YDit44F6mAqqVNryku/ENqh5wOlKsHI
 A7bw0TxlErrB56nzC8vBCZBxsx8WSwNxB1URZG9tceJ2GIdQ4a+6gPp
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

From: Finley Xiao <finley.xiao@rock-chips.com>

Define the RK3572 power-domain IDs. The driver uses the system GRF to
check firmware shift-ready status after powering on a domain.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

- Added the rockchip,grf property.
- Made the phandle required only for RK3572.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../bindings/power/rockchip,power-controller.yaml  | 17 ++++++++++++
 .../power/rockchip,rk3572-power-controller.h       | 30 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f95d..f8afb0fabe80 100644
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
+    description: System GRF with firewall readiness status.
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



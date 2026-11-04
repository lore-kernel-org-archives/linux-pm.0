Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793782669;
	b=xm+I/5zhr5fIIFGeYHyRw6oKfdO0kodFzhbWDkWFoKmk/BIY/KGcqQDFxaamEL0tTbP/
	 TYG3e5R2LLTwrxgnOpmIZN5DrI/gG2l7255iOgPltVgPqgHEwcuM3V9SOASHKwUygyj9f
	 yyL1FDEBO/tWZVp5EwIP9k36Xcts+qD4FT5uzprrk7TKkV1X0gjieZGwisGvKaASl6MiZ
	 Rp9kaYFUecxVub2RlipyG94UZX5O2Am4XzF1qS5tnWvFBxtbsgMsbvRQL+8lYV+vmP/GO
	 /Us+J5jzPNJVFri3q3xtyaAFp31fcCaNZonK5GGNqoRkFMpgwJ6gp/X7v++x07vtAaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782669;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=EsWY/yTZXFYVprtWvUf3XnhiSXDepU5aallNWHc59Og=;
	b=UUNHwcWwMOz8B8jV2S6W4Hrb6DC2MQAILz+/h2EwtL6U/C4oDr0g0fiEsso0UGxkVysS
	 KK43fMi59yG+J+r23bowINCjSwelU03C6KwGAa7By7Ie3L+gmsUHcdd8ZHybJfN2kEX6i
	 33TquBJNakT9q2xtBinob+osXm8fw0Pw5fAZWQzOb3G89qEyg5KP5pYVKUvIJqZIhw2/7
	 eT6sWrbpKpYAbRd3EGp2bRFv2Euwcyv8EoKj3ocxaeGg+mSpEf/HZa9zAptvu7bN4YfZ0
	 oXaTF0BGuS602lARI3TriEiIY/wFVKBgBd04xWr92xxeUFcI8dhZYqp2UnpJvOQOwfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmTzG+gG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A734606A31B;
	Wed,  4 Nov 2026 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmTzG+gG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793782669;
	b=pF25pVi15PUvV/N1uYk64uWWWbJ15808G6pOdzt+EeJWoSxarojJjQja6iunnLrR5D1v
	 D5qb4iMQtlBbi4sciegpxeAyQq1nYOnEjP7C/y0bB0P/OZyVygIdC5bxHnPwClQHulnV0
	 lb5qZB7SKXNjTLgSsgWwEDZEMpDFX3eFIft9bZi7tWTjXe7bl5On5PckD+2Aevv9Eq7/2
	 P5QfJB2faFXvnrHvvPUyLdiSegL6WLr4KpWbQ7b1KmvbTST1MkSfSi4dLOAhpxU93rZtU
	 xylK0FNYKBwFfC/ZPU2vqfSDNWlHfKti47qBDUjPhddnMrJzoZzzHXItiGjTUzyYBpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782669;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=EsWY/yTZXFYVprtWvUf3XnhiSXDepU5aallNWHc59Og=;
	b=QKfsJ+hZXfREJ8QUC6qf25bbxLgbx0BxPADKq9GWxPxdN46ZIQNFcr5JpVfP38Wyzm+b
	 DW3XI3Fbl1mBhDTt50s/Ox9Dl6u8Oq5yz6UXJYlwGhIc+gg+3wF1sByNvepqefDver2lw
	 29maVY8HFAAeWLvVyR/IpADBSB83WaC9eFSVf3ZwiS0INi/41pmC013QIh7PDWlej4DUF
	 mk8kP/sZDRSK3/zKNmaiBbPSsI2kCqU17HEWXmdTBKe2imfUx07tlJNPsIUIE4ROs3UJn
	 9iI0qGzXGRxB10+9bq4JC4cjHMLIJ7+8wx6bXaBl3dLFuZ+jmbC3MFsOsnUzMDZv6GA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AA13C1F000C1;
	Wed,  4 Nov 2026 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793782669;
	bh=EsWY/yTZXFYVprtWvUf3XnhiSXDepU5aallNWHc59Og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZmTzG+gGRt63kk9MWzueKzLUU17ctl9W8ua5PjpxJKK8DdAz9xtMjSVHzHjANGPt0
	 aepwr8IamHmADaJ2zhVojQiDuEE4AfgUk6FYsq9G2+4akJauvcHPWJx9Gd7g5BcFvB
	 OSypO+k6ZBYxPY+rQ9xr6e4Jx1yqUoIxVfy8cETXL116nxZ4y/yOj6F4tH8jX7Z/Ia
	 GNWplZk8f6JUyD20EknYYdIuSexTtWlQSuEWaqtOgFhuKB+A6TYJ/nWThznYLuHdHn
	 5TTq4lUamziQES3BFEjhAEgmoOU31lTeeUeF2VLEcE4+Hs0thYaB0DbtDWEOSnheHU
	 AOPfD8dTntSpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 18D0746D55;
	Wed,  4 Nov 2026 08:57:48 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 04 Nov 2026 16:56:03 +0800
Subject: [PATCH v4 1/2] dt-bindings: power: rockchip: Add RK3572 power
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
Message-Id: <20261104-add-board-ok3572-c-pmdomain-v4-1-15cf8b5a6e59@qq.com>
References: <20261104-add-board-ok3572-c-pmdomain-v4-0-15cf8b5a6e59@qq.com>
In-Reply-To: <20261104-add-board-ok3572-c-pmdomain-v4-0-15cf8b5a6e59@qq.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Cunhao Lu <1579567540@qq.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Finley Xiao <finley.xiao@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793782666; l=2834;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=oyvMUU7R4CjKJ/p4yd/DxcdPfUMgGd3L5BZrnlpZr8A=;
 b=QJ1uWl+F7GBiGoGGJ+woFdBVjA8OLhcGVy1YEOIXpoJqX/+/qBrkXK6SqOvk0bgcpYc8HWZHY
 0xT8khOcz40B93eyVSzKyNNqLh007MZTtht5ngy3HAw9FuuZPoli+1X
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



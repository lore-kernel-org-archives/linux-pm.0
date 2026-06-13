Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EEC38C2B0
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333922; cv=none; b=JYOOLTEgraVLcV6Xd6l4eyaqOWgofYg69dInPVJ1h6NrJbZ0sZoe48FbW39Hz2x8jM8xVLKIOg5cRiEmURv9VVkUqyvbA/XG+0mOtiW8RKWQNsNXvNGJdRGqHfQgbMlCiUbqEMLZhOQPda01Za04LiqFX7NbH8tFvf7uC9KeSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333922; c=relaxed/simple;
	bh=7jgzTiHZ5krI2MA++B97YNG6+febRofoGXHNduodpd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuILs0xQ9Xszn7/NX9cS9RzDt6cFJ8yU6nX53+tB3iRxNAh0h57O5hRX4L1BDtqFXPddrong28Qy7uv7CRGwWChRTxpdQyRz8MCfREqDS9c8wyKRw2QayLzluPpVgXgR6Jnz5niHZpsb7yl3rOpwmqhYN8AcLO9h5cxITVNjYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDsF+ycT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDsF+ycT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so11219085e9.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333919; x=1781938719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZ66LcteqJ4QI9hjgF9HToSLQnhyQKu6uHIFWcsfYcU=;
        b=UDsF+ycT240Ov/gPPEjnTFfSGBpor6IzTBZaKaNAB2fNy9hfkRTZ/AcCHMr6C5xu4i
         hMa+sV7sTtrSEVOYTNKhIElqFsHJVOLud3oPg4z9wIIXLcvi3NqUtqwbT0ElyySlAIm3
         amV59YRMaL+NXl2Yzl+wAioIMA4BhEhfluMABczTsh2ZT9u12vU5AObNcNeV8VNlbcOr
         YaQdPIzL03EWkeT9t6jr8qgCy2W1Ux+FxEwzsj28O0O4QUbiYrgzafO1bVPsq0uOVpuT
         6T0rKu6hXWjw+RZjGhOz9O5FCTIK8+LEp6ZENN5m7odPMhPl0dGlEl6aYS3+NdGqolHP
         McYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333919; x=1781938719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZ66LcteqJ4QI9hjgF9HToSLQnhyQKu6uHIFWcsfYcU=;
        b=XbyZdnPNoMO+iZcd6Ji6jnuNCWEHPPtmku4SXfAWHUc1S+QLXTNBkBOWDgqiba1FwE
         3jbyXQ5zo9XyMQ+fyIJlcvhPa3IcpTqTRRqgC7p+Q+uRsmwTf5fKj/MTQxGnHQxitJ38
         vSsEVpnQVLlSfu0I7MD+zW4KAb1AUYcZe7dngOgXb8QI1Wg1NgkjweYrQ/4N8yuI7mg4
         DogPT7gHYAMToDvl70nUDfr+2g5Ekz9PMnSyBAwoGOz+FQf6+mA5Bv6Qmy44167/RAx5
         OClp8JfmYGoHnNx9NthT0qf9+fAJ9YFfLE/f05L/lZJAqooGfJmU9PcnF9YFU2m/zFnm
         Bs5Q==
X-Forwarded-Encrypted: i=1; AFNElJ82GS8SKGzh8oQyFA2Y7eSDvyKAjK3Ux3kC9weLFVkvFKh+fvRrY/1RCavvBcC+bn081g4opoj9hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqfP6GmvET8GYa0Z28+MNGT2kOTCd/kJahLXQsjHEez7vZbZu
	lDxfHda9ipFfDgeTCcw32WmgfkjBbl9Yign6Qp+nfK1JFEDz6+OakLWW
X-Gm-Gg: Acq92OFI3/Teksd+wZgG+bYH/speWYL1T91aFlPsx+91vzrIJdzDWIcm0DX0xo30Oq4
	eGKhfjnEmCTZ3BFAUGR0VUdsnNi2SspZSlDP/S/J8Vozg1caBOzzEwft4pEva+kqE3YVbNPBBP6
	a3I9daMVLNNTl6Sfc5SudzfzHYOcnF9OcH8aM/6+Npb1fRTVuWobAe1aQVexI+BrtALdYhzjQZd
	H+tUEbnoiIpm6qnxL6XLBAAjA8Oqgx2IjFZGgqoreLXQVBCU3xBV8tM7A6T3P3qC/P6DFfBfUg+
	5ZjIp/8vY1KDAB8oTk12CRq6wmNg8OdL1KiHY3E/yvzfRhmhBDp0bz16Hx1k284g5An6rkTgGmX
	uncboNfUTpfwsDIw1v2C7rbtLbCj71rTOCVTDw/yUsxb6Y51nOT6T1VkVLW9aatSOot88EAY6g+
	G5C5mHz7qnvF93aIOpDN+U7Rp6UkxnRWH1oLWOoaImig==
X-Received: by 2002:a05:600c:4ed0:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-4922008485fmr28715325e9.7.1781333919182;
        Fri, 12 Jun 2026 23:58:39 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:38 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 6/9] dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
Date: Sat, 13 Jun 2026 09:01:13 +0200
Message-Id: <20260613070116.438906-7-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

The RK3568 carries a single core of the same NVDLA-derived NPU IP as the
RK3588.  Add its compatible.

On RK3568 the NPU NoC bus-idle and power gating are controlled through the
system PMU rather than a dedicated register block, so add a rockchip,pmu
phandle to that syscon.  The RK3568 NPU has no dedicated SRAM rail, so
sram-supply is required only on RK3588.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd1..e0b948ac47d45 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3568-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -50,6 +51,13 @@ properties:
 
   npu-supply: true
 
+  rockchip,pmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the PMU syscon.  On RK3568 the NPU's NoC bus-idle and
+      power gating are controlled through the PMU; this points to that
+      syscon so those registers can be reached.
+
   power-domains:
     maxItems: 1
 
@@ -75,7 +83,24 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-rknn-core
+    then:
+      required:
+        - sram-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-rknn-core
+    then:
+      required:
+        - rockchip,pmu
 
 additionalProperties: false
 
-- 
2.39.5


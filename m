Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962BB32861E;
	Tue, 21 Jul 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631164; cv=none; b=pv7TNHCpBVi7dHkoj77QpK4QcDoqpHksAgUrDrLGXYeLjIReiC1AaEnbFv1kyrjrINtkxjqdSLCQCR/LdaoRj6YS2twBR5cj07JyEQt5ZmcnZG8ZsoUOcGVt41q2njNq9H3FC68lkJLVlqXNgXI81xPxDeXXQcDDvCLLo29UqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631164; c=relaxed/simple;
	bh=Oxlrm51S+dtXKz86xcMf1a/yzkVrTdj9sQMFUYBwn3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7gl9c2zubuHwBKfOyez1mAkyguj8ub5gLvXXnE/dIzhIee6vBqlSc5CnwIZXYj4UgFeCm1XXbu9HVF876/lLVAFTsZvQuR27xgKxg0BG2/iJcbza/5qHG36TbHpBVUn/uASnRR0oN72UOMiA2ms/bm7kDsLoEpqrY1ZUoSjymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=arjKwPl9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="arjKwPl9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784631159;
	bh=Oxlrm51S+dtXKz86xcMf1a/yzkVrTdj9sQMFUYBwn3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arjKwPl9RtXV2l5kbVZjPsLcknBzzQfmLB/7syXdqSwaFx+SivcI2KS+RQEQy3UxY
	 BUE7iAP3C5IjEF0Lfkm7KorUuuuzdymORbZA9rMR1CYxhXKetdw6BdcT03b9hfN0jn
	 FagXGsGwkE568B2E0LiXsdNTf2YYneIJk4+GpbrOZ29i5lz7SFcHgEGbqciXetqt54
	 jsXr9Ne3RlXxjnXRlI2jk5a3FnLOkHXhJDTpk7FEgCFZYOxzq1cj5mihqaJpMSPIzT
	 WAWD8zQXnYyRGb4H2A8l8WrX5QNsDSeAQAKh7X9lL3XUXBdzSBxq8UpAZm3bwYbx2D
	 dR2WA/+Har/Iw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CE62017E0564;
	Tue, 21 Jul 2026 12:52:38 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	laura.nao@collabora.com,
	fshao@chromium.org,
	wenst@chromium.org,
	jiapeng.chong@linux.alibaba.com,
	frank-w@public-files.de,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 1/2] dt-bindings: thermal: mediatek: Make resets optional for MT8196
Date: Tue, 21 Jul 2026 12:52:29 +0200
Message-ID: <20260721105230.101906-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
References: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both LVTS-AP and LVTS-MCU may be shared with SoC-internal MCUs
running some sort of firmware that checks thermals in order to
scale frequency, or to take action for critical SoC thermal
protection - and this is seen on most MT8196 boards.

Make resets optional, as doing a HW reset on such boards will
result in either an immediate thermal protect shutdown or in
a rather important and usually permanent system slowdown.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/thermal/mediatek,lvts-thermal.yaml     | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 975235130670..29f431fcdcd5 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -94,12 +94,23 @@ allOf:
         nvmem-cell-names:
           minItems: 2
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - mediatek,mt8196-lvts-ap
+                - mediatek,mt8196-lvts-mcu
+    then:
+      required:
+        - resets
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
-  - resets
   - nvmem-cells
   - nvmem-cell-names
 
-- 
2.55.0


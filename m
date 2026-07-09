Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E03E4C94;
	Thu,  9 Jul 2026 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586804; cv=none; b=HAL3ukrWL+VU0FdJU0c9RKVhm98YcTgJpdDO7CiQE2bvZ2uh7vHoSVgb0v66nW7OariZsHKJzFM9gltxR+VHccdkkFc2921+kxS9d//HUr4ItXCuKUagXjPH4xEWA91hxAcR3j8jp2MWHFoBNyBiz27Ci4J+WnflUGUkUD7QnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586804; c=relaxed/simple;
	bh=n2rtxDpW28tQqpUdcTdDJfoTHpu2QkpMLw+Abe0Jg3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWqjCbJlg/dLkb89+vFRFXHWnHB3dGTf8DwjpRiJ7fQqjSWzQKB5ClUFu0TyXUMaG7tCgxjHoWXbyfIyrzG1Xp20vgeMfN7j/PwCqxXkiMUnbAh4Cfx6q2UuRxx3F6d8O7DrZxs6S+NEQ4Q6/PZUexzHAuU/tJXATsc4OjJ+NUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l/sG9Al+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l/sG9Al+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783586801;
	bh=n2rtxDpW28tQqpUdcTdDJfoTHpu2QkpMLw+Abe0Jg3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/sG9Al+KdlJ/5lPCLhdl4zSUn5svMza+wyH4aPuQMuFYldRmvWolcDhYxIFdvwaG
	 JxJuSSBSfRj7ufqlqdSnSBYKztqzbwWTUI8r6wv50C0N4O6nCd9kogTLYe6pC/Q+iI
	 QZAMQ+8Ba5kdbbico2oFB7hlVnIZhen6Z/riymPahNP+Q8Pgf/8WoTQZqNnWSTqhsk
	 76PvbHZVWSKiya++k+4aS5bTGzrgqMbTlpy5E4t77OGVql3fugO5pI4wBslDwpWBpj
	 IbT5sstqgqOhlfeJKdW4WyRgwtt7zPF5id2GPd+DfxvtTaqivovg5VNVfQE64NDQyF
	 bqwTcfNs7ZzhQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D13F17E0CDE;
	Thu, 09 Jul 2026 10:46:40 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ulfh@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nfraprado@collabora.com,
	irving-ch.lin@mediatek.com,
	macpaul.lin@mediatek.com,
	aford173@gmail.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	justin.yeh@mediatek.com,
	kernel@collabora.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/5] dt-bindings: power: mediatek: Add support for MT8196 direct HFRP
Date: Thu,  9 Jul 2026 10:46:31 +0200
Message-ID: <20260709084635.24912-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709084635.24912-1-angelogioacchino.delregno@collabora.com>
References: <20260709084635.24912-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the HFRPSYS direct control power domains in the
MT8196 SoC, controlling power for the DisplayPort and for the
Embedded DisplayPort Transmitter IPs.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/power/mediatek,power-controller.yaml  | 1 +
 include/dt-bindings/power/mediatek,mt8196-power.h             | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 07f046277f8a..070c6e5666dc 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -34,6 +34,7 @@ properties:
       - mediatek,mt8189-power-controller
       - mediatek,mt8192-power-controller
       - mediatek,mt8195-power-controller
+      - mediatek,mt8196-hfrp-power-controller
       - mediatek,mt8196-hwv-hfrp-power-controller
       - mediatek,mt8196-hwv-scp-power-controller
       - mediatek,mt8196-power-controller
diff --git a/include/dt-bindings/power/mediatek,mt8196-power.h b/include/dt-bindings/power/mediatek,mt8196-power.h
index 0f622a93c807..085790bf8124 100644
--- a/include/dt-bindings/power/mediatek,mt8196-power.h
+++ b/include/dt-bindings/power/mediatek,mt8196-power.h
@@ -30,6 +30,10 @@
 #define MT8196_POWER_DOMAIN_MM_PROC_DORMANT		0
 #define MT8196_POWER_DOMAIN_SSR				1
 
+/* HFRPSYS Multimedia Power Control (MMPC) - Direct Control */
+#define MT8196_POWER_DOMAIN_EDPTX			0
+#define MT8196_POWER_DOMAIN_DPTX			1
+
 /* HFRPSYS MultiMedia Power Control (MMPC) - HW Voter */
 #define MT8196_POWER_DOMAIN_VDE0			0
 #define MT8196_POWER_DOMAIN_VDE1			1
-- 
2.54.0


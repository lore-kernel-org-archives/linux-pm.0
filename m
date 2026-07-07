Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F2424652;
	Tue,  7 Jul 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439745; cv=none; b=WSzmhMlnx1QZRv8T5crEsiqSHZZ3pFUbPMwB1jD4TNgJF0vCw6Rz60D0kFzK3f5nMFyAQjN93KTFjuTMdIbC2h8Kpn9rpNLTIaLjYX2OlN5yTaWAmckjTCGq7jHpOCyZIeqsxmReQI3HKsYvYosE4dFPLuyKlDlO7C0xEqj3emA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439745; c=relaxed/simple;
	bh=Z8JIPwRXolEslet6JDKoYmFL7Uvymg9O2cw3pmF30s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN4nlrq/xqEmulfE8iDTJTFFT4GCbbiCJQ91VQb5rUfUEZTQvBFhIm2CJwJS6IxuMPFnUK/ytcPV3i6GdFVolHBzynmTmyRPfGXpCLvDKHozaH74MPLwBni9eJKaNT1US8OkzM3cqaGg/e/jNOGSNmy4KIX6lN/sKcqohaH40Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lqg56XAK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lqg56XAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783439742;
	bh=Z8JIPwRXolEslet6JDKoYmFL7Uvymg9O2cw3pmF30s8=;
	h=From:To:Cc:Subject:Date:From;
	b=Lqg56XAKyadVaTucKg2HZOcJoPceOjM5lxj1wEBajCpXa0R3qAynnipWI769qk70x
	 uCyycrVpFUqESlrDAxBJv2p4TdBTjB4YwJNmPDWpFvlisxsLiNghkypCh/18AZDVoF
	 KIL6vPWKaWgXw8OE6TLgKZ1QBViL4u5oPzgmveknwThccebLjqcAGKuJ9aZxc/1zve
	 iC+Xm/dddGXVsNCR0Z0Nd3oZuegY4fdixWDg2YdfnkqnusLlgfqRR2VSmHAxGg9ar1
	 SuiNRkYsL6foTdLWidZCnd8rWOJd474fWs8tuSXvbnrdTBRuqvw7M3WO79eZrHAcMD
	 ZsgdSQe0tPqfQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A73FC17E05E8;
	Tue, 07 Jul 2026 17:55:41 +0200 (CEST)
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
	kernel@collabora.com
Subject: [PATCH v2 0/4] pmdomains: Fixes and add support for HFRP Direct
Date: Tue,  7 Jul 2026 17:55:31 +0200
Message-ID: <20260707155535.199383-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Fixed return value checking in power off path

This series adds support for the DirectCTL HFRPSYS power domains found
on the MT8196 SoC (the ones without HW Voter support) and also adds a
fix to respect the power domain relationships during error cleanup,
which avoids HW lockups in case probe deferrals in the specific case
of "almost fully probed" power domains (where most of them probed and
got set up but a probe deferral happened almost at the end), behavior
seen on the MT8189 SoC during bringup (but honestly I have no idea how
are the current ones working fine without this fix...!).

This was tested on MT8173, MT8186, MT8188, MT8189, MT8192, MT8195 and
also on MT8196, over months of development, both manually and over CI,
with no regressions detected.

AngeloGioacchino Del Regno (4):
  dt-bindings: power: mediatek: Add support for MT8196 direct HFRP
  pmdomain: mediatek: Respect PD relationships during error cleanup
  pmdomain: mediatek: Add support for Direct CTL simple power sequence
  pmdomain: mediatek: Add support for MT8196 HFRP DirectCTL domains

 .../power/mediatek,power-controller.yaml      |   1 +
 drivers/pmdomain/mediatek/mt8196-pm-domains.h |  27 ++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 140 ++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |   1 +
 .../dt-bindings/power/mediatek,mt8196-power.h |   4 +
 5 files changed, 147 insertions(+), 26 deletions(-)

-- 
2.54.0


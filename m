Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A913FC5A7;
	Wed,  1 Jul 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908366; cv=none; b=vBY1i6a/7aWrRnWTT0zQ3TbZUOlwafJ/kPoZJFaoXfMgW7+SBzQn/rz3UwxrzcMhCt/VJd9uIaTq56BojCYNKKMW+4OuNf/847WiiQmI1cJ3PFBKVRgYL6kv59fvyuwT0Cc7f8cFRBEAs+DA+nLo5xT9Ty1yIWQ8Nta49Iy70X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908366; c=relaxed/simple;
	bh=RIGHToQ86+80dzU39WU9it8zdhmzP6nEWWQjnFhwEXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGk5JOiz/PQPstHet5YKHisahaFY7ynj5RCA3sah4Yz06X38TI/mH+23H+WoDYNDomIycpnHAsRs8FlK4ZWP4og+dpzH4sfMQHOi2jd1KNBpXO9miWmNWFzxFmyDPMG51kYxZnmQCDVZ6rHAb1rLjesxaGn1/jycGYdRU/gy5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SLOOeJbw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SLOOeJbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782908363;
	bh=RIGHToQ86+80dzU39WU9it8zdhmzP6nEWWQjnFhwEXU=;
	h=From:To:Cc:Subject:Date:From;
	b=SLOOeJbwtD22khwDQNSCEIXb2djNF8mPJ225Fxb0j2ZXY8SEJJO92p6+bQqCzsezh
	 1/viTRmV6/yR+CyoDSt52XoWDvHOYZr8XHE7I94fBo7wgN2yDTmTfWR3F4yMQD3GTe
	 rvo6g34jnhqocWbpq3W6Hewb3+WqdR8T+h4Gr3TN2Z/Ir8GoDfbal9lje7Njw3qwLa
	 qlYluFXthnKidoLpxu8zkA6+RwRGlY2+UBrwqUuLXwFEtPZcD7ZvLXGW2asJq3NIWr
	 R6VnCG6CrzclJa7IcoPwYk7k2hMrgPK4QypVgO3RazmTPYujnGKmvHvYiiW2VWj1kH
	 WOA1ZujbOgcbg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 257A017E0909;
	Wed,  1 Jul 2026 14:19:23 +0200 (CEST)
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
Subject: [PATCH 0/4] pmdomains: Fixes and add support for HFRP Direct
Date: Wed,  1 Jul 2026 14:19:16 +0200
Message-ID: <20260701121920.19347-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 134 ++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |   1 +
 .../dt-bindings/power/mediatek,mt8196-power.h |   4 +
 5 files changed, 141 insertions(+), 26 deletions(-)

-- 
2.54.0


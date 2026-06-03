Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFB36CDE3;
	Wed,  3 Jun 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463541; cv=none; b=F2ZMELfbdQNUGpxi4cLbmE9SrvkackInZkpaSuUBSrFR/CmMmt2SLOC10ZyLQ5jDgFSg04L0rnqtFoFM1c1afqtPeLiOAFmcHT8ZLD2YpdI6WLkpQobtpcABWHlSraDL8ClDyiabeBJVSE4rDZv8VM8neYbtMRZbAPkr7QGVMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463541; c=relaxed/simple;
	bh=jz1t51jM8z4KI7fGNfA45w+eFCH8zohm1f8GxJFeiQ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G9ep/NBlLHMz7vk/sCIbmN4pSlvLaDqqyetUPavvJW1x363jFTYgpTvfC0y9DwQlpy3ew+js9oeGddgo45oR5MHtvcnadITHxD1rakPfuK858Tg2SPYlfVUCrhr2AO9lsHB8kTdSykY8veh/8HUbO/AtT+Fk3PueWW6pHB1GFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FFvAZLx4; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FFvAZLx4"
X-UUID: c49f1a485f0a11f18dc8c9802ae25ab1-20260603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4gnyni3j/2zlxfKswDNVSdULzZ8nrI/K6H0ZWv8Sd6w=;
	b=FFvAZLx4KLSDHFNz97bytnVbI+pLsxM75yPr9fb8iQWd/X2pPYWc+rjAKXL5t9mFu9UkzZ640uaf+YUtYvmrL92NGCaj2yrRxPOj7EYm6a5oIY8gep5DSlrPMjmaVsSGzR3mga4JwAk/PQa6aGwYVsrEFNg0HqktBSO0VPm3mhY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:f6601f4b-73c2-4642-bb95-d42236f7116f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:669c103a-e7d9-4151-8ec1-5d8278df2039,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|136|836|865|888|898,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c49f1a485f0a11f18dc8c9802ae25ab1-20260603
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <justin.yeh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2046054805; Wed, 03 Jun 2026 13:12:07 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Jun 2026 13:12:06 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 3 Jun 2026 13:12:06 +0800
From: Justin Yeh <justin.yeh@mediatek.com>
To: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Justin Yeh <justin.yeh@mediatek.com>
Subject: [PATCH 0/2] pmdomain: mediatek: Enable module support for mtk-scpsys
Date: Wed, 3 Jun 2026 13:11:49 +0800
Message-ID: <20260603051200.1163226-1-justin.yeh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This series enables the MTK_SCPSYS driver to be built as a loadable
module for GKI (Generic Kernel Image) compliance.

This series depends on the following patches currently under review:
  - soc: mediatek: Allow MTK_INFRACFG to be built as module
  - soc: mediatek: mtk-infracfg: Export symbols for DDK modules

The MTK_SCPSYS driver depends on MTK_INFRACFG being available as a
module, which is enabled by these prerequisite patches.

Patch 1 converts the Kconfig option from bool to tristate, allowing
the driver to be built as either built-in or as a module.

Patch 2 adds MODULE_DESCRIPTION() and converts to module_platform_driver()
to complete the modularization and silence modpost warnings.

Together these changes allow the MediaTek SCPSYS power domain driver
to support modern Android GKI/vendor_dlkm module loading requirements
while maintaining backward compatibility with the traditional built-in
configuration.

Justin Yeh (2):
  pmdomain: mediatek: Convert MTK_SCPSYS to tristate
  pmdomain: mediatek: Add MODULE_DESCRIPTION to mtk-scpsys

 drivers/pmdomain/mediatek/Kconfig      | 2 +-
 drivers/pmdomain/mediatek/mtk-scpsys.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.45.2


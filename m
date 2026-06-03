Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE32FD69D;
	Wed,  3 Jun 2026 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463541; cv=none; b=fYzGp8gr/nWJLc98wA6/khVi3+KjRpie/kOgFz5PBkzNzaEmYVK7gTT8i6m7XTbUhWhUtcrrO8/cydxf8T8EHWfk2oI7OJN6XkedfctOLhvV54+qI4g/+o8A2E6EQrmXUqBCwfTlO9P4N6qNo9rLvQI5QXray6p41OisBOWIhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463541; c=relaxed/simple;
	bh=eTwkap8KYk91b+MPQ2wLF16pTvKHfR/ZljBU9ZjaKTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzswtTVG2h8GpYmzIWIKsxBrw67PwmoVlcbQzpeJ3f0qeFy8Bbd+tA0QAXExPWM3tfVI+zF5sdVX2FO6VHMqja7ob03NdxEBpPqjY0MK+4dSPYe6ZCX4bv8FRhZKM1ZOiXgvAhnKvAyLcRHuole1UT5YGnZQwRlHXkkwM9b++jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tBuDQFBO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tBuDQFBO"
X-UUID: c4b05d3a5f0a11f1b1788b6acf885367-20260603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cS8V8ziuaxkBUDx/2DlbKXIeghTQAJCLrGlXNV6o3Rs=;
	b=tBuDQFBO/gKGko2nULUbnoJ4mH8NUmMM4ClCURfICFG3ixOGb6h/v5j6nehbj0uymU5eFGSEEFF85xpfrG+ySrkDQ0bQaO1vYMf2fem1F8IRNaSR17y0Yx5a2pxmvz21rALKRkE4vrer2sMUXarMnwIGTWoyFaia66QW6nzdTzA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:663e072b-6c18-4a53-a272-99d676786110,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e276073,CLOUDID:dca17a96-4b61-4e8e-8981-a884a95e9126,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c4b05d3a5f0a11f1b1788b6acf885367-20260603
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <justin.yeh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1176617392; Wed, 03 Jun 2026 13:12:07 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
Subject: [PATCH 1/2] pmdomain: mediatek: Convert MTK_SCPSYS to tristate
Date: Wed, 3 Jun 2026 13:11:50 +0800
Message-ID: <20260603051200.1163226-2-justin.yeh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260603051200.1163226-1-justin.yeh@mediatek.com>
References: <20260603051200.1163226-1-justin.yeh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Convert CONFIG_MTK_SCPSYS from bool to tristate to support building
as a loadable module for GKI compliance.

This change allows MTK_SCPSYS to be built as:
- CONFIG_MTK_SCPSYS=y: built-in (traditional approach)
- CONFIG_MTK_SCPSYS=m: module (GKI/vendor_dlkm approach)
- CONFIG_MTK_SCPSYS is not set: disabled

The tristate option is the standard kernel pattern for drivers that
need to support both built-in and modular configurations without
requiring separate Kconfig options.

This aligns common/staging with the equivalent change in
private/desktop-google, ensuring consistent configuration across
both kernel trees.

Signed-off-by: Justin Yeh <justin.yeh@mediatek.com>
---
 drivers/pmdomain/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
index 8923e6516441..bf5108ba360a 100644
--- a/drivers/pmdomain/mediatek/Kconfig
+++ b/drivers/pmdomain/mediatek/Kconfig
@@ -4,7 +4,7 @@ menu "MediaTek PM Domains"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 
 config MTK_SCPSYS
-	bool "MediaTek SCPSYS Support"
+	tristate "MediaTek SCPSYS Support"
 	default ARCH_MEDIATEK
 	depends on OF
 	select REGMAP
-- 
2.45.2


Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8036C9ED;
	Wed,  3 Jun 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463542; cv=none; b=s0fdL/7FlokT38PJeUyCaUfvgWFpk9E+P2GKDo18EqUqFT71FNzOHHVT9WtgErD8rqHucXOY0scEKDycC+L2whIaGmtO5Wy1Bfpl7MB9xqOGzgBr1IJ+ZjKoYttUZP3+zIih80zlT23Kh7QxN0445GxuztMuveclcydV/rIgDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463542; c=relaxed/simple;
	bh=G+WqY5XIcdrXlsxDYeMoiUe7r6Sqz+4Q4gW8/P6nykU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McOkVRhhcYEsIFCEezam0JBHr2gIc7aKCaa/F29Z+wpkoI6141+8/CP0n89sAT62srlJN9iqxFnLrWNiNjy6iqyOQfRJPJOrxJDy7t3r2+oRJ0joMPDsGOFEjMJ5r4eRpn9l28E4mK6GYk6wPnLi21yrWYT2cVLCv5Xs1qmigrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ehIDNPri; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ehIDNPri"
X-UUID: c4c0d8ea5f0a11f18dc8c9802ae25ab1-20260603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xvl7IGRSO0uo+BOHssp3leKmVgpjzIAZO/denB7xxyw=;
	b=ehIDNPriy8IwCfVjYdUIcAzXBT5EAMibeHnqhuGXnxdYS+xf+/UChdSLfUgrXBAmH4JiGl75AJyMl1Zu4DeH8h/NgCqaZ84YJdflEGgIlkLp1071cn5i88nLhDU6S3owb6azRUzd3n6AlcmoilYdVePGywOuMSQ9Jd3bzdbNJsM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:52c26f1c-cabc-429a-9096-dbe18f1c0732,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e276073,CLOUDID:9d89425e-3770-4014-8e3e-07321c73275c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c4c0d8ea5f0a11f18dc8c9802ae25ab1-20260603
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <justin.yeh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 996942887; Wed, 03 Jun 2026 13:12:08 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
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
Subject: [PATCH 2/2] pmdomain: mediatek: Add MODULE_DESCRIPTION to mtk-scpsys
Date: Wed, 3 Jun 2026 13:11:51 +0800
Message-ID: <20260603051200.1163226-3-justin.yeh@mediatek.com>
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

Kernel modpost in v6.x emits a warning when a module is missing
MODULE_DESCRIPTION():

  WARNING: modpost: missing MODULE_DESCRIPTION() in mtk-scpsys.o

Add MODULE_DESCRIPTION() to mtk-scpsys.c to silence the warning.

Signed-off-by: Justin Yeh <justin.yeh@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index efc8f276ffce..bfaa6c8f88dc 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -1151,4 +1151,7 @@ static struct platform_driver scpsys_drv = {
 		.of_match_table = of_scpsys_match_tbl,
 	},
 };
-builtin_platform_driver(scpsys_drv);
+
+module_platform_driver(scpsys_drv);
+MODULE_DESCRIPTION("MediaTek SCPSYS power domain driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656B3126C0;
	Fri, 17 Apr 2026 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413232; cv=none; b=gwS3zTlAuenMQjy4CEy7lca/yoYqXIx4b8wikPW/m2GU8n5HR4dwlGFACQASraXQPVKX5DKbynlps9MAtop9U1J8WDDGcLxmGSS2TLJLWv/uhfSh6ZQbY7LSmKXaEGA9yNbV0NdC346nbV0aCqvl+1+nLucNGXIiV57lUGAqyKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413232; c=relaxed/simple;
	bh=/e+xUzGbZfufxRaNCCuSAEv4BwaXVbbWvQEOrjdWmxQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smLFCMN7QfqEtJ7xkXfpWpjtk56TJN1AMVz6MIPtvCjin5ji6qqLZvFMv0WomeDuyGRDM40hPgGNvuwa3pTaywNK5VEkzb8wglFouuMbB+l8KK6ClgnGWCsFgbIh1Dy6BEs7QO+7fsbs7ZlS46pwo2d9Lilung5WXZcpf7n/J/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hCy5uFlQ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hCy5uFlQ"
X-UUID: 6bafbef63a3411f19a16598d5ca7f8ec-20260417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Os1dnyvYL2jpJMtSiA0rHB9vces/3fIbY0D06HvlXQE=;
	b=hCy5uFlQ+OU3J0JLu0vBYpeMJPAryroIdAPQ+nBji356LkrGcpNtDloYKdEAF3+OFLWzH/vEJo6SIbcSVcBJ6j/nbFOVJnAqpPlDp3IaDYyq9CEQBS64qV5N53mtabousned13/btNAT3jySODUOUEoS8NhMv6kNJS/Gg08M+Fw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bd3b836a-ac7e-42ca-a7fa-e199c070b4f2,IP:0,U
	RL:0,TC:0,Content:29,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:29
X-CID-META: VersionHash:e7bac3a,CLOUDID:27cdf924-cb5c-4236-a89a-9a7fb20c9bc4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:4|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6bafbef63a3411f19a16598d5ca7f8ec-20260417
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <binbin.shi@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 169650723; Fri, 17 Apr 2026 16:07:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Apr 2026 16:07:02 +0800
Received: from gcnsap21.gcn.mediatek.inc (10.17.81.22) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 17 Apr 2026 16:07:02 +0800
From: Binbin Shi <binbin.shi@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Hector Yuan
	<hector.yuan@mediatek.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<vince-wl.liu@mediatek.com>, Binbin Shi <binbin.shi@mediatek.com>
Subject: [PATCH] dt-bindings: cpufreq: add mt8189 cpufreq hw dt-bindings
Date: Fri, 17 Apr 2026 16:06:17 +0800
Message-ID: <20260417080648.3692438-1-binbin.shi@mediatek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add mt8189 cpufreq hw compatible in dt-bindings.

Signed-off-by: Binbin Shi <binbin.shi@mediatek.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
index d0aecde2b89b..cff52fffc6b8 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
@@ -16,7 +16,9 @@ description:
 
 properties:
   compatible:
-    const: mediatek,cpufreq-hw
+    enum:
+      - mediatek,cpufreq-hw
+      - mediatek,mt8189-cpufreq-hw
 
   reg:
     minItems: 1
-- 
2.45.2


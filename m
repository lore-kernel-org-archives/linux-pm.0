Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604020125F
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834007; cv=none; b=jWhIGWkmdPywpzhhSWGfjvKLvfX52Te1xYw1jQ5MF0bt2UZyGFwSH6zJ8DTa7DRSaVHO2rbkmCxD3htpPgqkCghXUfW6yPKjaGAf8OT7hwhi0JQ/BS9kzHDJxZPByfxBsOMF8v1CGiTSje8CzeYR3QZTqcqBHMxPcj9IbvrBp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834007; c=relaxed/simple;
	bh=Hw5+Q73+ZWi9YmoMS+ZX9S0GXOSKMnNzUKiQEKe40vw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JEs6MSqjo3PzR5qh7o5PRNWecU7TsESLqaKVSC1EWgf6pZHpEOAa03aMusPMsQIc+A9m5uAPnRhbMtqwZcHT/AuLF+n7l8IgwgU0df0veBvoa+8XYda55CUGgmNVcecv0n9Pbz5mki5YaEWwIe7I4AQDwNVOcQQhGSdAzGVI0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 76d8c452a21311f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0d98c23f-030e-487d-9ef0-a3ff47140e41,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:4cb7de44c5339ad4a551f7cbc1321b86,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:2|-
	100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76d8c452a21311f19a56ed5b684f684d-20260827
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1170000177; Thu, 27 Aug 2026 20:33:10 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] doc: power: update swsusp.txt references to swsusp.rst
Date: Thu, 27 Aug 2026 20:32:56 +0800
Message-Id: <20260827123256.2548946-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The swsusp.txt documentation file has been renamed to swsusp.rst.
Update the references in the Documentation/power/userland-swsusp.rst
comments to use the correct filename.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 Documentation/power/userland-swsusp.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index 1cf62d80a9ca..b00b850148b2 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -4,9 +4,9 @@ Documentation for userland software suspend interface
 
 	(C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
 
-First, the warnings at the beginning of swsusp.txt still apply.
+First, the warnings at the beginning of swsusp.rst still apply.
 
-Second, you should read the FAQ in swsusp.txt _now_ if you have not
+Second, you should read the FAQ in swsusp.rst _now_ if you have not
 done it already.
 
 Now, to use the userland interface for software suspend you need special
-- 
2.25.1


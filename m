Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84C1FF1DA
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396290; cv=none; b=MZdq5qaTEimBYW+nVzw2e1A80tDB+APKC8lQf1J5izBcCgKZpZpZPjDXUmLWJNymWhIROE9Yy7PQvLfn3WObhw+iGwi5fs2TPPQEmmEUjCbgPeY/7Q2BApWXbZ8cYa45OoCkqXlmuf6ewh5JhU8zcEqNyMe4QlvQJMbDemfuMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396290; c=relaxed/simple;
	bh=LTa2NDwleG1lPrgo3OF8JsVLxkUAK7tIK2qlTAwvY8A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XDHEI4qO4asJZx1i4ArCH2fN/Z8LqmNEJsA/Xx3I7AxXoP8GIU1KtUWVwmqBTYQW1N6jFY/BuXmB4DE23qySAwZ8lQxkXeEnyYv51QLY8EV+vaAqdinzC5MrRoOnggki0O5EdQTRp2dsM4vQBMigAal13yb2u5uXCtjWlZp5YI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 337ba3705e6e11f1aa26b74ffac11d73-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e8528698-dc70-4add-b124-910d9207e9f4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:b5a6d7ec8d76bb97595c97f4da8cc14c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 337ba3705e6e11f1aa26b74ffac11d73-20260602
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 898214067; Tue, 02 Jun 2026 18:31:22 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	djakov@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: debugfs-client: add NULL check for platform_device_alloc
Date: Tue,  2 Jun 2026 18:31:20 +0800
Message-Id: <20260602103120.2966458-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_device_alloc() may return NULL when memory allocation fails.
Add proper error handling to prevent a potential NULL pointer
dereference when calling platform_device_add() with a NULL pointer.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/interconnect/debugfs-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index 08df9188ef94..91f86d9237a6 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -142,6 +142,8 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 	int ret;
 
 	pdev = platform_device_alloc("icc-debugfs-client", PLATFORM_DEVID_NONE);
+	if (!pdev)
+		return -ENOMEM;
 
 	ret = platform_device_add(pdev);
 	if (ret) {
-- 
2.25.1


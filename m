Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2F3BFE25;
	Wed, 15 Jul 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099772; cv=none; b=csB/3JdOl+0lxW2LkQegPPkKBl3zc5fdawIv65G9ezXdCehCiWx/Q3hlusfLQGbX0g2/KboIkqHwMrqmakjY1DbdrjBHzLjclj1OAvE2bjQgSbGxVuhObSYoh4HpZ3MzmY5sMZsEPWrXxuvsuIm7rtBZ+rOWRAAIZ7xMo+Shl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099772; c=relaxed/simple;
	bh=s86Kxd3sgEgAqxYCZHdxjvBLPCHbEkVfTcByZl2E9dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNogIyYWrdAZl2lSA4oWRCK5lEOdLmE0vzrPPN70yozqejHLRy2dSZPE8nX1nZDi8zC8Y3Wkt5PErn35k95VHnopGfR8KDy6qk86lKCE7oal+RMEyYe2j+Ftb0GRiavs6T+bes7/mHPzW698XXkPeoKZzrRIZgggZ6d9pTECYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0a3b0c14801d11f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8bd619c9-c0ae-440f-b457-a8080b9c57a1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:81dca6387843a2ed6db1532fab7a2c30,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a3b0c14801d11f1aa26b74ffac11d73-20260715
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1823525892; Wed, 15 Jul 2026 15:16:03 +0800
From: Can Peng <pengcan@kylinos.cn>
To: daniel.lezcano@kernel.org,
	rafael@kernel.org,
	heiko@sntech.de
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] powercap: dtpm: constify OF match table
Date: Wed, 15 Jul 2026 15:15:59 +0800
Message-ID: <20260715071559.202016-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dtpm_create_hierarchy() only passes the OF match table to
of_machine_get_match_data(), which already takes a const struct
of_device_id pointer.  The DTPM code does not modify the table.

Make the DTPM API const-correct and mark the Rockchip match table const as
well.  This documents the read-only contract and allows the table to live
in read-only init data.

No functional change.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/powercap/dtpm.c     | 2 +-
 drivers/soc/rockchip/dtpm.c | 2 +-
 include/linux/dtpm.h        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b7a65e543f19..0a503dc38eb9 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -546,7 +546,7 @@ static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
  * Return: zero on success, a negative value in case of error. Errors
  * are reported back from the underlying functions.
  */
-int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
+int dtpm_create_hierarchy(const struct of_device_id *dtpm_match_table)
 {
 	const struct dtpm_node *hierarchy;
 	int i, ret;
diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index b36d4f752c30..6f1ad9b24289 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -41,7 +41,7 @@ static struct dtpm_node __initdata rk3399_hierarchy[] = {
 	[9] = { /* sentinel */ }
 };
 
-static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
+static const struct of_device_id rockchip_dtpm_match_table[] __initconst = {
         { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
         {},
 };
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index a4a13514b730..05993a55138e 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -67,7 +67,7 @@ void dtpm_unregister(struct dtpm *dtpm);
 
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
-int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table);
+int dtpm_create_hierarchy(const struct of_device_id *dtpm_match_table);
 
 void dtpm_destroy_hierarchy(void);
 #endif
-- 
2.53.0


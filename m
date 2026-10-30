Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333267;
	b=4PA2q7BXnPEuzOWjc/e06yDsClunUgbQnTNEx0keRv6ZE2aPQtNWCvUa2N+W2VXKVnwv
	 PEefjEcihAJK7CdhzIKEogEwcEq1W9oo62Uz5TXfY+O81s/++lwf+0/vYo4ngfwH5F8H/
	 Zhy49IqQc2fFlFXPgBw6xwSeLFV3G088K9da6EYBAg1PasaJuvTbxnBX8ikBR2alliStT
	 T4SqNv0CVCGYih0g4FSKjGmJPzAKGi8sezgwc/0IRPuXZyRRlCIfcnSRrOAADq4VDWo33
	 Bd3zTf8+1njisdxv1Eh9JJ/iIwBLqzav6Fs2a4flHCLlL9xbR64QFvWTeuseqR92DZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333267;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Owl6dkkjPyyQNHRuGxPIjarHgpzeYVUSuyufxcjJ7Hk=;
	b=4na6wow+pMQ6v/OMPomhgNzQ+jYFXnaSjCL1uGF7BYGNL7PRvVEfVqfljBSbQB8RALbc
	 ujs8iSl4wcQjIWIhLfrQDg5gm8ReWKiWhDpk7/qMvCGYQMqL6uj69boCjlw+0TZ3Btedd
	 sRt+r/dry1yiZffksAiuqc72JcTOvhSUWhv4I8o/Tr0SQKFVNpCkU7o0qoSnNk1f2XV3p
	 N9vbQSAqj3291LUer0N5Go5DI8b8ltdLeolHapO52+OIWsp44HwJyT2jc5BpqTbbwSJtN
	 6Ham60iZWlXRepqhOdqEl9pHd/G8ee24UTaEjZnjZMGokCMOAyqrLv8IDYTAEuGbqUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KdpwQc9U;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C76606A31A;
	Fri, 30 Oct 2026 04:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KdpwQc9U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=KdpwQc9UjTTtv+C5JR0uM9BGQI3bXmfnEozfACzCuyvV/d2S3cJjpVRJLC3c55eClSLgoo54DYJV/
	 0zQUfgspKiuBnv6JuXxJdKzq6aCa7Q/+XH4xfxspC6noLgku3ePKIbprOIAdURYA47VE8dbI7bHgBW
	 ZI0JZs/lA9wATSb4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae41803e6b-6dd79;
	Fri, 30 Oct 2026 12:07:36 +0800 (CST)
X-RM-TRANSID:2ee56ae41803e6b-6dd79
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16ae4180585e-4cbb4;
	Fri, 30 Oct 2026 12:07:35 +0800 (CST)
X-RM-TRANSID:2ee16ae4180585e-4cbb4
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] thermal/drivers/airoha: Fix device_node leak in en7581_thermal_probe()
Date: Fri, 30 Oct 2026 12:07:32 +0800
Message-ID: <20261030040732.1333-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

en7581_thermal_probe() obtains the "airoha,chip-scu" device node with
of_parse_phandle(), which takes a reference on the node. If the
subsequent syscon_node_to_regmap() call fails, probe() returns the
error without dropping the reference, leaking the device node.

All the other paths in the function already release the node with
of_node_put(chip_scu_np). Do the same on the failing regmap lookup.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/thermal/airoha_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 7c63a1b44..b7062b35c 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -572,8 +572,10 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 		return -EINVAL;
 
 	priv->chip_scu = syscon_node_to_regmap(chip_scu_np);
-	if (IS_ERR(priv->chip_scu))
+	if (IS_ERR(priv->chip_scu)) {
+		of_node_put(chip_scu_np);
 		return PTR_ERR(priv->chip_scu);
+	}
 
 	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
 		struct regmap_field *field;




Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596FB285CB9
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773802125; cv=none; b=KKQ0sy/i6m+2JdwYPezGs36I4tX4KnlW3e/wjU6s2we5SVn6h1EPwJoHYO3fTKtMFeZr/HNxPWXt+Zi/pba7pHBgFezYZz3kgMhjPu1WFy75mJbJCUJK+gs2rwaefgweXH819fq+r/KDa/Fj04jMgi7OIoRkiqrBc4LBIhjio74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773802125; c=relaxed/simple;
	bh=b4GhCeYtl7uAbYl9+/ANPuQiNaXtSBWnV4gUaeDC3tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONkXiDywHOZgtk+PsH8vHK08QzeY/aW7FYnPsEDFsS/ZK3gyOe9aclYC4TXPZAI1cV4ZCBQisGL/oIh0Oj9LZDF2HBRacZ7XtiV/EcrGDqoPUUfODEB3FQIj2NAn2g7HfsTqtw4thiuocC2VT0OxZittQWuxuv9tpYeBmGDzykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPd4mUYh; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPd4mUYh"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so1328999eec.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 19:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773802121; x=1774406921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz8/2qEt8vMzdZArROcCz49QpkswhVDh5Jy8LhjWhmU=;
        b=DPd4mUYhKb9Yywl9nMVOrnFWLExC3j9U9NuICuUVodvWizzDIceRM2569OR8T7+6wZ
         4kSKDgU84nCXVguZZr3oZ0qu5WjTrMIrH+NBxUDZghYv2PGGr31DUIn+hYTErKfYrw5H
         kzOELSBHu/x6dcDVBI1kL8bFdQBp6Ls269Bn97dBdmIoiQ9CYK6iRRnTo9QrwKuXMA9W
         Y0R4GwJCOBTcgqCvgfji5ZLBQpKK3ktx7P3XxdhVHaqFMHPfY3B4nxIPXZCXLVDooxax
         LvipgpgozY1ly+LQarGbjlxTkgGdXZyu4oicHx1mxJy876jMw5RXbaP05+zbzyFpLYmK
         83zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773802121; x=1774406921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz8/2qEt8vMzdZArROcCz49QpkswhVDh5Jy8LhjWhmU=;
        b=Tfr8E052Ep+GJLT7cb15wvSKSTWgLYi8gPtLYN88j70kulqyxJXcKXy+MjEmUSUlYa
         r1XUE7WwdxCd6cebPU9rafEVK6QjzFK+mkVTLC007G+tcJbQO712LDWl5VVE+8KiqJML
         J0JuWRT0CdRExnTLUVCuT/IZQASxH1bUGE0L2xnnO28VVg7asBixNeZZ1kTFiiEu5f42
         INCXogT3YQUNAru9jIJPmwHSIIrP4PxjYBQZQww2uhFyw6EsXYsmqhKZ7av5KrpJiCff
         0CJ7IlOMeNI/5LhKQKKOIDkcoLFvapIOndvo6uZvdc3fMnSWnGU+ijgERTpBNWW8qJiz
         hZXw==
X-Forwarded-Encrypted: i=1; AJvYcCVbUVJye50sZOG/wlwEEvXKBgwC8ZnwSKcMhuwREH4UP+uGoAs4aQfcrHdwlA8dcQyp006QxI5O/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6AsSgwBsoR78sLqnw8DLa7TaoUwDuoXTvOpACPusUHpQWwpb
	KPa32v6DyG6Pv46Y7SiEzyhWzmDPVRszYYK4s/VuAUHuhSo1TBnag+Mi
X-Gm-Gg: ATEYQzzwfJBgoHTKTKzQByOpJ+3vXj+hAvzVM41bMHJhqvT/pUSo1d8+BWUuK//aeBb
	Pd//ZrgaDM3rGGrBZ2wn8srtXsFPIRI77TlHTou8T7EENjMcvackIGtg18pOgBIK9Iw87ZXtGMT
	xoZ4UdaXZPjlQZ4QS3zJnFfnS3CB+KcD1GVKGPhcjNccS01ifv94zSv7Ogq2S+Zl4usKKOLMRRh
	/7LERMq49DC3QaVPhtzv8XTFe5o4fdEZEIGJvcH5uvSUTtCD/BPydLbh+Pae/iB6kH2AHqGe2BX
	0ZIFHhLjzybDzSSUYGG/GQKtK/yH82lYRdMTlOnKbEVhk+5PVdcZj4yacWRr25WImLVZ2eZZHxh
	kBffPQwSF/NZu87mwwpVz1DQUu6o7wJJcOLkXpIYFgmhSy/lEff8dBYJQRGq731T3KRhCJuWfHP
	TiXadScm7t4VpvT8CDIbi7IjncyfOZ0Hpyn2pzjil+/TllDr+U+gqRk2iUalqahZZ9jilGJZwIb
	8HKBnHMuD2Zzg4FUjKaXC14yILTQo0Cj6SDHQ2AYpDxCyXeSD3oBgWkaKxvWrxlQJPv9kCv
X-Received: by 2002:a05:7300:ed0b:b0:2be:833c:1486 with SMTP id 5a478bee46e88-2c0e5020a54mr893060eec.18.1773802121076;
        Tue, 17 Mar 2026 19:48:41 -0700 (PDT)
Received: from 2045L.localdomain (130.sub-75-229-251.myvzw.com. [75.229.251.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55cd9cfsm1930911eec.26.2026.03.17.19.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 19:48:40 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akaieurus@gmail.com,
	me@ziyao.cc,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] interconnect: debugfs: fix devm_kstrdup and kfree mismatch
Date: Wed, 18 Mar 2026 10:48:15 +0800
Message-ID: <20260318024815.7655-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs_write_file_str() uses standard kfree() to release old strings.
Initializing src_node and dst_node with devm_kstrdup() creates a memory
management mismatch. If a user writes to these debugfs nodes, the
devm-allocated memory is freed via kfree(), leaving a dangling pointer
in the device resource list that can lead to a double free.

Fix this by using standard kstrdup() instead. Since the interconnect
subsystem is strictly built-in and cannot be unloaded as a module, there
is no exit path requiring manual cleanup of these strings. The error
handling path is also simplified by taking advantage of the fact that
kfree(NULL) is a safe no-op.

Fixes: 8cc27f5c6dd1 ("interconnect: debugfs: initialize src_node and dst_node to empty strings")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
I noticed this memory management mismatch while working on similar
debugfs string initialization fixes [1] recently.

[1] https://lore.kernel.org/driver-core/20260317185920.43387-1-hanguidong02@gmail.com/
---
 drivers/interconnect/debugfs-client.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index 5107bff53173..08df9188ef94 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -150,10 +150,13 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 		return ret;
 	}
 
-	src_node = devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
-	dst_node = devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
-	if (!src_node || !dst_node)
+	src_node = kstrdup("", GFP_KERNEL);
+	dst_node = kstrdup("", GFP_KERNEL);
+	if (!src_node || !dst_node) {
+		kfree(dst_node);
+		kfree(src_node);
 		return -ENOMEM;
+	}
 
 	client_dir = debugfs_create_dir("test_client", icc_dir);
 
-- 
2.43.0


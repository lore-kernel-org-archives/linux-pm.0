Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B32FD7C3
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999914; cv=none; b=ZZCx8BmT8RqnaD7kecFqtyGrkpbD64nMqI/FtvWqIoe+uD3qG47qWiwwXxFwkp5Rxi4o1SR4ewl+PZHRN6ZrIbCi4kYo36ewUANG2CaZj4F6Iilb9NzPGBzFVCRlYliAhim7S6HNL3ELPpSPCPEoM83GsMJM5/dfBwYhvOTtQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999914; c=relaxed/simple;
	bh=0ELtIeK9ay49MM27YAl67nwHaIXM2d/3LYuozln89P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f04Dv6timwpkmHKMOBGN8B19bq1BUpfT3rIVRa7qHahlEzbA+zQ98PKOjmQx4nxpd8NFJdSJ7qNcNupkMsu4yEMAGTU0JgMDkm6BaJi3UempYGLC0QhkdouBrEYGl6R0HSzzUDqEwL3Bu+APloXQrByZkp/nLCQjm8rg0BGfBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YknADfTL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YknADfTL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36ad15213fbso2912427a91.0
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779999913; x=1780604713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CggQBmAuhU/vixgo6EEwOoNqb/en0xhwekKbF0wLXKM=;
        b=YknADfTLMmJYDvfUJe4yR7iwMWCjyf+XaOzNlkY0vsKQn9UQnFFkxt2om9XQe0AlKD
         JSEDa1Xre66ObT9EF5cwu+C3m4PwXk+nCGrUWZdn76vKGH5+3W113OOADs9DNKdVYH1Q
         5/XrAVDnNn0/JQSgnAUWTzVr91nzGfMRZKeG9jy4QGr758Edrudm7EQts9tlRJ0/PeLP
         ZzsOVgKoJAX3vpaHw7voT6wzf0W8pw8XFFgNUNWcdVO3emPWXQ1ujT3XS2ySzeWviyct
         mRKmTQtIlU+Qhczs2gAoEfNTUTR6Rvaqg7axPdbxD3J3gH4VH9mIrKUlALtfZllx0bAn
         9pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999913; x=1780604713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CggQBmAuhU/vixgo6EEwOoNqb/en0xhwekKbF0wLXKM=;
        b=rgB8LqU+QVk4YN0+FXhNq2Xqnr2aua5xlwDz0mKY+clcNNj4V4HsY+mG5Ld/WGATSd
         9VE/Le0sIqD3Ka/jnp5Amy531Juq+mZC6pWH18ayxbD1960fPkCMCbXzI7SKE9+6JgUM
         be9p7IALczbTV8pXZK7J4DY8amDRP1XFPaPRd3AV4DEI942/f49LWGAJSrz3Bslo7RaU
         OYerV6j9mSEJBdQttfwCyMn6Viuz/7JYbpRacISTbZZPP5EryDM3BxV+xF4W+OG7eSw0
         M+wCB11BCPg5RY85wBZ/Bagiqnw7s/sdeVxL+je2nFTsOGkpxAIGnwGsdZUAzttRJ+PM
         sEmg==
X-Gm-Message-State: AOJu0Yxl+8fK/xEOag8nPkQ28gFJ+DCgxNrQkyi3PjB+7E5Ddr3TTjIW
	K3cbI30i9A5qqjnFr2zJs5Q99Az95wHy7n7XflEdqIxOn3jQv1tn3+DSY5TD1TFj
X-Gm-Gg: Acq92OF5FzfwME7aR9Oiu0vPyJZzTHcTg86veJei5HWZyiF+K0Lt+C1dfM3TXmGJ2vw
	Hqyj/yjh5DHM488bJBVjJXDWGlTD8lwITdTap8fqnfKFoRuH26xb3pKLzFtM85xCJquvT1W+Rb5
	jvie9axgjyNZcvUr24ycc3um1Ivz1LYWLOnmDwo1uKYPmRkP3rQOGtxWU6NrgPvogdES5oA/pAe
	5JZMk8J7O2Ot2TiuA6tQSsAXqMN0xTIn97K+pRWrpTY4sLOjibTUNiODbzqtCWBjdR3NV+9xSIL
	ODeBwotsNpBHZmqHLDetV20Tve+FFQxZbHRQgXroQTEy64rMNGtbfExwfmg8dwu2iIs2jbBgT8g
	J448VmOHJTl07rX3TxOMgpb0tYi+Qxoczd8lVoGjMmspRg54QKaAVYDB/+RXfbMMLXqUDw5CNsj
	Vh53dfvgYzQetppItm62RwIgSE7vvUhYQLoThhEoPuUyG2Mj1HJ6+SeL2l1EXQ2OI7Ax0MolaBk
	NW9x8QQ9/5O5TaBtpBSENCRT8YNo5v7S/w/sxbdLs07BDOQeckFwXfZ
X-Received: by 2002:a17:90b:224e:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-36bbc6c18c7mr197960a91.0.1779999913014;
        Thu, 28 May 2026 13:25:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdcda52dsm4343a91.4.2026.05.28.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:25:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] pmdomain: mediatek: mfg: move __packed after struct name to fix kernel-doc
Date: Thu, 28 May 2026 13:24:55 -0700
Message-ID: <20260528202455.136618-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc parser cannot parse 'struct __packed mtk_mfg_opp_entry {'.
Move __packed to the closing brace, which is the more common kernel style.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
index 3ce6fb74dd53..53bdab66cf15 100644
--- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
+++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
@@ -236,14 +236,14 @@ struct __packed mtk_mfg_ipi_sleep_msg {
  *
  * This struct is part of the ABI with the EB firmware. Do not change it.
  */
-struct __packed mtk_mfg_opp_entry {
+struct mtk_mfg_opp_entry {
 	__le32 freq_khz;
 	__le32 voltage_core;
 	__le32 voltage_sram;
 	__le32 posdiv;
 	__le32 voltage_margin;
 	__le32 power_mw;
-};
+} __packed;

 struct mtk_mfg_mbox {
 	struct mbox_client cl;
--
2.54.0


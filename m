Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD683DE440
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416784; cv=none; b=ZDrmHQIWCBoEBei+vX979iSSiwCps2Pt8tULLcvpZxqOSW4pN0u1kyaTvemdDqvzm83C5kin4sKAqDK/4kEF5kABEquJ3G3iaVTi1c6V+VBDrxWSaIAScQEWKR4W54vABSGIO22Nb+9Ki9XUwXkx6pJoXnbYHbKvczq0fIuZ060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416784; c=relaxed/simple;
	bh=9ZZ+x5hkD/0mxZXJpd66ErYLDuF7UKdZxcRaCMgFe+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fTZ/2/WjtK+dljEP/hcV+QATKrh4+IMyaJDrbuvxKYyrCT4FblyWNuH9Rm2Ntk1RKrCFv9Ic/D1Zd8WLLPA5LPgtSa+3H5q1K9pIUwGV4M6nMNoef6aAFWO9JxT4BEMcaf6pioxEQfXVwqPv+Fp77MzFQBucoCTKGTG00/MpisA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAcQXAFT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAcQXAFT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398a147688bso1200338a91.1
        for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790416782; x=1791021582; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kUiyvyXhITScv6LZw2RrZkQ+8/ZN40BHdOZkzQnRKMo=;
        b=JAcQXAFTHCpeAKPZOkXYY9JMAUHuN82T8hqCcbla4DEoRIZotLtKIoSIxPxJflHuam
         GwMsgVVGMT0HHoKk91LFylQ2bwTet+pBUVFHAaV37dtclhUrITWNdpRCY6i8ZAcj7lQ9
         J5bfpt7Wh2AcQcdqX5XhzW4tfr8pvKow9S29kCkUy91DFffkVU/P8yWKs4rJs4ECR9h2
         +2OtFrB21hnxpS5zwgci519LTTbM/RsmGEmjYgxBLJIRffpJKrFmYMNzBs98EyiHQIbj
         D00HC5BaeHPDb0hb7fjNXm3iBugVBzAMCsymtIPcrHm7ku67TgLY3zGc3p9J9oLhEHNH
         CxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790416782; x=1791021582;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kUiyvyXhITScv6LZw2RrZkQ+8/ZN40BHdOZkzQnRKMo=;
        b=rZllBcuQHqV4mZ0msci3GktOKGUQDWTPEYqnf4OrlDdlg5Q/J7g0yNz4v3EH8tbFMi
         i5AU009d2/+qMIj892DH9/tIDCGeisXjAF1rtcdQxoS+sLoLIX8KrohqcaG9VGygkYD4
         75qVwTVTglGxbajuOOLImiWWok8IY/u/MpRL5/tBcdeAt5Z5tRCmiBYDAa6W1fKNxQxw
         tf0ZfQGXvAtZQtw9opbJQtIaf9MHuHjHxGOyQNewozvIMMt2eD9Z5y4TqJBPd0udDZ+X
         Bn3DcLAWzpXTFSbp2L+mY+YCmm1GRvzefqoErsyZj3Rl0CypIRMqDG9pCo0YbQt+m/xm
         thfw==
X-Forwarded-Encrypted: i=1; AKwUvByhqEdk1gresRMgPrxk8qVt+Pd1+9qXTQ1CV8AfMwuV2WIZiaLphjeln1N4eRdWdqTgTjSvk1a9Zg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmeXBaKjilreED90Q75cHvKso9UPehvBgMsWnV8EeWkqTojwmC
	3jKMNbcCJljStCzhBgDIzYK7Xdwbm1kzwXP7/vHsQ96p5Ay1aacVAoT8Iu614Clzw+s=
X-Gm-Gg: AYBFou25HdwkaIYImC089+6nvuFMaHFJ5XiEa32h+vQ4nEUySDoRwPDpFW+XShHmlyF
	1UeC+avfA8FXCRjM11cCJBn/Jb704+3iKxeCuQ7FrMf49gLpDwgfiHLR/9kwS106av4Ohx/IDst
	yEFtoMpKMdYYxi5174Ygd/PZRIb0q5g58QsQmBDEnS3+qbcl8d74Bj3KCaLAJ3Vkjfb+x4MHNAc
	IIMX8pHESBMbMQbVevF0XuPnPiWS6DzjG4ZGASsAtSev/ZUqRWJFRrFYzlBv1uWTkApSjPp78kq
	AeBuX6e8cFcpSvdMSb0t6rq/bsuQ6Zr6pK5hf/zt7944FsqiMs6GF+A3GaYKP+Pzy38awDaADsf
	xOg3cT9JmpR5wGi+oBInEaw4dDGtjS3ajyColNn4qzjrduFvAqx6NA2Tw4MyWaPl3EdSzX9omMh
	kmvPal2PKHbbV4kAhHwUdBF2CWju7kjeAIFc8CQzhDX8xcCSCoD7UgBbEofqoHizREGkxEXHu5P
	V5xLKRWBw==
X-Received: by 2002:a17:90b:4a45:b0:39e:1633:d29e with SMTP id 98e67ed59e1d1-3a098d43634mr7056631a91.5.1790416782257;
        Sat, 26 Sep 2026 02:59:42 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:55f7:25d7::3c5:1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09766210bsm15033663a91.8.2026.09.26.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 02:59:41 -0700 (PDT)
From: Chuanhong Guo <gch981213@gmail.com>
Date: Sat, 26 Sep 2026 17:59:28 +0800
Subject: [PATCH] pmdomain: mediatek: scpsys: add MT7629 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-b4-mt7629-scpsys-v1-1-e02d03d2151e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ6CMBBA0auQWTuxVlPAqxAXbRlkEqlkppoaw
 t2tLt/i/w2UhEnh2mwg9GblZ6o4HRqIs093Qh6rwRrrTG8dhgsuuXW2R42rfhS7bjRxOrfRkYW
 arUITl/9yuFUHr4RBfIrzb/Tg9CqYqOTj4jWTwL5/AfKwaoGGAAAA
X-Change-ID: 20260926-b4-mt7629-scpsys-88d0cf37c6e2
To: Ulf Hansson <ulfh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuanhong Guo <gch981213@gmail.com>
X-Mailer: b4 0.14.3

MT7629 currently uses the MT7622 domain table through the device tree
fallback compatible. Attempting to power on the WB domain triggers a
warning during boot, and powering off AUDSYS times out.

Add an MT7629-specific match entry to register only ETHSYS, HIF0 and
HIF1, matching the domains exposed by the vendor driver. These occupy
the first three entries in the MT7622 domain table.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index efc8f276ffce..2b5bd8d61cb5 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -1073,6 +1073,17 @@ static const struct scp_soc_data mt7623a_data = {
 	.bus_prot_reg_update = true,
 };
 
+static const struct scp_soc_data mt7629_data = {
+	/* Reuse the MT7622 entries from ETHSYS through HIF1. */
+	.domains = scp_domain_data_mt7622,
+	.num_domains = MT7622_POWER_DOMAIN_HIF1 + 1,
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+	},
+	.bus_prot_reg_update = true,
+};
+
 static const struct scp_soc_data mt8173_data = {
 	.domains = scp_domain_data_mt8173,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt8173),
@@ -1105,6 +1116,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt7623a-scpsys",
 		.data = &mt7623a_data,
+	}, {
+		.compatible = "mediatek,mt7629-scpsys",
+		.data = &mt7629_data,
 	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = &mt8173_data,

---
base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
change-id: 20260926-b4-mt7629-scpsys-88d0cf37c6e2

Best regards,
-- 
Chuanhong Guo <gch981213@gmail.com>


Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5127724887E
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521393; cv=none; b=cfHr6KHMmk74sJN9sq4qGiTZeBl107hBXUGfvf3/W+96YL9HMt/Acwuz+DzOYdXZxrStmpzemrs+Jg61XLsrrzkGeFMilBDN0HOr5gvn0UC2IZqHv9y6T4ohiz9DjFr9rS6f46SZc3eB5TZYV980csyML72lZB+kwfC8kDSVs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521393; c=relaxed/simple;
	bh=NmpEIPGRlLUzKjoLSyn8mQV0OZgocjo2yX1kNidP4gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BCgMtPvAQAevGpanhQ4IuJNBrhmPaDjhzeyMcCmXAJu1fQo6/gJ0lpjwDxXUe14ruqiOsCos3sZgt5hnqZhp8JYKtaW1Q4bu8xXqyHazM3FprPvt9yK3ax4OZExdlGOd3v8LcUPo2tTQJHMaE1lelToaZZgLFHiQsI0tewVhWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q76H8pZY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q76H8pZY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso1886023a12.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521392; x=1779126192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/v/BO2s+C/N+KeMLepP9unKc4wiBqpI25gDLTzhr3g=;
        b=q76H8pZYFvxzBv8VfcrQlsftD09mPVh7I42rTvX/G87g7Ick7WvvBHT6HKaRHqEkBM
         Vh8b0UxZWL0IQ2foZP02BdcG3eBz3amUBlK8Esx8TOn0g/svtD/tAx6ohpdYOifggP6D
         9WIPy2/OiqPiAsBbvRLmxxy0VSdPfM7rf73owa53Ki+fK6dU5fdAXK+XuWOCwD3s8DED
         93FbmMi+n1i7bucTNexe7Fay5NA5Og4/XT+I2zpUlOm6/MbKLp0eIdJEsJ9cfAqKHT1q
         tl0lchfdrW7wrWjIYM6HOOplolpFpvYr13LdUV39crK1SWEOXbWN2h+EhswmZ5TqJW0P
         1bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521392; x=1779126192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/v/BO2s+C/N+KeMLepP9unKc4wiBqpI25gDLTzhr3g=;
        b=Qz0DQoI0+JUEbLSggRmbTstf6xaJhTExjTb7J7Jo7JalJFLV1U5xQMyukOSwz4Lpiw
         etzc7n5yJqVVL8GNfhl4KjewvUp7B7kMS+mMaH517wgNyu3sXkzA2BxZUWvyaL5Qp9km
         3BQrLLWq07+QH838H6rm04BP3KuCggxw+3S+jMb9+v5iso/pgmacaVucZE7igO4s68rK
         FUhmmlMZn2NZD3YT7BPoMu4uJdTdlsXKCVyyh6BTKc6dQCbFIs0XUTTzQ30cTMA76SEK
         jmVVft7I2janFTC1WSzLO9Vc6nuPgLge/OOPMchf19iEA6y4ROdmmci2HHjHuz6ZqUld
         g0mA==
X-Gm-Message-State: AOJu0YzXasCsrz1r2NhSkkq1MQ1bv3JAPQM3feban8JeOsgVttkYS/8e
	qtmZimRcxF1Lc9peqD/SK79CBFlzIicliK4sm1YNUlrd4EaUY5uWATyB
X-Gm-Gg: Acq92OHYgl+ko4TqXeELnTQAuiDf4nBWstrKD62iEZGSplyorJQtIwj7Ksf6RmdBoW+
	8Fhr6D7XpwYmwTTAFl8JGBq+M9ZHhcBqILIP3R3fzUdiCLHV2rZ6y8Nj4yPR/u69sIecnNFya7P
	aVluLrl/rvra7xmFyDFfUtXmEGZbUWNnFadm4lbkpQ1XDfH6WBA8DZaZJ37zWxn3DCa8tWuhj+R
	BAV59i5e+BgxD0zwqljpvDFuUWfvoqI2y/Xko8cmlwg2KJNyPaLYpbi+hZQs1JrJLJ52KsOhSdh
	K9IUMG1gsfBsMS5JNckG9/M9mjHYrh409TaX5bwHKYqhyGw1t17R0FseSbEZUL1pUQKXE1HrrZ6
	0R9LQLuPppT/VytfLr2wSzOugEJShyMu2gpLocJz7bGU+hhJxmtHw9bLQ+epd7Kbjr4S/Aw0pmf
	CWp3/Fn/R0pxiIys3sQwiaAOgq+qDXK0XfbmTn
X-Received: by 2002:a05:6a00:4b12:b0:82c:6f07:299f with SMTP id d2e1a72fcca58-83e39c37b69mr9964792b3a.14.1778521391621;
        Mon, 11 May 2026 10:43:11 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.50.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d34872sm21398367b3a.22.2026.05.11.10.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:43:11 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	festevam@gmail.com
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH] thermal: imx: do not split quoted string across lines
Date: Mon, 11 May 2026 23:12:55 +0530
Message-Id: <20260511174255.215207-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpatch tool warns against splitting quoted strings across
multiple lines. Join the dev_info message into a single line to
improve the ability to grep for the message in the source.

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/thermal/imx_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 38c993d1bcb..5aaacbc5347 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -693,8 +693,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	dev_info(dev, "%s CPU temperature grade - max:%dC"
-		 " critical:%dC passive:%dC\n", data->temp_grade,
+	dev_info(dev, "%s CPU temperature grade - max:%dC critical:%dC passive:%dC\n",
+			 data->temp_grade,
 		 data->temp_max / 1000, trips[IMX_TRIP_CRITICAL].temperature / 1000,
 		 trips[IMX_TRIP_PASSIVE].temperature / 1000);
 
-- 
2.34.1


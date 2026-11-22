Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362923;
	b=RSfasXnk/bzMab9t9D27p3zfjlvLsfN4kN/Wkn1QdUCJMKJbhkn1MsJ/Rg6cylbmHv5J
	 H8f4VF7yCA5D+HiiVj1CCqjJiwHXhp4r4LmjF4Kr0LgkV/f3YrvZnjfHE6VI1nA9KCDjb
	 3fuY3nBhxuy4p1C0qMW8vW9aQ7In8dcqkAlXgwkwWpAHzKDXE2hGWXKo6itgSVd38G1HI
	 lLOWGevSeN4UgVqu+fIcyUKZI0bqoiMWSmn/fgBqayUpIkKo76O1VoAzZ/imjqdPSIaD+
	 vXfBcwIb76/O7gkNqpJDA15ZK+0vFTuGcqREaZLMwGURmFXIh/kOMuwDdpqp7uIyDWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZGa4bNi0q15yRe5T7kbprOuROWeQOYZpNWhT2mvzHGg=;
	b=bma8byGaQpwsPPw5FY9QiNv26/AcmC5uxFqf2Jccfsst688zeRL5xVGVvPORCm/bp4JI
	 Ze83WT1A9+wF5TZB7Ao+IK47O5CVdkSC/QbRTZqKYkhv03OyNoXRR6SWvndYBrAd0Qnsw
	 8jTV/D4r0SFkuqGaaG+xv+uP+0Td6VRHnqdemdETGHEjq/uNzijqAtaDA3Zh/1K1RsCcU
	 j+MPOBfk2HBlVtsqANVkxXxEoPxalNv3RSrlDg7mjaDbKbcPKhBZwLkjloSYlPtCCs8qs
	 farXByQp/X9QMvQwegaRy46lIQv2PgTTAB4Olc3LRgbNyHVu6HeaVlEl6lMY0XAbN/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Bh5pnDGd;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86B606A320
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 15:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE86B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Bh5pnDGd
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso1090225f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795362921; x=1795967721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGa4bNi0q15yRe5T7kbprOuROWeQOYZpNWhT2mvzHGg=;
        b=Bh5pnDGd6b9Ef5qdmtJVQyp9T9ehBxOEnI5o2z0Nn/afdnYpJS1SdofUMcu9StOgUI
         0dLpze76oqdv8PKdHKg/ELJtNKVZHlj+QU7zLU7Hxq2vBselSVbfLCopcM5X54eEb/qD
         25zAdeRTk8tUi1I+3bR3N5vv6vKxaLsIsFp0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362921; x=1795967721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGa4bNi0q15yRe5T7kbprOuROWeQOYZpNWhT2mvzHGg=;
        b=GJAHTU3noElzZi0wO7gnazf5oJyBdr58HToqku+qrK2PPDSeMV7mdNm8MXvLLB/ITG
         MvG0j1o9VePKDz7ICIBUUVDwLOPGCUjmKCipiK1UNhbyLazniYr31xIfcznnzZwoVidU
         rNmrhYPW/DBNuloa0pCCcFKOa+XSK7z4DxEKL6/QdtEkpBads1dkl5pPwQhtEJqiTgNb
         U00UKOQp6w1CqPLaiUmWeX69O1pidP6g9TqCQ5lAbJS49tsYr8mp+koiTbH/qDB0tmZF
         Oqph3qEQcWRWze4iBBOWbjTURyl0uu53BvMu4IYQr+9ExmtH5eR+VhEpvLB0ZsI3YhPO
         rZ4w==
X-Forwarded-Encrypted: i=1; AL+hErGK1CqtNWAVOVDIypcq/hxxeZuE27JanyrsJJcxUEpRaWfQNAta1OsU5VC8orVSUGdtazamkNP6tA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ecirvbJwqqgFE0mK3R5beoD7oYyUcPCfCgACSvOKsFeacCgym
	ve+bL2BDq7ZYjdcENS8g5FnC4MnCX1abqKLoLeUKBMq3ut9hlpUwRz9Zj2TknVRxiKI=
X-Gm-Gg: AZFdTZdGWsU+/uQ4hXcTSpzDieapdFSLTR4g94i7aXUdU4W66FyE2QTKvzrNoulVrnG
	pHS/ttx9KaT4aQFTkZU2v0zfsB9qPmvawP33qT3OygAEC/BcNS2yl33KHyqJ5Y5mNvC6dwB0NDP
	wswYFS2pnLzM/e2nb+PNTskAasxTt3tk5t4C0Uw5zDKm+NoOY1FFJkFuSY3/JC7YIfXD9BcjB2X
	RlArG+N92yVnQQADivcZpjdFXmmzCTzmLhpvfoBkxmaIQNcIeyXEcB4HnBiYYrexktxlRm1yw6Z
	VA79NZbtNiK+PhfuysEP11Ag6X8mAkBp6h4HOq8/GnM2N5U938xOYsnlHi+3UrOAvfPRlJX1N2v
	TS3ftVKmkDBRAxLxHXH3yF2eq25TduDu2U/R1vkuWSkTA3TCf8qXJQ89QggMU3Blb+HwBMyCVAv
	HAUhKsG1lbImkUodDUDart1v4pIIWgX8NDSLUt/TX0OqIZx77wiwzFrc7m0u3DU/GetQQ2oUlRa
	ZxeoM8mdGnMlDYZVH1ywmG1Lik0K1aotXmbkyeoPP5dgaEjUsM71n1YPWaIT0iBUL5aWhR7w4at
	hHuJBxbfR5hk9kSxbCBfiutqWmsA1HizzVPx3+LU6KNqEK3OyeEjVm+VcbcdnKg8mwtG9QU5/IY
	049gsiVaST+42Xgnvm+cK17YZuS8ItcfawND7oVrsBSXVtZkEYOYTLf1ERUi3aULrWGQT2y0APT
	D0ukaioVvkTyxmLqomjbuQB575N1e7SwSxklwpSrbxQF5RZC6g
X-Received: by 2002:a05:6000:25ca:b0:4ac:7595:6f67 with SMTP id ffacd0b85a97d-4ac7595721cmr13682565f8f.40.1795362921141;
        Sun, 22 Nov 2026 07:55:21 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm20046526f8f.55.2026.11.22.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:55:20 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/4] pmdomain: imx8m-blk-ctrl: Remove the power notifier on probe failure
Date: Sun, 22 Nov 2026 16:55:08 +0100
Message-ID: <20261122155514.10289-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122155514.10289-1-dario.binacchi@amarulasolutions.com>
References: <20261122155514.10289-1-dario.binacchi@amarulasolutions.com>
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

If devm_of_platform_populate() fails, the probe returns leaving the
power notifier registered on the bus power domain, while the memory
holding it is released. Remove it.

Fixes: 9cb6d1b39a8f ("soc: imx: imx8m-blk-ctrl: Scan subnodes and bind drivers to them")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-227073@kernel.org
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Add Reported-by and Closes tags

Changes in v2:
- New patch

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 9df933a7a238..7d6735728d8c 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -345,10 +345,12 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 	ret = devm_of_platform_populate(dev);
 	if (ret)
-		goto cleanup_provider;
+		goto cleanup_notifier;
 
 	return 0;
 
+cleanup_notifier:
+	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
 cleanup_provider:
 	of_genpd_del_provider(dev->of_node);
 cleanup_pds:
-- 
2.43.0


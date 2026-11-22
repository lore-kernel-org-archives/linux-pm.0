Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380707;
	b=i34pgl1/BKENFkrY+Xeb5h8ZbFFvGgygO7H5DAeP9dm/s88gTLhFHo6dpFe+l8oq3Ot0
	 kdAcBdjshgMOlU1+4i8k4Ma106KJnzAcEYueP5Yv8jQNK6IJn3Yvqb5jrJMmqG84c/Uyy
	 ErhDhciub6ROT74UlQRlfu6rBGhkulG/RlVJuF6YAyMFvT4BV2XFUY88xGrJ8MBGNFbKz
	 pVQEBJZw5iKKxHeumhF07N8EN+Qszmw9ummFHtq5MqFFhaNZwGAWvetkGvXSlEGZVOA/B
	 URJgqfmUSKNhU3xoA+7VBfEPDkwFUTwUnWILWGmIj2t/VJ9R7Fw9UBrDeOSoTu878cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H1tDo9wE8GIjmvDNP7MPhEM33+qsU/I9oOSPNzyzY9E=;
	b=xZM0dBlYL/tvaX3ppDjjXHmPqAjkAsXqAPbUIzYt/EpaH/rMOpUoA80PP8QUKEUMRbet
	 lj9xgdxrp/F2hUfYxgOe1qPP/GyfxLoOyi+VshM3nTtcTYbXCln/PzhCh3sASe9OpeXKR
	 9BLfOr6zHZ559SjHR6zSvVp5r188jrOUZcz4qo+KRlOtXxZpEiBkfEVqVgi4ivzU3oo74
	 OkofIFIjo4Ns9ae9lZG3GHzhOMKEqstbUp7CsIx9p9Yd1a5WN1o56i5XIoUzz0qIy4Dp3
	 f0ngj0uy16z0OEray6Tiu6Ay/eSE/fiRdDBAIcxWzLfMDECxvLiLgMM68iT7OQ5Ldvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=FPDRGIUh;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37C606A695
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 20:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A37C606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=FPDRGIUh
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so27500495e9.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 12:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795380703; x=1795985503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1tDo9wE8GIjmvDNP7MPhEM33+qsU/I9oOSPNzyzY9E=;
        b=FPDRGIUhQPkYNgqSsmK1ZyfRT8aGLsKnPsk61rjuoSZlT3Ey2AuFIdGMeGzB21wv8+
         3jIMg6KAKsV1efyUHOQrN3blCI1nQEu6V7+t1UewC750uArEjBbmfiBsUDYGr6d/uT1Z
         VLU5iH+4n/+RWDTxn1hSEPCBomAa92UfEhFms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795380703; x=1795985503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H1tDo9wE8GIjmvDNP7MPhEM33+qsU/I9oOSPNzyzY9E=;
        b=2oNZbx3PIMDEWTJ5rOhz4yShegyYE8iSeKU23SZuRIVk+AsS8YVyWSM8B2wO21s6w1
         XgaChZDa64412YP+P1uSB8ytjUjLlqLn/Tk/Qmr2p2giVvnGx2REKRhYfdeGlJqrMO1+
         H/GptCdhGM2Z3mY6FuPTTapU0iHqKB4N5f+TIPcx+U6nEQSE6TgnNPtBkPe9gt5r9Kpl
         DxCAMVbVlZTqIjAzTBMskAa6+yfaQk1Jut87RdAY5DelMcP7q3o6pL+jgyd3Sskp/sWh
         KAAolMo2Rv1kK2b0+2yBgx92YeqWVIT0ehPXlfsIkaO6QhXquWpEZ/TYXBWSThrSrRBC
         I5Jg==
X-Forwarded-Encrypted: i=1; AL+hErF93uaSUUlk3opLPrYLk61th4tvZiAKK1Pa3VuvqOhOJ12cNrjJkKuyncW/Lyk3M8vxxoW5m5JPFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+CVUI2eAdBv+59uEimpQg/YlKMXG8jOAx4sRAiTXlPTIm4Brn4
	0G6Gij5BnTsWIeIaJPk5NizLcFeI/3PEqYWjOcB1g98FTArCGoni82zN6FmaP8hKykQ=
X-Gm-Gg: AZFdTZe6M8OWBBcHIBbiXcYXG4+4v5mPu0VZYYJOLZxXrbjZWZZFVHc06BNUtCdb8rP
	ARX1B09Y5v0B4GHmBlOLjJzztKG5T5wKmyIUeCMeseRcBsnQlDjQ4hBTgLPF59txXgCHF7F28jQ
	eZyjZsDAUWaJVxjzP41uoHrJkeVtPtuS6VgdJOSPUSsjZId+IkPWC6m/q6jAWsQeFRdnILdA+Z+
	k9m1xNFjXDISlUYcov4/ZV3MvDpmwyePL+seMwdNLiYrtqUNy5SFBB8TBUVDXsShE3lkgRvBuJI
	21U+HDfWdDiUAdgaBSb+FD9d3OflIMfn5GwoMv7zGQJHhOJw3I8p7TXG2n2QnEdC2NJNh+6LPrU
	QlbFKgiwMPx7LR2hinispaRNNQ1yPQm/X2mney/Ux077J2DKqQM+mg79YAxYOQp4iFEqe5wLaZ/
	bNi5yq2I+EV4zIwCG93++rK8lBwVX+YaJWzF58UlAmfCJTzVZ8oRtKGDWi7pr2cVokJcUNg2v/7
	SNGGV//hAT4V/ExFQSzI7icKcoApBnu2A/xLVWh7cAyxykX/8rChMQuzfF1zQI6EOP2sx+ESjGZ
	kzsWp4PdZmXDv6Xob2UIHrziUG7D9VNm7v5UMPKuComxH9tSZfC70eDJZiybzHnv94CKEqRbgjL
	vygRNwWCo7gztH4sgTG4pihTx65cmZgLSN7A5rbCjfyr14S8sCX+NU9gdKRflCVgyoLIW9UTQed
	GVhe5JeIE56qfm6xQGH33OyTevdA==
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr205083495e9.11.1795380702757;
        Sun, 22 Nov 2026 12:51:42 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm397355305e9.13.2026.11.22.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:51:42 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/4] pmdomain: imx8m-blk-ctrl: Remove the power notifier on probe failure
Date: Sun, 22 Nov 2026 21:51:10 +0100
Message-ID: <20261122205136.138173-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122205136.138173-1-dario.binacchi@amarulasolutions.com>
References: <20261122205136.138173-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v3)

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


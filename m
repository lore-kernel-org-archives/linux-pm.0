Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341576;
	b=VK7pA4zzciWcdDwBZmf59hx3YQhHUQrzFyQ7Wb4V8ETBWNxC3oJKn0n2p1m96j+em6Rq
	 sFM6WWUqvmJCTVHqsfpbMuv1IEZdSqKoGGV/qROvdsMIa9RhZiBeXjgEfQL4gYRIPeq4F
	 +VAmxEWSX/b7HKnA0doaIy5nTsJ+mbEsqeLtyh7WOq7ntiA4UaK30RpRun1pdFFzouqru
	 odAosv2fXiP/WS9Vq8PwKqUNulTJo6lPrXnfUQf3vgmX7k0gfxumxRsqvvUZBO1Mj7irq
	 A0dE0meh8zc6nvFY5X5HxJ5ZFjpAiTDN9CbgOVw0Oao3CZmgkAvs02hLP8YNHsP9SVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EAJZGrU+K9EIx1PBrfq2qgcoNQAfdXDu88XhOMIZ5xQ=;
	b=X/c97iPqd3aNqlihmyiPHFaKORuxI7HSnyjFE3mPELKdYdr1Ct0HRX853EX47d+9KhDT
	 LSS421NdomRpyVKwdjvKzcgkTMNhEdXErE1HAGP6E0fDMTF5LwLGgotc7GMj695U3tp4L
	 8bCgbRmTgNRXgIGGOSFU4LTLEzsg4DLKixYoCxT7yWS0Ad/vrRxCQ+6jp+LZoh10ViYZR
	 4WAH7d8EPKQztxVLlmXUIKRqXltyM8zPJz5kEPnaJ/SQjjgHFxdZ8PLLJDj1IYPW8BT0P
	 xKi5Ph47BT5S06IDMQYuZxHbgaRWmwqzT2cIv+q7NDcfu0xTJUgvE9eyuX6q9Bww49A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=o0maYXfo;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AB606A320
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC9AB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=o0maYXfo
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so19373275e9.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 01:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795341574; x=1795946374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EAJZGrU+K9EIx1PBrfq2qgcoNQAfdXDu88XhOMIZ5xQ=;
        b=o0maYXfoWoBxVGKCP9icgq3tFQRXaB8tp+Z8OgQLO6Xob4EgMu9n4oYNvs7KdkXi+/
         28xTodbRQuG2WP7lPisLApe9PNlzGDUmymzJNPgW18QrH0eEbpc16Q3rpqVTdttwntrL
         NPFnfrUn8WfsstYW6/ygx+7vlaHEmLQ95vR3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341574; x=1795946374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EAJZGrU+K9EIx1PBrfq2qgcoNQAfdXDu88XhOMIZ5xQ=;
        b=SATbDCPpbTJNjWoGKx7hwk5y1Ia9bjtgYs1NxKse0R1xzHGoTPPlokGGWjTrOC/ez0
         tE5NqYjeDrhJO3kSIcs5WjqO5/kONrTB15aHEi6W7WLa85Cnr136RpWYdpD6WCZTf+5x
         j8SJk7bTCPIlYXUr5JUlAst15mUpsxvaKIlVu16HdFS/+8quyQld+bdSPOCSde0BDcRj
         J0gNtoDqBSR7Lt/4EIw+BboFDGbkCi20xKr5oXOWT/VlHQ3O0CkThjYeodACwA3NngdH
         lhUCrn7rHBnNyU4aEWRQy5L2NCZ2uf4BKFB3UGN0WfhB/NtabPiN9XnTWyacdZsxt8n+
         3fVw==
X-Forwarded-Encrypted: i=1; AL+hErEQrynlVEvioib8TdwQPKOAwPadYu/j63Dt+P0MgS9fcNNcXHhFPQTh5L/TBttZVxuARoGO1ADMug==@vger.kernel.org
X-Gm-Message-State: APuU4Z/vh1f4U7buT2vNnXlozfO+1gqY/bzW6HT1ZavRO/Sf2VYkF/jb
	YyQfySx/GjuZbKHaFBMBg98kibTlFbL4X8Am1nVqfMOAz03LHGg53Izhukfu5bbVp4g=
X-Gm-Gg: AZFdTZdWwNons5f5kRcMyHSmukbjfhDC3L8CTUYwsAeZNnTznj8SAkrqb1M7tq5esLL
	c3/TZOXfbwyoSoLOtdaGv1IBvfu7+wacw1eSkhXN5LAqF+OwQ7eMVois7pGp+SXxdxhxH5JgcK7
	RB8rui6jTDUH63KF3eHvycfofZ/IAAy9Moz3gj6EhDouHc5ub+qAMVENNeO/M1XxTr/3Ea4PWrf
	QZzGgYYlhaa52UHcF8taFPgeEVLsRgYVu4EsLxfIphRc/VD6TIbV9wpNFgTYPESVpxxvj2gM6HF
	tvb8zVK1lQ+Wontza53udBLMrCuHz7KXFnAC6pqan5lxJA41bwL4xdI5eaAGXdxpDzhjoSCiPKS
	prAbis53HfldkrBZkmWPmgRV1/xaFRVngjDJ1AnlhCOgivIQkCel/b1Z/TRVWN8z1BUn4vWxqRD
	FwR8NpO5tpJ0nYfCnMAX6e3k/l56rYmaj3S+VE5UVgkwGYHPpRToRVDIxy5qxxEIrckkjRILfw1
	bVUlEVwOtb/AJy6me19dGeq3yaXf7uMe9JxOrBTbK5IJ5/7ODGyFuuLfrHqXYjFMZtsdbFaHJj4
	fygYISjkqvMS2BEYqCdHcQQBqhgG5GF8g7B2I9zEwSbrg3U2rdhgCSTdByUSff9GDovknk6zypC
	ffQRdnMEZs06i/2Aued+cNADWpnzH8T1zmGdGUH/QYoIrieq8PB6BXuqhPod2JVBEmrTXjO6xrh
	mgjxlf6vz+gGB9CvW0yYHXmXVCkkOwt2YxdJSKuhi9aBN/E+c=
X-Received: by 2002:a05:600c:3b1a:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4bb8881d4damr181304545e9.28.1795341574239;
        Sun, 22 Nov 2026 01:59:34 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm342455265e9.13.2026.11.22.01.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:59:33 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
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
Subject: [PATCH v2 1/4] pmdomain: imx8m-blk-ctrl: Remove the power notifier on probe failure
Date: Sun, 22 Nov 2026 10:59:16 +0100
Message-ID: <20261122095927.2631909-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122095927.2631909-1-dario.binacchi@amarulasolutions.com>
References: <20261122095927.2631909-1-dario.binacchi@amarulasolutions.com>
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
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

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


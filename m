Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89C4E06D6;
	Thu, 17 Sep 2026 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652971; cv=none; b=FSNlr5Q7J7hZ+AGxavfh/AlaAEixEugZKjc7t1SUYG0hidC51UdawUtP23P2u8738AgP0XlhTPGlh96cItVnabArSw6Iahxo6xnWY7QUmcn3b7DgS67sY/ReQHHLY5x55F0y44sIodHcR0ZVT1D6nT2Gu/8Cq+PP2MyLHrC4DVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652971; c=relaxed/simple;
	bh=R+0ORjkMahdOCQPNUtjC94W9dr82Rbx5na9hVn3u/Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6b9tqxDw1WSucavhUqmdyn1cNCIcrRK26Duh4cuxnSua+1OnaFibGYnMTp+gCTpSmT25q65b9XBiA58IAiPLZtYv1n6d7WJJfhb/xGlccCnzCXn73jr4yvopVGkuilwCjYTgWtuTNE1jGZZrzxBxs9b13+79QYPL1f8LTvhPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G/4NqSBO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G/4NqSBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789652962;
	bh=R+0ORjkMahdOCQPNUtjC94W9dr82Rbx5na9hVn3u/Ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G/4NqSBOfGgULBF4gDeB4Y73jKgWBtHyCvlOVnyWEaPREAGjUYQ1UtWk8zCXpKMI9
	 roQ02NIDWO8cT5Q33R17Vvz1D1oBCMOif7o5pNJhimbeaY35xqYbPnk1Fh48zQzJ5s
	 R72eU0IclAgiSobRoQZ0lAoV9hyidMqzk3ICxDm0X2kjhASpbqSNGRrj7aTmCDXx0R
	 6cVRd3aaxPBVk6FepSjY8oBeJhHfUGyF9k3JxA51eJH/k47U2rYyLt0FoeIx8ZECDz
	 eYcdrAnfzNfUsa+FoN9Vs0SSnfPBQZtUyILlut9NycPVDFDjIpG4KHdz4d/XAlOpAX
	 4PQKJl6s3Wl6Q==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C898A17E0C7E;
	Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 7F89E480031; Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 15:49:16 +0200
Subject: [PATCH 4/8] PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf
 capability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rockchip-dfi-cleanup-v1-4-4f00a97a69a6@collabora.com>
References: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
In-Reply-To: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=tS8n9fy0LBJivuuQhw0+orcBEclVJquJmZ0El2PFwMU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr7+FtYWVZhqL58bgqY/9AAoAVrODLk/2bk
 /G12vDhTY+kGIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq+/hAAoJENju1/PI
 O/qaQvcP/2ts/3qzSSPMQStKfeSOQqsfgNzziQqNcGI0S5KntolvAXoYDfkvsfwy8Jy5ClGTjMA
 5SKjGmVdDk1mPtm+I+K1+VsmsQ6CzAyW9+HW24itXgkBcjkc2W+eM7MjXxz8fyQr2jhWaJTHZSq
 CT3EIyYisTO1wvrUCtzRokHvsUlehB23uDk4ireeq7XaI3Q1QVKdsWTWhiaGmfdGJXpHC7oZn6f
 ek4J8J+INfYt+icxfNDiPpUS+mPjTYwoGeSpZ46Rv/5mcySSZJh5lBcrmm/UjheYd5tYSqdVi7E
 k1GarZzQbsHrpPQ8Ekmt9Phlg2JmpJT7ju3bB5JQQktVta942gk59V1n0wdnWM16jXkjFrPDwrI
 mripyUDRu6nIVo/oM0RrsYp4nRp6uOFHIJGytaNh5J9aZeaUAFvf+Y8DYaRfQ3zy2ZQvJxk386k
 DEl+ID5BF8klKmWOseyWAePwokQ/RkXEw8SdKOtYx8KjbW6M8QMj0lcAEJYVygoBrbdEnLHXoPP
 h4Nio2FwwGvFP9slvuyVQtQdXifS/JjmYq4+I2y+tg+s23s6i52/aiAnh6OBqC/nhlTca+aSih2
 mch6cCkUhpaTs+7kIFMWl8AWgoXfBZRzPn1nAPKgUg4YxI+t6uzQI/MmtbRt3NGmewKj6FrktqA
 eMLBQk1MYrFh2g8LsPgI0Ug==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The perf subsystem's PERF_PMU_CAP_NO_INTERRUPT is a bit of a
misnomer.[1] Instead of meaning that the PMU has no interrupt, it
actually means that the PMU does support sampling. On CPU PMUs, this is
equivalent to not having an interrupt, but for uncore PMUs like the
rockchip-dfi PMU is, no meaningful sample data could ever be generated
regardless of whether or not there is an interrupt, as it is not a CPU.

Since rockchip-dfi doesn't seem to make use of the interrupt the DT
provides it with anyway, this was probably never a confusion that
existed in this case; the capability flag was likely just forgotten.

Add PERF_PMU_CAP_NO_INTERRUPT to the set flags for the pmu struct's
capabilities member, so that the perf core knows about this limitation.

Fixes: 4d586b5724d3 ("PM / devfreq: rockchip-dfi: Add perf support")
Link: https://lore.kernel.org/all/20250619140442.GH1613376@noisy.programming.kicks-ass.net/ [1]
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 5339616f7ca6..dd9edfd6a674 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -646,7 +646,7 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
 	seqlock_init(&dfi->count_seqlock);
 
 	pmu->module = THIS_MODULE;
-	pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE;
+	pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT;
 	pmu->task_ctx_nr = perf_invalid_context;
 	pmu->attr_groups = attr_groups;
 	pmu->event_init  = rockchip_ddr_perf_event_init;

-- 
2.53.0


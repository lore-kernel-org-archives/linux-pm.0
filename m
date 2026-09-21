Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F3446074;
	Mon, 21 Sep 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022796; cv=none; b=YjyKqtC4WG2Ppwc+miiFOI6zQcwZKNPjPyVVY8MMbGgo8I4HFdf+aM6Fw9zF9xuGdIzLTe6ddt7241pDTa3vUgXK1e6ygpZvyG1F+Jbn9Uavezt7CL/LbuxFje3tM7JftfkA1BWIUikgIJdF8JS+QtSZW3hjpw4kwAGiC8jewt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022796; c=relaxed/simple;
	bh=R+0ORjkMahdOCQPNUtjC94W9dr82Rbx5na9hVn3u/Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bytHYbhGFoiEOnfrFsBnSvGUDnCexeG+9LJQkclKixBd6HPWpalk2i0ga9gsQ2kox6H5jpZ1/PpN85AwKjsegPpQ1BNAKaZh8jvMBVZUV20Q32uNAYd/JiipoVMcOmJO/5kyiWxhqUruwdLKxzxYnizai7tIQ++/77i7TRqTx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DmHh7oB8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DmHh7oB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=R+0ORjkMahdOCQPNUtjC94W9dr82Rbx5na9hVn3u/Ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DmHh7oB8N0I6iFYsM/yLTvS9u6vZiXDQVNkQ6JQWkISX7/8YkLi32jUnYQuC0APAA
	 xHJgvcBNTlwEUKDGvY8SCdEAraQUNkB87ulF5+jvGZHshOcB3wS4QhzprTGlEpogZM
	 x8FgB9ZAH/qGpGlOeamxANNLL9xmDVTcrLSvNZjZmN2Xyd66/ktepJBOJGCKEQ9Uua
	 mKK7E6cIFmNblXdJeJAWAJzdcH7+RUqIko8+u8aMqka1pbQa03/cvpS2O5dF5rHm/V
	 USMCNR1SJGyH5KWUCrPuC49UMaWNQrGs9ZPFbYJlrlsxs20loCUEWaNPvO+30UA7hT
	 ytidfkGKyeAJg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 413BB17E0C41;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EEB73480031; Mon, 21 Sep 2026 22:33:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 22:32:47 +0200
Subject: [PATCH v2 4/8] PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf
 capability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-rockchip-dfi-cleanup-v2-4-43ff34ac8599@collabora.com>
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
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
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlIfN8AICiJVidNsvdIb21QpyjLFYOPgg6
 9qMij7pt/NHAIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZSHAAoJENju1/PI
 O/qaH1AP/RFHTpW/TW6nZa9Wux+qImLvlT7+QAO0/A9qepx4hqt1BRaHVmF/9+GTpNRc2XMW04R
 i4BsfDf/ryZHWHFsXa1ppMd/Zq0wHvGWciOX4e1euF64KXEAg9aTN56W9dIdTb/2v1+io2XaGd6
 yfP4/TNGtZKIEW/1+lCVTMOTs8YtgqnY8OpVhZ1leDm9mWC9k/ZwDPRIE4lTFEjGtDkdYntw6UO
 3D2IkmEWLK6d5u1HesCtA7Fbr4jLn5Xd3tTKHa1mQIT56+R3FypRR8/PrpT7O41oaZ4QgCLtmcC
 PQCc+FcN8OZNuLGsdNwf0GFV3TNuQV6RJyuo5gn80tqh529JO6h3G2UKCkmTL4gWFI+inTWifL7
 BUtkoVVj8UTK/1iqFpO7pBGnRmyqO7PZVQr8WTDASar77JyS9C01NwS5KQFpYaAI96uDhFxGCPa
 gcarMHPMWw+kUAoVTtXn2jxqJv5Xdx2SN24FjA57ppV3afDeVr3Lix5BqUTkSc3s8aKb/mXO+dj
 cL4NhbEkHvlRCEUJq7khtr+2rMe0RCYBuMlFyDGD735TFxvPHnOXmGy9ak9XbHsfB+WtLgeaPbR
 XkhHHz+7j3JY45Oyi1kqg85f3j2Zsl42GpMqnPR3qJvqvs/uOjd3dWGDfx4vqL9q5tm1Ibm0ZL0
 LtNPY7WeoFW5URyn+ZD0tTw==
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


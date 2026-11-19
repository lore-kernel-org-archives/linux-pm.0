Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094597;
	b=jWo085NICn8gOYxzpY/tuVm0ZIua26riRtWQaZRUYHH4xEnefCaX1nE8PwpohNyovbb+
	 pGRHf5KlrE2tATrHb6PliR4V2Jtn3C2gOX/A1HBUxbmaNczGC9zqZWzcYb9bjA5m04Zq3
	 G9LhB5H1X20V9Y/DL7ZZ1VVASRu1e9s/5awhZe2PDZstyGeaV1G52AQVKm6pgEuamdaBv
	 hIlB6Ou9hCmSPjpolLwgOgAwe/ocBdqYPfNpZxD+EAUUjonc41EWEyzWkOJLB9nccSASn
	 hsW7LPgp8pW4hJ2x26fzUNx/1upUjGBwwaShqyo9GKtxxeXn0YkFFwR82DUVR/ztu7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094597;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=1HywxZj+ntCBxPb271XM3AEaJ1RvmUAp2KiCiKmlUJ4=;
	b=WnH2kueg5MUWoW945Vo+O6LlnFliisoAIj949jRRvdFT+eXTejPTpHbBEMj3tzWNLohp
	 QHizdo+LwqDEuPtCqxwxRh8SEbpuWzPzsRQu2nvXsNSAnZJarI6sn/wwsL4V8vrgYWbr5
	 CPjNZK12HhOpAXpzsLncTX+oZW+ZJiewNpDcJ4d2M4KKeQWwhGZI+ULgCICs2rTlHZRc0
	 jBxQne/2sqwWpeVFTE5zuzZAQyQbWdHpyi6onkhIxfxSpAq1QY4Ip1cza+0Qcvg0m/iNT
	 ah66vWe6A4iBPZwXLu9z9Q60gHmKWIe6XwagjNsri+PlLF4izZ9wztttKFZUlQjPW7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC77606A336;
	Thu, 19 Nov 2026 13:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD71F000C4;
	Thu, 19 Nov 2026 13:23:14 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] pmdomain: core: Remove unused generic_pm_domain_data.data
Date: Thu, 19 Nov 2026 14:22:59 +0100
Message-ID: <244b1e6c2c1b52f8324b622e23b8af8adcef43b4.1795094118.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795094118.git.geert+renesas@glider.be>
References: <cover.1795094118.git.geert+renesas@glider.be>
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

This reverts commit a5ea7a0fcbd7376b2c9fcb15fe59fec298c9ce9f.

The data pointer was added to the generic_pm_domain_data structure
specifically for use by the TI SCI Generic Power Domain Driver, but that
driver stopped using it in commit efa5c01cd7ee2042 ("soc: ti:
ti_sci_pm_domains: switch to use multiple genpds instead of one").
A new dummy user appeared in commit 58cbff023bfaeb9c ("soc: ti:
omap-prm: Add basic power domain support"), probably inspired by the
former, but it was removed, too.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/pm_domain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index d65ee8b3725c1bcb..0f2a9bf48c3e388d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -304,7 +304,6 @@ struct generic_pm_domain_data {
 	unsigned int opp_token;
 	bool hw_mode;
 	bool rpm_always_on;
-	void *data;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
2.43.0


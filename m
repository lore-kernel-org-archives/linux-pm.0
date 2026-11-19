Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094594;
	b=1vIUFUGPx9+oUE6KHgnQL8Gy+UYME5dCGB1nTD42Gqf1g7WprhfJLuzW9MC0SM8D8I7u
	 9XwVxBfobHepbs9ma4o3kKBOWbnmZVbdopAqRVyZnvZi1LLb7DuCdWSGTHo39vyPqYEAn
	 pkjtOxB//I7HaCUMFBFn9JBWD4dnQbPHpVsx9Vfzk9dK/1tnXPBX4BseyNsbgDqAZGdIi
	 pEjRF8DKpxZv5NIBSchnyY9xH42AhZYQCGAxf8kDWX4FjgBGRbRLPq/1YT9LBYfJdaWAv
	 51wFudM//ZmLigc/3r2e5zMS8FvvzEGDRwCwF/5N2+Lpc2e7xi8JDb/kJkhMLKEhOzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094594;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=zUgHiUxeai+462CgOJrAlgAIwv2ffSv36114dONT0IU=;
	b=Acm3Ih0qVROH0qbM0aKYyko3Rn3YxxkmCAN4HPw7gq3KJUEH5R8YL1RsMacXvzwZO8ny
	 oN7HR0RwlPhMDQPdBU2WhgyofusCi7U9D7PJKWEEfY8AJCkjn59LQfhS+mqFtuDiQMp+L
	 E7sBlyXdxHVExQfigYA/Ye2jctRA8h9oqFewYx6naj6oFHHJVYPWM4GwJS40yaeopfnBB
	 1PuKgzvlYmEAFojwSiW3hD8mYk18DWibsxRktX+j5MEWdDWrPWt4i0z5ixPvUT22Wp+pM
	 2Ajy5H6esPVUJ65ytuWC5EmR7a7h3AMUFqvbukFs57YCKrTH/TUiCnBboGkHVHg53pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B9606A336;
	Thu, 19 Nov 2026 13:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA141F000C4;
	Thu, 19 Nov 2026 13:23:12 +0000 (UTC)
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
Subject: [PATCH 2/3] pmdomain: ti: omap_prm: Remove dummy generic_pm_domain_data handling
Date: Thu, 19 Nov 2026 14:22:58 +0100
Message-ID: <05b6aee460879268c85c17035718f8c8787a2342.1795094118.git.geert+renesas@glider.be>
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

The TI OMAP2+ PRM driver clears generic_pm_domain_data.data in its
generic_pm_domain.attach_dev() and generic_pm_domain.detach() callbacks,
but never sets it to a non-NULL value.  Presumably this was part of
unfinished handling copied from the TI SCI Generic Power Domain Driver.

Remove the unused code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/ti/omap_prm.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
index 9515420da890cb31..eb4ce7cf9c176936 100644
--- a/drivers/pmdomain/ti/omap_prm.c
+++ b/drivers/pmdomain/ti/omap_prm.c
@@ -635,7 +635,6 @@ static int omap_prm_domain_attach_clock(struct device *dev,
 static int omap_prm_domain_attach_dev(struct generic_pm_domain *domain,
 				      struct device *dev)
 {
-	struct generic_pm_domain_data *genpd_data;
 	struct of_phandle_args pd_args;
 	struct omap_prm_domain *prmd;
 	struct device_node *np;
@@ -654,9 +653,6 @@ static int omap_prm_domain_attach_dev(struct generic_pm_domain *domain,
 			 prmd->pd.name, pd_args.args_count);
 	of_node_put(pd_args.np);
 
-	genpd_data = dev_gpd_data(dev);
-	genpd_data->data = NULL;
-
 	ret = omap_prm_domain_attach_clock(dev, prmd);
 	if (ret)
 		return ret;
@@ -667,12 +663,8 @@ static int omap_prm_domain_attach_dev(struct generic_pm_domain *domain,
 static void omap_prm_domain_detach_dev(struct generic_pm_domain *domain,
 				       struct device *dev)
 {
-	struct generic_pm_domain_data *genpd_data;
-
 	if (!pm_clk_no_clocks(dev))
 		pm_clk_destroy(dev);
-	genpd_data = dev_gpd_data(dev);
-	genpd_data->data = NULL;
 }
 
 static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
-- 
2.43.0


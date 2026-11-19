Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094592;
	b=A+PaBSnFrZmXzM5VKm7rg4kikBq047szQVq8dhC5j7Yjpiagn0bM971aCd7hJCT1LBEo
	 p7CibaW0c5YdXUvuns/DQcfPE6qyVGAZPYJnXOCeJV9wS2ZRUgRJDal8XexH7z3EFr1l4
	 3i85HVKIvdMpFsoHk6V/YmLKcO79wl/E6wXYpo3iS3/aU4oRjzyLL3uYy5DllsbrFX/xS
	 +hy6/p8DHIjpPUFk6VcyAvqZrQkl1JaZHz9sqUkZZJmYAB3+QTkWoZHJGd5nAmBiUFRCn
	 twV3aP1BvTE1K4Wr67TUlte+VrVLLLoQCIa5ZRCzz3/yrvuLPz7MUr7ctxR9rLNqM3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094592;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=pz0k4VxU3eBfCv8WD0OJkm6FuTK73OMGKkDamVlmtKA=;
	b=iLacXF3tbmkdyu2DbA2Ei+PY7ye3Q8Xx8bXQZdaaHbyNmD4/wbMmnVEN5mcnUOujOQb/
	 GxaIrtD5nhJlAhFdRViim3y1r0d3dwgz+8mDruuIKNcMmEpLgpuevk6+mjnX0OfWpD3V+
	 vhvC3AMj9dgp5V4ymXhFsBoL6w73DxPY0Khy1mR3ELiTXM38RTwJ5lCU3ohWEbHFfBhEn
	 dB5RLxdIrte6ypD69yQs4+aJY4Z+Rqpv8NMqs9KgPb7knervxWvnNXT9BkqBM3JqgjERz
	 0YOYJmg5mleANzO5HnW6F49kmjTTpM9C17rpyYb8KPbgA1yCIYKDE/84SeWwG1cJi8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BE606A33C;
	Thu, 19 Nov 2026 13:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1071F000C4;
	Thu, 19 Nov 2026 13:23:09 +0000 (UTC)
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
Subject: [PATCH 1/3] pmdomain: ti: omap_prm: Use pm_clk_no_clocks()
Date: Thu, 19 Nov 2026 14:22:57 +0100
Message-ID: <8c0bccb0d90d55d70b85e021979b0728893905c7.1795094118.git.geert+renesas@glider.be>
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

The TI OMAP2+ PRM driver uses a flag to keep track if any device clocks
were registered for power management.  Replace this custom logic by use
of the existing pm_clk_no_clocks() helper.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/ti/omap_prm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
index 671b028e367eb9de..9515420da890cb31 100644
--- a/drivers/pmdomain/ti/omap_prm.c
+++ b/drivers/pmdomain/ti/omap_prm.c
@@ -44,7 +44,6 @@ struct omap_prm_domain {
 	u16 pwrstst;
 	const struct omap_prm_domain_map *cap;
 	u32 pwrstctrl_saved;
-	unsigned int uses_pm_clk:1;
 };
 
 struct omap_rst_map {
@@ -630,8 +629,6 @@ static int omap_prm_domain_attach_clock(struct device *dev,
 		return error;
 	}
 
-	prmd->uses_pm_clk = 1;
-
 	return 0;
 }
 
@@ -671,10 +668,8 @@ static void omap_prm_domain_detach_dev(struct generic_pm_domain *domain,
 				       struct device *dev)
 {
 	struct generic_pm_domain_data *genpd_data;
-	struct omap_prm_domain *prmd;
 
-	prmd = genpd_to_prm_domain(domain);
-	if (prmd->uses_pm_clk)
+	if (!pm_clk_no_clocks(dev))
 		pm_clk_destroy(dev);
 	genpd_data = dev_gpd_data(dev);
 	genpd_data->data = NULL;
-- 
2.43.0


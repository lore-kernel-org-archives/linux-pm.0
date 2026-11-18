Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031194;
	b=4UqIV494BURdQ8xfiWRHJ2pjPbSls4B827SkZ2Rsd6Cb8KBoF8iYJcIsiQSiYIhRm95a
	 /SgxziYU6jX9BhB2xuaFgKyIJSoSBanETx1DCxfsS6SRnGfFMwF6euzNa9T1ECTamAjqM
	 Ml76ydKDx7QiS5I0qkI9GodDHNlycPLJ1MUnxz1Xl5dlAbjzuWizM6oO/6wfGN1WNkhXC
	 u0wBgCr4b8qlLGKDDpZOl6F51bNwz9No6aQiIduYdUhFuAlJPH7t1BLIqEFIDE7Tyl50H
	 hZ1LbkMFNCgEM/aWQ1hckgf7LPUTXvwuNzkUzxGV9XF2eve0lAnyKmrCg+NLIrOqBjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031194;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=+aCpfT9hXykgb7HwKIuZi82drA7L3aK5mwGRy+xyKWA=;
	b=DPOoYkVCjRGUj8MUAADo4Hv6O545hmXzaRftIghJ9kYATz8IXaYGs3z95FChIFBeyUrw
	 Zb4n5fe3mA+OxQH6X6cybcjnO3GX5WxvLNSXuHooFNJHE2KhKYqyqKd2eD6qaUqR0XDSY
	 I0zXBHhTlDRorSgLDWttWjaqJKAweyRhnAShyPYp4UVZyqO91F36TcPFRRzecmfa9pthd
	 urkfKIcIHuCGuCCPZmDio7fo6cxNpgzkIXGBDNtNNgm1r/3itU2QPgG7pBVPMU4eHjQHr
	 MBVvvrpOvTHVXZoEb5u7bEhs7tkeCkFMKyBUPPMwp7btg19sO5AeLo/5nRu/lUrShPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5E606A32A;
	Wed, 18 Nov 2026 19:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6031F000CC;
	Wed, 18 Nov 2026 19:46:28 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 13/15] pmdomain: renesas: r8a78000: Shrink IDs to 16 bits
Date: Wed, 18 Nov 2026 20:45:01 +0100
Message-ID: <72f8eae23faefaa169cff7a52cdbafce2cd50e1f.1795029012.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795029012.git.geert+renesas@glider.be>
References: <cover.1795029012.git.geert+renesas@glider.be>
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

Reduce table size by shrinking hardware module IDs from 32 to 16 bits,
which is still plenty.

While at it, use u32 to store of_phandle_args.args[1] in
r8a78000_mdlc_attach_dev().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 6477abe64511e880..733bf68dab2ce6dc 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -17,7 +17,7 @@
 #include <dt-bindings/power/renesas,r8a78000-mdlc.h>
 
 struct mod_id_map_entry {
-	u32 hw_id;		/* Hardware module ID */
+	u16 hw_id;		/* Hardware module ID */
 };
 
 struct mod_id_map {
@@ -148,8 +148,8 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 	struct device_node *np = dev->of_node;
 	struct r8a78000_mdlc_priv *priv;
 	struct of_phandle_args pd_spec;
-	unsigned int id;
 	int ret, idx;
+	u32 id;
 
 	ret = of_parse_phandle_with_args(np, "power-domains",
 					 "#power-domain-cells", 0, &pd_spec);
-- 
2.43.0


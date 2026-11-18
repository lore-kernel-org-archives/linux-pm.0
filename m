Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031165;
	b=JoNi71con7gYuBULrcdSzCnd0htJlAWbUVCQpqVLUXqix3n2kimrBZP6Wo4tvBv/c5qW
	 K99RMXd+XcyqAUFEeeAMLCMkVG0Y2zU0pBSndZdeCy2rkJyWC1ucW7f2FJeaqchVJ7ZJf
	 OIeh/K6q27zX+UBsfXIUcHcMKCDVuHO8NBnoJHmg3xyRYV4x6YPwEXHvTd8kbwPvtXUF/
	 Rm20O5XGQ4ob9PxexbX7bgAxuDXlKXiiUd+SE4sa6IcD64vDmWx8qxY8IWg90jaLJsoRD
	 c+QruiLtn7Yw1Wcy1rSZxivQM5Ol/OTpQezxXa4Oya4CV4PMuV8CZRfZkJZzu2tMXQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031165;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=SeSprMLclVOYKhtm/fy8TNO+yaPlltkJIArN4P50gi4=;
	b=v6h9Le2juS1sIpNttMe/KoFDcj/7pAn1WDI2EaBH4m2WRn0n7BsFD+FZJNB0zzHZ7vdQ
	 aF7kywOcr0YgwTn8O/zWVR8InxbmEUeP29dSwJIRp8ic9MDfoC0S4vq9qu54YA/Tpc3ns
	 4eIONJ+PKsk0tlSHqQvitB4HOeHAeBwDRHFjRE1maaTxbwCoV/2SaF5n/0Qlc8WuGDgJ1
	 N4xDuirLb06NvLiY1rfjN9p3//SxdqH2cDhbC6wg9yKIS85zW2r8ojHSsrpXsZf+fRrq/
	 422oOZ8jTF4ciDAnaVqvSouMahz0U8WpcTzFnH9hpMVWu29IWgztrJnlzP4wRWTv1WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63167606A320;
	Wed, 18 Nov 2026 19:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEA61F000C5;
	Wed, 18 Nov 2026 19:45:59 +0000 (UTC)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 08/15] pmdomain: Make genpd_get_from_provider() always return on first match
Date: Wed, 18 Nov 2026 20:44:56 +0100
Message-ID: <37ddba45a281d2957effe5773c59022835b6144c.1795029012.git.geert+renesas@glider.be>
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

The for-loop in genpd_get_from_provider() seems to imply that one can
have multiple providers for the same node: in case a provider's callback
fails to map a specifier to a PM domain, the loop continues looking for
another matching provider.

While technically one can register multiple providers for the same
device node, one can never safely remove one of them:
of_genpd_del_provider() just considers the device node, and removes the
first matching provider.

Use the same logic in genpd_get_from_provider() to avoid confusion.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/20261019160545.GC3705@killaraus.ideasonboard.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/pmdomain/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 964e44c2f78f1d55..ee8075e90852e738 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3031,10 +3031,10 @@ static struct generic_pm_domain *genpd_get_from_provider(
 
 	/* Check if we have such a provider in our array */
 	list_for_each_entry(provider, &of_genpd_providers, link) {
-		if (provider->node == genpdspec->np)
+		if (provider->node == genpdspec->np) {
 			genpd = provider->xlate(genpdspec, provider->data);
-		if (!IS_ERR(genpd))
 			break;
+		}
 	}
 
 	mutex_unlock(&of_genpd_mutex);
-- 
2.43.0


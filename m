Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031125;
	b=pMw2yH/DEtRJjAejGLV4U29zOcMjLVCI3S+Mbs0KEE/f4t6cgZ+2bFfihXRg3Q9PIZB6
	 cm1p+cTrIuMOSNgDwYnnm0nW0nhy2bXHyEPFtZa/EZp91oKVH6cSX9FuWlfxsZI9+ZqH/
	 MYU4T00mGM9vUyK7S9/thF0sk4rNnfJ+mUvJ8FQzSEG80Ntq0V0RVsnISosn8lfFv+8Hw
	 5ILZfmBsuFJWW33aA/K4aaLkuJzuwQ7WJhgNLM7K/6PdQeJBGwvXOIVHsNoWw7rDe8G46
	 52Aav3xNMSbmQM58hfptazEezp1acRcmhJ6VFTREmGI6QlU7+I9dgnP8ZQInuZP+rvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031125;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=rUSs3e7s6g8KsME4KEy6RBI5qct6OcNuN58yFbMXs0M=;
	b=HF8qjPtYYNYfh3ts5/+wUY7237gg1BztS11/NoOGb7tUlmleSCJvXXVQKPCrOOGwmK10
	 DXtgRiOwK/Mw50nm34KodzjA85ndMeP0xmBpdGuoqX1YJigHKkE2PeGotuzJT+ZhUY8Ej
	 Jsq261TrvHTM5ed5pPMazBd4vsyn8avyd5VPRX/G8KJxVm6Ui1lASMIEAM/xSBTWTuaRJ
	 hHSRoDF9gnpURYfQkzyT5TVT3uuuch0Q50Qim8ATO6tPSYbpmeQxH9IVgS+zHD53IvOyZ
	 hB3CX9UVXW1lwX7oxrqNBHEsHj9ltcZrL1lu9HFFUn+ynjXdv4CSi+aFFbFrsO3KBOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7A606A325;
	Wed, 18 Nov 2026 19:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247A91F000C5;
	Wed, 18 Nov 2026 19:45:19 +0000 (UTC)
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
Subject: [PATCH v5 01/15] clk: renesas: r8a78000: Merge debug prints in r8a78000_clk_get()
Date: Wed, 18 Nov 2026 20:44:49 +0100
Message-ID: <cee843b319c9eceba2339f14a134e305a2b05d7e.1795029012.git.geert+renesas@glider.be>
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

The two debug prints in r8a78000_clk_get() are very similar.
Merge them into a single debug print.

While at it, unwrap the (wrongly-indented) continuation of the
r8a78000_clk_get() function header, as it fits on a single line.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/clk/renesas/r8a78000-cpg.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 6fee05a899f47bf4..0e11ae139fbffd80 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -62,8 +62,7 @@ static const struct clk_map *clk_map_find(const struct clk_map *map, u32 id)
 	return NULL;
 }
 
-static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
-				      void *data)
+static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
 {
 	struct r8a78000_cpg_priv *priv = data;
 	struct device *dev = priv->dev;
@@ -82,12 +81,10 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
 		return ERR_PTR(-ENOENT);
 	}
 
-	dev_dbg(dev, "Mapping DT clock %u to fixed clock %u\n", id, map->fw_id);
-
 	hw = priv->fixed_hws[map->fw_id];
 
-	dev_dbg(dev, "clock %u is %s at %lu Hz\n", id, clk_hw_get_name(hw),
-		clk_hw_get_rate(hw));
+	dev_dbg(dev, "Mapping DT clock %u to %s at %lu Hz\n", id,
+		clk_hw_get_name(hw), clk_hw_get_rate(hw));
 
 	return hw;
 }
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796834;
	b=4zttq9XCPe9jnp82sdIZEyNI0BXfDtIX0c/yIbEYpaWBrnWiQoHN3iKJRAjPTKTBaWSu
	 zbKqgotF+pXGhwyCIz0x59/vipeRjvpaXa6V+SACiwCtedQq3N4UXiGBNwXhCKGEo5shW
	 IltYbeesrd3NBYSqSvLZl5oUZcyAEt6CCpCOCoMkld8IH4H3GNGVexaga9clsS5y4Ahp3
	 Xx7oCq9jRUeepmKqSuEL2b98QUAjUE0hZJU46R7AKZZ5Jg5uMUuO7DDzheBQsSn/WDRBl
	 ihPdXXlzgeYKTpSAK2TpbCSi3dpWL2wzSAN+ui+duPKJ01IQc77wVYBNSTCXUT6AAdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796834;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wpe/XInsRMyClo0wZtR891IB7bnYBNwFImpPUyM5/T8=;
	b=hf339mFCxKwT2BBew4Io2Ngt3aRUdtMsQMoyjm0oxe9wKGq3JOSPQevUSGSYL/ZCNK2W
	 Eahu6BoHhkYMF2cYa9PUBtYC+J4Py8Fo9j82AuRXDWsPh3zsLoQeVzTB6Sc/iVjEyrNke
	 oAV0qeYqG2dBot9Xpanu3g5QaiOhTSxOWO9nkmdk+knVsx5YU7QRwNhoGv4OaUPxttGQk
	 Jgqhxjxrl8H/nIOwqhtCV+oNjtK6EIlBDbDEy2dRSbXIL4QFeHfURKQMPw+nh06sjYiEs
	 mm1dhq0CLk0tzokux+aGTYoSi0q/ueRvURqT04YwKqX1Gip3IBf2rCUebmtSrMpjnEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKn8C8f8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591D606A31E;
	Fri, 27 Nov 2026 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKn8C8f8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DC71F0089B;
	Fri, 27 Nov 2026 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796834;
	bh=wpe/XInsRMyClo0wZtR891IB7bnYBNwFImpPUyM5/T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aKn8C8f8YiJZ7VBHVUT4M1yNl1CCoMRjHStdmygBcJ6vgC56+Fq/fzQgHw1lzL/TA
	 RHqixC87trjr8V1otXioNBTxe+VE/Gqi9ETgs969fHg71C2heyJqnIYOo9YAeigjGU
	 BJg3It+XwLYqQj9/iqW/IzhkfXnCuCycNWnbgVnPg1wSVrIQyfLLFs/itoEWG7HnoS
	 HTa/t54yi5Rfh9AnQoIAETqikB8juiJJW0+p9f8pmySdz//8Rh/LFILIx5yhkywUxX
	 FgfJ9L9/04OjR/qDDFm4ybBT4yxbuNTgkpg3D+0mxJk/fweeIMTPyobZ8S5TDhMi02
	 JvO94lLooiDQw==
From: Geert Uytterhoeven <geert@kernel.org>
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
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 01/14] clk: renesas: r8a78000: Merge debug prints in r8a78000_clk_get()
Date: Fri, 27 Nov 2026 17:26:46 +0100
Message-ID: <7abac4b033081657e2a9870182bc06f5a5a02c0c.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795796064.git.geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The two debug prints in r8a78000_clk_get() are very similar.
Merge them into a single debug print.

Note that the clock's name is still printed, but its ID no longer is, as
that is purely internal.  The printing of real firmware IDs will be
readded when their handling is added.

While at it, unwrap the (wrongly-indented) continuation of the
r8a78000_clk_get() function header, as it fits on a single line.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v6:
  - Add Reviewed-by,
  - Clarify that fw_id printing will be readded later,

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

